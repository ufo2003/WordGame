unit Unit_glb;
interface

uses
  SysUtils, Classes,RakNetStruct;

  const
  pl_count_c= 1024;
  net_port_c= 30806;
  clinet_port_c= 30805;

 g_cmd_buf_count= 63; //命令缓存数量
 g_str_buf_count= 63; //聊天数据缓存数量
 g_user_id_buf_count= 63; //网络id缓存数量
 g_nil_user_c= $FFFF; //不存在的用户

 //服务器部分××××××××××××××××××××

  g_scene_chg_b_c=1;   //改动场景事件bool，data1表明了场景id，需经过运算，一个integer保存了30个bool值。data2表明值

  g_scene_chg_i_c=2;  //改动场景事件integer，data1场景id，data2值
  g_wupin_chg_c=  3;  //改动物品事件，data1，物品事件编号，需经过运算，一个integer保存了30个值，data2，物品事件值，bool类型
  g_persona_chg_c=4;   //改动人物属性，比如升级，增加金钱等，cmd表示人物属性编号，data1表示原值 data2表示人物新值，为零直接清零
  g_page_chg_c=   5;   //切换了所在的页面 data1是新页面值


  g_player_exit_c=   6;   //玩家退出，data1表示了退出码144
  g_player_login_c=  7; //玩家登录--流数据，包括登录id，密码，客户端版本号
  g_player_reg_c=    8;  //玩家注册，修改--流数据，包含了注册信息，用 | 分割
  g_nicheng_chg_c=   9;   //玩家修改了昵称，流数据
  g_icon_chg_c=      10;  //玩家更新了头像，随后的4字节标明了id，后接流数据

  g_xiaodui_cj_c=    11;  //玩家创建了小队，流数据，包括玩家登录id，小队名称 高端 1，2，3表示小队，组织，国家 ***注

  g_xiaodui_jr_c=    12;  //玩家加入了小队，cmd=1小队，2组织，3国家，data1表示s_id，data2表示小队组织编号
  g_xiaodui_js_c=    13;  //玩家解散了小队，cmd=1小队，2组织，3国家，data1表示s_id，data2表示小队组织编号
  g_xiaodui_tc_c=    14;  //玩家退出了小队，cmd=1小队，2组织，3国家，data1表示s_id，data2表示小队组织编号

  g_xiaodui_td_c=    15;  //玩家被队长踢出了小队 data1为1，2，3表明是小队，组织，国家，data2表示组织id ********** 注

  g_xiaodui_sz_c=    16;  //玩家被设置为队长，后接4字节表明玩家id，随后是小队编号

  g_zhuzhi_cj_c=    17;  //****************************************************修改了 dwjh的数值
         {dwjh 的cmd说明，1=修改了队员模式，2=帮会内新的级别，3=国家内新的级别 data1表示sid，data2表示新的数值}

  g_xiaodui_sid_c=    18;  //玩家请求发送小队其他队员sid

  g_pl_data_chag=    19;  //玩家仅仅修改了在线动态数据，不转发通知 data1从1到9表示从当前页到国家等级，data2数据
  g_dwjh_zf9_c=    20;  //转发到9个玩家，后面跟随了9个sid

  g_zhuzhi_td_c=    21;  //玩家修改了名称，备注，后续的四个字节，高端为1，2，3，低端为s_id************************ 注

  g_zhuzhi_sz_c=    22;  //玩家被设置为老大，接msg类型，data1指名了被修改的id，data2指明了组织id，只有老大可以设置新老大
  g_zhuzhi_sz2_c=   23;  //玩家在组织内的等级被修改，接msg类型，data1指名了被修改的id，data2是新的等级，

  g_guojia_cj_c=    24;  //**************************************************************可挪他用
  g_guojia_jr_c=    25;  //玩家加入了国家，后接4字节表明玩家id，随后是国家编号
  g_guojia_js_c=    26;  //玩家解散了国家，只有国王可以解散，后接4字节表明玩家id，后接4字节表明了组织编号
  g_guojia_tc_c=    27;  //玩家退出了国家，后接4字节表明玩家id，后接4字节表明了国家编号

  g_guojia_td_c=    28;  //玩家被老大踢出了国家 *********************注 可挪它用

  g_guojia_sz_c=    29;  //玩家被设置为国王，接msg类型，data1指名了被修改的id，data2指明了国家id，只有国王才能设置新国王
  g_guojia_sz2_c=   30;  //玩家在组织内的等级被修改，接msg类型，data1指名了被修改的id，data2是新的等级，

  g_player_isreg_c= 31;  //查询该玩家是否已经注册，后续内容，玩家登录id
  g_player_isonline_c= 32; //查询该玩家是否在线，后续内容，玩家登录id
  g_player_need_data_c=33; //客户端请求查询数据，cmd指令标明了要查询的内容

  g_rep_zd_c=    34;  //转发数据到指定人，后4个字节指名了一个id
  g_rep_dw_c=    35;  //队伍内转发，后8个字节表示4个id
  g_rep_ddww_c=  36;  //发送到指定队伍，后4个字节指明了队伍id
  g_rep_all_c=   37;  //发送到服务器所有在线
  g_rep_gj_c=    38;  //发送到整个国家内，后4个字节指明了国家id
  g_rep_zz_c=    39;  //发送到指定组织，后4个字节指明了组织id
  g_rep_jz_c=    40;  //发送到指定家族
  g_rep_page_c=  41;  //发送到当前页面所有玩家
  g_rep_dwjh_z_c=  42;  //转发到指定组织的最高长官，小队给队长，组织给90以上等级，国家给70以上等级
  g_rep_dw_w_c=    43;  //改写并队伍内转发，后8个字节表示4个id *********************
  g_server_gonggao_c= 44; //发送服务器公告
  g_change_wupin_C= 45; //改动物品数量
  g_rep_dw_W_page_c=    46;  //换页并队伍内转发，后8个字节表示4个id *********************

  g_player_rq_c=    47;   //玩家请求人物数据
  g_wupin_rq_c=     48;   //玩家请求物品数据，启动时
  g_secne_rq_bl_c=     49;   //玩家请求场景bool数据
  g_scene_rq_int_c= 50;      //玩家请求场景int值
  g_guojia_page_rq_c= 51;     //玩家请求国家页面数据
  g_rep_online_page_data_c=52;  //请求当前页面的在线人物详细数据
  g_rep_dwjh_c=    53;  //玩家请求队伍组织的详细数据
  g_rep_guai_c=    54; //获取怪资料

  (*改动物品，Tmsg_cmd_send 类型
s_id 表明是哪个id，从服务器列表取得相应的用户登录名，然后修改
data1表明了物品的编号，物品的原始数量
data2表明了物品的新数量   *)

 //客户端部分******************************************************************************

  g_rec_cmd_c=    55;    //收到服务器端返回的查询数据或者服务器的指令，cmd指明了类型
  g_rec_cmd_dw_c=    56;    //收到队友数据改变指令
  g_rec_nc_dw_c=    57;    //收到队友昵称改变指令

  g_rec_login_c=  58;    //服务器返回信息，data1指名了 1登录成功，2登录被拒绝，未通过审核，3被管理员禁止，4客户端版本过低，5服务器已满，6未知的拒绝理由
  g_rec_kick_c=   59;    //被服务器踢出，data1=1,管理员踢出，2发现外挂，3物品原始数据不一致，可能作弊 4,其他原因
  g_rec_reg_c=    60;    //注册信息，data1=1，注册成功，2注册失败有同名存在，3注册失败，f服务器禁止注册，4，其他原因
                             //cmd= 1,返回注册信息，cmd=2，返回创建dwjh信息

  g_rec_reg_cx_c= 61;    //玩家是否可注册查询返回  data1=1，可以注册，2=不能注册，服务器关闭注册，3，id已经存在
  g_rec_chat_c=   62;    //聊天数据，随后的4个字节指明了来自的id，文本流
  g_rec_note_c=   63;    //通知，通告等文本，弹出显示框，如果是 http，则启动浏览器
  g_rec_icon_c=   64;     //收到了头像数据，随后的id，后接数据
  g_rec_player_cmd_c= 65; //收到其他客户端发来的数据 cmd类型如上

  g_req_player_cmd_c= 66; //其他客户端请求数据，cmd指明了需要的数据类型
  g_rec_page_chg_c= 67; //有玩家进入或者退出了页面
  g_rec_page_data_c= 68;  //收到服务器来的在线玩家id数据
  g_rec_role_act_c= 69;   //收到人物动作，数值，动画数据，开始动画
  g_rec_kongzhi_c=  70;   //收到了控制指令，表明当前获得控制权的人物


