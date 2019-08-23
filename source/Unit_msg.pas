unit Unit_msg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm_msg = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_msg: TForm_msg;

implementation

{$R *.dfm}

procedure TForm_msg.Timer1Timer(Sender: TObject);
begin
timer1.Enabled:= false;
 close;
end;

end.
