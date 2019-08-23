unit Unit_chinese;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, OleServer, SpeechLib_TLB, ExtCtrls,ShellAPI;
  const
   msg_langdu_huancong=WM_USER + $7127; //此变量在unit_mp3_yodao 内被重复定义
type
  TForm_chinese = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    N9: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N8Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure SpVoice1EndStream(Sender: TObject; StreamNumber: Integer;
      StreamPosition: OleVariant);
  private
    { Private declarations }
    tts_init: boolean; //中文tts初始化后
    zhanting: boolean;
    procedure chinese_tts_init; //初始化中文引擎
    procedure load_set;
    procedure save_set;
    procedure msg_goods_c1(var msg: TMessage); message msg_langdu_huancong;
  public
    { Public declarations }
   // SpVoice1: TSpVoice;
    en_string,cn_string: string; //朗读缓冲
    procedure speak_string(const s: string);
    procedure speak_string_tongbu(const s: string);
    function wait_tts: boolean; //等待tts朗读结束
  end;

var
  Form_chinese: TForm_chinese;
     G_can_chinese_tts: boolean;
implementation
       uses unit_set,unit_pop,unit1,unit_data,unit_mp3_yodao;
{$R *.dfm}

procedure TForm_chinese.Button1Click(Sender: TObject);
var t: tpoint;
begin
 t:= button1.ClientOrigin;
 popupmenu1.Popup(t.X,t.Y);
end;

procedure TForm_chinese.chinese_tts_init;
var   SOToken: ISpeechObjectToken;
  SOTokens: ISpeechObjectTokens;
    I: Integer;
begin
   tts_init:= true;
 { if game_bg_music_rc_g.yodao_sound then
   begin
    tts_init:= true;  //百度语音能朗读中文
    exit;
   end;
 
    SOTokens := SpVoice1.GetVoices('', '');
  for I := 0 to SOTokens.Count - 1 do
  begin
    //For each voice, store the descriptor in the TStrings list
    SOToken := SOTokens.Item(I);
     if sotoken.GetAttribute('Language')= '804' then
      begin
       SOToken._AddRef;
       SpVoice1.Voice := SOToken;
       tts_init:= true;
       exit;
      end;
  end;
  n6.Caption:= '中文朗读引擎不存在';
  tts_init:= false;  }
end;

procedure TForm_chinese.FormCreate(Sender: TObject);
begin
    load_set;
   {
     try
      SpVoice1:= TSpVoice.Create(application);
      chinese_tts_init; //初始化中文引擎
     except
       SpVoice1:= nil;
       tts_init:= false;
       game_bg_music_rc_g.yodao_sound:= true;
     end;

     if not tts_init then
        G_can_chinese_tts:= false;   }

end;

procedure TForm_chinese.load_set;
var str1: Tstringlist;
begin
    //载入设置
   str1:= Tstringlist.Create;
      if FileExists(ExtractFilePath(application.ExeName)+'dat\tts_cn.dat') then
      begin
      str1.loadfromFile(ExtractFilePath(application.ExeName)+'dat\tts_cn.dat');
      n4.Checked:= str1.Values['spk_char']='1';
      n5.Checked:= str1.Values['spk_word']='1';
      n10.Checked:= str1.Values['spk_all_cn']='1';
         G_can_chinese_tts:= str1.Values['spk_cn']  ='1';
      n6.Checked:= G_can_chinese_tts;
      end else begin
                  n4.Checked:= true;
                  n5.Checked:= true;
                  n6.Checked:= true;
                  n10.Checked:= true;
                 G_can_chinese_tts:= true;
               end;
   str1.Free;

end;

procedure TForm_chinese.save_set;
var str1: Tstringlist;
begin
    //保存设置
   str1:= Tstringlist.Create;
      str1.Values['spk_char']:= inttostr(ord(n4.Checked));
      str1.Values['spk_word']:= inttostr(ord(n5.Checked));
      str1.Values['spk_cn']:= inttostr(ord(n6.Checked));
      str1.Values['spk_all_cn']:= inttostr(ord(n10.Checked));

      str1.SaveToFile(ExtractFilePath(application.ExeName)+'dat\tts_cn.dat');
   str1.Free;
end;

procedure TForm_chinese.speak_string(const s: string);
begin
    if tts_init then
    Form_pop.skp_string(s);
end;

procedure TForm_chinese.speak_string_tongbu(const s: string);
begin
    if tts_init then
    Form_pop.skp_string(s);
end;

procedure TForm_chinese.N4Click(Sender: TObject);
begin
   tmenuitem(sender).Checked:= not tmenuitem(sender).Checked;
   save_set;
end;

procedure TForm_chinese.Label3Click(Sender: TObject);
begin
     form_set.Label33Click(self); //显示下载tts界面
     messagebox(handle,'安装中文引擎后需重新启动游戏才能识别。','提示',mb_ok);
end;

procedure TForm_chinese.Label4Click(Sender: TObject);
begin
     Label3.Visible:= false;   //关闭提示
       Label4.Visible:= false;
end;

procedure TForm_chinese.FormShow(Sender: TObject);
begin
  Timer1.Enabled:= true;
end;

