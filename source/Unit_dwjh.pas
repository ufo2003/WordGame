unit Unit_dwjh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TForm_dwjh = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit1: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Edit2: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Edit3: TEdit;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    Label36: TLabel;
    Label37: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label38: TLabel;
    Edit4: TEdit;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    GroupBox2: TGroupBox;
    ListBox2: TListBox;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label43: TLabel;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    GroupBox3: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label44: TLabel;
    procedure Label5MouseEnter(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure TabSheet4Show(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure Label36Click(Sender: TObject);
    procedure Label34Click(Sender: TObject);
    procedure Label35Click(Sender: TObject);
    procedure Label37Click(Sender: TObject);
    procedure Label40Click(Sender: TObject);
    procedure Label41Click(Sender: TObject);
    procedure Label42Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
  private
    { Private declarations }
     
    procedure EnableChanged(var Msg: TMessage); message WM_ENABLE;
    procedure show_info_0(id: integer); //显示页面一
    procedure show_info_1(id: integer); //显示页面二
     procedure show_info_2(id: integer); //显示页面三
      procedure show_info_3(id: integer); //显示页面四
      procedure create_dwjh(tp: integer); // 创建小队，帮派，国家，tp1，2，3
      procedure add_and_exit_dwjh(flag,id: integer); //flag=1加入小队，2退出小队，3解散小队，4加入组织……
      procedure add_dwjh_q(flag,id: integer); //请求加入小队，这是一个转发信息
  public
    { Public declarations }
    show_tp: integer;    //显示的类型
    show_data_sid: integer;
    show_data_xiaodui: integer; //需要用的数据
    show_data_zhuzhi: integer; //
    show_data_guojia: integer; //
    procedure CreateParams(var Para:TCreateParams);override;
  end;

var
  Form_dwjh: TForm_dwjh;

implementation
      uses unit1,unit_data,unit_glb,unit_net_set,unit_net;
{$R *.dfm}

{ TForm_dwjh }

procedure TForm_dwjh.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
   Para.WndParent:=GetDesktopWindow;

end;

procedure TForm_dwjh.EnableChanged(var Msg: TMessage);
begin
  EnableWindow(handle, true);
  inherited;
end;

procedure TForm_dwjh.Label5MouseEnter(Sender: TObject);
begin
    (sender as Tlabel).Font.Color:= clblue;
end;

procedure TForm_dwjh.Label5MouseLeave(Sender: TObject);
begin
    (sender as Tlabel).Font.Color:= cldefault;
end;

procedure TForm_dwjh.FormShow(Sender: TObject);
begin
    //显示相应的信息

     

 {  case show_tp of
   0: begin
       show_info_0(show_data_sid);
      end;
   1: begin
       show_info_1(show_data_xiaodui);
      end;
   2: begin
        show_info_2(show_data_zhuzhi);
      end;
   3: begin
       show_info_3(show_data_guojia);
      end;
   end; //end case   }

 if (show_tp>= 0) and (show_tp< 4) then
  begin
   if show_tp >= 3 then
      pagecontrol1.ActivePageIndex:=0
      else
       pagecontrol1.ActivePageIndex:=3;

         pagecontrol1.ActivePageIndex:= show_tp;

  end;

end;

procedure TForm_dwjh.Label5Click(Sender: TObject);
begin
  form1.Button1Click(sender);   //显示物品
end;

procedure TForm_dwjh.show_info_0(id: integer);
var p: p_user_id_time;
begin
   //显示个人信息，首先，把id和自己的id匹配

   label15.Visible:= id= my_s_id_G; //只能修改自己的昵称
   edit1.ReadOnly:= id<> my_s_id_G;
   edit1.Enabled:=  id= my_s_id_G;
   label5.Visible:= id= my_s_id_G;  //只能查看自己的物品

        if id= my_s_id_G then
         begin
           //显示自己的信息
            Label44.Caption:= '等级：'+ inttostr(form1.game_get_role_suxing(1,28));
            label13.Caption:= form_net_set.Edit2.Text;
            edit1.Text:= form1.game_get_newname_at_id(1);
            label6.Caption:= net_get_dwjhming(game_player_head_G.duiwu_id,1,true);
            label7.Caption:= net_get_dwjhming(game_player_head_G.zhuzhi_id,2,true);
            label8.Caption:= net_get_dwjhming(game_player_head_G.guojia_id,3,true);
            
              radiobutton1.Checked:= game_player_head_G.duiwu_dg= 0;  //自由模式
              radiobutton2.Checked:= game_player_head_G.duiwu_dg= 1;
              radiobutton3.Checked:= game_player_head_G.duiwu_dg= 2;
            groupbox3.Visible:= game_player_head_G.duiwu_dg< 100;
               groupbox3.Update;
         end else begin
                   p:= get_user_id_time_type(id); //取得指向该网络玩家的信息指针
                   if p<> nil then
                    begin
                      Label44.Caption:= '等级：'+ inttostr(p.dengji);
                     label13.Caption:= p.u_id;
                       edit1.Text:= p.nicheng;
                        label6.Caption:= net_get_dwjhming(p.xiaodui,1,true);
                      label7.Caption:= net_get_dwjhming(p.zhuzhi,2,true);
                        label8.Caption:= net_get_dwjhming(p.guojia,3,true);
                        //显示跟随状态，如果是本小队的，且自己为队长，否则灰色
                           groupbox3.Visible:= true;  //显示
                           radiobutton1.Checked:= p.xiaodui_dg= 0;  //自由模式
                           radiobutton2.Checked:= p.xiaodui_dg= 1;
                           radiobutton3.Checked:= p.xiaodui_dg= 2;
                          groupbox3.Enabled:= (game_player_head_G.duiwu_dg= 100) and (p.xiaodui=game_player_head_G.duiwu_id);
                    end else begin
                               label13.Caption:= '';
                               edit1.Text:= '';
                               label6.Caption:= '';
                               label7.Caption:= '';
                               label8.Caption:= '';
                             end;
                  end;

end;

function get_dwjh_name(id: integer): string;
var i: integer;
begin
result:= '';
  for i:= 0 to high(dwjh_g) do
   begin
     if dwjh_g[i].dwid= id then
      begin
        result:=  dwjh_g[i].p_name;
        exit;
      end
   end;
end;

function get_dwjh_ms(id: integer): string;
var i: integer;
begin
result:= '';
  for i:= 0 to high(dwjh_g) do
   begin
     if dwjh_g[i].dwid= id then
      begin
        result:=  dwjh_g[i].p_ms;
        exit;
      end
   end;

end;

procedure TForm_dwjh.show_info_1(id: integer);
var i: integer;
begin
  //显示小队信息

  if id= 0 then
    id:= -1;

  label17.Visible:= (id= game_player_head_G.duiwu_id) and (game_player_head_G.duiwu_dg=100); //自己的小队，且是队长，修改
  label18.Visible:= id<> game_player_head_G.duiwu_id;
  label19.Visible:= id= game_player_head_G.duiwu_id;
  label36.Visible:= (id= game_player_head_G.duiwu_id) and (game_player_head_G.duiwu_dg=100); //自己的小队，且是队长，解散

    edit2.Text:= get_dwjh_name(id);
    memo1.Text:= get_dwjh_ms(id);

   edit2.ReadOnly:=  not(label17.Visible or (game_player_head_G.duiwu_id= 0));
    memo1.ReadOnly:= not(label17.Visible or (game_player_head_G.duiwu_id= 0));

     label20.Visible:=  label17.Visible;
     label25.Visible:=  label17.Visible;
     label26.Visible:=  label17.Visible;
     label27.Visible:=  label17.Visible;
     label28.Visible:=  label17.Visible;
     label29.Visible:=  label17.Visible;
     label30.Visible:=  label17.Visible;
     label31.Visible:=  label17.Visible;

     label21.Caption:= '无';
      label21.Tag:= -1;
     label22.Caption:= '无';
      label22.Tag:= -1;
     label23.Caption:= '无';
      label23.Tag:= -1;
     label24.Caption:= '无';
      label24.Tag:= -1;

     for i:= 0 to high(user_info_time) do
      begin
        if user_info_time[i].xiaodui= id then
         begin
           if label21.Tag= -1 then
             begin
              label21.Caption:= user_info_time[i].nicheng;
              label21.tag:= user_info_time[i].s_id;
             end else if label22.Tag= -1 then
                       begin
                         label22.Caption:= user_info_time[i].nicheng;
                         label22.tag:= user_info_time[i].s_id;
                       end else if label23.Tag= -1 then
                           begin
                            label23.Caption:= user_info_time[i].nicheng;
                            label23.tag:= user_info_time[i].s_id;
                           end else if label24.Tag= -1 then
                               begin
                                label24.Caption:= user_info_time[i].nicheng;
                                label24.tag:= user_info_time[i].s_id;
                                exit;
                               end;
         end;
      end; //end for i

end;

procedure TForm_dwjh.show_info_2(id: integer);
var i: integer;
begin
  //显示组织信息
   if id= 0 then
    id:= -1;

  label33.Visible:= (id= game_player_head_G.zhuzhi_id) and (game_player_head_G.zhuzhi_dg=100); //自己的组织，且是队长，修改
  label34.Visible:= id<> game_player_head_G.zhuzhi_id;
  label35.Visible:= id= game_player_head_G.zhuzhi_id;
  label37.Visible:= (id= game_player_head_G.zhuzhi_id) and (game_player_head_G.zhuzhi_dg=100); //自己的组织，且是队长，解散

  edit3.Text:= get_dwjh_name(id);
    memo2.Text:= get_dwjh_ms(id);

   edit3.ReadOnly:= not(label33.Visible or (game_player_head_G.zhuzhi_id= 0));
    memo2.ReadOnly:= not(label33.Visible or (game_player_head_G.zhuzhi_id= 0));

    button1.Visible:= label33.Visible;
    button11.Visible:= label33.Visible;

    button2.Visible:= (id= game_player_head_G.zhuzhi_id) and (game_player_head_G.zhuzhi_dg >=50);
    button3.Visible:= (id= game_player_head_G.zhuzhi_id) and (game_player_head_G.zhuzhi_dg >=50);
    button4.Visible:= (id= game_player_head_G.zhuzhi_id) and (game_player_head_G.zhuzhi_dg >=50);

    listbox1.Items.Clear;

    for i:= 0 to high(user_info_time) do
        if user_info_time[i].zhuzhi= id then
          listbox1.Items.Append(user_info_time[i].nicheng);

end;

procedure TForm_dwjh.show_info_3(id: integer);
var i: integer;
begin
    //显示国家信息
   if id= 0 then
    id:= -1;

  label39.Visible:= (id= game_player_head_G.guojia_id) and (game_player_head_G.guojia_dg=100); //自己的组织，且是队长，修改
  label40.Visible:= id<> game_player_head_G.guojia_id;
  label41.Visible:= id= game_player_head_G.guojia_id;
  label42.Visible:= (id= game_player_head_G.guojia_id) and (game_player_head_G.guojia_dg=100); //自己的组织，且是队长，解散

   edit4.Text:= get_dwjh_name(id);
    memo3.Text:= get_dwjh_ms(id);

   edit4.ReadOnly:=  not(label39.Visible or (game_player_head_G.zhuzhi_id= 0));
    memo3.ReadOnly:= not(label39.Visible or (game_player_head_G.zhuzhi_id= 0));

    button5.Visible:= label39.Visible;
    button9.Visible:= label39.Visible;
             //100,国王，90以上，王，妃，后，80以上，王子公主，
    button10.Visible:= (id= game_player_head_G.guojia_id) and (game_player_head_G.guojia_dg >=90);
    button12.Visible:= (id= game_player_head_G.guojia_id) and (game_player_head_G.guojia_dg >=90);
    button13.Visible:= (id= game_player_head_G.guojia_id) and (game_player_head_G.guojia_dg >=90);

      button6.Visible:= (id= game_player_head_G.guojia_id) and (game_player_head_G.guojia_dg >=70);
    button7.Visible:= (id= game_player_head_G.guojia_id) and (game_player_head_G.guojia_dg >=50);
    button8.Visible:= (id= game_player_head_G.guojia_id) and (game_player_head_G.guojia_dg >=50);

    listbox2.Items.Clear;

    for i:= 0 to high(user_info_time) do
        if user_info_time[i].guojia= id then
          listbox1.Items.Append(user_info_time[i].nicheng);

end;

procedure TForm_dwjh.TabSheet1Show(Sender: TObject);
begin

        show_info_0(show_data_sid);
end;

procedure TForm_dwjh.TabSheet2Show(Sender: TObject);
begin
  if show_tp= 1 then
   show_info_1(show_data_xiaodui)
   else  begin
          if show_tp= 0 then
           if show_data_sid= my_s_id_G then
            show_data_xiaodui:= game_player_head_G.duiwu_id
           else
             show_data_xiaodui:= get_user_id_time_dwjh(show_data_sid,1);
          show_info_1(show_data_xiaodui) ;
         end;
end;

procedure TForm_dwjh.TabSheet3Show(Sender: TObject);
begin
   if show_tp= 2 then
   show_info_2(show_data_zhuzhi)
   else begin
          if show_tp= 0 then
            if show_data_sid= my_s_id_G then
            show_data_zhuzhi:= game_player_head_G.zhuzhi_id
            else
             show_data_zhuzhi:= get_user_id_time_dwjh(show_data_sid,2);
          show_info_2(show_data_zhuzhi) ;
         end;
end;

procedure TForm_dwjh.TabSheet4Show(Sender: TObject);
begin
  if show_tp= 3 then
    show_info_3(show_data_guojia)
  else begin
          if show_tp= 0 then
            if show_data_sid= my_s_id_G then
            show_data_guojia:= game_player_head_G.guojia_id
           else
             show_data_guojia:= get_user_id_time_dwjh(show_data_sid,3);
          show_info_3(show_data_guojia) ;
         end;
end;

procedure TForm_dwjh.Label15Click(Sender: TObject);
begin
       //修改了昵称
    if (pos('(',edit1.Text)> 0) or (pos('（',edit1.Text)> 0) then
     begin
      messagebox(handle,'昵称内不能有括号','错误',mb_ok);
      exit;
     end;

    if  show_data_sid= my_s_id_G then
     begin

     end;
end;

procedure TForm_dwjh.Label6Click(Sender: TObject);
begin
    //查看小队信息
    if show_tp<> 1 then
      begin
        //当小队信息不是默认页面时，给show_data2赋值
        if show_data_sid= my_s_id_G then
           show_data_xiaodui:= game_player_head_G.duiwu_id
           else begin
                  show_data_xiaodui:= get_user_id_time_dwjh(my_s_id_G,1); //获取小队id
                end;
      end;

   TabSheet2Show(sender);
end;

procedure TForm_dwjh.Label7Click(Sender: TObject);
begin
    //查看帮派信息
    if show_tp<> 1 then
      begin
        //当小队信息不是默认页面时，给show_data2赋值
        if show_data_sid= my_s_id_G then
           show_data_zhuzhi:= game_player_head_G.zhuzhi_id
           else begin
                  show_data_zhuzhi:= get_user_id_time_dwjh(my_s_id_G,2); //获取帮派id
                end;
      end;

   TabSheet3Show(sender);
end;

procedure TForm_dwjh.Label8Click(Sender: TObject);
begin
   //查看国家信息
    if show_tp<> 1 then
      begin
        //当小队信息不是默认页面时，给show_data2赋值
        if show_data_sid= my_s_id_G then
           show_data_guojia:= game_player_head_G.guojia_id
           else begin
                  show_data_guojia:= get_user_id_time_dwjh(my_s_id_G,3); //获取国家id
                end;
      end;

   TabSheet4Show(sender);
end;

procedure TForm_dwjh.Label9Click(Sender: TObject);
begin
    //创建小队
    if game_player_head_G.duiwu_id<> 0 then
      messagebox(handle,'您已经创建或者加入了一个小队，不能再次创建。','错误',mb_ok)
      else begin
             //发出创建小队消息，等待服务器回应
             if messagebox(handle,'您真的要自己创建一个小队吗？','提问',mb_yesno)=mryes then
                create_dwjh(1);
           end;
end;


procedure TForm_dwjh.Label10Click(Sender: TObject);
begin
     //创建帮派
     if game_player_head_G.zhuzhi_id<> 0 then
      messagebox(handle,'您已经创建或者加入了一个帮会，不能再次创建。','错误',mb_ok)
      else begin
             //发出创建消息，等待服务器回应
             //创建帮会，要求10万金钱，30级以上
             if form1.game_get_money(1)< 100000 then
                 messagebox(handle,'您金钱不足，创建帮会要求拥有10万或以上金钱。','错误',mb_ok)
                 else if form1.game_grade('无名',30)=0 then
                         messagebox(handle,'您等级不足，创建帮会要求30级或以上。','错误',mb_ok)
                         else if messagebox(handle,'您真的要自己创建一个帮会组织吗？','提问',mb_yesno)=mryes then
                                 create_dwjh(2);
           end;
end;

procedure TForm_dwjh.Label11Click(Sender: TObject);
begin
      //创建国家
      if game_player_head_G.guojia_id<> 0 then
      messagebox(handle,'您已经创建或者加入了一个国家，不能再次创建。','错误',mb_ok)
      else begin
             //发出创建消息，等待服务器回应
             //创建国家，要求100万金钱，50级以上
             if form1.game_get_money(1)< 1000000 then
                 messagebox(handle,'您金钱不足，创建国家要求拥有100万或以上金钱。','错误',mb_ok)
                 else if form1.game_grade('无名',50)=0 then
                         messagebox(handle,'您等级不足，创建国家要求50级或以上。','错误',mb_ok)
                         else if messagebox(handle,'您真的要自己创建一个国家吗？','提问',mb_yesno)=mryes then
                                create_dwjh(3);
           end;
end;

procedure TForm_dwjh.create_dwjh(tp: integer);
var ss,ss2,ss3: string;
    i: integer;
    t: cardinal;
    pp: Tdwjh_type;
begin
  // 创建小队，帮派，国家，tp1，2，3

             case tp of
             1: ss2:= trim(edit2.Text);
             2: ss2:= trim(edit3.Text);
             3: ss2:= trim(edit4.Text);
             end;

   if ss2= '' then
    begin
     messagebox(handle,'名称不能为空。','错误',mb_ok);
     exit;
    end;

  if (pos('(',ss)> 0) or (pos('（',ss)> 0) then
     begin
      messagebox(handle,'名称内不能有括号','错误',mb_ok);
      exit;
     end;

   if (length(trim(ss2))< 4) or (length(trim(ss2))> 32) then
     begin
      messagebox(handle,'名称不符要求，请输入大于4个字符（2汉字）并且最多不超过32个字符（16汉字）的名称','错误',mb_ok);
      exit;
     end;

     case tp of
      1: ss3:= memo1.Text;
      2: ss3:= memo2.Text;
      3: ss3:= memo3.Text;
      end;

  ss:= '        '+ trim(ss2) +'|'+ ss3;



  i:= byte_to_integer(g_xiaodui_cj_c,false);
   pinteger(ss)^:= i;

      i:= my_s_id_G;
      longrec(i).Hi:= tp;
    pinteger(integer(ss) + 4)^:= i;

    //发送数据，然后等待回应
     Game_wait_ok1_g:= false; //等待的一个来自服务器的ok信号
     game_wait_integer_g:= 0;
     t:= GetTickCount;
screen.Cursor:= crhourglass;
     g_send_msg_str(ss); //向服务器发送

      while (Game_wait_ok1_g= false) and (GetTickCount -t < 10000) do
      begin
        application.ProcessMessages;
        sleep(10);
      end;
screen.Cursor:= crdefault;

      if Game_wait_ok1_g then
       begin
        case game_wait_integer_g of
        1: begin
             case tp of
             1: begin
                 pp.dwid:= game_player_head_G.duiwu_id;
                // show_info_1(game_player_head_G.duiwu_id);
                end;
             2: begin
                 pp.dwid:= game_player_head_G.zhuzhi_id;
                // show_info_2(game_player_head_G.zhuzhi_id);
                end;
             3: begin
                 pp.dwid:= game_player_head_G.guojia_id;
                // show_info_3(game_player_head_G.guojia_id);
                end;
             end;

            pp.p_id:= '自己';
            pp.p_name:= ss2;
            pp.p_ms:= ss3;
            Data_net.game_dwjh_data(@pp,sizeof(Tdwjh_type));  //记录信息到本机列表
             case tp of
             1: begin
                 //pp.dwid:= game_player_head_G.duiwu_id;
                 show_info_1(game_player_head_G.duiwu_id);
                end;
             2: begin
                 //pp.dwid:= game_player_head_G.zhuzhi_id;
                 show_info_2(game_player_head_G.zhuzhi_id);
                end;
             3: begin
                // pp.dwid:= game_player_head_G.guojia_id;
                 show_info_3(game_player_head_G.guojia_id);
                end;
             end;
             messagebox(handle,'创建成功。','成功',mb_ok);
           end;
        2: messagebox(handle,'等级不够，创建失败。','错误',mb_ok);
        3: messagebox(handle,'用户在服务器上不存在，创建失败。','错误',mb_ok);
        4: messagebox(handle,'服务器保存数据出错，创建失败。','错误',mb_ok);
        end;
       end else messagebox(handle,'通讯超时，创建失败。','错误',mb_ok);


end;

procedure TForm_dwjh.add_and_exit_dwjh(flag, id: integer);
begin
    //flag=1加入小队，2退出小队，3解散小队，4加入组织……
    //玩家加入了小队，cmd=1小队，2组织，3国家，data1表示s_id，data2表示小队组织编号
   case flag of
   1: begin   //加入小队
     {  game_player_head_G.duiwu_id:= id;
       game_player_head_G.duiwu_dg:= 1;

       send_pak_tt(g_xiaodui_jr_c,1,my_s_id_G,id,0,); }
      end;
   2: begin //退出小队
        game_player_head_G.duiwu_id:= 0;
       game_player_head_G.duiwu_dg:= 0;

       send_pak_tt(g_xiaodui_tc_c,1,my_s_id_G,id,0);
      end;
   3: begin  //解散小队
        game_player_head_G.duiwu_id:= 0;
       game_player_head_G.duiwu_dg:= 0;

       send_pak_tt(g_xiaodui_js_c,1,my_s_id_G,id,0);
      end;
   4: begin   //加入组织
      {   game_player_head_G.zhuzhi_id:= id;
       game_player_head_G.zhuzhi_dg:= 1;

       send_pak_tt(g_xiaodui_jr_c,2,my_s_id_G,id,0,);  }
      end;
   5: begin //退出组织
        game_player_head_G.zhuzhi_id:= 0;
       game_player_head_G.zhuzhi_dg:= 0;

       send_pak_tt(g_xiaodui_tc_c,2,my_s_id_G,id,0);
      end;
   6: begin //解散组织
        game_player_head_G.zhuzhi_id:= 0;
       game_player_head_G.zhuzhi_dg:= 0;

       send_pak_tt(g_xiaodui_js_c,2,my_s_id_G,id,0);
      end;
   7: begin  //加入国家
       {   game_player_head_G.guojia_id:= id;
       game_player_head_G.guojia_dg:= 1;

       send_pak_tt(g_xiaodui_jr_c,3,my_s_id_G,id,0,); }
      end;
   8: begin //退出国家
        game_player_head_G.guojia_id:= 0;
       game_player_head_G.guojia_dg:= 0;

       send_pak_tt(g_xiaodui_tc_c,3,my_s_id_G,id,0);
      end;
   9: begin   //解散国家
        game_player_head_G.guojia_id:= 0;
       game_player_head_G.guojia_dg:= 0;

       send_pak_tt(g_xiaodui_js_c,3,my_s_id_G,id,0);
      end;
   end;

end;

procedure TForm_dwjh.Label18Click(Sender: TObject);
begin
     //加入小队
     if game_player_head_G.duiwu_id<> 0 then
      begin
        messagebox(handle,'您已经在小队内，不能重复加入。','错误',mb_ok);
        exit;
      end;

    // add_and_exit_dwjh(1,show_data2); //加入小队
    // show_info_1(show_data2);

     add_dwjh_q(1,show_data_xiaodui); //给队长发送请求加入信息
     form1.game_chat('请求信息已发送，请等待验证。');
      close;
    // messagebox(handle,'请求信息已发送，请等待验证。','已发送',mb_ok);
end;

procedure TForm_dwjh.Label19Click(Sender: TObject);
begin
     //退出小队
     if game_player_head_G.duiwu_id= 0 then
      begin
        messagebox(handle,'您没有在小队内，无须退出。','错误',mb_ok);
        exit;
      end;

      if game_player_head_G.duiwu_id <> show_data_xiaodui then
       begin
         messagebox(handle,'您没有在当前小队内。','错误',mb_ok);
         exit;
       end;

      if messagebox(handle,'真的要退出小队吗。','询问',mb_yesno)= mrno then
        exit;

     


     add_and_exit_dwjh(2,show_data_xiaodui);
     show_info_1(show_data_xiaodui);

     messagebox(handle,'退出成功。','成功',mb_ok);
end;

procedure TForm_dwjh.Label36Click(Sender: TObject);
begin
    //解散小队



     if (game_player_head_G.duiwu_id<> show_data_xiaodui) or (game_player_head_G.duiwu_dg<>100) then
      begin
        messagebox(handle,'您不是队长或者当前操作的不是自己的小队，不能解散。','错误',mb_ok);
        exit;
      end;

      if messagebox(handle,'真的要解散小队吗。','询问',mb_yesno)= mrno then
        exit;


     add_and_exit_dwjh(3,show_data_xiaodui);
     show_info_1(show_data_xiaodui);

     messagebox(handle,'解散成功。','成功',mb_ok);
     edit2.Text:= '';
     memo1.Lines.Clear;
     game_player_head_G.duiwu_id:= 0;
     game_player_head_G.duiwu_dg:= 0;
     close;
end;

procedure TForm_dwjh.Label34Click(Sender: TObject);
begin
   //加入帮会
     if game_player_head_G.zhuzhi_id<> 0 then
      begin
        messagebox(handle,'您已经在某个帮会内，不能重复加入。','错误',mb_ok);
        exit;
      end;


     add_dwjh_q(2,show_data_zhuzhi); //发送请求加入信息
     form1.game_chat('请求信息已发送，请等待验证。');
      close;

    { add_and_exit_dwjh(4,show_data2);
     show_info_2(show_data2);

     messagebox(handle,'加入成功。','成功',mb_ok); }
end;

procedure TForm_dwjh.Label35Click(Sender: TObject);
begin
   //退出帮会
     if game_player_head_G.zhuzhi_id= 0 then
      begin
        messagebox(handle,'您没有在帮会内，无须退出。','错误',mb_ok);
        exit;
      end;

    
      if game_player_head_G.zhuzhi_id <> show_data_zhuzhi then
       begin
         messagebox(handle,'您没有在当前帮会内。','错误',mb_ok);
         exit;
       end;

      if messagebox(handle,'真的要退出此帮会吗。','询问',mb_yesno)= mrno then
        exit;

     add_and_exit_dwjh(5,show_data_zhuzhi);
     show_info_2(show_data_zhuzhi);

     messagebox(handle,'退出成功。','成功',mb_ok);
end;

procedure TForm_dwjh.Label37Click(Sender: TObject);
begin
   //解散帮会


     if (game_player_head_G.zhuzhi_id<> show_data_zhuzhi) or (game_player_head_G.zhuzhi_dg<>100) then
      begin
        messagebox(handle,'您不是会长或者当前操作的不是自己的帮会，不能解散。','错误',mb_ok);
        exit;
      end;

       if messagebox(handle,'真的要解散此帮会吗。','询问',mb_yesno)= mrno then
        exit;


     add_and_exit_dwjh(6,show_data_zhuzhi);
     show_info_2(show_data_zhuzhi);

     messagebox(handle,'解散成功。','成功',mb_ok);
     edit3.Text:= '';
     memo2.Lines.Clear;
     listbox1.Items.Clear;
      game_player_head_G.zhuzhi_id:= 0;
     game_player_head_G.zhuzhi_dg:= 0;
     close;
end;

procedure TForm_dwjh.Label40Click(Sender: TObject);
begin
   //加入国家
     if game_player_head_G.guojia_id<> 0 then
      begin
        messagebox(handle,'您已经在某个国家内，不能重复加入。','错误',mb_ok);
        exit;
      end;


     add_dwjh_q(3,show_data_guojia); //给队长发送请求加入信息
     form1.game_chat('请求信息已发送，请等待验证。');
      close;
    { add_and_exit_dwjh(7,show_data2);
     show_info_3(show_data2);

     messagebox(handle,'加入成功。','成功',mb_ok); }
end;

procedure TForm_dwjh.Label41Click(Sender: TObject);
begin
    //退出国家
     if game_player_head_G.guojia_id= 0 then
      begin
        messagebox(handle,'您没有在国家内，无须退出。','错误',mb_ok);
        exit;
      end;

     
      if game_player_head_G.guojia_id <> show_data_guojia then
       begin
         messagebox(handle,'您没有在当前国家内。','错误',mb_ok);
         exit;
       end;

      if messagebox(handle,'真的要退出此国家吗。','询问',mb_yesno)= mrno then
        exit;

     add_and_exit_dwjh(8,show_data_guojia);
     show_info_3(show_data_guojia);

     messagebox(handle,'退出成功。','成功',mb_ok);
end;

procedure TForm_dwjh.Label42Click(Sender: TObject);
begin
    //解散


     if (game_player_head_G.guojia_id<> show_data_guojia) or (game_player_head_G.guojia_dg<>100) then
      begin
        messagebox(handle,'您不是国王或者当前操作的不是自己的国家，不能解散。','错误',mb_ok);
        exit;
      end;


      if messagebox(handle,'真的要解散此国家吗。','询问',mb_yesno)= mrno then
        exit;


     add_and_exit_dwjh(9,show_data_guojia);
     show_info_3(show_data_guojia);

     messagebox(handle,'解散成功。','成功',mb_ok);

     edit4.Text:= '';
     memo3.Lines.Clear;
     listbox2.Items.Clear;
      game_player_head_G.guojia_id:= 0;
     game_player_head_G.guojia_dg:= 0;
     game_player_head_G.guanzhi:= '';
     close;

end;

procedure TForm_dwjh.add_dwjh_q(flag, id: integer);
var pk: Tmsg_cmd_pk2;
begin
    //构造一个需要转发的数据包，然后发送
    pk.hander:= byte_to_integer(g_rep_dwjh_z_c,false); //服务器识别数据头
     pk.hander2:= byte_to_integer(g_rec_cmd_c,false); //转发后对方客户端识别数据头

     case flag of
     1: pk.pak.cmd:= g_cmd_a_game;   //请求加入组队
     2: pk.pak.cmd:= g_cmd_zhuzhi_q;   //请求加入组织
     3: pk.pak.cmd:= g_cmd_guojia_q;   //请求加入国家
     end;

     pk.pak.data1:= id;
     pk.pak.s_id:=  my_s_id_G;

     g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk2));
end;
procedure change_radiobutton_1(i: integer);
var p: p_user_id_time;
begin
    {dwjh 的cmd说明，1=修改了队员模式，2=帮会内新的级别，3=国家内新的级别 data1表示sid，data2表示新的数值}
    if game_player_head_G.duiwu_id= 0 then
      exit;



        if my_s_id_G= Form_dwjh.show_data_sid then
         begin
          if (game_player_head_G.duiwu_dg<> i) then
           begin
           game_player_head_G.duiwu_dg:= i;
           send_pak_tt(g_zhuzhi_cj_c,1,my_s_id_G,i,my_s_id_G);
           end;
         end else begin
                   p:= get_user_id_time_type(Form_dwjh.show_data_sid);
                   if p<> nil then
                    begin
                     if (game_player_head_G.duiwu_dg= 100) and (p.xiaodui=game_player_head_G.duiwu_id) then
                        begin
                        p.xiaodui_dg:= i;
                        send_pak_tt(g_zhuzhi_cj_c,1,p.s_id,i,my_s_id_G);
                        end;
                    end;
                  end;

end;

procedure TForm_dwjh.RadioButton1Click(Sender: TObject);
begin
    {dwjh 的cmd说明，1=修改了队员模式，2=帮会内新的级别，3=国家内新的级别 data1表示sid，data2表示新的数值}
    if radiobutton1.Checked then
    change_radiobutton_1(0);

end;

procedure TForm_dwjh.RadioButton2Click(Sender: TObject);
begin
 if radiobutton2.Checked then
  change_radiobutton_1(1);
end;

procedure TForm_dwjh.RadioButton3Click(Sender: TObject);
begin
   if radiobutton3.Checked then
    change_radiobutton_1(2);
end;

end.
