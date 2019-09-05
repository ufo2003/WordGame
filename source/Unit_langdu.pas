unit Unit_langdu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus,unit_data, ExtCtrls, ExtDlgs, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent,System.Hash;

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
    Label2: TLabel;
    Button4: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Button5: TButton;
    NetHTTPClient1: TNetHTTPClient;
    Label5: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Memo1DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure MP31Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
    line_index: integer;
    duanluo_total: integer;
  public
    { Public declarations }
  end;

var
  Form_langdu: TForm_langdu;

implementation
      uses unit1,unit_mp3_yodao,unit_pop,speechlib_tlb;
{$R *.dfm}
function GetComputerName: string;
var
  buffer: array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size: Cardinal;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  Windows.GetComputerName(@buffer, Size);
  Result := strpas(buffer);
end;

function WideToUTF8(const WS: WideString): UTF8String;
var
len: integer;
us: UTF8String;
begin
Result:='';
if (Length(WS) = 0) then
exit;
len:=WideCharToMultiByte(CP_UTF8, 0, PWideChar(WS), -1, nil, 0, nil, nil);
SetLength(us, len);
WideCharToMultiByte(CP_UTF8, 0, PWideChar(WS), -1, PansiChar(us), len, nil, nil);
Result:=trim(us);
end;

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

procedure TForm_langdu.Button4Click(Sender: TObject);
var ss,md5_s,pc_name,err,city: string;
  I,k: Integer;
  str1: tstringlist;
  //ss_utf8: utf8string;
begin
  //上传到服务器，先检测再上传

  if length(memo1.Text)>50000 then
   begin
     showmessage('字数过多，不能大于50K。');
     exit;
   end;
   err:= '';
   ss:= '<p>';
   k:= 0;
   for I := 0 to memo1.Lines.Count-1 do
    begin
     if (trim(memo1.Lines.Strings[i])='') or (i=memo1.Lines.Count-1) then
       begin
         //统计单次上传的长度
         if length(ss)>512 then
          begin
           Memo1.SelStart:=SendMessage(Memo1.Handle, EM_LINEINDEX, i, 0);
           Memo1.SelLength := Length(Memo1.Lines[i]);
           showmessage('第'+ inttostr(i)+'行所在的段落字数过多，段落之间需用空行隔开，迷宫每次显示一个段落，每个段落字数不能超过512个字符。');
            exit;
          end;
         ss:= '<p>';
       end else ss:= ss+ memo1.Lines.Strings[i] +'<br>';
    end;

    Button4.Enabled:= false;
    screen.Cursor:= crhourglass;
    city:= '';
   ss:= '<p>';
   str1:= tstringlist.Create;
   for I := 0 to memo1.Lines.Count-1 do
    begin
     if (trim(memo1.Lines.Strings[i])='') or (i=memo1.Lines.Count-1) then
       begin
         //上传
         if (i=memo1.Lines.Count-1) and (trim(memo1.Lines.Strings[i])<>'') then
           ss:= ss+ memo1.Lines.Strings[i] +'<br>';

        if length(ss)>30 then
         begin
           if duanluo_total>0 then
             begin
            label4.Caption:= '上传中'+k.ToString+ '/'+ duanluo_total.ToString+ ' 完成'+ formatfloat('0.0',k / duanluo_total * 100)+'%';
            label4.update;
             application.ProcessMessages;
             end;

           ss:= WideToUTF8(ss);
           pc_name:= WideToUTF8(GetComputerName);
           //ss_utf8:= pc_name + ss+ 'pxuv0583erql';
           //md5_s:= THashMD5.GetHashString(ss_utf8);
             md5_s:= THashMD5.GetHashString(pc_name + ss+ 'pxuv0583erql');
           str1.Clear;
           str1.Add('nm='+ pc_name);
           str1.Add('text='+ss);
           str1.Add('md5='+ md5_s);
           str1.Add('city='+ WideToUTF8(city));
           ss:= nethttpclient1.post('http://download.abcd666.cn/readtext/set_text.php',str1).ContentAsString(tencoding.UTF8);

           if pos('ok:',ss)>0 then
            begin
            inc(k);
            if city='' then
               city:= ss.Substring(3,32);
            end else err:= err+' '+ss;


         end;
         ss:= '<p>';
       end else ss:= ss+ memo1.Lines.Strings[i] +'<br>';
    end;
    str1.Free;
    Button4.Enabled:= true;
    screen.Cursor:= crdefault;
     label4.Caption:= '上传完成。';
     label4.update;
     application.ProcessMessages;

    if err='' then
     showmessage('成功提交了'+k.ToString+'段阅读材料，感谢您的分享，阅读材料将在后台审核后可用。')
     else
      showmessage('已提交'+k.ToString+'段阅读材料，并有错误信息：'+err);

      label4.Caption:= '';
end;

procedure TForm_langdu.Button5Click(Sender: TObject);
var str1: Tstringlist;
begin
   str1:= tstringlist.Create;
    str1.Add('nm='+WideToUTF8(GetComputerName));
     showmessage(nethttpclient1.post('http://download.abcd666.cn/readtext/get_count.php',str1).ContentAsString(tencoding.UTF8));
   str1.Free;
end;

procedure TForm_langdu.CheckBox1Click(Sender: TObject);
begin
 game_bg_music_rc_g.yodao_sound:= checkbox1.Checked;
end;

procedure TForm_langdu.Memo1Change(Sender: TObject);
var
  I: Integer;
begin
duanluo_total:= 0;
 for I := 0 to memo1.Lines.Count-1 do
    begin
     if (trim(memo1.Lines.Strings[i])='') or (i=memo1.Lines.Count-1) then
       inc(duanluo_total);
    end;

 label5.Caption:='迷宫内每次显示一段文字，字数不能少于30个，段与段之间用空行隔开，当前段落数：'+ duanluo_total.tostring+ ' 总字数：'+ length(memo1.Text).tostring;
  if length(memo1.Text)>50000 then
    label4.Caption:='字数过多不能大于50K';

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

              if form_pop.SpVoice1.Status.RunningState = 1 then //SRSEDone then
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