procedure TForm_chinese.N11Click(Sender: TObject);
begin
 form_set.Show;
end;

procedure TForm_chinese.N3Click(Sender: TObject);
begin
    ShowWindow(Handle, SW_HIDE);
end;

procedure TForm_chinese.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    Timer1.Enabled:= false;
end;

procedure TForm_chinese.N8Click(Sender: TObject);
begin
     if  zhanting then
      begin
        zhanting:= false;
        n8.Caption:= '暂停';
      end else begin
                 zhanting:= true;
                  n8.Caption:= '继续朗读';
               end;
end;

procedure TForm_chinese.Timer1Timer(Sender: TObject);
var ss,ss2,ss3: string;
    i: integer;
begin
     if zhanting then
        exit;

     if timer1.Tag= 0 then
       begin
        //*****************
        timer1.Enabled:= false;
        ss:= form_pop.wordlist1.Strings[form_pop.get_Word_id]; //取得单词编号，如果有错误重复选项，则会取回错误单词编号
        ss2:= copy(ss,1,pos('=',ss)-1);
        ss3:= copy(ss,pos('=',ss)+1,255);

        label1.Caption:= ss2;
        label2.Caption:= ss3;
         self.Update;
        application.ProcessMessages;

         if tts_init and n4.Checked then
            speak_string(ss2); //用中文引擎朗读字母

         en_string:= ss2;   //准备英文缓冲

       if (n10.Checked= false) and (length(ss3)> 8) then
         begin
           i:= pos(' ',ss3);   //朗读部分中文，到逗号或者空格为止
           if i= 0 then
              i:= pos('，',ss3);
           if i> 0 then
             ss3:= copy(ss3,1,i-1);
         end;

       if G_can_chinese_tts and n6.Checked then
       begin
        if ss3<> '' then
         begin
           cn_string:=ss3;
         end;
       end;
       end else timer1.Tag:= timer1.Tag- 1;
end;

function TForm_chinese.wait_tts: boolean;
begin
    if tts_init then
     result:= true;
    //result:= SpVoice1.Status.RunningState= SRSEDone;
end;

procedure TForm_chinese.N1Click(Sender: TObject);
begin
    postmessage(form1.Handle,WM_MYTRAYICONCALLBACK,0,WM_LBUTTONDOWN);
end;

procedure TForm_chinese.N9Click(Sender: TObject);
begin
     messagebox(handle,'您临时关闭了桌面背单词窗口，可以在“游戏设置”界面内选择是否关闭或开启此窗口。','提示',mb_ok);
     game_bg_music_rc_g.desktop_word:= false;
     close;
end;

procedure TForm_chinese.SpVoice1EndStream(Sender: TObject;
  StreamNumber: Integer; StreamPosition: OleVariant);
begin
   postmessage(handle,msg_langdu_huancong,1022,0);
end;

procedure TForm_chinese.msg_goods_c1(var msg: TMessage);
var str1: tstringlist;
begin
 //原先下载和朗读不同步，现在已经是先下载后朗读了，所以这个过程不需要了
      if msg.WParam= 1022 then
      begin
      screen.Cursor:= crhourglass;

      end
        else if msg.WParam= 1023 then
        begin
        //保存新的token
          str1:= tstringlist.Create;
          if FileExists(game_doc_path_g+'dat\set.txt') then
            str1.LoadFromFile(game_doc_path_g+'dat\set.txt')
               else
              str1.LoadFromFile(game_app_path_G+'dat\set.txt');
           str1.Values['token']:= token;
           str1.Values['expires']:= inttostr(get_second+token_expires);

           str1.saveToFile(game_doc_path_g+'dat\set.txt');
          str1.Free;
        screen.Cursor:= crdefault;
        end else if msg.WParam= 1024 then
              begin
              showmessage('获取百度语音授权失败，请安装最新版程序试试');
              ShellExecute(Handle,
              'open','IEXPLORE.EXE','http://www.finer2.com/wordgame',nil,sw_shownormal);
              end  else if msg.WParam= 1025 then
              begin
               if token_expires=40 then
                 showmessage('网络连接超时，下载百度语音文件失败，如果经常出现这个错误请检查网络状况或重启游戏试试，错误代码：'+ inttostr(token_expires))
                 else
                  showmessage('下载百度语音文件失败，一般重启游戏可以恢复，错误代码：'+ inttostr(token_expires));
              end  else if msg.WParam= 1026 then
              begin
              showmessage('播放百度语音文件失败，一般重启游戏可以恢复，错误代码：'+ inttostr(token_expires));
              end;

  {   if msg.WParam= 1022 then
      begin
       if en_string<> '' then
        begin
         form_pop.skp_string(en_string); //朗读英文
         en_string:= '';
        end else if cn_string<> '' then
                  begin
                   speak_string(cn_string); //朗读中文
                   cn_string:= '';
                  end else begin
                             if self.Showing then
                              begin
                               timer1.Enabled:= true;
                                 timer1.Tag:= 20; //两秒
                              // if Random(3)=0 then
                               // form_pop.show_ad(1); //显示广告加一，累计15显示广告
                              end;
                           end;

      end;   }
end;

end.
