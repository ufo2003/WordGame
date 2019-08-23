unit Unit_chat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,shellapi, ExtCtrls,unit_glb;

type
  TForm_chat = class(TForm)
    Button1: TButton;
    RichEdit1: TRichEdit;
    ComboBox1: TComboBox;
    Splitter1: TSplitter;
    RichEdit2: TRichEdit;
    Label1: TLabel;
    procedure RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RichEdit2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
   procedure EnableChanged(var Msg: TMessage); message WM_ENABLE; 
  public
    { Public declarations }
    player_chat_id: integer;
    procedure CreateParams(var Para:TCreateParams);override;
    procedure add_message(const s: string);
  end;

var
  Form_chat: TForm_chat;

implementation
   uses unit1,unit_net_set,unit_net,richedit,unit_data;
{$R *.dfm}

{ TForm3 }

procedure TForm_chat.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
   Para.WndParent:=GetDesktopWindow;
end;

procedure TForm_chat.RichEdit1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var ss: string;
begin
   ss:= form_net_set.RichWordOver(richedit1,x,y);
   if (pos('http://',ss)= 1) or (pos('www.',ss)=1) then
    begin
   ShellExecute(Handle,
  'open','IEXPLORE.EXE',pchar(ss),nil,sw_shownormal);
   end;
end;


procedure TForm_chat.EnableChanged(var Msg: TMessage);
begin
EnableWindow(handle, true);
  inherited;
end;

procedure TForm_chat.RichEdit2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var ss: string;
begin
   ss:= form_net_set.RichWordOver(richedit2,x,y);
   if (pos('http://',ss)= 1) or (pos('www.',ss)=1) then
    begin
   ShellExecute(Handle,
  'open','IEXPLORE.EXE',pchar(ss),nil,sw_shownormal);
   end;

end;

procedure TForm_chat.FormCreate(Sender: TObject);
var
mask: Word;
begin
mask := SendMessage(richedit1.Handle, EM_GETEVENTMASK, 0, 0);
SendMessage(richedit1.Handle, EM_SETEVENTMASK, 0, mask or ENM_LINK);
SendMessage(richedit1.Handle, EM_AUTOURLDETECT, Integer(True), 0);

  mask := SendMessage(richedit2.Handle, EM_GETEVENTMASK, 0, 0);
SendMessage(richedit2.Handle, EM_SETEVENTMASK, 0, mask or ENM_LINK);
SendMessage(richedit2.Handle, EM_AUTOURLDETECT, Integer(True), 0);
end;

procedure TForm_chat.FormShow(Sender: TObject);
 var i,j: integer;
begin
 combobox1.Items.Clear;
 combobox1.Items.Append('聊天：小队');      //-5
  combobox1.Items.Append('聊天：当前页');   //-4
  combobox1.Items.Append('聊天：帮派');     //-3
  combobox1.Items.Append('聊天：国家');     //-2
  combobox1.Items.Append('聊天：全部在线'); //-1
  j:= -1;
     for i:= 0 to high(user_info_time) do
      begin
        if ((user_info_time[i].page= form1.pscene_id) or (user_info_time[i].xiaodui=game_player_head_G.duiwu_id))
          and (user_info_time[i].s_id< g_nil_user_c) then
         begin
           combobox1.Items.Append(user_info_time[i].nicheng);
           if user_info_time[i].s_id= player_chat_id then
              j:= i;
         end;
      end;

   if j > -1 then
     combobox1.ItemIndex:= j+ 5;

end;

procedure TForm_chat.ComboBox1Select(Sender: TObject);
var i: integer;
begin
     case combobox1.ItemIndex of
      0: begin
          player_chat_id:= -5;
          label1.Caption:= '和全体队友聊天';
         end;
      1: begin
          player_chat_id:= -4;
          label1.Caption:= '给当前在线的发送信息';
         end;
      2: begin
          player_chat_id:= -3;
          label1.Caption:= '给本帮在线人员发消息';
         end;
      3: begin
          player_chat_id:= -2;
          label1.Caption:= '给本国在线人员发消息';
         end;
      4: begin
          player_chat_id:= -1;
          label1.Caption:= '向全部在线的广播信息';
         end;
      else
        for i:= 0 to high(user_info_time) do
         begin
          if user_info_time[i].nicheng= combobox1.Text then
           begin
            label1.Caption:= '玩家ID：'+ user_info_time[i].u_id;
            label1.Hint:= '所在小队：'+ net_get_dwjhming(user_info_time[i].xiaodui,1,true) + #13#10+
                          '所在帮派：'+ net_get_dwjhming(user_info_time[i].zhuzhi,2,true) + #13#10+
                          '所在国家：'+ net_get_dwjhming(user_info_time[i].guojia,3,true) + #13#10;
            exit;
           end;
         end;
      end; //end case
