unit Unit_exit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_exit = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_exit: TForm_exit;

implementation

{$R *.dfm}

procedure TForm_exit.Button4Click(Sender: TObject);
begin
 self.ModalResult:= mrcancel;
end;

procedure TForm_exit.Button1Click(Sender: TObject);
begin
 self.ModalResult:= mrok;
end;

procedure TForm_exit.Button2Click(Sender: TObject);
begin
   self.ModalResult:= mryes;
end;

procedure TForm_exit.Button3Click(Sender: TObject);
begin
  self.ModalResult:= mrno;
end;

end.