//客户端，cmd部分
 g_cmd_zhuzhi_q=0; //请求加入组织
 g_cmd_zhuzhi_jr=1; //加入了组织
 g_cmd_guojia_q=2; //请求加入国家
 g_cmd_guojia_jr=3; //加入了国家
 g_cmd_a_game=4; //要求加入组队
 g_cmd_game_ok=5; //加入了组队
 g_cmd_a_pk=6;     //要求加入pk
 g_cmd_pk_ok=7;    //同意加入pk
 g_cmd_a_jingsai=8;  //要求加入竞赛
 g_cmd_jingsai_ok=9;   //同意加入竞赛
 g_cmd_icon_need=10;
 g_cmd_shu_need=11;
 g_cmd_pk_sl=12;        //pk胜利
 g_cmd_pk_sb=13;        //pk失败
 g_cmd_jingsai_sl=14;    //竞赛胜利
 g_cmd_jingsai_sb=15;     //竞赛失败
 g_cmd_dj_xg=16; //***************等级修改
 g_cmd_page=17; //进入页面
 g_cmd_zhandou=18; //进入战斗-pk
 g_cmd_bishai=19; //进入比赛
 g_cmd_pop=20; //弹出背单词页面--来自队长，组队内
 g_cmd_pop_a=21;  //有开始效果的背单词 --来自队长
 g_cmd_pop_pk=22;   //打怪 --来自队长
 g_cmd_pop_pk_a=23;    //有开始效果的打怪 --来自队长
 g_cmd_pop_game=24;   //比赛  --来自队长
 g_cmd_gg_shibai=25;         //更改为打怪跟随或者完全跟随失败，比如对方战斗中
 g_cmd_exit=26;       //玩家退出或掉线
 g_cmd_xiaodui_sid=27;    //收到服务器发来的其他小队队员，data1，2，分别存储了4个sid
 g_cmd_dwjh_exit=28;    //玩家退出了小队，组织，国家
 g_cmd_dj_xd_r=29;    //是否允许修改小队跟随模式 **
 g_cmd_pop_wak=30;     //挖矿
 g_cmd_pop_caiyao=31;           //草药
 g_cmd_res_a=32;
 g_cmd_res_d=33;
 g_cmd_res_r=34;
 g_cmd_res_rr=35;
 g_cmd_wupin=36;         //物品（总）
 g_cmd_wupin_qingkong=37;     //清空物品
 g_cmd_wupin_xiugai=38;        //修改物品数量
 g_cmd_wupin_r=39;             //要求读取物品数量
 g_cmd_wupin_rr=40;            //返回的物品数量
 g_cmd_my_atc=41;             //我方攻击
 g_cmd_my_wufa =42;           //我方法术物品
 g_cmd_my_shu=43;             //我方属性修改
 g_cmd_guai_atc=44;           //怪攻击
 g_cmd_guai_wufa=45;          //怪法术物品
 g_cmd_my_bl=46;              //我方属性值飘动
 g_cmd_guai_bl=47;             //怪方飘动
 g_cmd_my_dead=48;              //我方人物死亡
 g_cmd_guai_dead=49;            //怪死亡
 g_cmd_game_over=50;            //游戏结束
 g_cmd_win=51;                  //战斗胜利
 g_cmd_chg_m=52; //修改金钱
 g_cmd_cl_m=53;   //清空金钱
 g_cmd_r_m=54;   //要求读取金钱
 g_cmd_rr_m=55;   //返回的金钱值
 g_cmd_guangbo= 56; //广播查询玩家（返回登录信息）
 g_cmd_ip= 57; //要求返回自己的公网ip
 g_cmd_ip_rr= 59; //返回了自己的ip
 g_cmd_redirect_ip= 60; //从定向到其他服务器地址