end;

procedure TForm_chat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= cafree;

end;

procedure TForm_chat.Button1Click(Sender: TObject);
var ss: string;
    i: integer;
    j: array[0..4] of integer;
    k: array[0..2] of integer;
    m: array[0..3] of integer;
    b: boolean;
begin
  //发送聊天
  if richedit2.GetTextLen= 0 then
     exit;

  longrec(j[1]).lo:= g_nil_user_c;
  longrec(j[1]).Hi:= g_nil_user_c;
  longrec(j[2]).lo:= g_nil_user_c;
  longrec(j[2]).Hi:= g_nil_user_c;

  b:= false; //不压缩

  case  combobox1.ItemIndex of
   0: begin
          //label1.Caption:= '和全体队友聊天';
         
          j[0]:= byte_to_integer(g_rep_dw_c,b);   //队伍内转发
          j[3]:=  byte_to_integer(g_rec_chat_c,b); //聊天
          j[4]:=  my_s_id_G;
          for i:= 0 to high(user_info_time) do
           begin
            if user_info_time[i].xiaodui= game_player_head_G.duiwu_id then
             begin
              if longrec(j[1]).lo= g_nil_user_c then
                 longrec(j[1]).lo:= user_info_time[i].s_id
                 else  if longrec(j[1]).hi= g_nil_user_c then
                          longrec(j[1]).hi:= user_info_time[i].s_id
                          else if longrec(j[2]).lo= g_nil_user_c then
                                  longrec(j[2]).lo:= user_info_time[i].s_id
                                  else if longrec(j[2]).hi= g_nil_user_c then
                                        begin
                                          longrec(j[2]).hi:= user_info_time[i].s_id;
                                          break;
                                        end;
             end;
           end;
         setlength(ss,20);
          move(j,Pointer(ss)^,20);
         end;
      1: begin
          //label1.Caption:= '给当前在线的发送信息';
          m[0]:= byte_to_integer(g_rep_page_c,b);
           m[1]:= form1.pscene_id; //当前页面id
           m[2]:=  byte_to_integer(g_rec_chat_c,b); //聊天
           m[3]:=  my_s_id_G;
          setlength(ss,16);
           move(m,Pointer(ss)^,length(ss));
         end;
      2: begin
          //label1.Caption:= '给本帮在线人员发消息';
              //加以限制
           m[0]:= byte_to_integer(g_rep_zz_c,b);
            m[1]:= game_player_head_G.zhuzhi_id;
              m[2]:=  byte_to_integer(g_rec_chat_c,b); //聊天
              m[3]:=  my_s_id_G;
            setlength(ss,16);
              move(m,Pointer(ss)^,length(ss));
         end;
      3: begin
         // label1.Caption:= '给本国在线人员发消息';
             //加以限制
           m[0]:= byte_to_integer(g_rep_gj_c,b);
            m[1]:= game_player_head_G.guojia_id;
             m[2]:=  byte_to_integer(g_rec_chat_c,b); //聊天
              m[3]:=  my_s_id_G;
            setlength(ss,16);
              move(m,Pointer(ss)^,length(ss));
         end;
      4: begin
          //label1.Caption:= '向全部在线的广播信息';
          k[0]:= byte_to_integer(g_rep_all_c,b);
           k[1]:=  byte_to_integer(g_rec_chat_c,b); //聊天
           k[2]:=  my_s_id_G;
          ss:='            ';
           move(k,Pointer(ss)^,length(ss));
         end;
      else
        for i:= 0 to high(user_info_time) do
         begin
          if user_info_time[i].nicheng= combobox1.Text then
           begin
            m[0]:= byte_to_integer(g_rep_zd_c,b);
            m[1]:= user_info_time[i].s_id;
            m[2]:=  byte_to_integer(g_rec_chat_c,b); //聊天
            m[3]:=  my_s_id_G;
            setlength(ss,16);
              move(m,Pointer(ss)^,length(ss));
            break;
           end;
         end;
      end; //end case

      //发送
      ss:= ss + richedit2.Text;
      g_send_msg_str(ss); //向服务器发送
      richedit1.Lines.Append(form1.game_get_newname_at_id(1)+' '+ timetostr(time));
       richedit1.Lines.Append(richedit2.Text);
      richedit2.Clear;
end;

procedure TForm_chat.add_message(const s: string);
begin
   //添加消息
   richedit1.Lines.Append(combobox1.Text+' '+ datetimetostr(time));
       richedit1.Lines.Append(s);
end;

procedure TForm_chat.Label1Click(Sender: TObject);
begin
    //显示这个人的信息
end;

end.
