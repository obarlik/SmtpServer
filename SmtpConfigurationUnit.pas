unit SmtpConfigurationUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SmtpModuleUnit, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TConfigurationForm = class(TForm)
    GroupBox1: TGroupBox;
    ServerPortUpDown: TUpDown;
    ServerPort: TLabeledEdit;
    ServerSslMode: TComboBox;
    GroupBox2: TGroupBox;
    ClientHost: TLabeledEdit;
    ClientPassword: TLabeledEdit;
    ClientUserName: TLabeledEdit;
    ClientPort: TLabeledEdit;
    ClientPortUpDown: TUpDown;
    ServerIp: TLabeledEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ButtonClose: TButton;
    ButtonApply: TButton;
    ClientSslMode: TComboBox;
    TabSheet2: TTabSheet;
    ServerName: TLabeledEdit;
    ClientTest: TButton;
    ServerUserName: TLabeledEdit;
    ServerPassword: TLabeledEdit;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    QueueDirectory: TLabeledEdit;
    SelectFolder: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonApplyClick(Sender: TObject);
    procedure ClientTestClick(Sender: TObject);
    procedure TestConnectionClick(Sender: TObject);
    procedure OnConfigurationChange(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    _Modified : Boolean;

    procedure SetModified(v: Boolean);

  protected
    property Modified : Boolean read _Modified write SetModified;

    procedure LoadSettings();
    procedure SaveSettings();

  public
    { Public declarations }
  end;

var
  ConfigurationForm: TConfigurationForm;

implementation

uses
  SmtpTestMailUnit;

{$R *.dfm}


procedure TConfigurationForm.ButtonApplyClick(Sender: TObject);
begin
  SaveSettings();
end;


procedure TConfigurationForm.ClientTestClick(Sender: TObject);
var
  testResult : string;
begin
  with TSmtpTestForm.Create(Self) do
  try
    if ShowModal() = mrOk then
    begin
      testResult := SmtpModule.TestClient(
              ClientHost.Text,
              StrToInt(ClientPort.Text),
              ClientSslMode.ItemIndex = 1,
              ClientUserName.Text,
              ClientPassword.Text,
              MailFrom.Text,
              MailTo.Text);

      if (testResult = 'OK') then
      begin
        ShowMessage('Client connection is successful!');
      end
      else
      begin
        ShowMessage('Client connection is failed!');
      end;
    end;
  finally
    Free;
  end;
end;

procedure TConfigurationForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TConfigurationForm.FormShow(Sender: TObject);
begin
  if Visible then
    LoadSettings();
end;


procedure TConfigurationForm.OnConfigurationChange(Sender: TObject);
begin
  Modified := true;
end;


procedure TConfigurationForm.SetModified(v: Boolean);
begin
  _Modified := v;
  ButtonApply.Enabled := _Modified;
end;


procedure TConfigurationForm.TestConnectionClick(Sender: TObject);
begin
end;


// Loads settings to UI
procedure TConfigurationForm.LoadSettings();
var
  s : TSmtpSettings;
begin
  try
    s := SmtpModule.SmtpSettings;

    // Read listening server settings

    ServerName.Text := s.ServiceName;

    ServerIp.Text := s.ListenIp;
    ServerPort.Text := IntToStr(s.ListenPort);

    if s.SslRequired then
      ServerSslMode.ItemIndex := 1
    else
      ServerSslMode.ItemIndex := 0;

    ServerUserName.Text := s.Username;
    ServerPassword.Text := S.Password;

    // Read remote server settings

    ClientHost.Text := s.RemoteHost;
    ClientPort.Text := IntToStr(s.RemotePort);

    if s.RemoteSslRequired then
      ClientSslMode.ItemIndex := 1
    else
      ClientSslMode.ItemIndex := 0;

    ClientUserName.Text := s.RemoteUserName;
    ClientPassword.Text := s.RemotePassword;
  finally
    Modified := false;
  end;
end;


// Saves settings from UI
procedure TConfigurationForm.SaveSettings();
var
  s : TSmtpSettings;
begin
  s := TSmtpSettings.Create();

  try
    // Get listening server settings

    s.SslRequired := ServerSslMode.ItemIndex = 1;

    s.ListenIp := ServerIp.Text;
    s.ListenPort := StrToInt(ServerPort.Text);
    s.Username := ServerUserName.Text;
    s.Password := ServerPassword.Text;

    // Get remote server settings

    s.RemoteSslRequired := ClientSslMode.ItemIndex = 1;

    s.RemoteHost := ClientHost.Text;
    s.RemotePort := StrToInt(ClientPort.Text);
    s.RemoteUserName := ClientUserName.Text;
    s.RemotePassword := ClientPassword.Text;
    s.ServiceName := ServerName.Text;

    // Write settings
    SmtpModule.SmtpSettings := s;

    Modified := false;
  finally
    s.Free;
  end;
end;


end.
