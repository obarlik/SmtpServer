unit SmtpModuleUnit;

interface

uses
  System.SysUtils, System.Classes, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdServerIOHandler, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer,
  IdCmdTCPServer, IdSMTPServer, IdUserPassProvider, IdSASL, IdSASLUserPass,
  IdSASLLogin;

type
  TSmtpSettings = class
  public
    ServiceName: string;
    SslRequired : boolean;
    ListenIp : string;
    ListenPort : word;
    UserName : string;
    Password : string;

    RemoteHost : string;
    RemotePort : word;
    RemoteSslRequired : boolean;
    RemoteUserName : string;
    RemotePassword : string;

    QueueDirectory : string;
  end;


  TSmtpModule = class(TDataModule)
    MailServer: TIdSMTPServer;
    MailClient: TIdSMTP;
    SslHandlerServer: TIdServerIOHandlerSSLOpenSSL;
    SslHandlerClient: TIdSSLIOHandlerSocketOpenSSL;
    ServerUserPass: TIdUserPassProvider;
    procedure MailClientTLSNotAvailable(Asender: TObject;
      var VContinue: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private
    { Private declarations }

    _ReadingSettings : Boolean;
    _WritingSettings : Boolean;

    procedure SetSmtpSettings(v: TSmtpSettings);
    function GetSmtpSettings(): TSmtpSettings;

    procedure LoadSettingsFromFile(fileName: string);
    procedure SaveSettingsToFile(fileName: string);

  public
    { Public declarations }

    QueueDirectory : string;

    property ReadingSettings : Boolean read _ReadingSettings;
    property WritingSettings : Boolean read _WritingSettings;
    property SmtpSettings : TSmtpSettings read GetSmtpSettings write SetSmtpSettings;

    function TestClient(host: string; port: word; ssl: boolean;
                        user: string; password: string;
                        testFrom: string = ''; testTo: string = ''): string;
  end;



var
  SmtpModule: TSmtpModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses IdMessage;


procedure TSmtpModule.LoadSettingsFromFile(fileName: string);
var
  sl: TStringList;
  cfg: TSmtpSettings;
begin
  if not FileExists(fileName) then
    Exit;

  sl := TStringList.Create();
  cfg := TSmtpSettings.Create();

  try
    sl.LoadFromFile(fileName);

    cfg.ServiceName := sl.Values['ServiceName'];
    cfg.SslRequired := StrToBool(sl.Values['SslRequired']);
    cfg.ListenIp := sl.Values['ListenIp'];
    cfg.ListenPort := StrToInt(sl.Values['ListenPort']);
    cfg.UserName := sl.Values['UserName'];
    cfg.Password := sl.Values['Password'];

    cfg.RemoteHost := sl.Values['RemoteHost'];
    cfg.RemotePort := StrToInt(sl.Values['RemotePort']);
    cfg.RemoteSslRequired := StrToBool(sl.Values['RemoteSslRequired']);
    cfg.RemoteUserName := sl.Values['RemoteUserName'];
    cfg.RemotePassword := sl.Values['RemotePassword'];

    cfg.QueueDirectory := sl.Values['QueueDirectory'];

    SmtpSettings := cfg;
  finally
    cfg.Free();
    sl.Free();
  end;
end;


procedure TSmtpModule.SaveSettingsToFile(fileName: string);
var
  sl: TStringList;
  cfg: TSmtpSettings;
begin
  sl := TStringList.Create();
  cfg := SmtpSettings;

  try
    sl.Values['ServiceName'] := cfg.ServiceName;
    sl.Values['SslRequired'] := BoolToStr(cfg.SslRequired, True);
    sl.Values['ListenIp'] := cfg.ListenIp;
    sl.Values['ListenPort'] := IntToStr(cfg.ListenPort);
    sl.Values['UserName'] := cfg.UserName;
    sl.Values['Password'] := cfg.Password;

    sl.Values['RemoteHost'] := cfg.RemoteHost;
    sl.Values['RemotePort'] := IntToStr(cfg.RemotePort);
    sl.Values['RemoteSslRequired'] := BoolToStr(cfg.RemoteSslRequired, True);
    sl.Values['RemoteUserName'] := cfg.RemoteUserName;
    sl.Values['RemotePassword'] := cfg.RemotePassword;

    sl.Values['QueueDirectory'] := cfg.QueueDirectory;

    sl.SaveToFile(fileName);
  finally
    cfg.Free();
    sl.Free();
  end;
end;


procedure TSmtpModule.MailClientTLSNotAvailable(Asender: TObject;
  var VContinue: Boolean);
begin
  case MailClient.UseTLS of
    utNoTLSSupport,
    utUseExplicitTLS:
      VContinue := true;
  else
    VContinue := false;
  end;
end;


procedure TSmtpModule.DataModuleCreate(Sender: TObject);
begin
  LoadSettingsFromFile('Smtp.conf');
end;


procedure TSmtpModule.DataModuleDestroy(Sender: TObject);
begin
  SaveSettingsToFile('Smtp.conf');
end;


function TSmtpModule.GetSmtpSettings: TSmtpSettings;
begin
  if (ReadingSettings or WritingSettings) then
    raise Exception.Create('Please wait for pending operation to finish, before reading SMTP settings!');

  _ReadingSettings := true;
  Result := TSmtpSettings.Create;

  try
    // Read listening server settings

    Result.SslRequired := MailServer.UseTLS = utUseRequireTLS;

    Result.ListenIp := MailServer.Bindings[0].IP;
    Result.ListenPort := MailServer.Bindings[0].Port;
    Result.UserName := ServerUserPass.Username;
    Result.Password := ServerUserPass.Password;

    // Read remote server settings

    Result.RemoteHost := MailClient.Host;
    Result.RemotePort := MailClient.Port;
    Result.RemoteSslRequired := MailClient.UseTLS = utUseRequireTLS;
    Result.ServiceName := MailClient.MailAgent;
    Result.RemoteUserName := MailClient.Username;
    Result.RemotePassword := MailClient.Password;

    Result.QueueDirectory := QueueDirectory;

  finally
    _ReadingSettings := false;
  end;
end;


procedure TSmtpModule.SetSmtpSettings(v: TSmtpSettings);
var
  backup : TSmtpSettings;
begin
  if (WritingSettings or ReadingSettings) then
    raise Exception.Create('Please wait for pending operation to finish before writing SMTP settings!');

  if (TestClient(v.RemoteHost, v.RemotePort, v.RemoteSslRequired,
                 v.RemoteUserName, v.RemotePassword) <> 'OK') then
    raise Exception.Create('Client connection test failed!');

  // Backup existing configuration
  backup := SmtpSettings;
  _WritingSettings := true;

  try
    try
      try
        // First, close all connections

        MailServer.Active := false;

        if MailClient.Connected() then
          MailClient.Disconnect(true);

        // Write listening server settings

        if v.SslRequired then
          MailServer.UseTLS := utUseRequireTLS
        else
          MailServer.UseTLS := utUseExplicitTLS;

        MailServer.Bindings[0].IP := v.ListenIp;
        MailServer.Bindings[0].Port := v.ListenPort;
        ServerUserPass.Username := v.UserName;
        ServerUserPass.Password := v.Password;

        // Read remote server settings

        if v.RemoteSslRequired then
          MailClient.UseTLS := utUseRequireTLS
        else
          MailClient.UseTLS := utUseExplicitTLS;

        MailClient.Host := v.RemoteHost;
        MailClient.Port := v.RemotePort;
        MailClient.Username := v.RemoteUserName;
        MailClient.Password := v.RemotePassword;
        MailClient.MailAgent := v.ServiceName;

        QueueDirectory := v.QueueDirectory;

        MailServer.Active := true;
      finally
        _WritingSettings := false;
      end;

    except
      // Recover from backup
      SmtpSettings := backup;
    end;

  finally
    backup.Free;
  end;
end;


function TSmtpModule.TestClient(host: string; port: word; ssl: boolean;
                                user: string; password: string;
                                testFrom: string = ''; testTo: string = ''): string;
var
  status : (stConnect, stAuthenticate, stTestMail, stDone);
  cli: TIdSmtp;
  testMail : TIdMessage;
  sslHandler : TIdSSLIOHandlerSocketOpenSSL;
begin
  status := stConnect;
  cli := TIdSMTP.Create(Self);
  sslHandler := TIdSSLIOHandlerSocketOpenSSL.Create(Self);

  try
    try
      cli.IOHandler := sslHandler;

      if ssl then
        cli.UseTLS := utUseRequireTLS
      else
        cli.UseTLS := utUseExplicitTLS;

      cli.Username := user;
      cli.Password := password;

      cli.Connect(host, port);

      if (cli.Connected()) then
      begin
        status := stAuthenticate;

        if (cli.Authenticate()) then
        begin
          if (testFrom <> '') then
          begin
            status := stTestMail;

            testMail := TIdMessage.Create(Self);

            testMail.From.Address := testFrom;
            testMail.Recipients.Add().Address := testTo;

            testMail.Subject := 'About test mail';
            testMail.Body.Text := 'Test mail sending successful!';

            try
              cli.Send(testMail);
            except
              on e: Exception do
              begin
                Result := e.Message;
                raise;
              end;
            end;
          end;

          status := stDone;
        end;
      end;

    finally
      if cli.Connected() then
          cli.Disconnect(true);

      cli.Free;
      sslHandler.Free;
    end;
  except
    // Shh!
  end;

  case status of
    stConnect: Result := 'Invalid host address!';
    stAuthenticate: Result := 'Invalid user name or password!';
    stTestMail: Result := 'Test e-mail sending failed with message: ' + Result;
    stDone: Result := 'OK';
  end;
end;



end.
