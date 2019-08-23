unit Unit_langdu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus,unit_data, ExtCtrls, ExtDlgs;

type
  TForm_langdu = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Memo1: TMemo;
    Timer1: TTimer;
    CheckBox2: TCheckBox;
    MP31: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure MP31Click(Sender: TObject);
  private
    { Private declarations }
    line_index: integer;
  public
    { Public declarations }
  end;

var
  Form_langdu: TForm_langdu;

implementation
      uses unit1,unit_mp3_yodao,unit_pop;
{$R *.dfm}

procedure TForm_langdu.Button1Click(Sender: TObject);
begin
   line_index:= 0;
   timer1.Enabled:= true;
end;

procedure TForm_langdu.Button2Click(Sender: TObject);
begin


  if button2.Caption='停止' then
   begin
    if timer1.Enabled then
     begin
      timer1.Enabled:= false;
      button2.Caption:='继续';
     end;
   end else begin
              timer1.Enabled:= true;
              button2.Caption:='停止';
            end;

end;

procedure TForm_langdu.Button3Click(Sender: TObject);
begin
  memo1.Lines.Clear;
  memo1.PasteFromClipboard;
  if memo1.Lines.Count>0 then
    begin
      line_index:= 0;
      button2.Caption:= '停止';
    end;
end;

procedure TForm_langdu.CheckBox1Click(Sender: TObject);
begin
 game_bg_music_rc_g.yodao_sound:= checkbox1.Checked;
end;

procedure TForm_langdu.Memo1DblClick(Sender: TObject);
var ss: string;
begin
  if baidu_busy then
   begin
    showmessage('百度语音合成正在下载或者朗读中，请等待。');
    exit;
   end;

  ss:= trim(memo1.Lines.Strings[memo1.CaretPos.y]);
  if ss<>'' then
   form_pop.skp_string(ss);
end;

procedure TForm_langdu.MP31Click(Sender: TObject);
var ss: string;
   i,l: integer;
   wss: widestring;
begin
   I:=Memo1.SelStart;
  l:=Memo1.SelLength;
// S:=MidStr(AllText,I+1,L); // 可以把Alltext定义为String，然后用这个函数
  wss:=  Memo1.Lines.Text;
  wss:=Copy(wss,I+1,L);
  //ss:= trim(memo1.SelText);
   ss:= wss;
  if ss='' then
   begin
    showmessage('请先选中要保存为mp3的文本。');
    exit;
   end;

  if length(ss)>1024 then
   begin
     showmessage('字符数最大只能1024个，多余部分将被裁切');
     ss:= copy(ss,1,1024);
   end;

 if checkbox1.Checked=false then
  begin
    showmessage('保存mp3只支持百度语音，将勾选百度语音。');
    checkbox1.Checked:= true;
    game_bg_music_rc_g.yodao_sound:= true;
  end;

   savedialog1.FileName:= '123.mp3';
  if savedialog1.Execute then
   begin
     mp3FileName:= savedialog1.FileName;
     form_pop.skp_string(ss);
   end;
end;

function IsMBCSChar(const ch: Char): Boolean;
begin
  Result := (ByteType(ch, 1) <> mbSingleByte); 
end;

procedure TForm_langdu.Timer1Timer(Sender: TObject);
var ss: string;
    i: integer;
begin
  if line_index>= memo1.Lines.Count then
         begin
           timer1.Enabled:= false;
           exit;
         end;

  if game_bg_music_rc_g.yodao_sound then
   begin
     if baidu_busy=false then
      begin
        ss:= trim(memo1.Lines.Strings[line_index]);
        if checkbox2.Checked then
          begin
            for I := 1 to length(ss) do
              begin
                if IsMBCSChar(ss[i]) then
                  begin
                   inc(line_index);
                   exit;
                  end;
              end;
          end;
        if ss<>'' then
           form_pop.skp_string(ss);
       inc(line_index);
      end;
   end else begin
              if form_pop.SpVoice1=nil then
                begin
                  showmessage('TTS朗读不可用，建议勾选左上角百度语音。');
                  timer1.Enabled:= false;
                  exit;
                end;
              if form_pop.SpVoice1.Status.RunningState= 1 then //SRSEDone then
                begin
                  ss:= trim(memo1.Lines.Strings[line_index]);
                  if checkbox2.Checked then
                      begin
                        for I := 1 to length(ss) do
                          begin
                            if IsMBCSChar(ss[i]) then
                              begin
                               inc(line_index);
                               exit;
                              end;
                          end;
                      end;
                   if ss<>'' then
                     form_pop.skp_string(ss);
                   inc(line_index);
                end;
            end;
end;

end.
