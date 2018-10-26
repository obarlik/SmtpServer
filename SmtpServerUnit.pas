unit SmtpServerUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls;

type
  TMainForm = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActConfiguration: TAction;
    procedure ActConfigurationExecute(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  MainForm: TMainForm;

implementation

uses
  SmtpConfigurationUnit;

{$R *.dfm}

procedure TMainForm.ActConfigurationExecute(Sender: TObject);
begin
  TConfigurationForm
  .Create(Self)
  .ShowModal();
end;

end.
