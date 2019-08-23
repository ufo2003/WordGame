unit Unit_scene_option;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtDlgs,jpeg;

type
  TForm_scene_option = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox_mi: TCheckBox;
    CheckBox_temp: TCheckBox;
    CheckBox_notstop: TCheckBox;
    CheckBox_after: TCheckBox;
    CheckBox_before: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    CheckBox_b_pic: TCheckBox;
    CheckBox_b_sound: TCheckBox;
    Edit3: TEdit;
    Edit4: TEdit;
    Button3: TButton;
    Button4: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    OpenDialog1: TOpenDialog;
    CheckBox_color: TCheckBox;
    Label1: TLabel;
    ColorDialog1: TColorDialog;
    CheckBox_link: TCheckBox;
    CheckBox_alink: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox_vlink: TCheckBox;
    Label4: TLabel;
    Button5: TButton;
    CheckBox_home: TCheckBox;
    RadioButton_PP: TRadioButton;
    RadioButton_LS: TRadioButton;
    RadioButton_GD: TRadioButton;
    CheckBox_tuichu: TCheckBox;
    Edit5: TEdit;
    CheckBox_not_down_img: TCheckBox;
    CheckBox_text: TCheckBox;
    Label5: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure CheckBox_beforeClick(Sender: TObject);
    procedure CheckBox_afterClick(Sender: TObject);
    procedure CheckBox_b_picClick(Sender: TObject);
    procedure CheckBox_b_soundClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CheckBox_tuichuClick(Sender: TObject);
  private
    { Private declarations }
    mu_play: boolean;
  public
    { Public declarations }
  end;

var
  Form_scene_option: TForm_scene_option;

implementation
   uses unit1,mmsystem,FastStrings;
{$R *.dfm}

procedure TForm_scene_option.Button2Click(Sender: TObject);
begin
self.Close;
end;

procedure TForm_scene_option.CheckBox_beforeClick(Sender: TObject);
begin

    edit1.Enabled:= CheckBox_before.Checked;
end;

procedure TForm_scene_option.CheckBox_afterClick(Sender: TObject);
begin
   edit2.Enabled:= CheckBox_after.Checked;
end;

procedure TForm_scene_option.CheckBox_b_picClick(Sender: TObject);
begin
   edit3.Enabled:= CheckBox_b_pic.Checked;
   button3.Enabled:= CheckBox_b_pic.Checked;
   radiobutton_gd.Enabled:= CheckBox_b_pic.Checked;
   radiobutton_pp.Enabled:=  CheckBox_b_pic.Checked;
   radiobutton_ls.Enabled:= CheckBox_b_pic.Checked;
end;

procedure TForm_scene_option.CheckBox_b_soundClick(Sender: TObject);
begin
   edit4.Enabled:= CheckBox_b_sound.Checked;
   button4.Enabled:= CheckBox_b_sound.Checked;
end;

