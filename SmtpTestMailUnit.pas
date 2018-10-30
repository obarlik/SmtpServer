unit SmtpTestMailUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSmtpTestForm = class(TForm)
    MailFrom: TLabeledEdit;
    MailTo: TLabeledEdit;
    Send: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SmtpTestForm: TSmtpTestForm;

implementation

{$R *.dfm}

end.
