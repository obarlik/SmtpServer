unit SmtpModuleUnit;

interface

uses
  System.SysUtils, System.Classes, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdServerIOHandler, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer,
  IdCmdTCPServer, IdSMTPServer;

type
  TSmtpModule = class(TDataModule)
    MailServer: TIdSMTPServer;
    MailClient: TIdSMTP;
    SslHandlerServer: TIdServerIOHandlerSSLOpenSSL;
    SslHandlerClient: TIdSSLIOHandlerSocketOpenSSL;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SmtpModule: TSmtpModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