procedure TForm_scene_option.Button1Click(Sender: TObject);
begin
   if CheckBox_before.Checked and (edit1.Text= '') then
      begin
       messagebox(handle,'您选中了载入前事件，请在右边的输入框内输入函数语句。','提示',
                  mb_ok or MB_ICONWARNING);
       edit1.SetFocus;
       exit;
      end;
   if CheckBox_after.Checked and (edit2.Text= '') then
      begin
       messagebox(handle,'您选中了载入后事件，请在右边的输入框内输入函数语句。','提示',
                  mb_ok or MB_ICONWARNING);
       edit2.SetFocus;
       exit;
      end;
    if CheckBox_tuichu.Checked and (edit5.Text= '') then
      begin
       messagebox(handle,'您选中了载入后事件，请在右边的输入框内输入函数语句。','提示',
                  mb_ok or MB_ICONWARNING);
       edit5.SetFocus;
       exit;
      end;
    if CheckBox_B_pic.Checked then
      begin
       if edit3.Text= '' then
       begin
       messagebox(handle,'您选中了背景图片，请在右边的输入框内输入背景文件路径。','提示',
                  mb_ok or MB_ICONWARNING);
       edit3.SetFocus;
       exit;
       end;
       //拷贝文件到img文件夹
        if not FileExists(data_path+'img\'+ ExtractFileName(edit3.Text)) then
           copyfile(pchar(edit3.text),pchar(data_path+'img\'+ ExtractFileName(edit3.Text)),true);
      end;
    if CheckBox_B_sound.Checked then
      begin
       if edit4.Text= '' then
       begin
       messagebox(handle,'您选中了背景音乐，请在右边的输入框内输入背景文件路径。','提示',
                  mb_ok or MB_ICONWARNING);
       edit4.SetFocus;
       exit;
       end;
       //拷贝文件到音乐文件夹
       if not FileExists(data_path+'music\'+ ExtractFileName(edit4.Text)) then
           copyfile(pchar(edit4.text),pchar(data_path+'music\'+ ExtractFileName(edit4.Text)),true);
      end;
  self.ModalResult:= mrok;

end;

procedure TForm_scene_option.Button3Click(Sender: TObject);
begin
   openpicturedialog1.InitialDir:= data_path+'img';
 if openpicturedialog1.Execute then
    edit3.Text:= openpicturedialog1.FileName;

end;

procedure TForm_scene_option.Button4Click(Sender: TObject);
begin
   opendialog1.InitialDir:= data_path +'music';
   if opendialog1.Execute then
    edit4.Text:= opendialog1.FileName;
end;

procedure TForm_scene_option.Label1Click(Sender: TObject);
begin
  if colordialog1.Execute then
     (Sender as tlabel).Color:= colordialog1.Color;
end;

procedure TForm_scene_option.FormCreate(Sender: TObject);
begin
 label1.Color:= clwindow;
 label2.Color:= clblue;
 label3.Color:= clgreen;
 label4.Color:= clred;
end;

procedure TForm_scene_option.Edit4Change(Sender: TObject);
begin
    button5.Enabled:= edit4.Text<> '';
    if edit4.Text<> '' then
     begin
      button5.Caption:= '试听';
      MCISendString('STOP NN386', '', 0, 0);
      MCISendString('CLOSE NN386', '', 0, 0);
       mu_play:= false;
     end;
end;

procedure TForm_scene_option.Button5Click(Sender: TObject);
var ss: string;
begin
if mu_play then
 begin
  MCISendString('STOP NN386', '', 0, 0);
  MCISendString('CLOSE NN386', '', 0, 0);
  mu_play:= false;
  button5.Caption:= '试听';
  exit;
 end;
screen.Cursor:= crhourglass;
button5.Enabled:= false;
MCISendString('STOP NN386', '', 0, 0);
MCISendString('CLOSE NN386', '', 0, 0);
application.ProcessMessages;
ss:= edit4.Text;
 if pos('$apppath$',ss)> 0 then
    ss:= FastReplace(ss,'$apppath$',data_path,true);

MCISendString(pchar('OPEN '+ExtractShortPathName(ss)+' TYPE SEQUENCER ALIAS NN386'), '', 0, 0);
mu_play:= true;
 button5.Caption:= '停止';
screen.Cursor:= crdefault;
MCISendString('PLAY NN386 FROM 0', '', 0, 0);
MCISendString('CLOSE ANIMATION', '', 0, 0);
button5.Enabled:= true;
end;

procedure TForm_scene_option.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if mu_play then
 begin
  MCISendString('STOP NN386', '', 0, 0);
  MCISendString('CLOSE NN386', '', 0, 0);
  mu_play:= false;
  button5.Caption:= '试听';
  exit;
 end;
end;

procedure TForm_scene_option.CheckBox_tuichuClick(Sender: TObject);
begin
   edit5.Enabled:= CheckBox_tuichu.Checked;
end;

end.
