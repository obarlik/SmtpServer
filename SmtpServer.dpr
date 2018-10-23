program SmtpServer;

uses
  Vcl.Forms,
  SmtpServerUnit in 'SmtpServerUnit.pas' {Form1},
  SmtpModuleUnit in 'SmtpModuleUnit.pas' {SmtpModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSmtpModule, SmtpModule);
  Application.Run;
end.
