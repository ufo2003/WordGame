unit Unit_net_set;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst,unit_net,unit_glb, ComCtrls,ShellApi,System.Hash,
  ExtCtrls;
const
    msg_show_note=$0400 + 32672;
type
  TForm_net_set = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
    RichEdit1: TRichEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure CreateParams(var Para:TCreateParams);override;
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure show_note(var msg:Tmessage); message msg_show_note;
  public
    { Public declarations }
   function RichWordOver(rch:trichedit; X,Y:integer):string;
  end;

var
  Form_net_set: TForm_net_set;
implementation
     uses unit1,unit_reg,unit_data,richedit,Unit_player,unit_show;
{$R *.dfm}

{ TForm_net_set }



procedure TForm_net_set.Button1Click(Sender: TObject);
begin
close;
end;

procedure TForm_net_set.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
  Para.WndParent:=Form1.Handle;

end;

procedure TForm_net_set.Button4Click(Sender: TObject);
begin
 form_reg:= Tform_reg.Create(nil);
 form_reg.ShowModal;
 form_reg.Free;
end;

procedure TForm_net_set.FormShow(Sender: TObject);
begin
 timer1.Enabled:= true;
 postmessage(handle,msg_show_note,0,0);
end;

procedure TForm_net_set.Edit1Change(Sender: TObject);
begin
  Game_server_addr_g := edit1.Text;
end;

