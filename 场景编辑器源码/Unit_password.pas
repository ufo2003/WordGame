unit Unit_password;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_password = class(TForm)
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    RadioButton5: TRadioButton;
    CheckBox1: TCheckBox;
    Button3: TButton;
    Edit4: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_password: TForm_password;

implementation
   uses unit1,md5;
{$R *.dfm}

function game_encrypt(const Src: string): string;
var

KeyLen :Integer;
KeyPos :Integer;
offset :Integer;
dest :string;
SrcPos :Integer;
SrcAsc :Integer;

Range :Integer;
key: string;
begin
    //加密字符串
    if Src= '' then
     begin
       result:= '';
       exit;
     end;
key:= 'fat dog';
KeyLen:=Length(Key);
KeyPos:=0;
//SrcPos:=0;
//SrcAsc:=0;
Range:=256;

Randomize;
offset:=Random(Range);
dest:=format('%1.2x',[offset]);
for SrcPos := 1 to Length(Src) do
begin
SrcAsc:=(Ord(Src[SrcPos]) + offset) MOD 255;
if KeyPos < KeyLen then KeyPos:= KeyPos + 1 else KeyPos:=1;
SrcAsc:= SrcAsc xor Ord(Key[KeyPos]);
dest:=dest + format('%1.2x',[SrcAsc]);
offset:=SrcAsc;
end;
Result:=Dest;

end;

procedure TForm_password.Button2Click(Sender: TObject);
begin
self.Close;
end;

procedure TForm_password.Button1Click(Sender: TObject);
var str1: Tstringlist;
begin
  //一致性检查
  if radiobutton1.Checked then
   begin
    if edit1.Text= '' then
     begin
      messagebox(handle,'选择自动加密时，必须输入默认密码。','错误', mb_ok);
      edit1.SetFocus;
      exit;
     end else begin
                if edit1.Text <> edit2.Text then
                 begin
                  messagebox(handle,'两次输入的密码不一致。','错误', mb_ok);
                  edit1.SetFocus;
                  exit;
                 end;
              end;
   end;

      if radiobutton3.Checked then
       if edit3.Text= '' then
         begin
          messagebox(handle,'选择自动解密，那么必须输入一个默认密码。','错误', mb_ok);
          edit3.SetFocus;
          exit;
         end;

//保存配置
   str1:= Tstringlist.Create;
    if radiobutton1.Checked then
        str1.Values['encrypt']:= '1'
        else if radiobutton2.Checked then
          str1.Values['encrypt']:= '2'
           else if radiobutton5.Checked then
                str1.Values['encrypt']:= '3'; //不加密


        str1.Values['savepas']:= game_encrypt(edit1.Text); //保存时用的密码

       if radiobutton3.Checked then
        str1.Values['dencrypt']:= '1'
        else if radiobutton4.Checked then
          str1.Values['dencrypt']:= '2';

        str1.Values['openpas']:= game_encrypt(edit3.Text); //打开文件时用的密码

       if checkbox1.Checked then
          str1.Values['showspace']:= '1'
           else
             str1.Values['showspace']:= '0';

      str1.SaveToFile(ExtractFilePath(application.ExeName)+'highlighters\set.dat');
   str1.Free;
//更新配置
    Form1.load_password_set;
  self.Close;
end;

procedure TForm_password.FormShow(Sender: TObject);
begin
  case save_type_G of
  1: radiobutton1.Checked:= true;
  2: radiobutton2.Checked:= true;
  3: radiobutton5.Checked:= true;
  end;
  case open_type_G of
  1: radiobutton3.Checked:= true;
  2: radiobutton4.Checked:= true;
  end;
  edit1.Text:= form1.get_save_ps;
  edit2.Text:= edit1.Text;

  edit3.Text:= form1.get_open_ps;

  checkbox1.Checked:= show_space; //是否启动时显示空白页
end;

procedure TForm_password.Button3Click(Sender: TObject);
begin
  if edit1.Text= '' then
   begin
    showmessage('请在上面的密码框内输入密码');
    exit;
   end;

   edit4.Text:= StrMD5(edit1.Text);
end;

end.
