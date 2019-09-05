unit Unit_net;

interface

uses
  SysUtils, Classes, windows,
  ExtCtrls,unit_glb,forms,
    RaknetDLL,
  RakNetTypes,
  RakNetStruct,
  RaknetMultiplayer;

type

   p_user_id_time= ^T_user_id_time;

   T_user_id_time= record   //在客户端上的用户列表
   s_id: integer;
   u_id: string[32];     //人物登录id
   nicheng: string[48];
   page: integer;       //当前页
   dengji: integer; //等级
   xiaodui: integer;
   xiaodui_dg: integer; //=0队员，自由模式，=1队员受限模式，=2领队，自由模式，=3领队，领导模式 ，4，队员，仅战斗跟随
   zhuzhi: integer;
   zhuzhi_dg: integer;
   guojia: integer;
   guojia_dg: integer;
   time: cardinal; //上次刷新时间
   player_id: T_play_id; //玩家的playerid
   end;

   T_is_pk_z= record
    is_pk: boolean;   //是否pk状态
    is_zhihui: boolean;     //是否处于总指挥状态
    is_kongzhi: boolean; //是否控制权
    game_zt: integer;   //0场景状态，1，背单词，2挖矿，3采药，4，打坐，5比赛，6战斗
    end;

  TData_net = class(TDataModule)
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

    procedure SetCallback(xCall: PTMultiPlayerCallbackList);
    procedure reshow_net_id(id,flag,p: integer); //增减网络用户在页面的显示
    procedure reshow_net_id_all(c: integer; p: pointer;show: boolean= true); //刷新全部网络用户在页面的显示
    procedure game_page_online_data(p: pointer; c: integer); //收到服务器发来的完整用户数据
    procedure add_s_id_in_list(sid: integer); //添加队员到跟随队员列表
    procedure del_s_id_in_list(sid: integer); //删除队员从跟随队员列表
    procedure nil_s_id_from_list_g(sid: integer); //从全局在线列表置空一个sid
   // procedure send_page_and_home_id(i, h, old: integer);
  public
    { Public declarations }
      LibLoaded:boolean;
  ClientServerInited:boolean;
  MSConnected:boolean;
  asdf:pointer;
  BroadcastPlayer:TRakPlayerID;
  MasterClient:TRaknetMultiplayerClient;
  procedure  InitializateClientServer(const ip: string);
  procedure  UnInitializateClientServer;
  procedure IntIdle;
  function g_start_udpserver2(const ip: string): boolean;  //启动服务
  procedure send_scene_integer(id,v: integer); //发送事件数值
  procedure send_scene_bool(id,v: integer); //发送事件bool
  procedure send_page_and_home_id(i,h,old: integer; ldui: boolean); //发送当前页面和home页面到服务器。是否领队
  procedure game_dwjh_data(p: pointer; c: integer);  //收到服务器发来的dwjh数据
  function get_s_id_nicheng(sid: integer): string; //获取指定人物的昵称
  procedure send_player_Fvalues(i,v_old,V_new: integer); //发送人物变动数据到服务器
  procedure send_dwjh_pop(flag,shu,guai: integer); //队长发出的指令，弹出背单词或者打怪窗口
  procedure send_game_cmd(js_sid: word;    //接受方（受攻击方）sid
                           fq_m: integer;
                           fq_t: integer;   //命体灵，发起方传送的是新值
                           fq_l: integer;
                           js_m: integer;   //接受方传送的是差值
                           js_t: integer;
                           js_l: integer;
                           flag: word;    //类型，指名是0无动画，1，物理攻击，2法术攻击，3物品攻击，4物品恢复，5法术恢复，6,防7逃
                           wu: word); //发送打怪，动画，指令
  procedure send_game_kongzhi(c,d1,d2: integer; sid: word); //发送控制权命令
  end;


          //全局函数****************************************************************
  procedure send_pak_tt(const h: byte; Acmd,Adata1,Adata2: integer; As_id: word; r: TPacketReliability= RELIABLE);
           //发送命令

  procedure g_send_msg_cmd(p:pointer; i: integer); //发包
  procedure g_send_msg_str(const s: string); //发送内容
  function ip_to_crd(const ip: string):cardinal; //ip转为cardinal
  function crd_to_ip(c:cardinal): string;
  function net_get_dwjhming(id,tp: integer; n: boolean=false): string;  //tp，0-3，表示显示的类型，n仅显示姓名
  function get_user_id_time_type(id: integer): p_user_id_time;
  function get_user_id_time_dwjh(id,tp: integer): integer; //返回wdjh id，0。。3，表示s_id,小队，帮派，国家id
  function get_user_id_time_dwjh_dg(id,tp: integer): integer; //返回等级

  procedure      ClientReceiveRemoteDisconnectionNotification(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveRemoteConnectionLost(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveRemoteNewIncomingConnection(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveRemoteExistingConnection(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveRemoteStaticData(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveConnectionBanned(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveConnectionRequestAccepted(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveNewIncomingConnection(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveConnectionAttemptFailed(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveConnectionResumption(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveNoFreeIncomingConnections(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveDisconnectionNotification(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveConnectionLost(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceivedStaticData(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveInvalidPassword(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveModifiedPacket(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveVoicePacket(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceivePong(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientReceiveAdvertisedSystem(Packet,InterfaceType:TRakInterface);  stdcall;
  procedure	 ClientProcessUnhandledPacket(Packet:TRakInterface;MessageID:byte;InterfaceType:TRakInterface); stdcall;

var
  Data_net: TData_net;
  my_send_cmd_g,my_rec_cmd_g: Tmsg_cmd_send;
  my_send_cmd_pak_g: Tmsg_cmd_pk; //发送的数据包，包含一个指令头和命令数据包
  my_s_id_G: integer; //本机的s_id 在服务器上的数组位置
  user_info_time: array of T_user_id_time;
  dwjh_g: array of Tdwjh_type;  //队伍江湖数组
  pk_zhihui_g: T_is_pk_z; //是否处于pk或者指挥状态
  rec_string_g: string;
  net_guai_g: array[0..4] of Tnet_guai;  //5个来自网络的怪信息
  loc_guai_g: array[0..4] of T_loc_guai;  //本地怪的辅助信息
implementation
    uses unit_player,unit_data,unit1,unit_net_set,zlib,unit_note,Unit_chat,Dialogs,
  Unit_pop;
{$R *.dfm}
procedure send_pak_tt(const h: byte; Acmd,Adata1,Adata2: integer; As_id: word; r: TPacketReliability= RELIABLE);   //发包函数
var pk: Tmsg_cmd_pk;
begin
   pk.hander:= byte_to_integer(h,false);
   pk.pak.cmd:= Acmd;
   pk.pak.data1:= Adata1;
   pk.pak.data2:= Adata2;
   pk.pak.s_id:= As_id;

   Data_net.MasterClient.Client.SendBuffer(@pk,sizeof(Tmsg_cmd_pk),MEDIUM_PRIORITY,r,0);

end;

function get_user_id_time_dwjh(id,tp: integer): integer; //返回id，0。。3，表示s_id,小队，帮派，国家id
var i: integer;
begin

result:= 0;

  for i:= 0 to high(user_info_time) do
      if user_info_time[i].s_id= id then
         begin
          case tp of
          1: result:= user_info_time[i].xiaodui;
          2: result:= user_info_time[i].zhuzhi;
          3: result:= user_info_time[i].guojia;
          end;

          exit;
         end;

end;

function get_user_id_time_dwjh_dg(id,tp: integer): integer; //返回等级
var i: integer;
begin

result:= 0;

  for i:= 0 to high(user_info_time) do
      if user_info_time[i].s_id= id then
         begin
          case tp of
          1: result:= user_info_time[i].xiaodui_dg;
          2: result:= user_info_time[i].zhuzhi_dg;
          3: result:= user_info_time[i].guojia_dg;
          end;

          exit;
         end;

end;

function get_user_id_time_type(id: integer): p_user_id_time;
var i: integer;
begin

result:= nil;
if id= g_nil_user_c then
   exit;

  for i:= 0 to high(user_info_time) do
      if user_info_time[i].s_id= id then
         begin
          result:= @user_info_time[i];
          exit;
         end;
end;

function net_get_dwjhming(id,tp: integer; n: boolean=false): string; //n,仅显示姓名
     var k: integer;
        t: cardinal;
        pk: Tmsg_cmd_pk;
        label pp;
begin
      result:= '无';
      if id= 0 then
         exit;

        pp:
       for k:= 0 to high(dwjh_g) do
        begin
         if dwjh_g[k].dwid= id then
            begin
             if n then
             result:= dwjh_g[k].p_name
             else
             result:='<a href="game_show_dwjh('+ inttostr(id)+','+inttostr(tp)+')" title="查看详情">'+ dwjh_g[k].p_name + '</a>';
             exit;
            end;
         if k= high(dwjh_g) then
          begin  //如果没有发现，那么发送消息并等待获取该信息
            t:= GetTickCount;
             Game_wait_ok1_g:= false;
             game_wait_integer_g:= 0;
             pk.hander:= byte_to_integer(g_rep_dwjh_c,false); //头文件
             pk.pak.data1:= id;
             g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk)); //发送
             screen.Cursor:= -11;
             while (Game_wait_ok1_g= false) and (GetTickCount -t < 6000) do
               begin
                  application.ProcessMessages;
                  sleep(10);
               end;
             screen.Cursor:= 0;
             if Game_wait_ok1_g and (game_wait_integer_g=1) then
                goto pp;
          end; //end if k
        end; // enf for
end;
//********************************************************接收数据后的处理
function get_or_add_user_id_time_type(sid: integer): p_user_id_time;
var w: word;
begin
     //获取，如果不存在，那么添加
    result:= get_user_id_time_type(sid); //取得一个指针
     if result= nil then
        begin
         w:= sid;
         data_net.reshow_net_id_all(2,@w,false); //添加一个id到在线列表
         result:= get_user_id_time_type(sid); //再次获取
        end;
end;

procedure pro_g_cmd_zhuzhi_q(sid: integer);
var ss: string;
begin
   //请求加入帮会
   ss:= '玩家<a href="game_show_dwjh('+ inttostr(sid)+',0)" title="查看信息">' + Data_net.get_s_id_nicheng(sid)+ '</a>'+
        '请求加入帮会。<a href="game_add_user_dwjh(2,'+inttostr(sid)+','+ inttostr(game_player_head_G.zhuzhi_id) +');game_chat_cleans(0)">同意申请</a> · <a href="game_chat_cleans(0)">取消</a>';
   form1.game_chat(ss);
end;

procedure pro_g_cmd_zhuzhi_jr(sid,id: integer);
var i: integer;
begin
   //加入了帮会
    if (sid= my_s_id_G) and (game_player_head_G.zhuzhi_id= 0) then
    begin
    game_player_head_G.zhuzhi_id:= id;
    game_player_head_G.zhuzhi_dg:= 0;
     form1.game_chat('<b>您被批准加入了帮会。</b>');
    end else begin
              if sid<> my_s_id_G then
               begin
                 for i:= 0 to high(user_info_time) do
                   if (user_info_time[i].s_id= sid) and (user_info_time[i].zhuzhi= 0) then
                      begin
                        user_info_time[i].zhuzhi:= id;
                        user_info_time[i].zhuzhi_dg:= 0;
                        user_info_time[i].time:= GetTickCount;
                        exit;
                      end;
               end;
             end;
end;

procedure pro_g_cmd_guojia_q(sid: integer);
var ss: string;
begin
   //请求加入国家
   ss:= '玩家<a href="game_show_dwjh('+ inttostr(sid)+',0)" title="查看信息">' + Data_net.get_s_id_nicheng(sid)+ '</a>'+
        '请求加入国家。<a href="game_add_user_dwjh(3,'+inttostr(sid)+','+ inttostr(game_player_head_G.guojia_id) +');game_chat_cleans(0)">同意申请</a> · <a href="game_chat_cleans(0)">取消</a>';
   form1.game_chat(ss);
end;

procedure pro_g_cmd_guojia_jr(sid,id: integer);
var i: integer;
begin
   //加入了国家
   if (sid= my_s_id_G) and (game_player_head_G.guojia_id= 0) then
    begin
    game_player_head_G.guojia_id:= id;
    game_player_head_G.guojia_dg:= 0;
    form1.game_chat('<b>您被批准加入了国家。</b>');
    end else begin
              if sid<> my_s_id_G then
               begin
                 for i:= 0 to high(user_info_time) do
                   if (user_info_time[i].s_id= sid) and (user_info_time[i].guojia= 0) then
                      begin
                        user_info_time[i].guojia:= id;
                        user_info_time[i].guojia_dg:= 0;
                        user_info_time[i].time:= GetTickCount;
                        exit;
                      end;
               end;
             end;
end;

procedure pro_g_cmd_a_game(sid: integer); //要求加入组队
var ss: string;
begin
  //弹出对话框，询问是否同意加入组队。
  ss:= '玩家<a href="game_show_dwjh('+ inttostr(sid)+',0)" title="查看信息">' + Data_net.get_s_id_nicheng(sid)+ '</a>'+
        '请求加入小队。<a href="game_add_user_dwjh(1,'+inttostr(sid)+','+ inttostr(game_player_head_G.duiwu_id) +');game_chat_cleans(0)">同意申请</a> · <a href="game_chat_cleans(0)">取消</a>';
   form1.game_chat(ss);
end;
procedure pro_g_cmd_game_ok(sid,id: integer); //加入了组队
var
    p2: p_user_id_time;
begin
  //data1= 小队id

   if (sid= my_s_id_G) and (game_player_head_G.duiwu_id= 0) then
    begin
    game_player_head_G.duiwu_id:= id;
    game_player_head_G.duiwu_dg:= 1;
    send_pak_tt(g_xiaodui_sid_c,0,0,0,my_s_id_G); //请求其他队员的sid
    form1.game_chat('<b>您被批准加入了小队。</b>');
    end else begin
              if sid<> my_s_id_G then
               begin
                 //如果对方的小队号和自己的相同，那么加入自己的小队
                 p2:= get_or_add_user_id_time_type(sid);
                 if p2= nil then exit;

                   p2.time:= GetTickCount;
                 if id= game_player_head_G.duiwu_id then
                 begin
                   
                    p2.xiaodui:= game_player_head_G.duiwu_id;
                    p2.xiaodui_dg:= 1;

                  Data_net.add_s_id_in_list(sid);
                 end else begin
                           p2.xiaodui:= id;
                           p2.xiaodui_dg:= 0;
                         end;
               end;
             end;

end;

procedure pro_g_cmd_a_pk;     //要求加入pk
begin
  //弹出对话框，询问是否同意对方加入pk

end;
procedure pro_g_cmd_pk_ok;    //同意加入pk
begin
  //根据data1的值判断对方是否同意，100表示同意，其他值拒绝

end;
procedure pro_g_cmd_a_jingsai;  //要求加入竞赛
begin
   //弹出对话框，询问是否同意对方加入竞赛

end;
procedure pro_g_cmd_jingsai_ok;   //同意加入竞赛
begin
  //根据data1的值判断对方是否同意，100表示同意，其他值拒绝

end;
procedure pro_g_cmd_icon_need;
begin
  //发送头像信息

end;
procedure pro_g_cmd_shu_need;
begin
  //发送属性信息，data1的值指明了要哪个人物的属性

end;
procedure pro_g_cmd_pk_sl;        //pk胜利
begin
  //pk胜利，加经验值

end;
procedure pro_g_cmd_pk_sb;        //pk失败
begin
   //pk失败，减经验值

end;
procedure pro_g_cmd_jingsai_sl;    //竞赛胜利
begin
   //竞赛胜利，加经验值，加钱
end;
procedure pro_g_cmd_jingsai_sb;     //竞赛失败
begin
  //失败，减去

end;

procedure pro_g_cmd_g_cmd_dj_xg(p: pointer); //等级修改
var p2: p_user_id_time;
    cmd,d_sid: integer;
    pk: Tmsg_cmd_pk3;
begin
   //dwjh 的cmd说明，1=修改了队员模式，2=帮会内新的级别，3=国家内新的级别 data1表示被修改的 sid，
   //data2表示新的数值  s_id 表示消息发送者的id
p2:= nil;
cmd:= longrec(Tmsg_cmd_send(p^).data1).Hi;
d_sid:= longrec(Tmsg_cmd_send(p^).data1).Lo;
   if d_sid<> my_s_id_G then
    begin
     p2:= get_or_add_user_id_time_type(d_sid); //如果不是修改自己，那么取得一个指针
         if p2<>nil then
           begin
            p2.xiaodui:= game_player_head_G.duiwu_id;
            p2.nicheng:= '';
            p2.page:= 0;
           end else exit;

    end;

   case cmd of
   1: begin   //小队
       if d_sid=my_s_id_G then //被修改的是自己 ，这里没做对方是否有权限的检查
        begin
              if pk_zhihui_g.game_zt >= 5 then  //如果处于战斗状态  这里处理的不是很好
               begin
                    pk.hander:= byte_to_integer(g_rep_zd_c,false); //转发
                    pk.id:= Tmsg_cmd_send(p^).s_id;
                    pk.hander2:= byte_to_integer(g_rec_cmd_c,false); //接收命令
                    pk.pak.cmd:= g_cmd_gg_shibai;
                    pk.pak.data1:= 1; //1表示处于战斗中
                    pk.pak.data2:= d_sid;
                     g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk3));  //如果处于战斗状态，那么对方主动修改无效
               end else begin
                    game_player_head_G.duiwu_dg:= Tmsg_cmd_send(p^).data2;
                    if game_player_head_G.duiwu_dg > 0 then
                     begin
                      form1.game_chat('被队长改为了<b>跟随模式。</b>');
                     end else begin
                                form1.game_chat('被队长改为了<b>自由模式。</b>');
                              end;
                        end;
        end  else begin
                 //对方主动改为跟随状态，这时，如果是在战斗中，修改无效，如果是队长，发出拒绝指令
                if pk_zhihui_g.game_zt >= 5 then  //如果处于战斗状态
                  begin
                    if game_player_head_G.duiwu_dg= 100 then
                    begin
                    pk.hander:= byte_to_integer(g_rep_zd_c,false); //转发
                    pk.id:= d_sid;
                    pk.hander2:= byte_to_integer(g_rec_cmd_c,false); //接收命令
                    pk.pak.cmd:= g_cmd_gg_shibai;
                    pk.pak.data1:= 1; //1表示处于战斗中
                    pk.pak.data2:= d_sid;
                     g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk3));  //如果处于战斗状态，那么对方主动修改无效
                    end;

                    exit;  //退出
                  end;

                p2.xiaodui_dg:= Tmsg_cmd_send(p^).data2; //修改别人
                if game_player_head_G.duiwu_id= p2.xiaodui then
                 begin
                   if p2.xiaodui_dg > 0 then
                     begin
                      Data_net.add_s_id_in_list(p2.s_id);
                      form1.game_chat(Data_net.get_s_id_nicheng(p2.s_id)+'改为了<b>跟随模式。</b>');
                     end else begin
                                Data_net.del_s_id_in_list(p2.s_id);
                                form1.game_chat(Data_net.get_s_id_nicheng(p2.s_id)+'改为了<b>自由模式。</b>');
                              end;
                 end;
               end;
      end;
   2: begin
        if d_sid=my_s_id_G then //被修改的是自己 ，这里没做对方是否有权限的检查
          game_player_head_G.zhuzhi_dg:= Tmsg_cmd_send(p^).data2
          else p2.zhuzhi_dg:= Tmsg_cmd_send(p^).data2; //修改别人
      end;
   3: begin
        if d_sid=my_s_id_G then //被修改的是自己 ，这里没做对方是否有权限的检查
          game_player_head_G.guojia_dg:= Tmsg_cmd_send(p^).data2
          else p2.guojia_dg:= Tmsg_cmd_send(p^).data2; //修改别人
      end;
   end;

end;
procedure pro_g_cmd_page(i: integer); //进入页面
begin
  //进入了指定的页面
  //=0队员，自由模式，=1队员受限模式，=2领队，自由模式，=3领队，领导模式 ,4队员，打怪跟随
 if game_player_head_G.duiwu_dg= 1 then
   begin
    game_page_from_net_g:= true;
    form1.game_page(i);
    game_page_from_net_g:= false;
   end;
end;
procedure close_all_window;
begin //关闭非主窗口
   while screen.ActiveForm.Name<> 'Form1' do
         screen.ActiveForm.Close;
end;

procedure pro_g_cmd_zhandou; //进入战斗
begin
  //弹出战斗窗口

end;
procedure pro_g_cmd_bishai; //进入比赛
begin
  //弹出比赛窗口


end;
procedure pro_g_cmd_pop(p: pointer); //弹出背单词页面
var p2: p_user_id_time;
begin
  //弹出背单词窗口，data1指名了要背的数量

   {//队长发出的指令，弹出背单词或者打怪窗口
      //flag 1背单词，2带弹出效果的背单词窗口，3打怪，4带弹出效果的打怪，5比赛类型的打怪
      data1表示shu，shu就是背单词的数量或者怪物的数量
      data2表示怪物类型，一万以下表示本地怪，一万以上，表明高端是一个sid，负数，表明是一个小队id
      }


      p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
      if p2<> nil then
       begin
        if (p2.xiaodui= game_player_head_G.duiwu_id) and (p2.xiaodui_dg= 100) and
           (game_player_head_G.duiwu_dg= 1) then
         begin  //只接受来自队长的指令，且完全跟随
            close_all_window;
            game_page_from_net_g:= true;
            form1.game_pop(Tmsg_cmd_send(p^).data1);
            game_page_from_net_g:= false;
         end;
       end;

end;
procedure pro_g_cmd_pop_a(p: pointer);  //背单词
var p2: p_user_id_time;
begin
  p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
      if p2<> nil then
       begin
        if (p2.xiaodui= game_player_head_G.duiwu_id) and (p2.xiaodui_dg= 100) and
           (game_player_head_G.duiwu_dg= 1) then
         begin  //只接受来自队长的指令，且完全跟随
            close_all_window;
            game_page_from_net_g:= true;
            form1.game_pop_a(Tmsg_cmd_send(p^).data1);
            game_page_from_net_g:= false;
         end;
       end;

end;
procedure pro_g_cmd_pop_pk(p: pointer);   //打怪
var p2: p_user_id_time;
begin
  p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
      if p2<> nil then
       begin
        if (p2.xiaodui= game_player_head_G.duiwu_id) and (p2.xiaodui_dg= 100) and
           ((game_player_head_G.duiwu_dg = 1) or (game_player_head_G.duiwu_dg = 2)) then
         begin  //只接受来自队长的指令，且完全跟随
            close_all_window;
            game_page_from_net_g:= true;
            form1.game_pop_fight(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2);
            game_page_from_net_g:= false;
         end;
       end;

end;
procedure pro_g_cmd_pop_pk_a(p: pointer);    //进入打怪
var p2: p_user_id_time;
begin
  p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
      if p2<> nil then
       begin
        if (p2.xiaodui= game_player_head_G.duiwu_id) and (p2.xiaodui_dg= 100) and
           ((game_player_head_G.duiwu_dg = 1) or (game_player_head_G.duiwu_dg = 2)) then
         begin  //只接受来自队长的指令，且完全跟随
            close_all_window;
            game_page_from_net_g:= true;
            form1.game_pop_fight_a(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2);
            game_page_from_net_g:= false;
         end;
       end;

end;
procedure pro_g_cmd_pop_game(p: pointer);   //比赛
var p2: p_user_id_time;
begin
   p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
      if p2<> nil then
       begin
        if (p2.xiaodui= game_player_head_G.duiwu_id) and (p2.xiaodui_dg= 100) and
           ((game_player_head_G.duiwu_dg = 1) or (game_player_head_G.duiwu_dg = 2)) then
         begin  //只接受来自队长的指令，且完全跟随
            close_all_window;
            game_page_from_net_g:= true;
            form1.game_pop_game(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2);
            game_page_from_net_g:= false;
         end;
       end;
end;
procedure pro_g_cmd_gg_shibai(p: pointer);         //更改状态失败
var p2: p_user_id_time;
begin
  //data2是一个更改状态失败，需要被改回0的sid，
  if Tmsg_cmd_send(p^).data2= my_s_id_g then
     begin
     game_player_head_G.duiwu_dg:= 0;
     //修改一个属性
     send_pak_tt(g_pl_data_chag,0,5,0,my_s_id_g);
     end else begin
                p2:= get_user_id_time_type(Tmsg_cmd_send(p^).data2);
                if p2<> nil then
                   p2.xiaodui_dg:= 0;
              end;

  case Tmsg_cmd_send(p^).data1 of
  1: form1.game_chat('更改状态失败，对方处于战斗中。');
  2: form1.game_chat('更改状态失败，拒绝。');
  3: form1.game_chat('更改状态失败，原因不明。');
  end;

end;
procedure pro_g_cmd_exit(p: pointer);       //玩家退出
begin
  //如果是本小队的，那么从小队在线内清除
  //然后从全局表清空

 if Tmsg_cmd_send(p^).data2= game_player_head_G.duiwu_id then
    Data_net.del_s_id_in_list(Tmsg_cmd_send(p^).s_id);

    Data_net.nil_s_id_from_list_g(Tmsg_cmd_send(p^).s_id);

end;
procedure pro_g_cmd_xiaodui_sid(p: pointer);    //收到小队其他人员sid 信息
var p2: p_user_id_time;
begin
  if Tmsg_cmd_send(p^).s_id<> g_nil_user_c then
   begin //队长
     p2:= get_or_add_user_id_time_type(Tmsg_cmd_send(p^).s_id);
     if p2<> nil then
      begin
        p2.xiaodui:= game_player_head_G.duiwu_id;
        p2.xiaodui_dg:= 100;
      end;
   end;
  if longrec(Tmsg_cmd_send(p^).data1).Lo<> g_nil_user_c then
   begin //队员一
    p2:= get_or_add_user_id_time_type(longrec(Tmsg_cmd_send(p^).data1).Lo);
     if p2<> nil then
        p2.xiaodui:= game_player_head_G.duiwu_id;

    Data_net.add_s_id_in_list(longrec(Tmsg_cmd_send(p^).data1).Lo);
   end;
  if longrec(Tmsg_cmd_send(p^).data1).Hi<> g_nil_user_c then
   begin //队员二
     p2:= get_or_add_user_id_time_type(longrec(Tmsg_cmd_send(p^).data1).Hi);
     if p2<> nil then
        p2.xiaodui:= game_player_head_G.duiwu_id;

     Data_net.add_s_id_in_list(longrec(Tmsg_cmd_send(p^).data1).Hi);
   end;
  if longrec(Tmsg_cmd_send(p^).data2).Lo<> g_nil_user_c then
   begin //队员三
    p2:= get_or_add_user_id_time_type(longrec(Tmsg_cmd_send(p^).data2).Lo);
     if p2<> nil then
        p2.xiaodui:= game_player_head_G.duiwu_id;
    Data_net.add_s_id_in_list(longrec(Tmsg_cmd_send(p^).data2).Lo);
   end;
  if longrec(Tmsg_cmd_send(p^).data2).Hi<> g_nil_user_c then
   begin //队员四
     p2:= get_or_add_user_id_time_type(longrec(Tmsg_cmd_send(p^).data2).Hi);
     if p2<> nil then
        p2.xiaodui:= game_player_head_G.duiwu_id;

     Data_net.add_s_id_in_list(longrec(Tmsg_cmd_send(p^).data2).Hi);
   end;
end;
procedure pro_g_cmd_dwjh_exit(p: pointer);   //dwjh有人退出
var p2: p_user_id_time;
begin
     p2:= get_user_id_time_type(Tmsg_cmd_send(p^).s_id);
     if p2= nil then
       exit;

  case Tmsg_cmd_send(p^).data1 of
  1: begin
       //如果退出的人是本小队的，那么，从小队内清除，如果退出的人是队长，那么整个小队清除
       if Tmsg_cmd_send(p^).data2= game_player_head_G.duiwu_id then
           Data_net.del_s_id_in_list(Tmsg_cmd_send(p^).s_id);

          p2.xiaodui:= 0;
          p2.xiaodui_dg:= 0;

     end;
  2: begin
      p2.zhuzhi:= 0;
      p2.zhuzhi_dg:= 0;
     end;
  3: begin
      p2.guojia:= 0;
      p2.guojia_dg:= 0;
     end;
  end;

end;
procedure pro_g_cmd_dj_xd_r(p: pointer);    //是否允许修改小队模式
begin
  {首先查询本机状态，如果允许，那么再查看被改动者是否自己，
  如果自己是，表明是对方想要更改跟随模式，发送更改指令
  如果不是队长，那么表明是对方想要修改自己，发送自己更改指令
  }

end;
procedure pro_g_cmd_pop_wak;     //返回的场景事件值
begin
  //接收到了指定场景事件的值
  //需要把接收到标记设置为真

end;
procedure pro_g_cmd_pop_caiyao;           //物品记录事件  （总）
begin
   //目前无用
end;
procedure pro_g_cmd_res_a;
begin
 //添加值到物品事件列表

end;
procedure pro_g_cmd_res_d;
begin
  //从物品事件列表删除

end;
procedure pro_g_cmd_res_r;
begin
  //发送物品事件值

end;
procedure pro_g_cmd_res_rr;
begin
   //接收到了物品事件
   //收到标记设置为真

end;
procedure pro_g_cmd_wupin;         //物品（总）
begin
   //目前无用

end;
procedure pro_g_cmd_wupin_qingkong;     //清空物品
begin
   //把指定物品数量清空

end;
procedure pro_g_cmd_wupin_xiugai;        //修改物品数量
begin
  //修改物品数量 data1值为1表示增加，为2表示减少，为4表示设置为data2指定的值

end;
procedure pro_g_cmd_wupin_r;             //要求读取物品数量
begin
  //发送物品数量

end;
procedure pro_g_cmd_wupin_rr;            //返回的物品数量
begin
  //读取到了物品数量，相应等待标志设置为真

end;
procedure pro_g_cmd_my_atc;             //我方攻击
begin
  //收到此消息开始攻击

end;
procedure pro_g_cmd_my_wufa;           //我方法术物品
begin
  //收到此消息开始使用物品或者法术

end;
procedure pro_g_cmd_my_shu;             //我方属性修改
begin
  //修改属性

end;
procedure pro_g_cmd_guai_atc;           //怪攻击
begin
   //怪物开始攻击

end;
procedure pro_g_cmd_guai_wufa;          //怪法术物品
begin
  //怪物使用了物品或者法术

end;
procedure pro_g_cmd_my_bl;              //我方属性值飘动
begin
  //飘动属性值

end;
procedure pro_g_cmd_guai_bl;             //怪方飘动
begin
  //怪飘动属性值

end;
procedure pro_g_cmd_my_dead;              //我方人物死亡
begin
   //指定人物死亡

end;
procedure pro_g_cmd_guai_dead;            //怪死亡
begin
   //指定怪物死亡

end;
procedure pro_g_cmd_game_over;            //游戏结束
begin
  //战斗失败

end;
procedure pro_g_cmd_win;                  //战斗胜利
begin
   //战斗胜利

end;
procedure pro_g_cmd_chg_m; //修改金钱
begin
  //修改金钱 data1值为1表示增加，为2表示减少，为4表示设置为data2指定的值

end;
procedure pro_g_cmd_cl_m;   //清空金钱
begin
  //金钱为零

end;
procedure pro_g_cmd_r_m;   //要求读取金钱
begin
    //发送金钱值

end;
procedure pro_g_cmd_rr_m;   //返回的金钱值
begin
   //返回了金钱值，相应等待标志设置为真

end;

procedure pro_g_cmd_ip_rr; //返回了自己的ip
begin
  //收到了ip，后续处理

end;
procedure pro_g_cmd_redirect_ip; //从定向到其他服务器地址
begin
   //修正服务器地址

end;

//***************************聊天（长内容）消息
procedure pro_g_cmd_chat(p: pointer; c: integer); //私人聊天
var i,j,k,sid: integer;
    ss: string;
    p2: p_user_id_time;
begin
 //显示聊天信息
 j:= 0; //统计已经弹出的聊天窗口数量，大于
 k:= -1;
 sid:= integer(p^);
   setlength(ss,c-4);
        move(pointer(dword(p)+ 4)^,pointer(ss)^,c-4);
  p2:= get_or_add_user_id_time_type(sid); //添加人物实例
     if p2<> nil then
       if p2.u_id= '' then
          p2.nicheng:= Data_net.get_s_id_nicheng(sid);


  for i:= 0 to application.ComponentCount-1 do
   begin
    if application.Components[i] is Tform_chat then
     begin
      if Tform_chat(application.Components[i]).player_chat_id= integer(p^) then
       begin

        Tform_chat(application.Components[i]).add_message(ss);
        Tform_chat(application.Components[i]).Show;
         exit;
       end else begin
                 inc(j);
                 if Tform_chat(application.Components[i]).player_chat_id < 0 then
                    k:= i; //保留下一个非特定人的聊天窗口
                 if i= application.ComponentCount-1 then
                  begin
                    //假如没有找到合适的，那么再次搜索有没有针对非特定人的聊天窗口存在
                    if k<> -1 then
                     begin
                      Tform_chat(application.Components[k]).add_message(ss);
                      Tform_chat(application.Components[k]).Show;
                      exit;
                     end else begin
                               with Tform_chat.Create(application) do
                                begin
                                  if j >= 16 then //限制聊天窗口不要过多
                                    player_chat_id:= -5
                                    else
                                      player_chat_id:= integer(p^);
                                  
                                  add_message(ss);
                                  Show;
                                end;

                              end;
                  end;
                end;
     end;

   end; // for i

   if j= 0 then
    with Tform_chat.Create(application) do
        begin
        player_chat_id:= integer(p^);
        add_message(ss);
        Show;
        end;
end;

procedure pro_g_cmd_name(p: pointer; const ip: string; pt: integer); //人物名称数据
begin
 //显示人物名称
end;
procedure pro_g_cmd_icon(p: pointer; const ip: string; pt: integer); //头像数据
begin
  //组包，显示头像
end;
procedure pro_g_cmd_data(p: pointer; const ip: string; pt: integer); //自定义数据包
begin
  //根据内容，做不同处理

end;

//***************************************************************************
procedure ClientReceiveConnectionAttemptFailed(Packet,
  InterfaceType:TRakInterface);
begin
  // raktest.MemoServer.Lines.Add('Client recived : Connection Attemp Failed');
end;

procedure ClientReceiveConnectionBanned(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Connection Banned');
 Data_net.MSConnected:= false; //禁止连接
end;

procedure ClientReceiveConnectionLost(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Connection lost');
 Data_net.MSConnected:= false;         //网络断开

end;

procedure ClientReceiveConnectionRequestAccepted(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Recived Connection Request Accept');
  Data_net.MSConnected:= true; //接受了一个链接
end;

procedure ClientReceiveConnectionResumption(Packet,
  InterfaceType:TRakInterface);
begin
 //  raktest.MemoServer.Lines.Add('Client recived : Connection Resumption ');
  Data_net.MSConnected:= true;         //网络恢复
end;

procedure ClientReceiveDisconnectionNotification(Packet,
  InterfaceType:TRakInterface);
begin
//  raktest.MemoServer.Lines.Add('Client recived : Disconnect Notification ');
end;

procedure ClientReceivedStaticData(Packet, InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Static data');
end;

procedure ClientReceiveInvalidPassword(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Invalid Password');
 Data_net.MSConnected:= false; //密码无效
end;

procedure ClientReceiveModifiedPacket(Packet,
  InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived :Mofified Packet ');
end;

procedure ClientReceiveNewIncomingConnection(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : New Incoming Connection');
end;

procedure ClientReceiveNoFreeIncomingConnections(Packet,
  InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : No Free Incoming Connection ');
end;

procedure ClientReceivePong(Packet, InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Receive Pong ');

end;

procedure ClientReceiveRemoteConnectionLost(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Remote Connection Lost');
end;

procedure ClientReceiveRemoteDisconnectionNotification(Packet,
  InterfaceType:TRakInterface);
begin
 // raktest.MemoServer.Lines.Add('Client recived : Disconnect notification ');
end;

procedure ClientReceiveRemoteExistingConnection(Packet,
  InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : Existing Connection ');
end;

procedure ClientReceiveRemoteNewIncomingConnection(Packet,
  InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : Remote New Incoming Connection');
end;

procedure ClientReceiveRemoteStaticData(Packet,
  InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : Remote static data ');
end;

procedure ClientReceiveVoicePacket(Packet, InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : Voice Packet');
end;


procedure	 ClientReceiveAdvertisedSystem(Packet,InterfaceType:TRakInterface);
begin
  //raktest.MemoServer.Lines.Add('Client recived : Advertise system');
end;

procedure	 ClientProcessUnhandledPacket(Packet:TRakInterface;MessageID:byte;InterfaceType:TRakInterface);
var b:boolean;
    p,p2: pointer;
    ii,c2: integer;
    c: cardinal;
begin   //收到数据

   c:= TRAKPacket_Length(Packet);

  if c  < 5 then
   exit;

   p:=  TRAKPacket_data(Packet);
   c:= c- 4;  //减去了头上的4字节数据

   move(p^,(@ii)^,4);
   dword(p):= dword(p) +4;

   case integer_to_byte(ii,b) of
      g_server_gonggao_c : begin
                            //收到服务器通告
                            setlength(rec_string_g,c);
                            move(p^,pointer(rec_string_g)^,c);
                            Form_net_set.richedit1.Text:= rec_string_g;
                           end;
       g_player_rq_c: begin
                     //收到服务器端返回的玩家数据
                     ZDecompress(p,c,p2,c2);
                     if c2 > 20 then
                      begin
                      game_wait_integer_g:= game_add_player_from_net(p2,c2);
                      Game_wait_ok1_g:= true;
                      end;
                      freemem(p2,c2);
                   end;
       g_wupin_rq_c: begin
                     //收到服务器端返回的玩家物品数据，游戏登录时
                       ZDecompress(p,c,p2,c2);
                     if c2 > 20 then
                      begin
                      game_wait_integer_g:= game_add_goods_from_net(p2,c2);
                      Game_wait_ok1_g:= true;
                      end;
                      freemem(p2,c2);

                   end;
       g_secne_rq_bl_c: begin
                     //收到服务器端返回的场景事件的bool
                     Game_wait_ok2_g:= true;
                    game_wait_integer2_g:= Tmsg_cmd_send(p^).data1;
                   end;
       g_scene_rq_int_c: begin
                     //收到服务器端返回的场景事件的int
                    Game_wait_ok2_g:= true;
                    game_wait_integer2_g:= Tmsg_cmd_send(p^).data1;
                   end;
       g_guojia_page_rq_c: begin
                     //收到服务器端返回的国家页面编号
                     Game_wait_ok2_g:= true;
                    game_wait_integer2_g:= Tmsg_cmd_send(p^).data1;
                   end;
       g_rep_online_page_data_c: begin
                    //收到了服务器发来的当前页面在线人物详细数据
                    ZDecompress(p,c,p2,c2);
                    Data_net.game_page_online_data(p2,c2);
                    freemem(p2,c2);
                   end;

       g_rep_dwjh_c: begin
                       //收到dwjh数据 53
                      ZDecompress(p,c,p2,c2);
                    Data_net.game_dwjh_data(p2,c2);
                    freemem(p2,c2);
                     end;
       g_rep_guai_c: begin
                       //收到怪资料
                       game_wait_integer_g:= c div sizeof(Tnet_guai); //取得怪数量
                        if game_wait_integer_g > 0 then
                          begin
                           move(p^,net_guai_g,c);
                          end;

                       Game_wait_ok1_g:= true;
                     end;
      g_rec_cmd_c: begin
                     //收到服务器端返回的查询数据或者服务器的指令，cmd指明了类型************
                     case Tmsg_cmd_send(p^).cmd of
                  g_cmd_zhuzhi_q: pro_g_cmd_zhuzhi_q(Tmsg_cmd_send(p^).s_id);
                  g_cmd_zhuzhi_jr:pro_g_cmd_zhuzhi_jr(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2);
                  g_cmd_guojia_q: pro_g_cmd_guojia_q(Tmsg_cmd_send(p^).s_id);
                  g_cmd_guojia_jr:pro_g_cmd_guojia_jr(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2);
                  g_cmd_a_game:pro_g_cmd_a_game(Tmsg_cmd_send(p^).s_id); //要求加入组队
                  g_cmd_game_ok:pro_g_cmd_game_ok(Tmsg_cmd_send(p^).data1,Tmsg_cmd_send(p^).data2); //同意加入组队
                  g_cmd_a_pk:pro_g_cmd_a_pk;     //要求加入pk
                  g_cmd_pk_ok:pro_g_cmd_pk_ok;    //同意加入pk
                  g_cmd_a_jingsai:pro_g_cmd_a_jingsai;  //要求加入竞赛
                  g_cmd_jingsai_ok:pro_g_cmd_jingsai_ok;   //同意加入竞赛
                  g_cmd_icon_need:pro_g_cmd_icon_need;
                  g_cmd_shu_need:pro_g_cmd_shu_need;
                  g_cmd_pk_sl:pro_g_cmd_pk_sl;        //pk胜利
                  g_cmd_pk_sb:pro_g_cmd_pk_sb;        //pk失败
                  g_cmd_jingsai_sl:pro_g_cmd_jingsai_sl;    //竞赛胜利
                  g_cmd_jingsai_sb:pro_g_cmd_jingsai_sb;     //竞赛失败
                  g_cmd_dj_xg:pro_g_cmd_g_cmd_dj_xg(p); //等级修改
                  g_cmd_page:pro_g_cmd_page(Tmsg_cmd_send(p^).data1); //进入页面
                  g_cmd_zhandou:pro_g_cmd_zhandou; //进入战斗
                  g_cmd_bishai:pro_g_cmd_bishai; //进入比赛
                  g_cmd_pop:pro_g_cmd_pop(p); //弹出背单词页面
                  g_cmd_pop_a:pro_g_cmd_pop_a(p);  //带启动效果的背单词
                  g_cmd_pop_pk:pro_g_cmd_pop_pk(p);   //进入打怪
                  g_cmd_pop_pk_a:pro_g_cmd_pop_pk_a(p);    //带启动效果的打怪
                  g_cmd_pop_game:pro_g_cmd_pop_game(p);   //比赛
                  g_cmd_gg_shibai:pro_g_cmd_gg_shibai(p);        //更改状态失败
                  g_cmd_exit:pro_g_cmd_exit(p);       //玩家退出
                  g_cmd_xiaodui_sid:pro_g_cmd_xiaodui_sid(p);    //收到小队其他人员sid信息
                  g_cmd_dwjh_exit:pro_g_cmd_dwjh_exit(p);    //dwjh 有人退出
                  g_cmd_dj_xd_r:pro_g_cmd_dj_xd_r(p);    //是否允许修改小队等级
                  g_cmd_pop_wak:pro_g_cmd_pop_wak;     //返回的场景事件值
                  g_cmd_pop_caiyao:pro_g_cmd_pop_caiyao;           //物品记录事件  （总）
                  g_cmd_res_a:pro_g_cmd_res_a;
                  g_cmd_res_d:pro_g_cmd_res_d;
                  g_cmd_res_r:pro_g_cmd_res_r;
                  g_cmd_res_rr:pro_g_cmd_res_rr;
                  g_cmd_wupin:pro_g_cmd_wupin;         //物品（总）
                  g_cmd_wupin_qingkong:pro_g_cmd_wupin_qingkong;     //清空物品
                  g_cmd_wupin_xiugai:pro_g_cmd_wupin_xiugai;        //修改物品数量
                  g_cmd_wupin_r:pro_g_cmd_wupin_r;             //要求读取物品数量
                  g_cmd_wupin_rr:pro_g_cmd_wupin_rr;            //返回的物品数量
                  g_cmd_my_atc:pro_g_cmd_my_atc;             //我方攻击
                  g_cmd_my_wufa:pro_g_cmd_my_wufa;           //我方法术物品
                  g_cmd_my_shu:pro_g_cmd_my_shu;             //我方属性修改
                  g_cmd_guai_atc:pro_g_cmd_guai_atc;           //怪攻击
                  g_cmd_guai_wufa:pro_g_cmd_guai_wufa;          //怪法术物品
                  g_cmd_my_bl:pro_g_cmd_my_bl;              //我方属性值飘动
                  g_cmd_guai_bl:pro_g_cmd_guai_bl;             //怪方飘动
                  g_cmd_my_dead:pro_g_cmd_my_dead;              //我方人物死亡
                  g_cmd_guai_dead:pro_g_cmd_guai_dead;            //怪死亡
                  g_cmd_game_over:pro_g_cmd_game_over;            //游戏结束
                  g_cmd_win:pro_g_cmd_win;                  //战斗胜利
                  g_cmd_chg_m:pro_g_cmd_chg_m; //修改金钱
                  g_cmd_cl_m:pro_g_cmd_cl_m;   //清空金钱
                  g_cmd_r_m:pro_g_cmd_r_m;   //要求读取金钱
                  g_cmd_rr_m:pro_g_cmd_rr_m;   //返回的金钱值
                  g_cmd_ip_rr:pro_g_cmd_ip_rr; //返回了自己的ip
                  g_cmd_redirect_ip:pro_g_cmd_redirect_ip; //从定向到其他服务器地址

                    end; //end case
                     //****************************************************************8
                   end;
      g_rec_cmd_dw_c: begin
                        //收到队友信息改变
                      end;
      g_rec_nc_dw_c: begin
                        //收到队友昵称改变
                     end;
      g_rec_login_c: begin
                     //服务器返回信息，data1指名了 1登录成功，2登录被拒绝，未通过审核，3被管理员禁止，4客户端版本过低，5服务器已满，6未知的拒绝理由
                    // move(p^,my_msg_cmd_g,c);
                    Game_wait_ok1_g:= true;
                    game_wait_integer_g:= Tmsg_cmd_send(p^).data1;
                    if game_wait_integer_g= 1 then
                       my_s_id_G:= Tmsg_cmd_send(p^).data2; //保存下服务器端的s_id
                   end;
      g_rec_kick_c: begin
                     //被服务器踢出
                     case Tmsg_cmd_send(p^).data1 of
                     1:form1.game_show_note('您被管理员踢出了服务器。');
                     2: form1.game_show_note('您涉嫌使用外挂，被服务器踢出。');
                     3: form1.game_show_note('由于物品数量和服务器上的不一致，被中断了连接。');
                     4: form1.game_show_note('被服务器踢出游戏，原因不明。');
                     end;
                      Data_net.MasterClient.Client.Disconnect(0,0);
                      Data_net.MSConnected:= false;
                      Game_at_net_G:= false;
                      form1.game_page(14444); //游戏结束
                   end;    
      g_rec_reg_c: begin
                     //注册信息，data1=1，注册成功，2注册失败有同名存在，3注册失败,服务器禁止，其他原因
                   // move(p^,my_msg_cmd_g,c);
                    Game_wait_ok1_g:= true;
                    game_wait_integer_g:= Tmsg_cmd_send(p^).data1;
                     if (Tmsg_cmd_send(p^).cmd= 2) and (Tmsg_cmd_send(p^).data1=1) then
                       begin
                          //返回了创建dwjh的数据
                        case Tmsg_cmd_send(p^).s_id of
                         1: begin
                             game_player_head_G.duiwu_id:= Tmsg_cmd_send(p^).data2;
                             game_player_head_G.duiwu_dg:= 100;
                            end;
                         2: begin
                             game_player_head_G.zhuzhi_id:= Tmsg_cmd_send(p^).data2;
                             game_player_head_G.zhuzhi_dg:= 100;
                            end;
                         3: begin
                             game_player_head_G.guojia_id:= Tmsg_cmd_send(p^).data2;
                             game_player_head_G.guojia_dg:= 100;
                            end;
                         end;
                       end;
                   end;
      g_rec_reg_cx_c: begin
                     //玩家是否可注册查询返回  data1=1，可以注册，2=不能注册，服务器关闭注册，3，id已经存在
                   // move(p^,my_msg_cmd_g,c);
                    Game_wait_ok1_g:= true;
                    game_wait_integer_g:= Tmsg_cmd_send(p^).data1;
                   end;    
      g_rec_chat_c: begin
                     //聊天数据，随后的4个字节指明了来自的id，文本流
                     pro_g_cmd_chat(p,c);
                   end;    
      g_rec_note_c: begin
                     //通知，通告等文本
                     setlength(rec_string_g,c);
                     move(p^,pointer(rec_string_g)^,c);
                     Form_note.add_and_show(rec_string_g);
                   end;    
      g_rec_icon_c: begin
                     //收到了头像数据，随后的id，后接数据
                   end;    
      g_rec_player_cmd_c: begin
                     //收到其他客户端发来的数据 cmd类型如上
                   end; 
      g_req_player_cmd_c: begin
                    //其他客户端请求数据，cmd指明了需要的数据类型
                   end;
      g_rec_page_chg_c: begin
                    //有id进入或者退出了页面
                      Data_net.reshow_net_id(Tmsg_cmd_send(p^).s_id,Tmsg_cmd_send(p^).cmd,Tmsg_cmd_send(p^).data1);
                   end;
      g_rec_page_data_c: begin
                    //收到了服务端发送的用户在线id
                       Data_net.reshow_net_id_all(c,p);
                   end;
      g_rec_role_act_c: begin
                    //收到了人物，怪物的动作数据，开始动画

                   end;
      g_rec_kongzhi_c: begin
                          //收到了控制指令
                        Form_pop.net_cmd_center(Tmsg_cmd_send(p^).cmd,Tmsg_cmd_send(p^).data1,
                                                Tmsg_cmd_send(p^).data2,Tmsg_cmd_send(p^).s_id);
                       end;
    end;
   //数据包处理

end;
//*******************************************************************************


function ip_to_crd(const ip: string):cardinal;
var i,j: integer;
begin
 i:= fastcharpos(ip,'.',1);
 result:= strtoint(copy(ip,1,i-1));
   j:= fastcharpos(ip,'.',i+1);
  result:=result shl 8 + cardinal(StrToInt(copy(ip,i+1,j-1)));
  i:= j;
  j:= fastcharpos(ip,'.',i+1);
  result:=result shl 8+ cardinal(strtoint(copy(ip,i+1,j-1)));
  i:= j;
  result:=result shl 8+ cardinal(strtoint(copy(ip,i+1,3)));
end;

function crd_to_ip(c:cardinal): string;
begin
 result:= inttostr(c and $FF000000) + '.'+
          inttostr(c and $00FF0000) + '.'+
          inttostr(c and $0000FF00) + '.'+
          inttostr(c and $000000FF);
end;


procedure g_send_msg_cmd(p:pointer; i: integer); //发送命令
begin
 // p.crc:= CRC16_std($FFFF,pchar(p),sizeof(Tmsg_cmd_send)-2); //crc信息加入
  Data_net.MasterClient.Client.SendBuffer(p,i,MEDIUM_PRIORITY,RELIABLE,0);
end;

procedure g_send_msg_str(const s: string); //发送内容
begin
 //发送字符串
 Data_net.MasterClient.Client.SendBuffer(pchar(s),length(s),MEDIUM_PRIORITY,RELIABLE,0);
end;

function TData_net.g_start_udpserver2(const ip: string): boolean;  //开始监听
begin
  if not MSConnected then
   begin
    try
     InitializateClientServer(ip);

   except
     MSConnected:= false;
    end;

   end;

  result:= MSConnected;
end;


procedure TData_net.Timer1Timer(Sender: TObject);
begin

  IntIdle;

end;


procedure TData_net.InitializateClientServer(const ip: string);
var
    t: cardinal;

begin
MSConnected:= false;
  MasterClient := TRaknetMultiplayerClient.Create;
  SetCallback(MasterClient.GetCallbackList);

    MasterClient.Client.SetPassword('sata');


  MasterClient.Client.SetMTUSize(576);

 // ClientServerInited:= MasterClient.Client.Connect(ip,net_port_c,clinet_port_c,0,0);
    ClientServerInited:= MasterClient.Client.Connect(ip,net_port_c,strtoint(inputbox('端口','端口','35677')),0,1);
  //MasterClient.Client.RegisterAsRemoteProcedureCall('ClientMessageRPC',ClientRPC,ClientRPC.RpcCallback);
     MasterClient.Client.StartOccasionalPing;
   t:= GetTickCount;
  while (MSConnected= false) and (GetTickCount -t < 9000) do
      begin
        MasterClient.ProcessMessages;
        application.ProcessMessages;
        
      sleep(10);
     end;

      timer1.Enabled:= MSConnected;


end;

procedure TData_net.IntIdle;
begin
 if ClientServerInited then
   MasterClient.ProcessMessages;
end;

procedure TData_net.UnInitializateClientServer;
begin
   ClientServerInited := False;
   MasterClient.Client.Disconnect(0,0);
  // MasterClient.Client.UnregisterAsRemoteProcedureCall('ClientMessageRPC');
   MasterClient.Destroy;
   MSConnected:= false;
end;

procedure TData_net.SetCallback(xCall: PTMultiPlayerCallbackList);
begin

with xCall^ do
  begin
  ReceiveRemoteDisconnectionNotification  :=  ClientReceiveRemoteDisconnectionNotification;
  ReceiveRemoteConnectionLost             :=  ClientReceiveRemoteConnectionLost;
  ReceiveRemoteNewIncomingConnection      :=  ClientReceiveRemoteNewIncomingConnection;
  ReceiveRemoteExistingConnection         :=  ClientReceiveRemoteExistingConnection;
  ReceiveRemoteStaticData                 :=  ClientReceiveRemoteStaticData;
  ReceiveConnectionBanned                 :=  ClientReceiveConnectionBanned;
  ReceiveConnectionRequestAccepted        :=  ClientReceiveConnectionRequestAccepted;
  ReceiveNewIncomingConnection            :=  ClientReceiveNewIncomingConnection;
  ReceiveConnectionAttemptFailed          :=  ClientReceiveConnectionAttemptFailed;
  ReceiveConnectionResumption             :=  ClientReceiveConnectionResumption;
  ReceiveNoFreeIncomingConnections        :=  ClientReceiveNoFreeIncomingConnections;
  ReceiveDisconnectionNotification        :=  ClientReceiveDisconnectionNotification;
  ReceiveConnectionLost                   :=  ClientReceiveConnectionLost;
  ReceivedStaticData                      :=  ClientReceivedStaticData;
  ReceiveInvalidPassword                  :=  ClientReceiveInvalidPassword;
  ReceiveModifiedPacket                   :=  ClientReceiveModifiedPacket;
  ReceiveVoicePacket                      :=  ClientReceiveVoicePacket;
  ReceivePong                             :=  ClientReceivePong;
  ReceiveAdvertisedSystem                 :=  ClientReceiveAdvertisedSystem;
  ProcessUnhandledPacket                  :=  ClientProcessUnhandledPacket;
  end;
end;

procedure TData_net.DataModuleDestroy(Sender: TObject);
begin
   
        if ClientServerInited then
       UnInitializateClientServer;

      sleep(10);

     if LibLoaded then
    UnInitRaknetC;
end;

procedure TData_net.DataModuleCreate(Sender: TObject);
var i: integer;
begin
{
   self.LibLoaded := InitRaknetC;
   my_s_id_G:= g_nil_user_c;
   setlength(user_info_time,200); //开辟200个id
   for i:= 0 to 199 do
      user_info_time[i].s_id:= g_nil_user_c; //初始化s id

   setlength(dwjh_g,10); //初始化10个小队，江湖数组
   }
end;

procedure TData_net.send_scene_integer(id, v: integer);  //发送场景integer值
var pk: Tmsg_cmd_pk;
begin
   pk.hander:= byte_to_integer(g_scene_chg_i_c,false);
      pk.pak.s_id:= my_s_id_g;
      pk.pak.data1:= id;
      pk.pak.data2:= v;
      g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk)); //向服务器发送
end;

procedure TData_net.send_scene_bool(id, v: integer);
var pk: Tmsg_cmd_pk;
begin
   pk.hander:= byte_to_integer(g_scene_chg_b_c,false);
      pk.pak.s_id:= my_s_id_g;
      pk.pak.data1:= id;
      pk.pak.data2:= v;
      g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk)); //向服务器发送 场景布尔

end;

procedure TData_net.send_page_and_home_id(i, h,old: integer; ldui: boolean);
var pk: Tmsg_cmd_pk;
    pk2: Tmsg_duiwu_cmd_pk;
begin
   if ldui then //领队模式，用领队标志，转发到队员
   begin
    pk2.hander:= byte_to_integer(g_rep_dw_W_page_c,false); //换页并队伍内转发
    pk2.duiyuan[0]:= game_player_head_G.duiyuan[0];
     pk2.duiyuan[1]:= game_player_head_G.duiyuan[1];
     pk2.duiyuan[2]:= game_player_head_G.duiyuan[2];
     pk2.duiyuan[3]:= game_player_head_G.duiyuan[3];
    pk2.pak.s_id:= my_s_id_g;
    pk2.pak.cmd:= old;
    pk2.pak.data1:= i;
    pk2.pak.data2:= h;
    g_send_msg_cmd(@pk2,sizeof(Tmsg_duiwu_cmd_pk)); //向服务器发送 当前页和回城页
   end
   else begin
    pk.hander:= byte_to_integer(g_page_chg_c,false);
      pk.pak.s_id:= my_s_id_g;
      pk.pak.cmd:= old;
      pk.pak.data1:= i;
      pk.pak.data2:= h;
        g_send_msg_cmd(@pk,sizeof(Tmsg_cmd_pk)); //向服务器发送 当前页和回城页
        end;

      

end;

procedure TData_net.reshow_net_id(id, flag,p: integer);
var i: integer;
begin
//flag 为1，表示有id进入当前页面，否则，表示这id离开了这个页面

   for i:= 0 to high(user_info_time) do
    begin
     if user_info_time[i].s_id= id then
       begin
         if flag= 1 then
            user_info_time[i].page:= p
            else
               user_info_time[i].page:= 0;
         break;
       end;
    end;
    //刷新显示
    
    Form1.game_reshow_net_id(false);

end;

procedure TData_net.reshow_net_id_all(c: integer; p: pointer;show: boolean= true);
 var i,j,k,L: integer;
    label pp;
begin
   //刷新全部的id在当前页面显示
   pp:
    for i:= 1 to c div 2 do
     begin
       for j:= 0 to high(user_info_time) do
        begin
         if word(p^)= my_s_id_G then
            continue;

          if user_info_time[j].s_id= word(p^) then
            begin
             user_info_time[j].page:= form1.pscene_id;
             break;
            end;
          if j= high(user_info_time) then
           begin   //表示没有遇到合适的位置，则查找空位
             for k:= 0 to high(user_info_time) do
               begin
                 if user_info_time[k].s_id= g_nil_user_c then
                  begin
                     user_info_time[k].s_id:= word(p^);
                    user_info_time[k].page:= form1.pscene_id;
                     break;
                  end;
                 if k= high(user_info_time) then
                  begin  //没有空位
                    setlength(user_info_time,high(user_info_time)+ 101); //加大空间
                     for l:= high(user_info_time) downto high(user_info_time)-99 do
                          user_info_time[l].s_id:= g_nil_user_c; //初始化
                    goto pp;
                  end;
               end; // for k
           end;
        end; //for j
       dword(p):= dword(p)+ 2;
     end;  // for i

     if show then
        form1.game_reshow_net_id(false);

end;

procedure TData_net.game_page_online_data(p: pointer; c: integer);
var i,j: integer;
   // t: cardinal;
begin
   //收到服务器发来的在线用户详细数据
 //  t:= GetTickCount;
   for i:= 1 to c div sizeof(Tnet_user_id_exchg) do
    begin
      for j:= 0 to high(user_info_time) do
       begin
        if user_info_time[j].s_id= Tnet_user_id_exchg(p^).Id then
         begin

           with user_info_time[j] do
            begin
            u_id:= Tnet_user_id_exchg(p^).u_id;
            nicheng:= Tnet_user_id_exchg(p^).nicheng;
            dengji:=  Tnet_user_id_exchg(p^).dengji;
            xiaodui:= Tnet_user_id_exchg(p^).duiwuid;
            xiaodui_dg:=Tnet_user_id_exchg(p^).duiwudg;
            zhuzhi:=  Tnet_user_id_exchg(p^).zhuzhiid;
            zhuzhi_dg:=Tnet_user_id_exchg(p^).zhuzhidg;
            guojia:= Tnet_user_id_exchg(p^).guojiaid;
            guojia_dg:= Tnet_user_id_exchg(p^).guojiadg;
            time:= GetTickCount;
            end;

           break;
         end;
       end; //end for j
       dword(p):= dword(p) + sizeof(Tnet_user_id_exchg); //指针增加
    end;

   Form1.game_reshow_net_id(false); //刷新显示

end;

procedure TData_net.game_dwjh_data(p: pointer; c: integer);
var i: integer;
    label pp;
begin
   pp:
    for i:= 0 to high(dwjh_g) do
     begin
       if dwjh_g[i].dwid= 0 then
        begin
         with dwjh_g[i] do
          begin
          dwid:= Tdwjh_type(p^).dwid;
          p_id:= Tdwjh_type(p^).p_id;
          p_name:= Tdwjh_type(p^).p_name;
          p_rk:= Tdwjh_type(p^).p_rk;
          p_sl:= Tdwjh_type(p^).p_sl;
          p_ms:= Tdwjh_type(p^).p_ms;
          end;
          game_wait_integer_g:= 1;
          break;
        end;
       if i= high(dwjh_g) then
        begin
         setlength(dwjh_g,high(dwjh_g) + 11);
         goto pp;
        end;
     end; //end for

     Game_wait_ok1_g:= true; //
end;

function TData_net.get_s_id_nicheng(sid: integer): string; //获取指定人物的昵称
var i,j: integer;
    w: array[0..2] of word;
begin
      for i:= 0 to high(user_info_time) do
       begin
         if user_info_time[i].s_id= sid then
          begin
           if user_info_time[i].nicheng= '' then
            result:= '{'+ inttostr(sid)+ '}'
           else
            result:= user_info_time[i].nicheng;
            exit;
          end;
         if i= high(user_info_time) then
          begin
           for j:= 0 to high(user_info_time) do
               if user_info_time[j].s_id= g_nil_user_c then
                 begin
                  user_info_time[j].s_id:= sid;
                  break;
                 end;

           pinteger(@w)^:= byte_to_integer(g_rep_online_page_data_c,false);
           w[2]:= sid;
           g_send_msg_cmd(@w,6);  //发送请求，获取该sid的详细数据
            result:= '{'+ inttostr(sid)+ '}';
          end;
       end; //end for
end;

procedure TData_net.add_s_id_in_list(sid: integer);   //添加队员和实例到跟随列表
var i,j: integer;
    pk: Tmsg_cmd_pk;
begin
   get_or_add_user_id_time_type(sid);

    for i:= 0 to 3 do
     if game_player_head_G.duiyuan[i]= sid then
        exit;

   for i:= 0 to 3 do
     if game_player_head_G.duiyuan[i]= g_nil_user_c then
       begin
        game_player_head_G.duiyuan[i]:= sid;
         //添加实例
         for j:= 0 to Game_role_list.Count-1 do
             begin
              if Assigned(Game_role_list.Items[j]) then
               begin
                if Tplayer(Game_role_list.Items[j]).plvalues[34]= sid then
                   exit;  //如果实例已经存在，退出

               end;
             end; //end for j
         pk.hander:= byte_to_integer(g_player_rq_c,false);
         pk.pak.s_id:= sid;
         g_send_msg_cmd(@pk,sizeof(pk)); //向服务器发送
        exit;
       end;

end;

procedure TData_net.del_s_id_in_list(sid: integer);
var i: integer;
begin
    //删除队员从跟随队员列表
    for i:= 0 to 3 do
     if game_player_head_G.duiyuan[i]= sid then
        game_player_head_G.duiyuan[i]:= g_nil_user_c;

    //从人物实例列表 清除
       for i:= 1 to Game_role_list.Count-1 do
             begin
              if Assigned(Game_role_list.Items[i]) then
               begin
                if Tplayer(Game_role_list.Items[i]).plvalues[34]= sid then
                   begin
                   Tplayer(Game_role_list.Items[i]).Free;
                   Game_role_list.Delete(i);
                   exit;
                   end;
               end;
             end; //end for i
end;

procedure TData_net.nil_s_id_from_list_g(sid: integer);
var i: integer;
begin
    //从全局在线列表置空一个sid
    for i:= 0 to high(user_info_time) do
     begin
       if user_info_time[i].s_id= sid then
          begin
           user_info_time[i].s_id:= g_nil_user_c;
           user_info_time[i].nicheng:= '';
           user_info_time[i].u_id:= '无';
           user_info_time[i].page:= 0;
           user_info_time[i].player_id.addr:= 0;
          end;
     end; //end for
end;

procedure TData_net.send_player_Fvalues(i, v_old, V_new: integer);
begin
     //发送人物变动数据到服务器
     
    send_pak_tt(g_persona_chg_c,i,v_old,V_new,my_s_id_g);

end;

procedure TData_net.send_dwjh_pop(flag, shu, guai: integer);
var pk: Tmsg_duiwu_cmd_zf_pk;
    p2: p_user_id_time;
    i: integer;
    b: boolean;
begin
      {//队长发出的指令，弹出背单词或者打怪窗口
      //flag 1背单词，2带弹出效果的背单词窗口，3打怪，4带弹出效果的打怪，5比赛类型的打怪，6挖矿，7采药
      data1表示shu，shu就是背单词的数量或者怪物的数量
      data2表示怪物类型，一万以下表示本地怪，一万以上，表明高端是一个sid，负数，表明是一个小队id
      }

      if game_player_head_G.duiwu_dg< 100 then
         exit;  //不是队长，退出

    b:= false; //检测是否有队员

    pk.hander:= byte_to_integer(g_rep_dw_c,false); //合成文件头
      //加入队员sid资料
      for i:= 0 to 3 do
      pk.duiyuan[i]:= g_nil_user_c;  //初始化

      for i:= 0 to 3 do
      begin
      p2:= get_user_id_time_type(game_player_head_G.duiyuan[i]); //取得一个指针
      if p2<> nil then
       begin
         if p2.xiaodui= game_player_head_G.duiwu_id then
            if (p2.xiaodui_dg= 1) or ((p2.xiaodui_dg=2) and (flag>2)) then //如果是完全跟随，那么直接发窗口指令，如果搜打怪跟随，那么只发战斗指令
              begin
              pk.duiyuan[i]:= p2.s_id;
              b:= true;
              end;
       end;
     end; //end for

     if b= false then
       exit;  //如果没有队员需要通知，退出

    pk.hander2:= byte_to_integer(g_rec_cmd_c,false);
      //处理cmd资料
      case flag of
      1: pk.pak.cmd:= g_cmd_pop;
      2: pk.pak.cmd:= g_cmd_pop_a;
      3: pk.pak.cmd:= g_cmd_pop_pk;
      4: pk.pak.cmd:= g_cmd_pop_pk_a;
      5: pk.pak.cmd:= g_cmd_pop_game;
      6: pk.pak.cmd:= g_cmd_pop_wak;  //挖矿
      7: pk.pak.cmd:= g_cmd_pop_caiyao;   //草药
      end;

      //合成数据
      pk.pak.data1:= shu;
      pk.pak.data2:= guai;
      pk.pak.s_id:= my_s_id_g;

     g_send_msg_cmd(@pk,sizeof(Tmsg_duiwu_cmd_zf_pk)); //向服务器发送
end;

procedure TData_net.send_game_cmd(js_sid: word;    //接受方（受攻击方）sid
                                  fq_m: integer;
                                  fq_t: integer;   //命体灵，发起方传送的是新值
                                  fq_l: integer;
                                  js_m: integer;   //接受方传送的是差值
                                  js_t: integer;
                                  js_l: integer;
                                  flag: word;    //类型，指名是0无动画，1，物理攻击，2法术攻击，3物品攻击，4物品恢复，5法术恢复，6,防7逃
                                  wu: word);
var pk_ben: Tgame_cmd_dh_pk_ben_xd;
    pk_shuang: Tgame_cmd_dh_pk_shuang_xd;
    i,k: integer;
begin
     {打怪，动画，物品，救援等指令
     ***********我方数据变更，做出攻击或者恢复等动作后，发出此指令给本小队以及敌方小队。*******
     让对方更新数据，并做出动画
     参数包括 flag：0无动画，1，物理攻击，2法术攻击，3物品攻击，4物品恢复，5法术恢复，6,防7逃
     wu：物品法术编号，物理攻击时为零
     guai：接受方编号

     发送的参数   pk_zhihui_g
     我方变动的值，命体灵新值

     T_is_pk_z= record
    is_pk: boolean;   //是否pk状态
    is_zhihui: boolean;     //是否处于总指挥状态
    game_zt: integer;   //0场景状态，1，背单词，2挖矿，3采药，4，打坐，5比赛，6战斗

     pk_zhihui_g
     }

     //交出控制权
     pk_zhihui_g.is_kongzhi:= false;

     k:= 0;  //统计双方总人数
     if pk_zhihui_g.is_pk then
      begin
       for i:= 0 to 4 do
        if net_guai_g[i].sid<> g_nil_user_c then
           inc(k);
      end;

      for i:= 0 to 3 do
        if game_player_head_G.duiyuan[i] <> g_nil_user_c then
           inc(k);

     if k <= 4 then
      begin  //转发到4个人
       pk_ben.hd:= byte_to_integer(g_rep_dw_c,false);
       k:= 0;
         if pk_zhihui_g.is_pk then
            begin
             for i:= 0 to 4 do
              if net_guai_g[i].sid<> g_nil_user_c then
                 begin
                  if k < 4 then
                  pk_ben.duiyuan[k]:= net_guai_g[i].sid;
                  inc(k);
                 end;
            end;
             for i:= 0 to 3 do
                if game_player_head_G.duiyuan[i] <> g_nil_user_c then
                  begin
                   if k < 4 then
                   pk_ben.duiyuan[k]:= game_player_head_G.duiyuan[i];
                   inc(k);
                  end;
        pk_ben.hd2:= byte_to_integer(g_rec_role_act_c,false);
        pk_ben.pk.fq_sid:= my_s_id_g;
        pk_ben.pk.js_sid:= js_sid;
        pk_ben.pk.fq_m  := fq_m;
        pk_ben.pk.fq_t  := fq_t;
        pk_ben.pk.fq_l  := fq_l;
        pk_ben.pk.js_m  := js_m;
        pk_ben.pk.js_t  := js_t;
        pk_ben.pk.js_l  := js_l;
        pk_ben.pk.flag  := flag;
        pk_ben.pk.wu    := wu;
        g_send_msg_cmd(@pk_ben,sizeof(Tgame_cmd_dh_pk_ben_xd)); //向服务器发送
      end else begin  //转发到多于4个人
                  pk_shuang.hd:= byte_to_integer(g_dwjh_zf9_c,false);
                  k:= 0;
                   if pk_zhihui_g.is_pk then
                    begin
                     for i:= 0 to 4 do
                      if net_guai_g[i].sid<> g_nil_user_c then
                         begin
                          if k < 9 then
                          pk_shuang.duiyuan[k]:= net_guai_g[i].sid;
                          inc(k);
                         end;
                    end;
                    for i:= 0 to 3 do
                     if game_player_head_G.duiyuan[i] <> g_nil_user_c then
                      begin
                      if k < 9 then
                       pk_shuang.duiyuan[k]:= game_player_head_G.duiyuan[i];
                      inc(k);
                      end;

                  pk_shuang.hd2:= byte_to_integer(g_rec_role_act_c,false);

                  pk_shuang.pk.fq_sid:= my_s_id_g;
                  pk_shuang.pk.js_sid:= js_sid;
                  pk_shuang.pk.fq_m  := fq_m;
                  pk_shuang.pk.fq_t  := fq_t;
                  pk_shuang.pk.fq_l  := fq_l;
                  pk_shuang.pk.js_m  := js_m;
                  pk_shuang.pk.js_t  := js_t;
                  pk_shuang.pk.js_l  := js_l;
                  pk_shuang.pk.flag  := flag;
                  pk_shuang.pk.wu    := wu;
                  g_send_msg_cmd(@pk_shuang,sizeof(Tgame_cmd_dh_pk_shuang_xd)); //向服务器发送
               end;
end;

procedure TData_net.send_game_kongzhi(c, d1, d2: integer; sid: word); //发送控制权命令
var pk_ben: Tmsg_duiwu_cmd_zf_pk;
    pk_shuang: Tmsg_duiwu_cmd_zf9_pk;
    i,k: integer;
begin
     {发送控制命令
     data1，
     data2，

     T_is_pk_z= record
    is_pk: boolean;   //是否pk状态
    is_zhihui: boolean;     //是否处于总指挥状态
    game_zt: integer;   //0场景状态，1，背单词，2挖矿，3采药，4，打坐，5比赛，6战斗

     pk_zhihui_g
     }


     k:= 0;  //统计双方总人数
     if pk_zhihui_g.is_pk then
      begin
       for i:= 0 to 4 do
        if net_guai_g[i].sid<> g_nil_user_c then
           inc(k);
      end;

      for i:= 0 to 3 do
        if game_player_head_G.duiyuan[i] <> g_nil_user_c then
           inc(k);

     if k <= 4 then
      begin  //转发到4个人
       pk_ben.hander:= byte_to_integer(g_rep_dw_c,false);
       k:= 0;
         if pk_zhihui_g.is_pk then
            begin
             for i:= 0 to 4 do
              if net_guai_g[i].sid<> g_nil_user_c then
                 begin
                  if k < 4 then
                  pk_ben.duiyuan[k]:= net_guai_g[i].sid;
                  inc(k);
                 end;
            end;
             for i:= 0 to 3 do
                if game_player_head_G.duiyuan[i] <> g_nil_user_c then
                  begin
                   if k < 4 then
                   pk_ben.duiyuan[k]:= game_player_head_G.duiyuan[i];
                   inc(k);
                  end;
        pk_ben.hander2:= byte_to_integer(g_rec_kongzhi_c,false);
        pk_ben.pak.cmd:= c;
        pk_ben.pak.data1:= d1;
        pk_ben.pak.data2  := d2;
        pk_ben.pak.s_id  := sid;

        g_send_msg_cmd(@pk_ben,sizeof(Tmsg_duiwu_cmd_zf_pk)); //向服务器发送
      end else begin  //转发到多于4个人
                  pk_shuang.hander:= byte_to_integer(g_dwjh_zf9_c,false);
                  k:= 0;
                   if pk_zhihui_g.is_pk then
                    begin
                     for i:= 0 to 4 do
                      if net_guai_g[i].sid<> g_nil_user_c then
                         begin
                          if k < 9 then
                          pk_shuang.duiyuan[k]:= net_guai_g[i].sid;
                          inc(k);
                         end;
                    end;
                    for i:= 0 to 3 do
                     if game_player_head_G.duiyuan[i] <> g_nil_user_c then
                      begin
                      if k < 9 then
                       pk_shuang.duiyuan[k]:= game_player_head_G.duiyuan[i];
                      inc(k);
                      end;

                  pk_shuang.hander2:= byte_to_integer(g_rec_kongzhi_c,false);

                  pk_shuang.pak.cmd:= c;
                  pk_shuang.pak.data1:= d1;
                  pk_shuang.pak.data2  := d2;
                  pk_shuang.pak.s_id  := sid;

                  g_send_msg_cmd(@pk_shuang,sizeof(Tmsg_duiwu_cmd_zf9_pk)); //向服务器发送
               end;

end;

end.
