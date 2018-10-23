program SmtpServer;

uses
  Vcl.Forms,
  SmtpServerUnit in 'SmtpServerUnit.pas' {MainForm},
  SmtpModuleUnit in 'SmtpModuleUnit.pas' {SmtpModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSmtpModule, SmtpModule);
  Application.Run;
end.
