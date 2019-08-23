unit Unit_paiban;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_paiban = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    RadioButton_left: TRadioButton;
    RadioButton_right: TRadioButton;
    Label2: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    Button3: TButton;
    Label8: TLabel;
    Edit5: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Edit6: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Edit7: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function clean_pos(ss: string): string;
  public
    { Public declarations }
    char_W,char_h: integer;
  end;

var
  Form_paiban: TForm_paiban;

implementation
    uses unit_gpic;
{$R *.dfm}

procedure TForm_paiban.Button2Click(Sender: TObject);
begin
close;
end;

procedure TForm_paiban.Button3Click(Sender: TObject);
begin
if messagebox(handle,'是否清除全部定位信息？','询问',mb_yesno or MB_ICONQUESTION)= mryes then
 begin
  form_gpic.text_result:= clean_pos(edit2.Text);
  close;
 end;
end;

procedure TForm_paiban.FormShow(Sender: TObject);
begin
  edit2.Text:=
     clean_pos(form_gpic.text_result);
  edit5.Text:= inttostr(char_h div 2); //行高
   edit6.Text:= inttostr(char_w div 2); //列宽
end;

procedure TForm_paiban.Button1Click(Sender: TObject);
var i: integer;
    ss,ss2: widestring;
    acol,arow: integer;//当前列号和当前行号
begin
  if edit1.Text= '' then
     edit1.Text:= '50';
  if edit3.Text= '' then
     edit3.Text:= '25';
  if edit4.Text= '' then
     edit4.Text:= '1';

  ss:= edit2.Text;
  ss2:= '';
  i:= 1;
  while i <= length(ss) do
    begin
    //计算出离开左右边缘的距离
    acol:= i div (strtoint(edit7.text) + 1) * (char_w + strtoint(edit6.Text))+
           strtoint(edit1.Text) + char_w;

    if radiobutton_right.Checked then
       acol:= acol * -1; //右边的采用负值

    //计算出离顶部的距离
    arow:= ((i-1) mod strtoint(edit7.text)) * (char_h + strtoint(edit5.Text))
           + strtoint(edit3.Text);

     ss2:= ss2 + '{'+inttostr(acol)+'@'+ inttostr(arow)+ '}'+ copy(ss,i,strtoint(edit4.Text));

     inc(i,strtoint(edit4.Text));
    end;
 form_gpic.text_result:= ss2;
 close;
end;

procedure TForm_paiban.Edit2Change(Sender: TObject);
begin
  if pos('{',edit2.Text)= 0 then
    begin
     case length(edit2.Text) of
      1..9: edit7.Text:= inttostr(length(edit2.Text));
      10: edit7.Text:= '5';
      14: edit7.Text:= '7';
      16: edit7.Text:= '8';
      20: edit7.Text:= '5';
      24: edit7.Text:= '6';
      28: edit7.Text:= '7';
      32: edit7.Text:= '8';
    end;
  end;
end;

function TForm_paiban.clean_pos(ss: string): string;
var i: integer;
    b: boolean;
begin

  b:= false;
  for i:= length(ss) downto 1 do
    begin
     if ss[i]= '}' then
      b:= true;
     if ss[i]= '{' then
      begin
       b:= false;
       delete(ss,i,1);
      end;

     if b then
        delete(ss,i,1);

     result:= ss;
    end;

end;

procedure TForm_paiban.FormCreate(Sender: TObject);
begin
 SetWindowLong(Edit1.Handle, GWL_STYLE, GetWindowLong(Edit1.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(Edit3.Handle, GWL_STYLE, GetWindowLong(Edit3.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(Edit4.Handle, GWL_STYLE, GetWindowLong(Edit4.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(Edit5.Handle, GWL_STYLE, GetWindowLong(Edit5.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(Edit6.Handle, GWL_STYLE, GetWindowLong(Edit6.Handle, GWL_STYLE) or ES_NUMBER);
 SetWindowLong(Edit7.Handle, GWL_STYLE, GetWindowLong(Edit7.Handle, GWL_STYLE) or ES_NUMBER);


end;

end.
