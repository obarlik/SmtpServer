program SmtpServer;

uses
  Vcl.Forms,
  SmtpServerUnit in 'SmtpServerUnit.pas' {MainForm},
  SmtpConfigurationUnit in 'SmtpConfigurationUnit.pas' {ConfigurationForm},
  SmtpModuleUnit in 'SmtpModuleUnit.pas' {SmtpModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TConfigurationForm, ConfigurationForm);
  Application.CreateForm(TSmtpModule, SmtpModule);
  Application.Run;
end.