type
  PRakPlayerID= ^TRakPlayerID;

  Tnet_user_id_exchg= packed record  //用户id
   Id: integer; //来自服务器的一个id值，表示一个唯一的用户
   u_id: string[32];     //人物id
   nicheng: string[48];
   duiwuid: integer;
   duiwudg: integer;
   zhuzhiid: integer;
   zhuzhidg: integer;
   guojiaid: integer;
   guojiadg: integer;
   dengji: integer;
   end;

   T_play_id= packed record  //playerid结构
    addr: cardinal;
    port: word;
    end;

  Pmsg_cmd_send= ^Tmsg_cmd_send;
  Tmsg_cmd_send=packed record
   cmd: integer;
   data1: integer;
   data2: integer;
   s_id: word;  //发送者id
   crc: word;//crc
   end;
  Tmsg_cmd_pk= packed record  //带标志头的数据包
    hander: integer;
    pak: tmsg_cmd_send;
    end;

  Tmsg_cmd_pk2= packed record  //带转发功能的数据包
    hander: integer;
    hander2: integer;
    pak: tmsg_cmd_send;
    end;

   Tmsg_cmd_pk3= packed record  //转发到指定人的数据包
    hander: integer;    //转发标识
    id: integer;       //接收方id
    hander2: integer;  //接收方数据标识
    pak: tmsg_cmd_send;
    end;

   Tmsg_duiwu_cmd= packed record
    duiyuan: array[0..3] of word; //后面跟随4个队员id
    pak: tmsg_cmd_send;
    end;
    
  Tmsg_duiwu_cmd_pk= packed record
    hander: integer;
    duiyuan: array[0..3] of word; //后面跟随4个队员id
    pak: tmsg_cmd_send;
    end;

  Tmsg_duiwu_cmd_zf_pk= packed record //后面跟随4个队员id 带直接转发
    hander: integer;
    duiyuan: array[0..3] of word;
    hander2: integer;
    pak: tmsg_cmd_send;
    end;
  Tmsg_duiwu_cmd_zf9_pk= packed record //后面跟随9个队员id 带直接转发
    hander: integer;
    duiyuan: array[0..8] of word;
    hander2: integer;
    pak: tmsg_cmd_send;
    end;

   //游戏人物数据
   Tplayer_type=packed record
    nicheng: string[48];
    guanzhi: string[32];
    hdata: array[0..13] of integer; //头部数据
    player_data: array[0..161] of integer; //人物数据
    end;
    Tplayer_type_pk=packed record
     hander: integer;
     tp: Tplayer_type;
     end;
   //游戏物品数据
   Tgame_wupin=packed record
    wupin: array[0..253] of integer;  //物品最多只能1012种
    end;
   Tgame_wupin_pk=packed record
    hander: integer;
    tp: Tgame_wupin;
    end;

    //游戏人物数据头
    Tplayer_head=packed record
     duiwu_id: integer;
     duiwu_dg: integer; //=0队员，自由模式，=1队员受限模式，=2队员，打怪跟随,=100领队
     zhuzhi_id: integer;
     zhuzhi_dg: integer;
     guojia_id: integer;
     guojia_dg: integer;
     duiyuan: array[0..3] of word; //四个队员
     kongzhiquan: word;  //当前控制权
     tag: word;
     guanzhi: string[32];
     end;

    Tdwjh_type=packed record
     dwid: integer;
     p_id: string[32]; //帮主
     p_name: string[32];  //小队或者组织的名称
     p_rk: integer;
     p_sl: integer;    //该值小于100，表示国家的税率，大于100小于1000，表示江湖组织，大于1000表示小队
     p_ms: string[255];
     end;

     {动画，命令，新值数据包}
    Tgame_cmd_dh=packed record                   //数据体
      fq_sid: word;   //发起方sid
      js_sid: word;    //接受方（受攻击方）sid 如果此值为 $FFFF 表示全体
      fq_m: word;
      fq_t: word;   //命体灵，发起方传送的是新值
      fq_l: word;
      js_m: smallint;   //接受方传送的是差值
      js_t: smallint;
      js_l: smallint;
      js_g: smallint;
      js_f: smallint;
      js_shu:smallint;
      flag: word;    //类型，指名是0无动画，1，物理攻击，2法术攻击，3物品攻击，4物品恢复，5法术恢复，6,防7逃，8攻击被躲避
      wu: word;  //法术或者物品的编号
      end;

    Tgame_cmd_dh_pk=packed record
    hd: integer;
    pk: Tgame_cmd_dh;
    end;

    Tgame_cmd_dh_pk_dfxd=packed record //转发给指定小队的包
    hd: integer;  //转发标志
    xdid: integer; //小队id
    hd2: integer; //包标志（指名处理的程序）
    pk: Tgame_cmd_dh;
    end;

    Tgame_cmd_dh_pk_ben_xd=packed record //转发给本小队的包
    hd: integer;  //转发标志
    duiyuan: array[0..3] of word; //小队队员sid
    hd2: integer; //包标志（指名处理的程序）
    pk: Tgame_cmd_dh;
    end;

    Tgame_cmd_dh_pk_shuang_xd=packed record //转发给两个小队的包
    hd: integer;  //转发标志
    duiyuan: array[0..8] of word; //小队队员sid
    hd2: integer; //包标志（指名处理的程序）
    pk: Tgame_cmd_dh;
    end;

     Tnet_guai=packed record
      sid: word;       //来自网络的怪，sid
      ming: integer;  //命，当前值
      ti:   integer;
      ling: integer;
      ming_gu: integer;  //命上限
      ti_gu:   integer;
      ling_gu: integer;
      shu:  integer;
      gong: integer;
      fang: integer;
      L_fang:word; //临时防护值
      end;
    T_loc_guai=packed record
      name1: string[32];
      fa_wu: integer;  //法术或者物品id
      wu_shu: integer;    //如果是施放物品，那么物品数量
      wu_diao: integer;    //掉落的物品
      wu_diao_shu: integer;  //掉落物品的数量
      wu_diao_gai: integer;   //掉落物品的概率
      qian: integer;           //掉落的金钱
      qian_diao_gai: integer;   //掉落金钱的概率
      jingyan: integer; //经验
      icon: integer;
      end;
  TColor4 = array[0..3] of Cardinal;
