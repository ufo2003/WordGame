unit Unit_set;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,shellapi,jpeg, ExtDlgs,Unit_music;

type
  TForm_set = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    gbAttrs: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    lblMinSpeed: TLabel;
    lblMaxSpeed: TLabel;
    lblRate: TLabel;
    lblMinVolume: TLabel;
    lblMaxVolume: TLabel;
    lblVolume: TLabel;
    tbRate: TTrackBar;
    tbVolume: TTrackBar;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CheckBox1: TCheckBox;
    Label13: TLabel;
    Button7: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label14: TLabel;
    Edit5: TEdit;
    Label22: TLabel;
    Edit13: TEdit;
    Edit6: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Edit7: TEdit;
    Label17: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Label19: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    Label21: TLabel;
    Edit18: TEdit;
    Label27: TLabel;
    Label26: TLabel;
    Edit17: TEdit;
    Edit16: TEdit;
    Label25: TLabel;
    Label24: TLabel;
    Edit15: TEdit;
    Edit14: TEdit;
    Label23: TLabel;
    TabSheet2: TTabSheet;
    CheckBox5: TCheckBox;
    Button5: TButton;
    TabSheet3: TTabSheet;
    ListBox1: TListBox;
    Label3: TLabel;
    Button8: TButton;
    Button9: TButton;
    TabSheet4: TTabSheet;
    ListBox2: TListBox;
    Button10: TButton;
    Button11: TButton;
    CheckBox8: TCheckBox;
    Button12: TButton;
    Button13: TButton;
    TrackBar1: TTrackBar;
    Label9: TLabel;
    Label28: TLabel;
    TrackBar2: TTrackBar;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    CheckBox10: TCheckBox;
    OpenPictureDialog1: TOpenPictureDialog;
    OpenDialog1: TOpenDialog;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    Button18: TButton;
    Label29: TLabel;
    TrackBar3: TTrackBar;
    Button19: TButton;
    TabSheet5: TTabSheet;
    CheckBox_sch: TCheckBox;
    Label30: TLabel;
    Edit_sch_key: TEdit;
    GroupBox4: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Label31: TLabel;
    Edit19: TEdit;
    Button20: TButton;
    Button21: TButton;
    TabSheet6: TTabSheet;
    Label2: TLabel;
    Edit2: TEdit;
    Label6: TLabel;
    Edit3: TEdit;
    Label7: TLabel;
    Edit4: TEdit;
    Label10: TLabel;
    ComboBox_fen: TComboBox;
    Label11: TLabel;
    ComboBox_cuo: TComboBox;
    Label12: TLabel;
    ComboBox_ting: TComboBox;
    GroupBox3: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    CheckBox9: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    Label32: TLabel;
    Label33: TLabel;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    Label34: TLabel;
    Edit20: TEdit;
    Button22: TButton;
    CheckBox19: TCheckBox;
    Label35: TLabel;
    Label36: TLabel;
    FontDialog1: TFontDialog;
    Button6: TButton;
    Label8: TLabel;
    Edit21: TEdit;
    Label37: TLabel;
    Edit22: TEdit;
    GroupBox5: TGroupBox;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    Label38: TLabel;
    Edit23: TEdit;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbRateChange(Sender: TObject);
    procedure tbVolumeChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure TrackBar3Exit(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure CheckBox_schClick(Sender: TObject);
    procedure Edit_sch_keyExit(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure Edit19Exit(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Edit_sch_keyEnter(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure CheckBox16Click(Sender: TObject);
    procedure Label33Click(Sender: TObject);
    procedure CheckBox17Click(Sender: TObject);
    procedure CheckBox18Click(Sender: TObject);
    procedure Edit20Exit(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure CheckBox19Click(Sender: TObject);
    procedure Label35Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure Edit21Exit(Sender: TObject);
    procedure Edit22Exit(Sender: TObject);
    procedure RadioButton7Click(Sender: TObject);
    procedure Edit23Exit(Sender: TObject);
  private
    { Private declarations }
    L_needchange: boolean; //需要修改当前语言
    g_danci_w: boolean;
    key_ss_prv: string;
    procedure change_hotkey;
    procedure tts_list_rf; //刷新tts引擎列表
  public
    { Public declarations }
  end;

var
  Form_set: TForm_set;
  t_music: tr_music;

implementation
   uses unit1,unit_pop,SpeechLib_TLB,Menus,unit_data,shlobj;
{$R *.dfm}

procedure TForm_set.Button3Click(Sender: TObject);
begin
self.Close;
end;

procedure TForm_set.FormCreate(Sender: TObject);
var
  SOToken: ISpeechObjectToken;
  str1: Tstringlist;
begin
       //读取设置文件
   str1:= Tstringlist.Create;  //初始化背单词文本和背景颜色
   if FileExists(game_doc_path_g+'dat\set.txt') then
     str1.LoadFromFile(game_doc_path_g+'dat\set.txt')
     else
      str1.LoadFromFile(game_app_path_G+'dat\set.txt');

   { game_E_color_R:= strtoint(str1.Values['game_E_color_R']);
    game_E_color_G:= strtoint(str1.Values['game_E_color_G']);
    game_E_color_B:= strtoint(str1.Values['game_E_color_B']);
       game_C_color_R:= strtoint(str1.Values['game_C_color_R']);
       game_C_color_G:= strtoint(str1.Values['game_C_color_G']);
       game_C_color_B:= strtoint(str1.Values['game_C_color_B']);
       game_BE_color_R:= strtoint(str1.Values['game_BE_color_R']);
       game_BE_color_G:= strtoint(str1.Values['game_BE_color_G']);
       game_BE_color_B:= strtoint(str1.Values['game_BE_color_B']);
       game_BC_color_R:= strtoint(str1.Values['game_BC_color_R']);
       game_BC_color_G:= strtoint(str1.Values['game_BC_color_G']);
       game_BC_color_B:= strtoint(str1.Values['game_BC_color_B']); }
       edit3.Text:= str1.Values['game_en_size'];
       edit4.Text:= str1.Values['game_cn_size'];
        if str1.Values['game_speed_a']='1' then //动画速度
         radiobutton1.Checked:= true
          else
           radiobutton2.Checked:= true;

        if str1.Values['game_tts_sooth'] = '1' then
         checkbox1.Checked:= true
       else
         checkbox1.Checked:= false;

        if str1.Values['game_bk'] = '1' then
         checkbox2.Checked:= true
       else
         checkbox2.Checked:= false; //是否开启黑色背景
       if str1.Values['game_width'] = '1' then
         checkbox3.Checked:= true
       else
         checkbox3.Checked:= false; //是否单词栏双倍宽度
       if str1.Values['game_shunxu'] = '1' then
         checkbox4.Checked:= true
       else
         checkbox4.Checked:= false; //是否顺序背
       if str1.Values['game_abhs'] = '1' then
         checkbox5.Checked:= true
       else
         checkbox5.Checked:= false; //是否艾宾号斯

      if str1.Values['no_image'] = '1' then
         checkbox6.Checked:= true
       else
         checkbox6.Checked:= false;

      if str1.Values['No_RevealTrans'] = '1' then
         checkbox7.Checked:= true
       else
         checkbox7.Checked:= false;

         if str1.Values['bg_lrc'] = '1' then  //禁止显示歌词
         checkbox8.Checked:= true
       else
         checkbox8.Checked:= false;

       if str1.Values['mg_pop'] = '1' then  //迷宫弹出式背单词窗口
         checkbox9.Checked:= true
       else
         checkbox9.Checked:= false;

    if strtoint2(str1.Values['delay_show_word']) < 3000 then
       edit2.Text:= '3000'
       else
        edit2.Text:= str1.Values['delay_show_word'];

      combobox_fen.ItemIndex:= strtoint2(str1.Values['game_m_color']);
      combobox_cuo.ItemIndex:= strtoint2(str1.Values['game_rep']);
      ComboBox_ting.ItemIndex:= strtoint2(str1.Values['game_tingli_i']);
      CheckBox_sch.Checked:=    (str1.Values['sch_enable']='1');
      edit_sch_key.text:=            str1.Values['sch_key'];
      edit19.Text:=                  str1.Values['sch_img_height'];
      checkbox13.Checked:=  (str1.Values['not_tiankong']='1');
      checkbox14.Checked:=  (str1.Values['type_word']='1');
        checkbox15.Checked:=  (str1.Values['type_word_flash']='1');
        checkbox16.Checked:=  (str1.Values['type_char_spk']='1');
          checkbox15.Enabled:= checkbox14.Checked;
          checkbox16.Enabled:= checkbox14.Checked;
        checkbox17.Checked:=  (str1.Values['desktop_word']='1');
        checkbox18.Checked:=  (str1.Values['yodao_sound']='1');
        checkbox19.Checked:=  (str1.Values['down_readfile']='1');
         label35.Font.Name:= str1.Values['en_type_name'];
          label35.Caption:= label35.Font.Name;
         label36.Font.Name:= str1.Values['cn_type_name'];
          label36.Caption:= label36.Font.Name;

      edit20.Text:=                  str1.Values['part_size'];
      if edit20.Text= '' then
         edit20.Text:= '0';

      if strtoint(edit20.Text) > 0 then
      setlength(part_size_g,strtoint(edit20.Text)+1);  //保存分段背诵的数组。加一是因为一位置用来保存进度了

      case strtoint(str1.Values['sch_img_sty']) of
      0: radiobutton3.Checked:= true;
      1: radiobutton4.Checked:= true;
      2: radiobutton5.Checked:= true;
       else
         radiobutton3.Checked:= true;
      end;

   try
    tts_list_rf; //创建tts引擎列表

  if combobox1.Items.Count > 2 then
  begin
     if strtoint2(str1.Values['game_tts_index'])< combobox1.Items.Count then
        combobox1.ItemIndex := strtoint2(str1.Values['game_tts_index'])
        else
        combobox1.ItemIndex := 0; //Select 1st voice

    {  SOToken := ISpeechObjectToken(Pointer(
          combobox1.Items.Objects[combobox1.ItemIndex]));
      if sotoken.GetAttribute('Language')= '804' then
         L_needchange:= true;

    if L_needchange then
     begin

         //如果发现当前引擎是简体中文，而且引擎号是默认值零，那么主动修改
         if messagebox(handle,'当前默认语音引擎可能是中文发音，是否更改为英文？本修改不会影响您电脑上的其他设置。','提示',mb_yesno)= mryes then
          begin
           case combobox1.ItemIndex of
             0: if combobox1.Items.Count > 1 then combobox1.ItemIndex:= 1;
             1..9: combobox1.ItemIndex:= 0;
           end;
          end;
     end;  }
    combobox1.OnChange(combobox1); //& ensure OnChange triggers
  end else begin
             //语音引擎不可用
          {   gbAttrs.Enabled:= false;
             label8.Visible:= true;
             button4.Enabled:= false;
             button1.Enabled:= false;
             form_pop.CheckBox2.Checked:= false;
             form_pop.CheckBox2.Hint:= '朗读不可用，可能您电脑上没有安装语音合成引擎，百度语音自动启用。';
             form_pop.CheckBox2.Enabled:= false;   }
             game_bg_music_rc_g.yodao_sound:= true;
             //ShellExecute(Handle,
              //  'open','IEXPLORE.EXE',pchar('http://www.finer2.com/wordgame/tts.htm'),nil,sw_shownormal);

           end;
   except
    form_pop.CheckBox2.Hint:= '朗读不可用，可能您电脑上没有安装语音合成引擎，百度语音自动启用。';
    game_bg_music_rc_g.yodao_sound:= true;
   end;

   str1.Free;

  SetWindowLong(Edit2.Handle, GWL_STYLE, GetWindowLong(Edit1.Handle, GWL_STYLE) or ES_NUMBER);
  SetWindowLong(Edit3.Handle, GWL_STYLE, GetWindowLong(Edit3.Handle, GWL_STYLE) or ES_NUMBER);
  SetWindowLong(Edit4.Handle, GWL_STYLE, GetWindowLong(Edit4.Handle, GWL_STYLE) or ES_NUMBER);
  SetWindowLong(Edit20.Handle, GWL_STYLE, GetWindowLong(Edit20.Handle, GWL_STYLE) or ES_NUMBER);
end;

procedure TForm_set.ComboBox1Change(Sender: TObject);
var
  SOToken: ISpeechObjectToken;
begin
 if (combobox1.Text='下载音质更好的TTS') or (combobox1.Text='TTS不存在，立即下载') then
 begin
  combobox1.ItemIndex:=ComboBox1.Tag;
  ShellExecute(Handle,
         'open','IEXPLORE.EXE',pchar('http://www.finer2.com/wordgame/downtts.htm'),nil,sw_shownormal);
 end else if combobox1.Text='刷新列表' then
            begin
             combobox1.ItemIndex:=ComboBox1.Tag;
             tts_list_rf; //刷新列表
             messagebox(handle,'如果您新安装了语音朗读引擎，且刷新列表后选择新的朗读引擎后不能朗读，那么请重启电脑试试。另外，有些朗读引擎安装时请按默认路径安装，更改安装路径可能导致TTS工作不正常。','提示',mb_ok);

            end else
         begin
         if form_pop.SpVoice1<>nil then
          begin
           if combobox1.ItemIndex=-1 then
             combobox1.ItemIndex:= 0;

          SOToken := ISpeechObjectToken(Pointer(
          combobox1.Items.Objects[combobox1.ItemIndex]));
          form_pop.SpVoice1.Voice := SOToken;
          ComboBox1.Tag:= combobox1.ItemIndex;
          if self.Showing and (checkbox1.Checked or checkbox18.Checked) then
             begin
               checkbox1.Checked:= false;
               checkbox18.Checked:= false;
               messagebox(handle,'您重新设置了tts引擎，因此百度语音或者金山词霸声音优先的选项被取消，如果需要，你可以重新勾选。','提示',mb_ok);
             end;
          end;
         end;
end;

procedure TForm_set.FormShow(Sender: TObject);
var i: integer;
begin
   if form_pop.SpVoice1<>nil then
    begin
     tbRate.Position := form_pop.SpVoice1.Rate;
     lblRate.Caption := IntToStr(tbRate.Position);
     tbVolume.Position := form_pop.SpVoice1.Volume;
     lblVolume.Caption := IntToStr(tbVolume.Position);
    end else begin
     tbRate.Enabled:= false;
     tbVolume.Enabled:= false;
    end;

      edit8.Text := ShortCutToText(form_pop.Action1.ShortCut);
      edit9.Text := ShortCutToText(form_pop.Action2.ShortCut);
      edit10.Text:= ShortCutToText(form_pop.Action3.ShortCut);
      edit11.Text:= ShortCutToText(form_pop.Action4.ShortCut);
      edit12.Text:= ShortCutToText(form_pop.Action5.ShortCut);
      edit5.Text := ShortCutToText(form_pop.Action6.ShortCut);
      edit6.Text := ShortCutToText(form_pop.Action7.ShortCut);
      edit7.Text := ShortCutToText(form_pop.Action9.ShortCut);
      edit13.Text:= ShortCutToText(form_pop.Action8.ShortCut);

      edit14.Text:= ShortCutToText(form_pop.Action16.ShortCut);
      edit15.Text:= ShortCutToText(form_pop.Action17.ShortCut);
      edit16.Text:= ShortCutToText(form_pop.Action18.ShortCut);
      edit17.Text:= ShortCutToText(form_pop.Action19.ShortCut);
      edit18.Text:= ShortCutToText(form_pop.Action20.ShortCut);

      g_danci_w:= false;

      listbox1.Items.Clear;

    if Assigned(bg_img_filelist_g) then
     begin
      for i:= 0 to bg_img_filelist_g.Count-1 do
         listbox1.Items.Append(ExtractFileName(bg_img_filelist_g.Strings[i]));
     end;

      listbox2.Items.Clear;
    if Assigned(bg_music_filelist_g) then
     begin
      for i:= 0 to bg_music_filelist_g.Count-1 do
         listbox2.Items.Append(ExtractFileName(bg_music_filelist_g.Strings[i]));
     end;

     TrackBar1.Position:= game_bg_music_rc_g.bg_tm;
     TrackBar2.Position:= game_bg_music_rc_g.bg_yl;
     if game_bg_music_rc_g.bg_img then
       begin
        button16.Caption:= '关闭背景';
        button16.Hint:= '图片背景已启用，点此关闭';
       end else begin
                 button16.Caption:= '启用背景';
                 button16.Hint:= '图片背景已关闭，点此启用';
                end;
     if game_bg_music_rc_g.bg_music then
       begin
        button17.Caption:= '关闭音乐';
        button17.Hint:= '背景音乐已启用，点此关闭';
       end else begin
                 button17.Caption:= '播放音乐';
                 button17.Hint:= '背景音乐已关闭，点此播放';
                end;
                
     checkbox10.Checked:= game_bg_music_rc_g.bg_music_base;
     checkbox11.Checked:= game_bg_music_rc_g.bg_img_radm;
     checkbox12.Checked:= game_bg_music_rc_g.bg_music_radm;
     label28.Caption:= '音量：'+ inttostr(game_bg_music_rc_g.bg_yl);
     label9.Caption:='背景透明度'+ inttostr(game_bg_music_rc_g.bg_tm);
     
     edit21.Text:= inttostr(game_bg_music_rc_g.baidu_vol);
     edit22.Text:= inttostr(game_bg_music_rc_g.baidu_spd);
     edit23.Text:= inttostr(game_bg_music_rc_g.baidu_pit);
     
     if game_bg_music_rc_g.baidu_sex=0 then
        radiobutton7.Checked:= true
        else
         radiobutton6.Checked:= true;

     if CompareText(form_set.combobox1.Text,'Microsoft Sam')=0 then
      begin
        label32.Visible:= true;
        label33.Visible:= true;
      end;
checkbox18.Checked:= game_bg_music_rc_g.yodao_sound;

end;

procedure TForm_set.tbRateChange(Sender: TObject);
begin
  button4.Click;
  form_pop.SpVoice1.Rate := tbRate.Position;
  lblRate.Caption := IntToStr(tbRate.Position);
end;

procedure TForm_set.tbVolumeChange(Sender: TObject);
begin
 button4.Click;
  form_pop.SpVoice1.Volume := tbVolume.Position;
  lblVolume.Caption := IntToStr(tbVolume.Position);
end;

procedure TForm_set.Button1Click(Sender: TObject);
begin
  if checkbox1.Checked then
  begin
    messagebox(handle,'注意，金山的朗读模块不能读句子，将用单词替换。','注意',mb_ok);
    edit1.Text:= 'study';
  end;

  form_pop.skp_string(edit1.Text);
end;

procedure TForm_set.Button4Click(Sender: TObject);
begin
form_pop.SpVoice1.Skip('Sentence', MaxInt);
end;

function check_bool_str(b: boolean):string;
begin
  if b then
   result:= '1'
   else
    result:= '0';
end;
procedure TForm_set.Button2Click(Sender: TObject);
var str1: Tstringlist;
begin
       //保存设置文件
   str1:= Tstringlist.Create;  //初始化背单词文本和背景颜色

   if FileExists(game_doc_path_g+'dat\set.txt') then
     str1.LoadFromFile(game_doc_path_g+'dat\set.txt')
     else
      str1.LoadFromFile(game_app_path_G+'dat\set.txt');

       if edit3.Text= '' then
       str1.Values['game_en_size']:= '21'
       else
       str1.Values['game_en_size']:= edit3.Text;

       form_pop.game_en_size:= strtoint2(str1.Values['game_en_size']);

       if edit4.Text= '' then
       str1.Values['game_cn_size']:= '16'
       else
        str1.Values['game_cn_size']:=edit4.Text;

        form_pop.game_cn_size:= strtoint2(str1.Values['game_cn_size']);

        if radiobutton1.Checked= true then //动画速度
         begin
          str1.Values['game_speed_a']:='1';
          form_pop.game_speed_a:= true;
         end else begin
                   str1.Values['game_speed_a']:='0';
                   form_pop.game_speed_a:= false;
                  end;
    if edit2.Text = '' then
      begin
      str1.Values['delay_show_word']:= '3000';
      
      end else begin
       if strtoint2(edit2.Text) < 3000 then
        begin
        str1.Values['delay_show_word']:= '3000';
        end else begin
                  str1.Values['delay_show_word']:=edit2.Text;

                  end;
               end;

       form_pop.timer1.Interval:= strtoint2(str1.Values['delay_show_word']);

       if form_pop.SpVoice1<>nil then
        begin
         str1.Values['game_tts_rate']:=  inttostr(form_pop.SpVoice1.Rate);
         str1.Values['game_tts_vol'] := inttostr(form_pop.SpVoice1.Volume);
        end;
        
       if combobox1.Items.Count= 0 then
        str1.Values['game_tts_index'] := '0'
       else
       str1.Values['game_tts_index'] := inttostr(combobox1.ItemIndex);

       if checkbox1.Checked then
        str1.Values['game_tts_sooth'] := '1'
       else
       str1.Values['game_tts_sooth'] := '0';

       str1.Values['game_m_color']:= inttostr(combobox_fen.ItemIndex);
      str1.Values['game_rep']:= inttostr(combobox_cuo.ItemIndex);
      str1.Values['game_tingli_i']:= inttostr(ComboBox_ting.ItemIndex);
       if checkbox2.Checked then
          str1.Values['game_bk']:= '1'
          else
            str1.Values['game_bk']:= '0';
            
       if checkbox3.Checked then
         begin
          str1.Values['game_width']:= '1';
          //form_pop.game_bmp_width:= 512;
          //form_pop.g_word_show_left:= 64; //单词和解释显示的左边位置
          //form_pop.init_weizi;
        end  else begin
                  // form_pop.game_bmp_width:= 256;
                   //form_pop.g_word_show_left:= 192; //单词和解释显示的左边位置
                   str1.Values['game_width']:= '0';
                   //form_pop.init_weizi;
                  end;
        if checkbox4.Checked then
         str1.Values['game_shunxu']:= '1'
       else
         str1.Values['game_shunxu']:= '0'; //是否顺序背
       if checkbox5.Checked then
       begin
         str1.Values['game_abhs']:= '1';
         Form_pop.init_tiame_day_abhs;
       end else
         str1.Values['game_abhs']:= '0'; //是否艾宾号斯

        if checkbox6.Checked then
        begin
         str1.Values['no_image']:= '1';
         Game_error_count_G:= 100;
        end else begin
                 str1.Values['no_image']:= '0'; //是否下载图片
                 Game_error_count_G:= 0;
                 end;

        if checkbox7.Checked then
        begin
         str1.Values['No_RevealTrans']:= '1';
         game_NoRevealTrans_g:= true;
        end else begin
                 str1.Values['No_RevealTrans']:= '0'; //是否转场效果
                 game_NoRevealTrans_g:= false;
                 end;

         //背景图启用，值为 1，表示启用
         str1.Values['bg_img']:= check_bool_str(game_bg_music_rc_g.bg_img);
         str1.Values['bg_tm']:= inttostr(game_bg_music_rc_g.bg_tm);  //背景图透明度
          str1.Values['bg_music']:= check_bool_str(game_bg_music_rc_g.bg_music); //背景音乐启用
          str1.Values['bg_yl']:= inttostr(game_bg_music_rc_g.bg_yl);  //背景音乐音量
          str1.Values['bg_lrc']:= check_bool_str(game_bg_music_rc_g.bg_lrc);      // ;背景歌词启用
          str1.Values['mg_pop']:= check_bool_str(game_bg_music_rc_g.mg_pop);      // ;迷宫弹出式背单词窗口启用
          str1.Values['pop_img']:= check_bool_str(game_bg_music_rc_g.pop_img);     // ;网页式背单词窗口背景图启用

          str1.Values['pop_img_tm']:= inttostr(game_bg_music_rc_g.pop_img_tm);             //;网页式背单词窗口背景图透明度
           str1.Values['bg_img_radm']:= check_bool_str(game_bg_music_rc_g.bg_img_radm); //   ;背景图随机显示
           str1.Values['bg_music_radm']:= check_bool_str(game_bg_music_rc_g.bg_music_radm);  //   ;背景音乐随机播放

          str1.Values['bg_img_index']:= inttostr(game_bg_music_rc_g.bg_img_index);          //背景图像序号
          str1.Values['bg_music_index']:= inttostr(game_bg_music_rc_g.bg_music_index);      //背景音乐序号

           str1.Values['bg_music_base']:= check_bool_str(game_bg_music_rc_g.bg_music_base); //开启重低音
            str1.Values['lrc_dir']:=game_bg_music_rc_g.lrc_dir;
            str1.Values['sch_enable']:= inttostr(ord(game_bg_music_rc_g.sch_enable));//    ;图片搜索开启
            str1.Values['sch_key']:= game_bg_music_rc_g.sch_key;   // ;图片搜索关键字
            str1.Values['sch_img_sty']:= inttostr(game_bg_music_rc_g.sch_img_sty);     //   ;下载图显示方式
            str1.Values['sch_img_height']:= inttostr(game_bg_music_rc_g.sch_img_height);

            str1.Values['not_tiankong']:= inttostr(ord(checkbox13.Checked));
            str1.Values['type_word']:= inttostr(ord(checkbox14.Checked));
            str1.Values['type_word_flash']:= inttostr(ord(checkbox15.Checked));
            str1.Values['type_char_spk']:= inttostr(ord(checkbox16.Checked));
            str1.Values['desktop_word']:= inttostr(ord(checkbox17.Checked));
            str1.Values['yodao_sound']:= inttostr(ord(checkbox18.Checked));
            str1.Values['down_readfile']:= inttostr(ord(checkbox19.Checked));
            str1.Values['en_type_name']:=label35.Font.Name;
            str1.Values['cn_type_name']:=label36.Font.Name;

            str1.Values['part_size']:= edit20.Text;
             //检测是否需重新设置数组
             if strtoint(edit20.Text)<> length(part_size_g) then
                begin
                if strtoint(edit20.Text)= 0 then
                 setlength(part_size_g,0)
                else
                setlength(part_size_g,strtoint(edit20.Text)+1); //加一，是因为该数组的第一个位置保存了当前进度的指针
                if part_size_g<> nil then
                fillchar(part_size_g[0],length(part_size_g)* sizeof(integer),0);
                end;
             //************************
         game_shunxu_g:=  checkbox4.Checked;
         game_abhs_g:= checkbox5.Checked;

         form_pop.game_m_color:= combobox_fen.ItemIndex;
          form_pop.game_rep:= combobox_cuo.ItemIndex;
          form_pop.game_tingli_i:= ComboBox_ting.ItemIndex;
          form_pop.game_not_bg_black:= not checkbox2.Checked;
          
      str1.Values['game_word1']:= edit5.Text;
      str1.Values['game_word2']:= edit6.Text;
      str1.Values['game_word3']:= edit7.Text;
      str1.Values['game_gong']:=  edit8.Text;
      str1.Values['game_fang']:=  edit9.Text;
      str1.Values['game_shu']:=   edit10.Text;
      str1.Values['game_wu']:=    edit11.Text;
      str1.Values['game_tao']:=   edit12.Text;
      str1.Values['game_del']:=   edit13.Text; //ShortCutToText

      str1.Values['game_key1']:= edit14.Text;
      str1.Values['game_key2']:= edit15.Text;
      str1.Values['game_key3']:= edit16.Text;
      str1.Values['game_key4']:= edit17.Text;
      str1.Values['game_key5']:= edit18.Text;
       change_hotkey; //更改热键

      str1.Values['game_key4']:= edit17.Text;
      str1.Values['game_key5']:= edit18.Text;

      str1.Values['baidu_vol']:= edit21.Text;
      str1.Values['baidu_spd']:= edit22.Text;
      str1.Values['baidu_pit']:= edit23.Text;
      
     if radiobutton7.Checked then
        str1.Values['baidu_sex']:= '0'
        else
          str1.Values['baidu_sex']:= '1';

   str1.saveToFile(game_doc_path_g+'dat\set.txt');
   str1.Free;
   if g_danci_w then
     begin
     checkbox3.Caption:= '单词栏双倍(重启后声效)';
     checkbox3.Font.Color:= clred;
     messagebox(handle,'您修改了单词显示的宽度，该设置将在游戏重新启动后生效。','注意',mb_ok or MB_ICONWARNING);
     end;
   self.Close;
end;

procedure TForm_set.Label8Click(Sender: TObject);
begin
ShellExecute(Handle,
                'open','IEXPLORE.EXE',pchar('http://www.finer2.com/wordgame/tts.htm'),nil,sw_shownormal);

end;

procedure TForm_set.CheckBox1Click(Sender: TObject);
begin
 if checkbox1.Checked then
    begin
    form_pop.game_kptts_init;
    form_pop.game_is_sooth:= true;
    game_bg_music_rc_g.yodao_sound:= false;
    checkbox18.Checked:= false;
    end else
     form_pop.game_is_sooth:= false;
end;

procedure TForm_set.change_hotkey;
begin
      form_pop.Action1.ShortCut:= TextToShortCut(edit8.Text);
      form_pop.Action2.ShortCut:= TextToShortCut(edit9.Text);
      form_pop.Action3.ShortCut:= TextToShortCut(edit10.Text);
      form_pop.Action4.ShortCut:= TextToShortCut(edit11.Text);
      form_pop.Action5.ShortCut:= TextToShortCut(edit12.Text);
      form_pop.Action6.ShortCut:= TextToShortCut(edit5.Text);
      form_pop.Action7.ShortCut:= TextToShortCut(edit6.Text);
      form_pop.Action9.ShortCut:= TextToShortCut(edit7.Text);
      form_pop.Action8.ShortCut:= TextToShortCut(edit13.Text);

      form_pop.Action16.ShortCut:= TextToShortCut(edit14.Text);
      form_pop.Action17.ShortCut:= TextToShortCut(edit15.Text);
      form_pop.Action18.ShortCut:= TextToShortCut(edit16.Text);
      form_pop.Action19.ShortCut:= TextToShortCut(edit17.Text);
      form_pop.Action20.ShortCut:= TextToShortCut(edit18.Text);
end;

procedure TForm_set.Edit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     (sender as tedit).Text:= ShortCutToText(key);
     key:= 0;
end;

procedure TForm_set.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
  key:= #0;
end;

procedure TForm_set.CheckBox3Click(Sender: TObject);
begin
   g_danci_w:= true;
end;

procedure TForm_set.Button5Click(Sender: TObject);
begin
  if messagebox(handle,'是否清空学习进度？','确认',mb_yesno or MB_ICONQUESTION)= mryes then
    form_pop.del_abhs;
end;

procedure TForm_set.ComboBox1Enter(Sender: TObject);
begin
   ComboBox1.Tag:= combobox1.ItemIndex;
end;

procedure TForm_set.Button6Click(Sender: TObject);
begin
    messagebox(handle,'选择方法：在出现背单词或者战斗窗口时，在窗口的右上角那里下拉选择词库即可。','词库选择',mb_ok);
end;

procedure TForm_set.Button7Click(Sender: TObject);
begin
   ShellExecute(Handle,
         'open','IEXPLORE.EXE',pchar(game_app_path_G+'lib\'),nil,sw_shownormal);
end;

procedure TForm_set.Button16Click(Sender: TObject);
begin
     if game_bg_music_rc_g.bg_img then
      begin
       game_bg_music_rc_g.bg_img:= false;
       button16.Caption:= '启用背景';
       button16.Hint:= '图片背景已关闭，点此启用';
      end else begin
                 if listbox1.Items.Count= 0 then
                  messagebox(handle,'请先导入图片。','图片',mb_ok)
                  else begin
                         game_bg_music_rc_g.bg_img:= true;
                         button16.Caption:= '关闭背景';
                         button16.Hint:= '图片背景已启用，点此关闭';
                       end;
               end;
end;

procedure TForm_set.TrackBar1Change(Sender: TObject);
begin
    game_bg_music_rc_g.bg_tm:= trackbar1.Position;
        label9.Caption:='背景透明度'+ inttostr(game_bg_music_rc_g.bg_tm);
end;

procedure TForm_set.Button9Click(Sender: TObject);
begin
   if messagebox(handle,'确定要清空全部图片？注：此动作不会删除图片原文件。','询问',mb_yesno)= mryes then
    begin
      game_bg_music_rc_g.bg_img:= false;
      bg_img_filelist_g.Clear;
      DeleteFile(game_doc_path_G+'save\bg_img.txt');
      listbox1.Items.Clear;
    end;
end;

procedure TForm_set.Button11Click(Sender: TObject);
begin
    if messagebox(handle,'确定要清空全部音乐？注：此动作不会删除音乐原文件。','询问',mb_yesno)= mryes then
    begin
      game_bg_music_rc_g.bg_music:= false;
      bg_music_filelist_g.Clear;
      DeleteFile(game_doc_path_G+'save\bg_music.txt');
      listbox2.Items.Clear;
    end;
end;

procedure TForm_set.ListBox1Click(Sender: TObject);
begin
    button15.Enabled:= listbox1.ItemIndex>= 0;
end;

procedure TForm_set.ListBox2Click(Sender: TObject);
begin
     button14.Enabled:= listbox2.ItemIndex>= 0;
end;

procedure TForm_set.Button15Click(Sender: TObject);
begin
     if listbox1.ItemIndex>= 0 then
      begin
       if messagebox(handle,'确定要删除已选图片？注：此动作不会删除图片原文件。','询问',mb_yesno)= mryes then
         begin
           bg_img_filelist_g.Delete(listbox1.ItemIndex);
           listbox1.DeleteSelected;

               bg_img_filelist_g.SaveToFile(game_doc_path_G+'save\bg_img.txt');


         end;
      end;
end;

procedure TForm_set.Button14Click(Sender: TObject);
begin
    if listbox2.ItemIndex>= 0 then
      begin
       if messagebox(handle,'确定要删除已选音乐？注：此动作不会删除音乐原文件。','询问',mb_yesno)= mryes then
         begin
           bg_music_filelist_g.Delete(listbox2.ItemIndex);
           listbox2.DeleteSelected;

            bg_music_filelist_g.SaveToFile(game_doc_path_G+'save\bg_music.txt');
         end;
      end;
end;

procedure TForm_set.Button17Click(Sender: TObject);
begin
   if game_bg_music_rc_g.bg_music then
      begin
       game_bg_music_rc_g.bg_music:= false;
       button17.Caption:= '播放音乐';
       button17.Hint:= '音乐背景已关闭，点此播放';
      end else begin
                 if listbox2.Items.Count= 0 then
                  messagebox(handle,'请先导入音乐，支持mp3和wma。','音乐',mb_ok)
                  else begin
                         game_bg_music_rc_g.bg_music:= true;
                         button17.Caption:= '关闭音乐';
                         button17.Hint:= '音乐背景播放中，点此关闭';
                         //开始播放
                         t_music:= tr_music.Create(false);
                       end;
               end;
end;

procedure TForm_set.TrackBar2Change(Sender: TObject);
begin
   game_bg_music_rc_g.bg_yl:= trackbar2.Position;
    label28.Caption:= '音量：'+ inttostr(game_bg_music_rc_g.bg_yl);
    if Assigned(t_music) then
      postthreadmessage(t_music.ThreadID,music_msg_c,1,888);
end;

procedure TForm_set.CheckBox10Click(Sender: TObject);
begin
     game_bg_music_rc_g.bg_music_base:= checkbox10.Checked;
    if checkbox10.Checked then
     begin
       if Assigned(t_music) then
        postthreadmessage(t_music.ThreadID,music_msg_c,2,888);
     end else begin
                if Assigned(t_music) then
                   postthreadmessage(t_music.ThreadID,music_msg_c,3,888);
              end;
end;

procedure TForm_set.CheckBox8Click(Sender: TObject);
begin
     game_bg_music_rc_g.bg_lrc:= checkbox8.Checked;
end;

procedure TForm_set.Button13Click(Sender: TObject);
var i: integer;
begin
   if openpicturedialog1.Execute then
    begin
     if not Assigned(bg_img_filelist_g) then
         bg_img_filelist_g:= tstringlist.Create;

     bg_img_filelist_g.AddStrings(openpicturedialog1.Files);
     listbox1.Items.Clear;
       for i:= 0 to bg_img_filelist_g.Count-1 do
         listbox1.Items.Append(ExtractFileName(bg_img_filelist_g.Strings[i]));

       //保存

     if listbox1.Items.Count> 0 then
      begin
       bg_img_filelist_g.SaveToFile(game_doc_path_G+'save\bg_img.txt');
        if game_bg_music_rc_g.bg_img= false then
           button16.Click;
      end;
    end;
end;

procedure TForm_set.Button12Click(Sender: TObject);
var i: integer;
begin
   if opendialog1.Execute then
    begin
    if not Assigned(bg_music_filelist_g) then
         bg_music_filelist_g:= tstringlist.Create;
     bg_music_filelist_g.AddStrings(opendialog1.Files);
     listbox2.Items.Clear;
       for i:= 0 to bg_music_filelist_g.Count-1 do
         listbox2.Items.Append(ExtractFileName(bg_music_filelist_g.Strings[i]));

     //保存

     if listbox2.Items.Count> 0 then
      begin
       bg_music_filelist_g.SaveToFile(game_doc_path_G+'save\bg_music.txt');
        if game_bg_music_rc_g.bg_music= false then
           button17.Click;
      end;
    end;

end;

procedure TForm_set.CheckBox11Click(Sender: TObject);
begin
    game_bg_music_rc_g.bg_img_radm:= checkbox11.Checked;
end;

procedure TForm_set.CheckBox12Click(Sender: TObject);
begin
   game_bg_music_rc_g.bg_music_radm:= checkbox12.Checked;
end;

function BrowseFolder(strTitle: string): string;
var
  Info:TBrowseInfo;
  Dir:array[0..260] of char;
  ItemId:PItemIDList;
begin
  with Info do
  begin
    hwndOwner:= Form_set.Handle;
    pidlRoot:=nil;
    pszDisplayName:=nil;
    lpszTitle:=PCHAR(strTitle);
    ulFlags:=65;
    lpfn:=nil;
    lParam:=0;
    iImage:=0;
  end;
  ItemId:=SHBrowseForFolder(Info);
  SHGetPathFromIDList(ItemId,@Dir);
  Result:=string(Dir);

end;

function FindFileList(Path, Filter: string; FileList:Tstringlist; ContainSubDir: Boolean): boolean;
var
  FSearchRec,DSearchRec:TSearchRec;
  FindResult:shortint;
begin
  FindResult:=FindFirst(path+'*.*',faAnyFile,FSearchRec);
  try
  while FindResult=0 do
  begin
   if (FSearchRec.Name <> '.') and (FSearchRec.Name <> '..') then
    begin
     if pos(lowercase(ExtractFileExt(FSearchRec.Name)),Filter)> 0 then
        FileList.Add(path+ FSearchRec.Name);
    end;
    FindResult:=FindNext(FSearchRec);

  end;
  if ContainSubDir then
  begin
    FindResult:=FindFirst(path+ '*.*',faDirectory,DSearchRec);
    while FindResult=0 do
    begin
      if ((DSearchRec.Attr and faDirectory)=faDirectory)
        and (DSearchRec.Name<>'.') and (DSearchRec.Name<>'..') then
        FindFileList(path+DSearchRec.Name+ '\',Filter,FileList,ContainSubDir);
        FindResult:=FindNext(DSearchRec);
    end;
  end;

  finally
    FindClose(FSearchRec);
  end;

  result:= true;

end;

procedure TForm_set.Button8Click(Sender: TObject);  //导入文件夹
var ss: string;
    i: integer;
begin
   ss:= BrowseFolder('选择有图片的文件夹，按住CTRL键遍历子文件夹：');
   if ss= '' then
     exit;
   if not Assigned(bg_img_filelist_g) then
      bg_img_filelist_g:= Tstringlist.Create;
   FindFileList(ss+'\','.jpg,.gif,.bmp,.png',bg_img_filelist_g,(GetKeyState(VK_CONTROL)< 0));

   if listbox1.ItemIndex> bg_music_filelist_g.Count then
      game_bg_music_rc_g.bg_img:= false;

   listbox1.Items.Clear;
       for i:= 0 to bg_img_filelist_g.Count-1 do
         listbox1.Items.Append(ExtractFileName(bg_img_filelist_g.Strings[i]));

   if listbox1.Items.Count> 0 then  //自动播放
      begin
       bg_img_filelist_g.SaveToFile(game_doc_path_G+'save\bg_img.txt');
        if game_bg_music_rc_g.bg_img= false then
           button16.Click;
      end;
end;

procedure TForm_set.Button10Click(Sender: TObject);  //导入音乐文件夹
var ss: string;
    i: integer;
begin
   ss:= BrowseFolder('选择一个有音乐的文件夹，按下CTRL键遍历子目录：');
   if ss= '' then
     exit;
     if not Assigned(bg_music_filelist_g) then
      bg_music_filelist_g:= Tstringlist.Create;
      
   FindFileList(ss+'\','.mp3,.wma',bg_music_filelist_g,(GetKeyState(VK_CONTROL)< 0));

   if listbox2.ItemIndex> bg_music_filelist_g.Count then
      game_bg_music_rc_g.bg_music:= false;

   listbox2.Items.Clear;
       for i:= 0 to bg_music_filelist_g.Count-1 do
         listbox2.Items.Append(ExtractFileName(bg_music_filelist_g.Strings[i]));

    if listbox2.Items.Count> 0 then  //自动播放
      begin
       bg_music_filelist_g.SaveToFile(game_doc_path_G+'save\bg_music.txt');
        if game_bg_music_rc_g.bg_music= false then
           button17.Click;
      end;
end;
procedure TForm_set.FormDestroy(Sender: TObject);
begin
    game_bg_music_rc_g.bg_music:= false;
end;

procedure TForm_set.Button18Click(Sender: TObject);
begin
   if Assigned(t_music) then
      postthreadmessage(t_music.ThreadID,music_msg_c,4,888);

end;

procedure TForm_set.ListBox2DblClick(Sender: TObject);
begin
  if Assigned(t_music) and game_bg_music_rc_g.bg_music then
    begin
     if listbox2.ItemIndex >= 0 then
      begin
       game_bg_music_rc_g.bg_music_index:=listbox2.ItemIndex;
      postthreadmessage(t_music.ThreadID,music_msg_c,5,888);
      end;
    end else button17.Click;
end;

procedure TForm_set.TrackBar3Exit(Sender: TObject);
begin
  //调整同步后保存
    bg_music_filelist_g.SaveToFile(game_doc_path_G+'save\bg_music.txt');
end;

procedure TForm_set.TrackBar3Change(Sender: TObject);
begin
    if Assigned(t_music) then
       postthreadmessage(t_music.ThreadID,music_msg_c,6,TrackBar3.Position);
end;

procedure TForm_set.CheckBox9Click(Sender: TObject);
begin
     game_bg_music_rc_g.mg_pop:= checkbox9.Checked;
end;

procedure TForm_set.Button19Click(Sender: TObject);
var ss: string;
begin
     if messagebox(handle,'只有当您把LRC歌词放在单独的文件夹内，才需要设定歌词目录，如果歌词是在和歌曲同一目录下的，无须设置。是否设置？','设置',mb_yesno)=mryes then
      begin
        ss:= BrowseFolder('选择一个LRC歌词的文件夹：');
       if ss<> '' then
          game_bg_music_rc_g.lrc_dir:= ss +'\';
      end;

end;

procedure TForm_set.CheckBox_schClick(Sender: TObject);
begin
     game_bg_music_rc_g.sch_enable:= checkbox_sch.Checked;
end;

procedure TForm_set.Edit_sch_keyExit(Sender: TObject);
begin
     game_bg_music_rc_g.sch_key:= edit_sch_key.Text;
     if key_ss_prv<> edit_sch_key.Text then
       begin
         key_ss_prv:= edit_sch_key.Text;
         game_bg_music_rc_g.sch_count1:= 0;
       end;
end;

procedure TForm_set.RadioButton3Click(Sender: TObject);
begin
       if sender= radiobutton3 then
          game_bg_music_rc_g.sch_img_sty:= 0
          else if sender= radiobutton4 then
          game_bg_music_rc_g.sch_img_sty:= 1
          else if sender= radiobutton5 then
          game_bg_music_rc_g.sch_img_sty:= 2;

end;

procedure TForm_set.RadioButton6Click(Sender: TObject);
begin
   game_bg_music_rc_g.baidu_sex:=1;
end;

procedure TForm_set.RadioButton7Click(Sender: TObject);
begin
  game_bg_music_rc_g.baidu_sex:=0;
end;

procedure TForm_set.Edit19Exit(Sender: TObject);
begin
    game_bg_music_rc_g.sch_img_height:= strtoint2(edit19.Text);
end;

procedure TForm_set.Button20Click(Sender: TObject);
begin
   ShellExecute(0,
             'open',pchar(game_doc_path_G + 'down_img'),nil,nil,sw_shownormal);
end;

procedure TForm_set.Button21Click(Sender: TObject);
begin
     if messagebox(handle,'是否清空图片缓存目录？','询问',mb_yesno)= mryes then
       form1.DeleteDirNotEmpty(game_doc_path_G + 'down_img\');
end;

procedure TForm_set.Edit_sch_keyEnter(Sender: TObject);
begin
   key_ss_prv:= edit_sch_key.Text;
end;

procedure TForm_set.CheckBox14Click(Sender: TObject);
begin
     game_bg_music_rc_g.type_word:= CheckBox14.Checked;
     checkbox15.Enabled:= CheckBox14.Checked;
     checkbox16.Enabled:= CheckBox14.Checked;
end;

procedure TForm_set.CheckBox13Click(Sender: TObject);
begin
    game_bg_music_rc_g.not_tiankong:= CheckBox13.Checked;
end;

procedure TForm_set.CheckBox15Click(Sender: TObject);
begin
    game_bg_music_rc_g.type_word_flash:= CheckBox15.Checked;
end;

procedure TForm_set.CheckBox16Click(Sender: TObject);
begin
     game_bg_music_rc_g.type_char_spk:= CheckBox16.Checked;
end;

procedure TForm_set.tts_list_rf;
var   SOToken: ISpeechObjectToken;
  SOTokens: ISpeechObjectTokens;
    I: Integer;
begin
    combobox1.Items.Clear;
    if form_pop.SpVoice1<> nil then
    begin
    SOTokens := form_pop.SpVoice1.GetVoices('', '');
  for I := 0 to SOTokens.Count - 1 do
  begin
    //For each voice, store the descriptor in the TStrings list
    SOToken := SOTokens.Item(I);
    combobox1.Items.AddObject(SOToken.GetDescription(0), TObject(SOToken));
    //Increment the descriptor reference count to ensure it doesn't get destroyed
    SOToken._AddRef;
  end;

     end; //end SpVoice1

     combobox1.Items.Append('刷新列表');
     if combobox1.Items.Count= 1 then
      combobox1.Items.Append('TTS不存在，立即下载')
     else
       combobox1.Items.Append('下载音质更好的TTS');
end;

procedure TForm_set.Label33Click(Sender: TObject);
begin
    ShellExecute(Handle,
         'open','IEXPLORE.EXE',pchar('http://www.finer2.com/wordgame/downtts.htm'),nil,sw_shownormal);
end;

procedure TForm_set.CheckBox17Click(Sender: TObject);
begin
   game_bg_music_rc_g.desktop_word:= checkbox17.Checked;
end;

procedure TForm_set.CheckBox18Click(Sender: TObject);
begin
    game_bg_music_rc_g.yodao_sound:= checkbox18.Checked;
    if checkbox18.Checked then
      begin
       checkbox1.Checked:= false;
       form_pop.game_is_sooth:= false;
      end;
end;

procedure TForm_set.Edit20Exit(Sender: TObject);
begin
 if edit20.Text= '' then
    edit20.Text:= '0';
end;

procedure TForm_set.Edit21Exit(Sender: TObject);
begin
     if strtoint(edit21.Text) in[0..9] then
      begin
        game_bg_music_rc_g.baidu_vol:= strtoint(edit21.Text);
      end else showmessage('音量无效，输入数字要在0到9之间，默认是5');


end;

procedure TForm_set.Edit22Exit(Sender: TObject);
begin
       if strtoint(edit22.Text) in[0..9] then
      begin
        game_bg_music_rc_g.baidu_spd:= strtoint(edit22.Text);
      end else showmessage('语速无效，输入数字要在0到9之间，默认是5');
end;

procedure TForm_set.Edit23Exit(Sender: TObject);
begin
   if strtoint(edit23.Text) in[0..9] then
      begin
        game_bg_music_rc_g.baidu_pit:= strtoint(edit23.Text);
      end else showmessage('音调无效，输入数字要在0到9之间，默认是5');
end;

procedure TForm_set.Button22Click(Sender: TObject);
begin
  fillchar(part_size_g[0],length(part_size_g)* sizeof(integer),0);
end;

procedure TForm_set.CheckBox19Click(Sender: TObject);
begin
    game_bg_music_rc_g.down_readfile:= CheckBox19.Checked;
end;

procedure TForm_set.Label35Click(Sender: TObject);
begin
   fontdialog1.Font.Name:= tlabel(sender).Font.Name;
    if fontdialog1.Execute then
     begin
       tlabel(sender).Font.Name:= fontdialog1.Font.Name;
       tlabel(sender).Caption:= tlabel(sender).Font.Name;
     end;
end;

end.