procedure TForm_net_set.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
     if key= #13 then
      begin
      key:= #0;
      edit3.SetFocus;
      end else begin
            if key in['|','''','"'] then
              begin
                messagebox(handle,'信息内不能含有 | " '' 这些符号。','错误',mb_ok);
                key:= #0;
              end;
           end;
end;

procedure TForm_net_set.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
    if key= #13 then
      begin
      key:= #0;
      button2click(sender);
      end;
end;

procedure TForm_net_set.Button2Click(Sender: TObject);
var i: integer;
    ss: string;
    t: cardinal;
    pk: Tmsg_cmd_pk;
    label pp;
begin
   //登录
   if Game_role_list.Count> 0 then
    begin
     for i:= 0 to Game_role_list.Count- 1 do
       begin
        Tplayer(Game_role_list.Items[i]).Free;
       end;
     Game_role_list.Clear;
    end;

   if edit2.Text= '' then
    begin
      messagebox(handle,'id不能为空，如果是新玩家，请先点击左边的“注册”按钮先注册一个用户名。','错误',mb_ok);
      edit2.SetFocus;
      exit;
    end;
   if edit3.Text= '' then
    begin
      messagebox(handle,'密码不能为空，如果是新玩家，请先点击左边的“注册”按钮先注册一个用户名。','错误',mb_ok);
      edit3.SetFocus;
      exit;
    end;

    //登录服务器，提交用户名密码版本号，等待验证，
    //显示验证结果，成功，则发送请求，获取用户人物信息，物品信息
    //启动页面
     button2.Enabled:= false;
    label9.Caption:= '正在连接服务器……';
    label9.Update;

   if Data_net.g_start_udpserver2(Game_server_addr_g) then
   begin
   Game_at_net_G:= true; //设置网络标志
    Game_wait_ok1_g:= false;
    game_wait_integer_g:= 0;
     t:= GetTickCount;
     //发送查询数据，然后等待查询结果
      ss:= '    '+ edit2.Text+ '|' + THashMD5.GetHashString(edit3.Text) + '|' + banben_const;
      i:= byte_to_integer(g_player_login_c,false);   //登录数据头信息
      move(i,Pointer(ss)^,4);
      screen.Cursor:= crhourglass;
      sleep(100);
      g_send_msg_str(ss); //向服务器发送
      label9.Caption:= '发送登录信息，等待验证……';
      label9.Update;
    while (Game_wait_ok1_g= false) and (GetTickCount -t < 10000) do
      begin
        application.ProcessMessages;
        sleep(10);
      end;

       label9.Font.Color:= clred;
       screen.Cursor:= crdefault;
       if Game_wait_ok1_g then
        begin
         //1登录成功，2登录被拒绝，未通过审核，3被管理员禁止，4客户端版本过低，5服务器已满，6未知的拒绝理由
         case game_wait_integer_g of
         1: begin
             label9.Font.Color:= cldefault;
             label9.Caption:= '验证通过，获取人物数据……';
             label9.Update;
            end;
         2: begin
             label9.Caption:= '请等待管理员审核';
             goto pp;
            end;
         3: begin
             label9.Caption:= 'ID被管理员锁定';
             goto pp;
            end;
          4: begin
             label9.Caption:= '客户端版本过低。请升级';
             goto pp;
            end;
          5: begin
             label9.Caption:= '服务器已满。';
             goto pp;
            end;
          6: begin
             label9.Caption:= '用户不存在。';
             goto pp;
            end;
          7: begin
             label9.Caption:= '密码错误。';
             goto pp;
            end;
          8: begin
             label9.Caption:= '登录失败，未知的理由。';
             goto pp;
            end;
         end;
        end else begin
                   label9.Caption:= '通讯超时，登录失败。';
                    goto pp;
                 end;

    Game_wait_ok1_g:= false; //下一步，请求人物信息
    game_wait_integer_g:= 0;
    t:= GetTickCount;
      pk.hander:= byte_to_integer(g_player_rq_c,false);
      pk.pak.s_id:= my_s_id_g;
      screen.Cursor:= crhourglass;
      sleep(100);
      g_send_msg_cmd(@pk,sizeof(pk)); //向服务器发送
      label9.Caption:= '等待人物角色数据……';
      label9.Update;
    while (Game_wait_ok1_g= false) and (GetTickCount -t < 10000) do
      begin
        application.ProcessMessages;
        sleep(10);
      end;
       screen.Cursor:= crdefault;
        if Game_wait_ok1_g then
        begin
         //收到人物数据
         case game_wait_integer_g of
         1: begin
             label9.Font.Color:= cldefault;
             label9.Caption:= '人物已加载，等待物品数据……';
             label9.Update;
            end;
         2: begin
             label9.Caption:= '人物数据加载失败';
             goto pp;
            end;
         end;
        end else begin
                   label9.Caption:= '获取角色数据超时，失败';
                    goto pp;
                 end;
       //等待物品数据*****************
        Game_wait_ok1_g:= false; //下一步，请求物品数据
       game_wait_integer_g:= 0;
        t:= GetTickCount;

      pk.hander:= byte_to_integer(g_wupin_rq_c,false);
      pk.pak.s_id:= my_s_id_g;
      screen.Cursor:= crhourglass;
      sleep(100);
      g_send_msg_cmd(@pk,sizeof(pk)); //向服务器发送
      label9.Caption:= '等待物品数据……';
      label9.Update;
    while (Game_wait_ok1_g= false) and (GetTickCount -t < 10000) do
      begin
        application.ProcessMessages;
        sleep(10);
      end;
       screen.Cursor:= crdefault;
        if Game_wait_ok1_g then
        begin
         //收到物品数据
         case game_wait_integer_g of
         1: begin
             label9.Font.Color:= cldefault;
             label9.Caption:= '物品数据已加载，启动页面……';
             label9.Update;
             self.close;
             //进一步初始化
             form1.game_load_doc_net; //进入网络版开始页面
            end;
         2: begin
             label9.Caption:= '物品数据加载失败';
             goto pp;
            end;
         end;
        end else begin
                   label9.Caption:= '获取物品数据超时，失败';
                    goto pp;
                 end;
    //等待物品数据结束*******************
   end else begin
              messagebox(handle,'不能连接到服务器，登录失败。','错误',mb_ok);
            end;
    pp:
   button2.Enabled:= true;
   screen.Cursor:= crdefault;
end;

procedure TForm_net_set.Edit2Change(Sender: TObject);
begin
  if edit2.Text<> '' then
     label2.Font.Color:= cldefault
     else label2.Font.Color:= clred;
end;

procedure TForm_net_set.FormCreate(Sender: TObject);
var
mask: integer;
begin
   form_show.show_info('准备开始……100% 请等待');
mask := SendMessage(richedit1.Handle, EM_GETEVENTMASK, 0, 0);
SendMessage(richedit1.Handle, EM_SETEVENTMASK, 0, mask or ENM_LINK);
SendMessage(richedit1.Handle, EM_AUTOURLDETECT, Integer(True), 0);

end;


Function TForm_net_set.RichWordOver(rch:trichedit; X,Y:integer):string;
var pt:tpoint;
    pos,
    start_pos,
    end_pos:Integer;
    txt:String;
    ch: char;
    txtlen:Integer;
begin

    pt.X:= X;
    pt.Y:= Y;
    pos:=rch.Perform(EM_CHARFROMPOS, 0, longint(@pt));
    If pos <= 0 Then Exit;
    txt:= rch.Text;
    For start_pos:= pos downTo 1 do
    begin
        ch:=rch.text[start_pos];
        If (ord(ch) < 33) or (ord(ch) > 126) Then break;
    end;

    inc(start_pos);

    txtlen:= Length(txt);
    For end_pos:= pos To txtlen do
    begin
        ch:= txt[end_pos];
        If (ord(ch) < 33) or (ord(ch) > 126) Then break;
    end;
    dec(end_pos);

    If start_pos <= end_pos Then
        result:=copy(txt, start_pos, end_pos - start_pos + 1);
End;


procedure TForm_net_set.RichEdit1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var ss: string;
begin
   ss:= RichWordOver(richedit1,x,y);
   if (pos('http://',ss)= 1) or (pos('www.',ss)=1) then
    begin
   ShellExecute(Handle,
  'open','IEXPLORE.EXE',pchar(ss),nil,sw_shownormal);
   end;
end;

procedure TForm_net_set.show_note(var msg: Tmessage);
var ss: string;
    i: integer;
begin
screen.Cursor:= crhourglass;
   edit1.Text:= Game_server_addr_g;
   timer1.Tag:= 9;
   timer1.Enabled:= true;
   button4.Enabled:= false;
   button2.Enabled:= false;
   button3.Enabled:= false;
   button1.Enabled:= false;
update;
   if Data_net.g_start_udpserver2(Game_server_addr_g) then
   begin
     //发送查询数据，然后等待查询结果
      timer1.Enabled:= false;
      i:= byte_to_integer(g_server_gonggao_c,false);
      ss:= '    '+ inttostr(i);
      move(i,Pointer(ss)^,4);
      sleep(100);
      g_send_msg_str(ss); //向服务器发送


   end else begin
             richedit1.Lines.Clear;
             richedit1.Lines.Append('获取公告失败，服务器没有启动或者网络不通。更多信息，欢迎访问游戏论坛 http://www.finer2.com/wordgame/bbs.htm');
            end;
screen.Cursor:= crdefault;
button4.Enabled:= true;
   button2.Enabled:= true;
   button3.Enabled:= true;
   button1.Enabled:= true;
end;

procedure TForm_net_set.Timer1Timer(Sender: TObject);
begin
    richedit1.Lines.Clear;
    richedit1.Lines.Append('正在获取服务器公告……'+ inttostr(timer1.Tag));
    timer1.Tag:= timer1.Tag -1;

    if timer1.Tag= 0 then
       timer1.Enabled:= false;

end;

end.