function CRC16_std(InitCrc: Word; Buffer: PChar; Length: Integer): Word;
function CRCInfo(const asInfo: string): string;
function integer_to_byte(i: integer; var b: boolean): byte; //检查并返回数值，如果校验不通过，返回 0
function byte_to_integer(bt: byte;b: boolean): integer; //合成带校验的 b表示是否压缩

implementation

function integer_to_byte(i: integer; var b: boolean): byte; //检查并返回数值，如果校验不通过，返回 0
var
    i2: integer;
begin
  i2:= i shl 8;
  i2:= i2 shr 24;
  b:= i2= 1;  //1 表示压缩

  i2:= i shr 24;
  i:= i shl 16;
  i:= i shr 16;
  if i = (i2 div 2 +189) then
    result:= i2
    else
     result:= 0;

end;

function byte_to_integer(bt: byte;b: boolean): integer; //合成带校验的 b表示是否压缩
begin
  result:= bt;
  result:= result shl 8;
  if b then
   result:= result + 1;

   result:= result shl 16;

   result:= result + bt div 2 + 189;
end;

function CRC16_std(InitCrc: Word; Buffer: PChar; Length: Integer): Word;
const
  Crc16Table: array[0..$FF] of Word =
  (
    $0000, $C0C1, $C181, $0140, $C301, $03C0, $0280, $C241,
    $C601, $06C0, $0780, $C741, $0500, $C5C1, $C481, $0440,
    $CC01, $0CC0, $0D80, $CD41, $0F00, $CFC1, $CE81, $0E40,
    $0A00, $CAC1, $CB81, $0B40, $C901, $09C0, $0880, $C841,
    $D801, $18C0, $1980, $D941, $1B00, $DBC1, $DA81, $1A40,
    $1E00, $DEC1, $DF81, $1F40, $DD01, $1DC0, $1C80, $DC41,
    $1400, $D4C1, $D581, $1540, $D701, $17C0, $1680, $D641,
    $D201, $12C0, $1380, $D341, $1100, $D1C1, $D081, $1040,
    $F001, $30C0, $3180, $F141, $3300, $F3C1, $F281, $3240,
    $3600, $F6C1, $F781, $3740, $F501, $35C0, $3480, $F441,
    $3C00, $FCC1, $FD81, $3D40, $FF01, $3FC0, $3E80, $FE41,
    $FA01, $3AC0, $3B80, $FB41, $3900, $F9C1, $F881, $3840,
    $2800, $E8C1, $E981, $2940, $EB01, $2BC0, $2A80, $EA41,
    $EE01, $2EC0, $2F80, $EF41, $2D00, $EDC1, $EC81, $2C40,
    $E401, $24C0, $2580, $E541, $2700, $E7C1, $E681, $2640,
    $2200, $E2C1, $E381, $2340, $E101, $21C0, $2080, $E041,
    $A001, $60C0, $6180, $A141, $6300, $A3C1, $A281, $6240,
    $6600, $A6C1, $A781, $6740, $A501, $65C0, $6480, $A441,
    $6C00, $ACC1, $AD81, $6D40, $AF01, $6FC0, $6E80, $AE41,
    $AA01, $6AC0, $6B80, $AB41, $6900, $A9C1, $A881, $6840,
    $7800, $B8C1, $B981, $7940, $BB01, $7BC0, $7A80, $BA41,
    $BE01, $7EC0, $7F80, $BF41, $7D00, $BDC1, $BC81, $7C40,
    $B401, $74C0, $7580, $B541, $7700, $B7C1, $B681, $7640,
    $7200, $B2C1, $B381, $7340, $B101, $71C0, $7080, $B041,
    $5000, $90C1, $9181, $5140, $9301, $53C0, $5280, $9241,
    $9601, $56C0, $5780, $9741, $5500, $95C1, $9481, $5440,
    $9C01, $5CC0, $5D80, $9D41, $5F00, $9FC1, $9E81, $5E40,
    $5A00, $9AC1, $9B81, $5B40, $9901, $59C0, $5880, $9841,
    $8801, $48C0, $4980, $8941, $4B00, $8BC1, $8A81, $4A40,
    $4E00, $8EC1, $8F81, $4F40, $8D01, $4DC0, $4C80, $8C41,
    $4400, $84C1, $8581, $4540, $8701, $47C0, $4680, $8641,
    $8201, $42C0, $4380, $8341, $4100, $81C1, $8081, $4040
  );

var
  Crc: Word;
begin
  Crc := 0;
  while Length > 0 do
  begin
    Crc := (Crc shr 8) xor CRC16Table[(Crc xor (Byte(Buffer^))) and $00FF];
    Inc(Buffer);
    Dec(Length);
  end;
  Result := Crc;
end;

function CRCInfo(const asInfo: string): string;
var
 wdCRC: Word;
 bytLow, bytHi: Byte;
 M: PChar;
 i: Integer;
begin
  M := PChar(asInfo);
  i := StrLen(M);
  wdCRC := CRC16_std($FFFF, M, I);
  bytLow := Lo(wdCRC);
  bytHi := Hi(wdCRC);
  Result := Chr(bytLow) + Chr(bytHi);
end;
end.
