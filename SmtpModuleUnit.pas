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
    Listening : boolean;

    RemoteHost : string;
    RemotePort : word;
    RemoteSslRequired : boolean;
    RemoteUserName : string;
    RemotePassword : string;
  end;

  TSmtpModule = class(TDataModule)
    MailServer: TIdSMTPServer;
    MailClient: TIdSMTP;
    SslHandlerServer: TIdServerIOHandlerSSLOpenSSL;
    SslHandlerClient: TIdSSLIOHandlerSocketOpenSSL;
    ServerUserPass: TIdUserPassProvider;
    procedure MailClientTLSNotAvailable(Asender: TObject;
      var VContinue: Boolean);
  private
    { Private declarations }

    _ReadingSettings : Boolean;
    _WritingSettings : Boolean;

    procedure SetSmtpSettings(v: TSmtpSettings);
    function GetSmtpSettings():TSmtpSettings;
  public
    { Public declarations }

    property ReadingSettings : Boolean read _ReadingSettings;
    property WritingSettings : Boolean read _WritingSettings;
    property SmtpSettings : TSmtpSettings read GetSmtpSettings write SetSmtpSettings;

    function TestClient(host: string; port: word; ssl: boolean;
                        user: string; password: string;
                        testFrom : string = ''; testTo : string = ''): boolean;
  end;



var
  SmtpModule: TSmtpModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses IdMessage;

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

    Result.Listening := MailServer.Active;

    // Read remote server settings

    Result.RemoteHost := MailClient.Host;
    Result.RemotePort := MailClient.Port;
    Result.RemoteSslRequired := MailClient.UseTLS = utUseRequireTLS;
    Result.ServiceName := MailClient.MailAgent;
    Result.RemoteUserName := MailClient.Username;
    Result.RemotePassword := MailClient.Password;

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

  if (not TestClient(v.RemoteHost, v.RemotePort, v.RemoteSslRequired,
                     v.RemoteUserName, v.RemotePassword)) then
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

        MailServer.Active := v.Listening;
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
                                testFrom: string = ''; testTo: string = ''): boolean;
var
  cli: TIdSmtp;
  testMail : TIdMessage;
  sslHandler : TIdSSLIOHandlerSocketOpenSSL;
begin
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

      Result := cli.Connected()
            and cli.Authenticate();

      if (Result and (testFrom <> '')) then
      begin
        testMail := TIdMessage.Create(Self);

        testMail.From.Address := testFrom;
        testMail.Recipients.Add().Address := testTo;

        testMail.Subject := 'About test mail';
        testMail.Body.Text := 'Test mail sending successful!';

        cli.Send(testMail);
      end;

    except
      Result := false;
    end;
  finally
    if MailClient.Connected() then
        MailClient.Disconnect(true);

    cli.Free;
    sslHandler.Free;
  end;
end;



end.
