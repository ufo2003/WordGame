unit Unit1;

interface
  // {$DEFINE game_downbank}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,shellapi, ExtCtrls, ActnList, Menus,mmsystem, ImgList,
  ComCtrls, OleCtrls, Activex,Unit_data, AppEvnts,Unit_player
  {右键菜单,IEDocHostUIHandler,IEConst},inifiles, Buttons,Registry,Langji.Wke.Webbrowser,
  Langji.Miniblink.types, Langji.Miniblink.libs,Langji.Wke.types,jpeg;

const
  html_C=   WM_USER + $5101;
  func_C=   WM_USER + $5102;
  event_c1= WM_USER + $5103;
  event_c2= WM_USER + $5104;
  res_c1=   WM_USER + $5105;
  res_c2=   WM_USER + $5106;
  goods_c1=  WM_USER + $5107;
  goods_c2=  WM_USER + $5108;
  page_c1=  WM_USER + $5109;
  page_c2=  WM_USER + $5110;
  stop_c=   WM_USER + $5111;
  player_c1= WM_USER + $5112;
  player_c2= WM_USER + $5113;
  WM_MYTRAYICONCALLBACK = WM_USER + 1002;
type
  //ie 加载时出现错误的处理类*****************************************************
      // Event types exposed from the Internet Explorer interface
  // Event component for Internet Explorer
       {
  TIEEvents = class(TComponent, IUnknown, IDispatch)
  private
     // Private declarations
    FConnected: Boolean;
    FCookie: Integer;
    FCP: IConnectionPoint;
    FSinkIID: TGuid;
    FSource: IWebBrowser2;
  protected
     // Protected declaratios for IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; override;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
     // Protected declaratios for IDispatch
    function GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID:
      Integer; DispIDs: Pointer): HResult; virtual; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; virtual; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; virtual; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual; stdcall;

     // Protected declarations
    procedure DoOnNavigateError(const pDisp: IDispatch;
                                  var URL: OleVariant;
                                  var TargetFrameName: OleVariant;
                                  var StatusCode: OleVariant;
                                  var Cancel: wordbool); safecall;
  public
     // Public declarations
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ConnectTo(Source: IWebBrowser2);
    procedure Disconnect;
    property SinkIID: TGuid read FSinkIID;
    property Source: IWebBrowser2 read FSource;
//  published
     // Published declarations
    property WebObj: IWebBrowser2 read FSource;
    property Connected: Boolean read FConnected;
  end;
          }
  //类结束************************************************************************

  TForm1 = class(TForm)
    Button3: TButton;
    Button2: TButton;
    Button4: TButton;
    Button13: TButton;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    ComboBox2: TComboBox;
    ApplicationEvents1: TApplicationEvents;
    Button1: TButton;
    Button5: TButton;
    Button6: TButton;
    PopupMenu3: TPopupMenu;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    Button7: TButton;
    Timer1: TTimer;
    Edit1: TEdit;
    Timer_exe: TTimer;
    Button8: TButton;
    N6: TMenuItem;
    N8: TMenuItem;
    SpeedButton1: TSpeedButton;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    CheckBox1: TCheckBox;
    Button9: TButton;
    Button10: TButton;
    Timer_duihua: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1BeforeNavigate2(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; var Cancel: boolean);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer_exeTimer(Sender: TObject);
    procedure ComboBox2DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ComboBox2MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure Button8Click(Sender: TObject);
    procedure WebBrowser2StatusTextChange(Sender: TObject;
      const Text: WideString);
    procedure N6Click(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure WMHotKey(var Msg : TWMHotKey); message WM_HOTKEY;
    procedure SpeedButton1Click(Sender: TObject);
    procedure WebBrowser1NewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure N10Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Timer_duihuaTimer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    //FDocHostUIHandler: TDocHostUIHandler;  //屏蔽右键菜单
    Phome_id: integer; //回城点scene id
    g_time_count: integer; //游戏倒计时器的剩余时间
    g_time_page: integer; //定时器超时后的返回页面
    talkchar1,talkchar2,talkchar3,talkchar4,talkchar5: char;
    Game_temp_event: Tstringlist; //临时事件表
    game_time_exe_list: Tstringlist; //定时执行函数表
    hot_wordgame_h: integer; //热键id
    ad_mtl_time: dword; //命体灵 广告间隔定时器
    is_down_readlist: boolean;
    game_url: string;

    procedure TrayShow(Sender: TObject); //显示托盘图标
    procedure WMMyTrayIconCallBack(var Msg : TMessage); message WM_MYTRAYICONCALLBACK;
    procedure Game_action_exe_S(s: string);  //执行函数，不能带if then
    procedure Game_talk_run(id,role_id: integer); //显示聊天话语
    function Game_talk_random(id: integer; const n: string): integer; //返回一个随机的聊天语句，在多个聊天语句内
    procedure Game_scr_clean2; //私聊窗口清屏
    procedure Game_scr_clean3; //私聊窗口清屏并打点
    procedure initialize_role(n: string; new: integer);
    //function game_extfile_rename(oldname,newname: string): boolean; //修改人物对照文件
    procedure button_stat(b: boolean);
    //function WBLoadFromStream(const   AStream:   TStream;   WB:   TWebBrowser):   HRESULT;
    procedure game_script_message(var msg: TMessage); message game_const_script_after;
    procedure game_reset_role_chatid; //人物聊天id清零
    procedure OnContent(const url:String; var Stream:TStream);  //自定义协议传输的内容
    procedure OnAccept(const URL:String;var Accept:Boolean); //接受自定义协议

    procedure game_load_image_to_imglist;
    procedure game_page_id_change(new_id: integer); //场景变化
    function wait_scene_int_bool(b: boolean;id: integer): integer; //等待场景事件


    procedure msg_event_c1(var msg: TMessage); message event_c1;  //收到了查询消息
    procedure msg_event_c2(var msg: TMessage); message event_c2;  //收到了设置
    procedure msg_res_c1(var msg: TMessage); message res_c1;
    procedure msg_res_c2(var msg: TMessage); message res_c2;
    procedure msg_goods_c1(var msg: TMessage); message goods_c1;
    procedure msg_goods_c2(var msg: TMessage); message goods_c2;
    procedure msg_player_c1(var msg: TMessage); message player_c1;
    procedure msg_player_c2(var msg: TMessage); message player_c2;
    procedure msg_page_c2(var msg: TMessage); message page_c2;
    procedure msg_stop_c(var msg: TMessage); message stop_c;

    procedure html_pop(i: integer); //html模式的背单词
    procedure change_html_by_id(const id,html: string); //根据id更新html
    procedure visible_html_by_id(const id: string; canshow: boolean); //根据id决定显示还是隐藏
    procedure loadurlbegin(Sender: TObject; sUrl: string;  out bHook,bHandled:boolean);
  public
    { Public declarations }
    pscene_id,old_pscene_id: integer; //当前显示的场景id,前一个场景id
    web1: TWkeWebbrowser;
    procedure game_start(flag: integer); //游戏开始
    procedure game_save2;
    procedure Game_action_exe(const id: string); //执行动作，如果参数不是D字母开头，那么直接执行参数
    function Game_action_exe_A(const F: string): integer; //执行动作内的单个函数
    procedure Game_action_exe_S_adv(const s: string);  //执行函数和语句，可带if then
    procedure Game_add_line_to_web2(const s: string);
    procedure game_role_clean; //清除角色
    function game_get_roleByNmae(n: string): Tplayer;
    procedure game_load_friend_list(n: string); //载入伙伴列表
    procedure game_save_friend_list(n: string); //保存伙伴列表
    procedure game_load_doc(path: string);  //载入存档，参数为存档目录
    procedure game_load_doc_net; //初始化网络文件
    procedure game_save_doc(path: string);    // 保存存档
     procedure game_save_doc_net; //保存网络配置，一些数据
     procedure game_write_scene_event(i,v: integer);  //写入场景编号，第一个参数表示序号，1000以下为保留系统用
     function game_read_scene_event(i: integer): integer;   //读取场景号，第一个参数表示序号，1000以下为系统用
     procedure temp_event_clean; //清空临时事件表
     procedure game_write_home_id; //把当前id赋值给回城点id
     function game_get_blood_l(id: integer): integer; //获取人物的血值低点
     function game_get_blood_h(id: integer): integer; //获取人物的血值高点
     function game_get_ti_l(id: integer): integer;
     function game_get_ti_h(id: integer): integer;
     function game_get_ling_l(id: integer): integer;
     function game_get_ling_h(id: integer): integer;
     function game_doc_is_ok(s: string): boolean; //判断存盘文件是否有效，可以载入
     procedure shell_exe(s: string); //再次执行，并读盘,参数是要显示的消息
     procedure game_error_net_user(ip:cardinal;pt: integer); //网络错误，断开了用户的连接
     procedure game_reshow_net_id(all : boolean); //刷新页面的网络id显示
     procedure debug_send_func_str(const s: string; flag: integer); //发送调试时函数信息
     procedure show_ad_error; //当广告不能加载时显示错误信息
     procedure DeleteDirNotEmpty(DirName: string); //清空目录
     procedure load_sch_pic; //刷新下载的图片
     procedure update_caption(i: integer); //更新背单词数量到标题
     function game_create_guid: string;   //创建一个guid
     procedure game_pic_from_text(Stream:TStream; s: string; path: string=''); //根据字符串返回图片数据
  published
    
    function game_show_scene(id: integer): integer; //显示场景
    procedure game_cmd_execute(const s: string); //命令解释
    function game_pop(i: integer): integer;     //弹出背单词窗口
    function game_pop_love(i: integer; const n: string): integer;     //弹出只显示两个人的背单词窗口
    function game_pop_dig(i: integer): integer;     //挖矿 默认数字为一百
    function game_pop_fight(i: integer; i2: integer): integer;     //战斗，第一参数怪物数量，第二参数，怪物种类
    function game_pop_game(i: integer; i2: integer): integer;     // 打擂 ，对方人数，人物种类
    function game_page(id: integer): integer;   //引导到新的页，聊天窗口清屏
    function game_direct_scene(id: integer): integer; //直接读取页面，忽略脚本和转场效果
    function game_direct_page(id: integer): integer; //直接读取页面，忽略脚本和转场效果，聊天窗口清屏
    function game_infobox(s: string): integer; //弹出一个消息框
    function game_trade(id,flag: integer): integer; //交易窗口 ,flag=0表示买，1表示卖
    function game_chat(const s: string): integer; //在聊天窗口显示一句话
    function game_delay(i: integer):integer; //延时，参数毫秒
    function game_question(s: string): integer;
    function game_goods_change(id,values: integer):integer; //修改游戏物品数量
    function game_goods_change_n(n: string; values: integer):integer; //修改游戏物品数量，用物品名
    function game_attribute_change(p,id,v: integer): integer;
    //修改属性值，第一个参数，角色，0表示全体,1表示第一个人物，2第二个，第二个参数属性编号，第三个参数，加减值

    function game_write_name(s: string): integer; //修改当前对话人姓名
    function game_save(i: integer): integer; //游戏存盘，0=手动存盘，1=自动存盘，2=
    function game_talk(const n: string): integer;  //聊天，参数是 姓名
    function game_talk_char_set(c1: string; role_id: integer): integer; //修改角色的聊天char
    function game_talk_stop(i: integer): integer; //结束聊天
    function game_npc_talk(const n: string): integer;
    function game_accouter1_wid(i1: integer): integer; //弹出人物属性，装备窗口
    function game_add_res_event(id: integer): integer; //添加捡拾物品事件
    function game_check_res_event(id: integer): integer; // 检查物品事件是否发生过，是返回true
     function game_not_res_event(id: integer): integer; // 事情不存在，返回true
                           //多个and 检查物品事件是否全部发生过，是返回true
      function game_check_res_event_and(s: string): integer;
                          //多个and 事情都不存在，返回true
       function game_not_res_event_and(s: string): integer;
                              //多个事件有一个存在or
             function game_check_res_event_or(s: string): integer;
                          //多个or 事情有一个不存在，返回true
              function game_not_res_event_or(s: string): integer;

    function game_del_res_event(id: integer): integer; // 删除物品事件
    function game_add_scene_event(id: integer): integer; //添加剧情事件
     function game_check_scene_event(id: integer): integer; // 检查剧情事件是否发生过 ，存在返回true
     function game_not_scene_event(id: integer): integer; // 剧情不存在，返回 true
     function game_inc_scene_event(id:integer; v: integer):integer; //事件值累加函数，会把参数值与里面原先保存的数字累加,返回值恒为1表示执行成功
     function game_dec_scene_event(id: integer; v: integer):integer; //事件值累减函数，会与里面原先保存的数减去参数,返回值恒为1表示执行成功
        //多个and 检查物品事件是否全部发生过，是返回true
      function game_check_scene_event_and(s: string): integer;
                          //多个and 事情都不存在，返回true
       function game_not_scene_event_and(s: string): integer;
                              //多个事件有一个存在or
             function game_check_scene_event_or(s: string): integer;
                          //多个or 事情有一个不存在，返回true
              function game_not_scene_event_or(s: string): integer;

     function game_write_scene_string(id: integer;const values: string): integer; //写入字符串到场景表
     function game_read_scene_string(id: integer): pchar;  //从场景表读取字符串

    function game_del_scene_event(id: integer): integer; // 删除剧情事件
    function game_prop_enbd(b: integer): integer; //激活或者禁用装备属性按钮，0禁用，1激活
    function game_add_friend(n: string; new: integer): integer; //添加一个朋友
    function game_del_friend(n: string;b: integer): integer; //删除一个朋友
    function game_over(i: integer): integer; //游戏结束
    function game_random_chance(i: integer): integer; //判断随机机会是否允许
                   //判断随机机会是否允许，带延时以产生多次真随机
    function game_random_chance_at_sleep(i: integer): integer;
    function game_rename(oldname: string): integer; //修改人物姓名 ，oldname为原的名字
    function game_rename_byid(id: integer;const newname: string): integer; //修改人物姓名 ，oldname为原的名字
             //检查名字是否含有英文，标点等，参数为空表示检查主角，该函数主要是为游戏增添一点意思，
             //该函数判断第一个字节是否为中文前缀，仅此而已
    function game_checkname_abc(n: string): integer;
    function game_reload(i: integer): integer; //重新载入当前场景
    function game_reload_direct(i: integer): integer; //重新载入当前场景,并忽略脚本和转场效果
    function game_add_message(const s: string): integer;  //添加一个提示消息
    function game_add_task(id: integer): integer;      //添加任务
    function game_comp_task(id: integer): integer; //完成任务
    function game_check_goods_nmb(n: string; i: integer): integer; //检查某物品数量是否有几个，有，返回 1

                 //检查某个人物的某属性值是否达到某值
    function game_check_role_values(n: string; i,v: integer): integer;

              {临时事件处理，临时表一般在载入场景时被清空，除非场景属性注明保留临时事件（比如在迷宫内）}
    function game_write_temp(id,values: integer): integer; //写入一个临时事件,id是事件名，values是事件内容
    function game_read_temp(id: integer): integer;  // 读取事件的值，不存在，返回0
    function game_write_temp_string(id: integer;const values: string): integer;
    function game_read_temp_string(id: integer): pchar;
    function game_check_temp(id,values: integer): integer; //比较事件，看是否大于等于指定值

    function game_enabled_scene(i: integer): integer; // 1,激活场景窗口，0，禁用场景窗口
    function game_can_stop_chat(i: integer): integer; //1,可以结束聊天  0, 禁止结束聊天（用于必须进行下去的对话)
    function game_functions_m(const s: string): integer; //一个执行参数内多函数，带表达式处理的
    function game_role_is_exist(n: string): integer; //如果这个人物存在，返回 1
    function game_set_role_0_hide(n: string; x: integer): integer; //设置某个人物的显隐，1显示，0隐藏
    function game_role_only_show(n: string): integer; //仅显示此人，隐藏其他全部
    function game_role_reshow: integer; //恢复人物原先的显隐状态
    function game_bet(id,flag: integer): integer; //赌钱，参数为一个临时表id和压大小，1大，0小。赢了返回 1
    function game_newname_from_oldname(const n: string): pchar; //根据原始名来获取新的人物名称
    function game_pop_a(i: integer): integer;     //带动画效果的弹出背单词窗口
    function game_change_money(i: integer):integer; //修改金钱
    function game_role_count(c: integer): integer; //查询人物数，参数为零，返回人物数，参数非零，如果大于等于c，返回1
    function game_role_sex_count(x: integer): integer; //返回指定性别的人物数，参数1为男，0为女
    function game_get_newname_at_id(x: integer): pchar; //根据序列号返回新的名字，1为第一个，2为第二个
    function game_get_oldname_at_id(x: integer): pchar; //根据序列号返回新的名字，1为第一个，2为第二个

    function game_goto_home(i: integer): integer; //回城
    function game_id_is_name(id: integer; n: string): integer; //判断此id是否指定人物,参数id为当前role列表的序列号+1

    function game_sex_from_id(id: integer): integer; //判断此id是男是女，id为role列表的序号、+ 1。男返回1
    function game_sex_from_name(const n: string): integer; //判断此名是男是女，男返回1
    function game_check_money(v: integer): integer; //比对金钱，如果大于等于 v 返回 1
    function game_pop_fight_a(i: integer; i2: integer): integer; //带动画战斗弹出窗口
    function game_write_scene_integer(id,v: integer): integer; //往scene事件表写入一个值
    function game_read_scene_integer(id: integer): integer;    //从scene事件表读取一个值
    function game_integer_comp(i1: integer; c: string;i2: integer): integer; //对i1和i2进行比较，c可取比较符号如 =,>,<
    function game_chat_cleans(i: integer): integer; //聊天窗口清屏，参数随意
    function game_chat_cleans2(i: integer): integer; //聊天窗口清屏，参数随意
    function game_grade(n: string; g: integer): integer; //检查此人物是否大于等于这个等级了
    function game_start_now(i:integer): integer; //游戏开始
    function game_change_sex(n: string; sex: integer): integer;//更改性别,sex为1表示男，0表示女
    function game_get_fm_1(sex: integer): integer; //返回第一个指定性别的序号，1为第一个
    function game_id_exist(id: integer): integer; //检查指定序号人物是否存在，1表示第一个
    function game_del_friend_byid(a,b: integer): integer; //通过id删除朋友
    function game_move_money(id1,id2,m: integer): integer; //转移金钱，从id1转移到id2，1表示第一个人物
    function game_role_all_mtl(p: integer): integer; //命体灵全满，p=0表示全体，1表示第一个人物
    function game_clear_money(i: integer): integer; //金钱清空，参数为1则减半
    function game_get_money(i: integer): integer; //返回金钱,参数为1表示第一个人物
    function game_get_role_suxing(i,v: integer): integer; //返回属性值,参数为1表示第一个人物，v表示要取的属性编号
    function game_get_goods_count(n: string): integer; //返回指定名称的物品数量
    function game_set_game_time(t,page: integer): integer; //启动定时器，定时秒数，超时后的载入页面
    function game_kill_game_time(i:integer):integer; //取消定时
    function game_spk_string(const s: string): integer; //朗读
    function game_not_rename(i: integer): integer; //是否改名
    function game_clear_temp(i: integer): integer; //清空临时表
    function game_random_chance_2(i: integer): integer; //返回一个随机数
    function game_get_pscene_id(i: integer): integer; //返回当前页id和参数的累加值
    function game_role_value_half(id: integer): integer; //生命值减半 id为0表示全体减半，为1表示第一个人物
    function game_get_pscene_id_s(i: integer): pchar; //返回页号，字符形式，id和参数的累加值
    function game_inttostr(i: integer): pchar;  // 返回数字的字符形式
    function game_get_read_txt(i: integer): pchar; //返回一个阅读材料的字符串，参数如果为零，表示随机，否则返回指定行
    function game_include_str(const s: string): pchar; //读取包含文件
    function game_true(i: integer): integer; //参数为一返回true，参数为零返回false
    function game_weather(i: integer): integer; //指定战斗场景天气-1关闭，0自动（默认） 1，大雪，2大雨，3红叶，4，小雪
    function game_get_accoutre(i,idx: integer): integer; //返回装备值，i为1表示第一个人物，idx表示要取的装备种类
    function game_get_TickCount(i: integer): integer; //返回开机以来的毫秒数量，参数为1，则返回秒
    function game_get_date(i: integer): pchar; //返回日期，字符型，如果参数为零，返回系统日期
    function game_get_time(i: integer): pchar; //返回时间，字符型，如果参数为零，返回系统时间
    function game_get_datetime(i: integer): pchar; //返回日期和时间，字符型，如果参数为零，返回系统日期时间
    function game_int_datetime(i: integer): integer; //返回整形的日期时间，参数随意
    function game_int_date(i: integer): integer; //返回整形的日期，参数随意
    function game_int_time(i: integer): integer; //返回整形的时间 。参数随意
    function game_time_exe(i: integer;const s: string): integer; //定时函数，在指定秒数后执行内容
    function game_webform_isshow(i: integer): integer; //主窗口是否处于前面
    function game_run_off_no(i: integer): integer; //禁止逃跑，0表示禁止，1表示允许
    function game_write_factor(i: integer): integer; //写入怪物难度系数
    function game_read_factor(i: integer): integer; //读取怪物难度系数
    function game_allow_gohome(i: integer): integer;   //是否允许回城，1，允许，0禁止
    function game_id_from_oldname(const s: string): integer; //用名称返回id，返回1表示第一个
    function game_lingli_add(p,t: integer): integer; //增减灵力，百分比，第一个参数为零表示全体，后一个参数表示百分比
    function game_check_role_values_byid(id,id2,values: integer): integer; //检查指定人物的id，1表示第一个，第二参数指定那个值
    function game_goto_oldpage(i: integer): integer; //返回前一页，只适合只有唯一来源的页面使用
    function game_is_net_hide(i: integer): integer;  //是否隐藏网络版显示
    function game_show_logon(const ip: string): integer; //显示登录窗口
    function game_is_online(i: integer): integer; //是否联网游戏
    function game_show_note(const s: string): integer; //显示通告
    function game_netuserinfo(i: integer): integer; // 在对话区域显示玩家信息
    function game_reshow_online(i: integer): integer; //重新显示在线人物
    function game_show_dwjh(id,tp: integer): integer; //显示队伍，国家，组织信息
    function game_show_chat(id: integer): integer; //显示聊天窗口
    function game_send_pk_msg(id: integer): integer; //发送pk邀请
    function game_show_trade(id: integer): integer; //显示交易窗口
    function game_send_game_msg(id: integer): integer; //发送竞赛邀请
    function game_add_user_dwjh(tp,sid,dwjh_id: integer): integer; //同意，添加此用户
    function game_reload_chatlist(i: integer): integer; //仅仅重载聊天列表
    function game_asw_html_in_pop(i: integer): integer; //html模式的背单词
    function game_show_set(i: integer): integer; //显示设置窗口
    function game_set_var(i,v: integer): integer; //设置指定变量的值
    function game_inner_html(i: integer; s: string): integer; //输入html
    function game_biao_html(i: integer): integer; //做标记
    function game_res_goods(i,sl: integer; const s: string): pchar; //id,数量，名称。返回一个物品是否捡到的标准字符串
    function game_can_fly(i: integer): integer; //是否允许飞行，参数随意
    function game_bubble(bb: integer): integer; //泡泡龙，参数是泡泡数量
    function game_wuziqi(bb: integer): integer; //五子棋，参数是等级，1-4，从低到高
    function game_save_count(i: integer): integer; //取得存档数量
    function game_chinese_spk(const s: string): integer; //朗读中文
    function game_chat_spk_add(const s: string): integer; //添加一句话到等待发音的列表里。并启动发音
    function game_showshare_readtext(i: integer): integer; //显示一个上传资源的窗口
  end;


 function game_read_values(id,index: integer): integer;
 function game_write_values(id,index,value: integer): boolean;
 function game_get_role_H: integer; //返回队员数组上限
 function game_add_player_from_net(p: pointer; c: integer): integer; //添加游戏人物数据（主角）
 procedure game_lib_change; //词库改变了
 procedure img_zoom(oldbmp,newbmp: tbitmap; new_w,new_h: integer); //放大缩小图片
 function getBilv(i: integer): integer; //把一个数值乘以dpi_bilv
 function HexToStr(s:ansistring):string; //16进制转字串
var
  Form1: TForm1;
  Game_friend_list: Tstringlist; //伙伴列表
    Game_role_list: Tlist;  //人物列表
    Game_action_list: Tstringlist;
    Game_Chat_list: Tstringlist;
    Game_read_stringlist: Tstringlist;
    Game_pscene_img_list: Tstringlist; //当前页已经下载的图片，防止图片重复下载，切换页面时清除。
    Game_duihua_list: Tstringlist; //对话朗读列表
    game_effect_ini: Tinifile;
    game_hide_windows_h: boolean;
    dpi_bilv: single;
    In_xp_system: boolean;
    //IEEvents1: TIEEvents;
    MyTrayIcon : TNotifyIconData;   //定义一个托盘图标的类
    show_share_text: string; //预读取的显示阅读的材料

implementation
  uses unit_save,unit_trade,unit_pop,
  Unit_goods,unit_task,AAFont,GDIPAPI,GDIPOBJ,unit_zj_ly, Unit_set,unit2,
  unit_net,unit_chat,Unit_net_set,unit_download,unit_note,unit_glb,
  unit_dwjh,unit_downhttp,unit_chinese,unit_exit,unit_langdu,unit_mp3_yodao,unit_httpserver,unit_down_tips;
{$R *.dfm}

   const 
 csfsBold      = '|Bold';     
 csfsItalic    = '|Italic';   
 csfsUnderline = '|Underline';
 csfsStrikeout = '|Strikeout';
function getBilv(i: integer): integer; //把一个数值乘以dpi_bilv
begin
  result:= round(i * dpi_bilv);
end;
procedure img_zoom(oldbmp,newbmp: tbitmap; new_w,new_h: integer); //放大缩小图片
var
  gdibmp: TGPBitmap;
  //hb: HBITMAP;
  //ss: string;
  Graphic: TGPGraphics;
  I: Integer;

begin
  // 图片放大缩小
  if oldbmp.Width=0 then
   exit;

  gdibmp := TGPBitmap.Create(oldbmp.Handle, oldbmp.Palette);

  with newbmp do
    begin
      Width :=new_w;
      Height := new_h;
      PixelFormat := pf24bit;
    end;

     Graphic := TGPGraphics.Create(newbmp.Canvas.Handle);
  Graphic.SetInterpolationMode(InterpolationModeHighQualityBicubic);  // bicubic resample
  Graphic.DrawImage(gdibmp, 0, 0, newbmp.Width, newbmp.Height);

  Graphic.Free;
   gdibmp.Free;
end;
procedure game_lib_change; //词库改变了
var s: string;
 hFile : THandle; 
 FT,ft2 : TFileTime;
 ST : TSystemTime;
 d,t,d2,t2: word;
begin
  s:= game_app_path_G+'lib\'+ form_pop.combobox1.Text;
  if not FileExists(s) then
     begin
       messagebox(screen.ActiveForm.handle,'当前词库不存在。','错误',mb_ok or MB_ICONERROR);
     end else begin
             hFile := FileOpen(s, fmOpenRead);
              GetFileTime(hFile, nil, nil, @FT);
              FileClose(hFile);
              
              DateTimeToSystemTime(now, ST);
              SystemTimeToFileTime(ST, FT2);
              LocalFileTimeToFileTime(FT2, FT2);

            FileTimeToDosDateTime(ft,d,t);
            FileTimeToDosDateTime(ft2,d2,t2);
               if (t2- t) < 15 then
                 begin
                   //当前词库被修改
                  if messagebox(screen.ActiveForm.handle,'当前词库被修改，是否重新载入。','刷新',mb_yesno or MB_ICONWARNING)= mryes then
                     begin
                      form_pop.wordlist1.Clear;
                      form_pop.wordlist1.LoadFromFile(s);
                     end;
                 end else begin
                             //文件夹变动，重新载入词库
                           // form_pop.show_ck;
                          end;
                  form_pop.show_ck; //提示有时不准，就总是刷新词库列表。
              end;
end;

function game_add_player_from_net(p: pointer; c: integer): integer; //添加游戏人物数据
var
    i: integer;
    j: integer;
begin
//添加人物数据成功，返回1，否则返回2

    j:= Game_role_list.Add(Tplayer.Create('net'));

    if j= 0 then //初始化玩家自己
    begin
    game_player_head_G.duiwu_id:= Tplayer_type(p^).hdata[3];
    game_player_head_G.duiwu_dg:= Tplayer_type(p^).hdata[4];

     if game_player_head_G.duiwu_dg<>100 then
        begin
        game_player_head_G.duiwu_dg:= 0; //队员初始化为自由模式
        game_player_head_G.duiwu_id:= 0; //加入小队重新登录后就不存在了，创建的小队还是继续存在
        end;

    game_player_head_G.zhuzhi_id:= Tplayer_type(p^).hdata[5];
    game_player_head_G.zhuzhi_dg:= Tplayer_type(p^).hdata[6];
    game_player_head_G.guojia_id:= Tplayer_type(p^).hdata[7];
    game_player_head_G.guojia_dg:= Tplayer_type(p^).hdata[8];
    game_player_head_G.guanzhi:=  Tplayer_type(p^).guanzhi;
       game_player_head_G.duiyuan[0]:= g_nil_user_c;
       game_player_head_G.duiyuan[1]:= g_nil_user_c;
       game_player_head_G.duiyuan[2]:= g_nil_user_c;
       game_player_head_G.duiyuan[3]:= g_nil_user_c;

   end; // end j
     Assert(j<>-1,'人物索引越位');
     Tplayer(Game_role_list.Items[j]).plname:= Tplayer_type(p^).nicheng;
      Game_at_net_G:= false; //初始化人物数据
     for i:= 0 to 161 do
     begin
      case i of
       0..63: Tplayer(Game_role_list.Items[j]).plvalues[i]:= Tplayer_type(p^).player_data[i];  //属性
       64..73: Tplayer(Game_role_list.Items[j]).pl_accouter1[i-64]:= Tplayer_type(p^).player_data[i];    //装备
       74..97: Tplayer(Game_role_list.Items[j]).pl_ji_array[i-74]:= Tplayer_type(p^).player_data[i];       //技能
       98..161: Tplayer(Game_role_list.Items[j]).pl_fa_array[i-98]:= Tplayer_type(p^).player_data[i];       //法术
       end;
     end;

      Game_at_net_G:= true;  //初始化结束
  result:= 1;
end;

function game_get_role_H: integer; //返回队员数组上限
begin

    result:= Game_role_list.Count -1;
end;

function game_read_values(id,index: integer): integer;
begin
result:= 0;
          Assert(id<>-1,'人物索引越位');
           if id < Game_role_list.Count then
            begin
             if Assigned(Game_role_list.Items[id]) then
                result:= Tplayer(Game_role_list.Items[id]).plvalues[index];
            end;

end;

function game_write_values(id,index,value: integer): boolean;
begin
 result:= false;


            if id < Game_role_list.Count then
             begin
             if Assigned(Game_role_list.Items[id]) then
               begin
                Tplayer(Game_role_list.Items[id]).plvalues[index]:= value;
                result:= true;
              end;
             end;

        
end;

//把字符串转换为字体的相关属性！
//sFont参数的格式: 宋体,134,9,[Bold],[clRed]
procedure StringToFont(sFont : string; Font : TFont );
var
  p : integer;
  sStyle : string;
begin
  with Font do
  begin
    // get font name
    p := Pos( ',', sFont );
    Name := Copy( sFont, 1, p-1 );
    Delete( sFont, 1, p );

    // get font charset
    p := Pos( ',', sFont );
    Charset :=StrToInt2( Copy( sFont, 1, p-1 ) );
    Delete( sFont, 1, p );

    // get font size
    p := Pos( ',', sFont );
    Size :=StrToInt2( Copy( sFont, 1, p-1 ) );
    Delete( sFont, 1, p );

    // get font style
    p := Pos( ',', sFont );
    sStyle := '|' + Copy( sFont, 2, p-3 );
    Delete( sFont, 1, p );

    // get font color
    Color :=StringToColor(Copy( sFont, 2,Length( sFont ) - 2 ) );

    // convert str font style to font style
    Style := [];

    if( Pos( csfsBold,sStyle ) > 0 )then
      Style := Style + [ fsBold ];

    if( Pos( csfsItalic,sStyle ) > 0 )then
      Style := Style + [ fsItalic ];

    if( Pos( csfsUnderline,sStyle ) > 0 )then
      Style := Style + [ fsUnderline ];

    if( Pos( csfsStrikeout,sStyle ) > 0 )then
      Style := Style + [ fsStrikeout ];
  end;
end;

function Get_WindowsDirectory: string;
var
    pcWindowsDirectory        : PChar;
    dwWDSize                  : DWORD;

begin
    dwWDSize := MAX_PATH + 1;
    result := '';
    GetMem(pcWindowsDirectory, dwWDSize);
    try
        if Windows.GetWindowsDirectory(pcWindowsDirectory, dwWDSize) <> 0 then
            Result := pcWindowsDirectory;
    finally
        FreeMem(pcWindowsDirectory);
    end;
end;
function Get_SystemDirectory: string;
var
    pcSystemDirectory         : PChar;
    dwSDSize                  : DWORD;
begin
    dwSDSize := MAX_PATH + 1;
    result := '';
    GetMem(pcSystemDirectory, dwSDSize);
    try
        if Windows.GetSystemDirectory(pcSystemDirectory, dwSDSize) <> 0 then
            Result := pcSystemDirectory;
    finally
        FreeMem(pcSystemDirectory);
    end;
end;
procedure TForm1.DeleteDirNotEmpty(DirName: string);
var
 sr: TSearchRec;
 f: integer;
begin
 if DirName[Length(DirName)] <> '\' then
   DirName := DirName + '\';
 f := FindFirst(DirName + '*.*', faAnyFile, sr);
 while f = 0 do
   begin
     if (sr.Name <> '.') and (sr.Name <> '..') then
       begin
         if (sr.Attr and faDirectory <> 0) then
           DeleteDirNotEmpty(DirName + sr.Name + '\')
         else
          // begin
            //  FileSetAttr(DirName + sr.Name, 0);
              if not DeleteFile(DirName + sr.Name) then Exit;
          // end;
       end;
     f := FindNext(sr);
   end;
 FindClose(sr);
 //RemoveDir(DirName);
end;

function GetMyDocPath: string;
var
Reg:TRegistry;
begin
Reg:=TRegistry.Create;
try
Reg.RootKey:=HKEY_CURRENT_USER;
if Reg.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders') then
Result:=Reg.ReadString('Personal')
finally
Reg.CloseKey;
Reg.Free;
end;
end;

function getDPI(var h1:integer; var h2: integer): integer;
var
  DC: HDC;
begin
  DC := GetDC(0);
  Result := GetDeviceCaps(DC, logpixelsx); //获取逻辑dpi，如果由系统负责缩放那么获取的值固定为96
  h1:=  GetDeviceCaps(DC, DESKTOPHORZRES); //当程序属性，兼容，更改高dpi设置，高dpi缩放替代，选择 应用程序，那么 h1，h2相同
  h2:=  GetDeviceCaps(DC, HORZRES);   //当程序属性，兼容，更改高dpi设置，高dpi缩放替代，选择 系统，那么 h2比 h1 小
  ReleaseDC(0, DC);
end;

procedure TForm1.FormCreate(Sender: TObject);
var ss: string;
    k,h1,h2: integer;
begin
  if sametext(TOSVersion.Name,'Windows XP') then
   begin
    self.Caption:= self.Caption+' '+ TOSVersion.Name;
    In_xp_system:= true;

   end;

 Randomize; //初始化随机数
 // show_inst_game;
    k:= getDPI(h1,h2);
    if h1=h2 then
    begin
     //缩放由应用程序执行
        if k=96 then
         dpi_bilv:= 1
        else
          dpi_bilv:= k / 96;
     end   else  begin
                  //缩放由系统执行 系统或者系统增强dpi总是为96
                  //showmessage(k.ToString); 系统有点模糊 系统增强清晰
                  if k=96 then
                    dpi_bilv:= 1
                    else
                      dpi_bilv:= h1 / h2;
                  showmessage('当前高DPI设置导致显示效果不佳，建议在程序图标点击鼠标右键“属性”，再点开“兼容性”标签页，然后'+#13#10
                  +'（win10 点击“更改高DPI设置”，然后取消勾选“替代高dpi缩放行为”或者缩放执行选择为“应用程序”）'+#13#10+
                  '（win7 请勾选“禁用高 DPI 显示缩放”）');
                 end;

     web1:= TWkeWebbrowser.Create(form1);

  web1.Parent:= groupbox5;
  web1.Align:=  alclient;
  web1.OnBeforeLoad := WebBrowser1BeforeNavigate2;
   web1.OnLoadUrlBegin:= loadurlbegin;
  web1.LoadHTML('<html><body><p>游戏载入中，请稍后……</body></html>');

 //
 game_app_path_G:= ExtractFilePath(application.ExeName);
  ss:= game_app_path_G;

 game_doc_path_g:= GetMyDocPath+ '\玩游戏背单词';
  if not DirectoryExists(game_doc_path_g) then
     CreateDir(game_doc_path_g);
  if not DirectoryExists(game_doc_path_g+'\img') then
     CreateDir(game_doc_path_g+'\img');
  if not DirectoryExists(game_doc_path_g+'\scene') then
     CreateDir(game_doc_path_g+'\scene');

  if not DirectoryExists(game_doc_path_g) then
   begin
          CreateDir(game_doc_path_g);
          CreateDir(game_doc_path_g+'\save');
          CreateDir(game_doc_path_g+'\dat');
          CreateDir(game_doc_path_g+'\tmp');
          CreateDir(game_doc_path_g+'\down_img');
          CreateDir(game_doc_path_g+'\down_ugm');
   end;
  game_doc_path_g:= game_doc_path_g+'\'; //路径后加斜杠，以保持程序内统一



 Game_app_img_path_G:= game_doc_path_g + 'img\'; //保存游戏图片路径


 Game_action_list:= Tstringlist.Create;
  Game_chat_list:= Tstringlist.Create;
  Game_role_list:= Tlist.Create;
  Game_friend_list:= Tstringlist.Create;
  Game_temp_event:= Tstringlist.Create;  //临时事件表
  game_time_exe_list:= Tstringlist.Create; //定时执行函数表
   Game_read_stringlist:= Tstringlist.Create;
   Game_pscene_img_list:= Tstringlist.Create;
   Game_duihua_list:= Tstringlist.Create; //等待发音的对话列表

 //FDocHostUIHandler := TDocHostUIHandler.Create;

     Game_touxian_list_G:= Tstringlist.Create;
               {
 DynamicProtocol.ProtocolName := 'gpic'; //game picture 协议
  DynamicProtocol.Enabled := True;
  DynamicProtocol.OnGetContent := OnContent;
  DynamicProtocol.OnAccept := OnAccept;
                           }
 game_effect_ini:= Tinifile.Create(ss +'dat\effect.ini');


    hot_wordgame_h:= GlobalAddAtom('wordgame_H');

    try
     RegisterHotKey(Handle,hot_wordgame_h , mod_alt or MOD_CONTROL, ord('D')); //注册D键
    except

    end;

  // IEEvents1:= TIEEvents.create(application);
    // IdHTTPServer1.Active:= True;

 {  httpserver1:= Thttpserver.Create();
   httpserver1.FreeOnTerminate:= True;
      httpserver1.Resume;   }

  {$IFDEF game_downbank}
   caption:= caption + ' -- www.downbank.cn 下载银行专版';
   button13.Caption:= '访问下载银行';
   button13.Font.Style:= [fsBold];
   button13.hint:= '下载银行，提供精品软件下载。网址：http://www.downbank.cn 点击访问';
  {$ENDIF}
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
ShellExecute(Handle,
              'open','http://www.finer2.com/wordgame/bbs.htm',nil,nil,sw_shownormal);

{ShellExecute(Handle,
  'open','rundll32.exe',
  'url.dll,FileProtocolHandler http://www.finer2.com/wordgame/bbs.htm',nil,sw_shownormal);}
end;



procedure TForm1.FormDestroy(Sender: TObject);
begin
// httpserver1.Terminate; //结束服务线程

 Game_read_stringlist.Free;
 Game_action_list.Free;
 Game_Chat_list.Free;
 game_role_clean; //清除角色数据
 Game_role_list.Free;
 Game_friend_list.Free;
 Game_temp_event.Free;
 game_effect_ini.Free;
 game_time_exe_list.Free;
 Game_touxian_list_G.Free;
 Game_pscene_img_list.Free;
 Game_duihua_list.Free;
  web1.Free;
end;
  {
function get_ad_IWeb2: IWebBrowser2;
var pDoc:  IHTMLDocument3;
    tt: IHTMLElement;
begin
  result:= nil;
  pdoc:= Form1.WebBrowser1.Document as IHTMLDocument3;
    if pdoc<> nil then
     begin
      tt:= pdoc.getElementById('ad_layer1');
       if tt<> nil then
        result:= tt as IWebBrowser2;
     end;
end;
   }
procedure TForm1.FormShow(Sender: TObject);
var
    vv: Variant;
  //  Content: string;
begin
   checkbox1.Visible:= DebugHook=1;
 { pdoc:= WebBrowser2.Document as IHTMLDocument2;
  vv := VarArrayCreate([0, 0], varVariant);
  Content :='欢迎来到武侠的世界。';
  vv[0] := Content;
  pdoc.writeln(PSafeArray(TVarData(vv).VArray));}
     vv := VarArrayCreate([0, 0], varVariant);
     vv[0] :='玩游戏背单词 2007-2012傅铖荣版权所有';
  // pdoc:= WebBrowser1.Document as IHTMLDocument2;
  //  pdoc.writeln(PSafeArray(TVarData(vv).VArray));

  self.WindowState:= wsMaximized;
  web1.ZoomPercent:=  round(dpi_bilv * 100);

 // web1.ScaleForPPI(96);
   if (ParamCount > 0) then
   begin

       if pos('debug-',ParamStr(1))= 1 then
        begin
          game_debug_handle_g:= strtoint(copy(ParamStr(1),7,32));
          form1.Caption:= form1.Caption +'--调试中……';
          sendmessage(game_debug_handle_g,page_c1,handle,1800);
          game_show_scene(10000);
        end else begin

    form_save.cunpan:= ParamStr(1);
    form_save.Button2Click(form1); //读盘
                 end;
   end else
       game_show_scene(10000);

  kill1:= Tkill.Create(false);
    {
if (CompareText(form_set.combobox1.Text,'VW paul')=0) or
     (CompareText(form_set.combobox1.Text,'VW kate')=0) then
      begin
        game_bg_music_rc_g.yodao_sound:= false;
      end;
       }
  Game_ad_count_G.Y:= 10; //关闭广告
end;

function TForm1.game_show_scene(id: integer): integer;
var str1: Tstringlist;
   // pDoc:  IHTMLDocument2;
  //  AStream:   TMemoryStream;
begin
 if DebugHook=1 then
  self.Caption:= '玩游戏背单词-'+ inttostr(id);
screen.Cursor:= crhourglass;
  str1:= Tstringlist.Create;
  Game_action_list.Clear; //清除动作
  Game_chat_list.Clear;
  game_reset_role_chatid; //人物聊天记录恢复

      game_page_id_change(id); //保存老场景和新战斗场景id
      //pscene_id:= id; //保存场景id

      game_tianqi_G:= 0;  //设置战斗，背单词天气效果为自动
    data2.load_scene(inttostr(id),str1); //拆分出场景html

     //str1.SaveToFile('e:\a.txt');
    web1.LoadHTML(str1.Text);
screen.Cursor:= crdefault;
      //从内存流载入html到webbrowser
   {   AStream   :=   TMemoryStream.Create;
      try
          str1.SaveToStream(AStream);
          WBLoadFromStream(AStream   ,   WebBrowser1);
      finally
          AStream.Free;
      end;
          }
   // pdoc:= WebBrowser1.Document as IHTMLDocument2;
       //直接插入html代码，但此方法不支持全部的html，如head段会被忽略
  //  pdoc.body.innerHTML:= str1.Text;
       //运行脚本
    //IHtmlWindow2(pdoc.parentWindow).execScript('div1.filters[0].apply();div1.filters[0].play();','JavaScript');
  str1.Free;

 // Button_talk.Enabled:= Game_can_talk_G;


result:= 1;

end;

procedure TForm1.WebBrowser1BeforeNavigate2(Sender: TObject; sUrl: string; navigationType: wkeNavigationType; var Cancel: boolean);
var k: integer;
begin
 Game_script_scene_G:= sUrl;
  if pos('file:',Game_script_scene_G)>0 then
   begin
    k:= pos('/',Game_script_scene_G);
     while k>0 do
       begin
       delete(Game_script_scene_G,1,k);
        k:= pos('/',Game_script_scene_G);
       end;
   end;
 if Game_script_scene_G<> 'about:blank' then
  begin
   if pos('about:blank',Game_script_scene_G)= 1 then
      delete(Game_script_scene_G,1,11)
      else if pos('about:',Game_script_scene_G)= 1 then
      delete(Game_script_scene_G,1,6);

  end;

         if Game_script_scene_G[1]= 'g' then
             begin
              Cancel:= true;
              postmessage(Handle,game_const_script_after,32,0);
              //Game_action_exe(Game_script_scene_G);
             end else if Game_script_scene_G[1]= 'i' then
                       begin
                        Cancel:= true;
                        postmessage(Handle,game_const_script_after,33,0);
                        //Game_action_exe_S_adv(Game_script_scene_G);
                       end else
                       if Game_script_scene_G[1]= 'D' then
                       begin
                        Cancel:= true;
                        postmessage(Handle,game_const_script_after,31,0);
                        //Game_action_exe_S_adv(Game_script_scene_G);
                       end else
                    if length(Game_script_scene_G)=5 then
                      begin
                        Cancel:= true;
                        postmessage(Handle,game_const_script_after,34,0);
                        //game_show_scene(strtoint(Game_script_scene_G));
                      end;
end;

procedure TForm1.game_start(flag: integer);
begin

      game_role_clean;
      game_role_list.Add(Tplayer.create(game_app_path_G+'persona\Player0.upp'));
  //初始化人物角色

   Data2.load_goods_file; //载入游戏物品描述表
   Data2.load_event_file(''); //激活事件系统

   //载入头衔
    data2.Load_file_upp(game_app_path_G+'dat\touxian.upp',Game_touxian_list_G);

   Game_not_save:= true;
   button_stat(true); //更改button状态
   if flag= 0 then
      game_show_scene(10001);  //载入开始场景
    game_load_image_to_imglist;
end;

procedure TForm1.game_cmd_execute(const s: string);
begin                         //执行游戏命令
 if s='Pstart' then
    game_start(0)
    else if s='Psave' then
       game_save2;
end;

procedure TForm1.game_save2;
begin
 if not Game_not_save then
     Form_save.addr:= ''
     else
       Form_save.addr:= groupbox5.Caption;

  Form_save.ShowModal;

end;

      {执行游戏动作，由多个函数组成}
procedure TForm1.Game_action_exe(const id: string);
begin
    //游戏动作内的多个函数的执行
 if id= '' then
    exit;

  if id[1]= 'D' then
   begin
   
      Game_action_exe_S_adv(Game_action_list.Values[copy(id,1,5)]);

   end else
        Game_action_exe_S_adv(id);
end;

function TForm1.Game_action_exe_A(const F: string): integer;  //执行单个脚本内的函数
    function strtoint3(const s: string): integer;
     begin
      //如果含有 game_ 字样，表示是一个函数，那么先求函数的值
      if fastpos(s,'game_',length(s),5,1)> 0 then
         result:= Game_action_exe_A(s)
         else
          result:= strtoint(s);
     end;
    function youkuohao(const s: string; index: integer): integer;
      var i87,i86: integer;
     begin
      youkuohao:=0;
      i86:= 0;
       for i87:= index to length(s) do
           if s[i87]= '(' then
              inc(i86)
              else if s[i87]= ')' then
                    begin
                     dec(i86);
                     if i86= 0 then
                        begin
                          youkuohao:= i87;
                          exit;
                        end;
                    end;
     end;
    function strFromstr2(const s: string): string;
     var i88,i89: integer;
     begin
       i88:= fastpos(s,'game_',length(s),5,1);
       if i88> 1 then
        begin
          if (s[i88-1]='=') or (s[i88-1]='"') then
             exit; //包含在链接内的函数不处理
        end;

       if i88 > 0 then
        begin
         result:= '';
         i89:= length(s);
         if (fastpos(s,'ing ',length(s),4,1)> 0) and
            (fastpos(s,'ing ',length(s),4,1)< i88) then
             begin //字符形
             i89:=youkuohao(s,i88);
              if i88 > 8 then
                 result:= copy(s,1,i88-8);
              result:= result + pchar(Game_action_exe_A(copy(s,i88,i89-i88+1)));
             end else begin  //数字型
                        if i88 >= 1 then
                           result:= copy(s,1,i88-1);
                        result:= result + inttostr(Game_action_exe_A(copy(s,i88,i89-i88+1)));
                      end;
         if i89< length(s) then
          result:= result + copy(s,i89+ 1,length(s)-i89);
          
         result:= strFromstr2(result);
        end else
             result:= s;
     end;
    function ss2int(var s1: string): integer;
     begin
       delete(s1,1,1);
       s1:= trimleft(s1);
       if fastpos(s1,'game_',length(s1),5,1)> 0 then
         ss2int:= Game_action_exe_A(s1)
          else
           ss2int:= strtoint2(s1);
     end;
var a: array of TVarRec;
    i,j,k: integer;
    ss,ss2,ss3,ss4: string;
    b,b_not: boolean;
    a2: array[0..7] of word; //一个函数最多允许7个参数，最前面一个挪作它用了
begin
 if length(f)< 2 then
  begin
   result:= 0;
   exit;
  end;
 if f[1]= 'D' then
  begin
    Game_action_exe(f);
   result:= 1;
    exit;
  end;

 i:= FastCharPos(f,'(',1);
 if i= 0 then
  begin
   messagebox(handle,pchar('错误，函数'+f +'的参数不存在。'),'错误',mb_ok or MB_ICONERROR);
   result:= 0;
   exit;
  end;
  ss:= trim(copy(f,1,i -1));  //获得函数名称
  ss:= ansilowercase(ss); //转换为小写
  if pos('not ',ss)= 1 then
   begin
    b_not:= true;
    delete(ss,1,4);
   end else b_not:= false;

k:= 0;
  //取得参数括号匹配
   for j:= i to length(f) do
    begin
       if f[j]= '(' then
         inc(k)
         else if f[j]=')' then
          begin
           dec(k);
           if k= 0 then
              begin
               k:= j;
               break;
              end;
          end;
    end; //end for j

          if k=1  then
               begin
                k:= length(f)+1;
               end;
  ss2:=trim(copy(f,i+ 1,k- i-1)); //获得函数参数

  if k < length(f) then
     ss4:= copy(f,k+1,length(f))
     else
      ss4:= '';    //ss4保存了后续的内容

  if (length(ss2)= 0) then
   begin
    result:= 0;
     exit;
   end;

  if (ss2[length(ss2)]= ')') then
     delete(ss2,length(ss2),1);

  if fastcharpos(ss2,'^',1)> 0 then
        ss2:= stringReplace(ss2, '^', '''', [rfReplaceAll]);  //处理转义符

  b:= false;
  j:= 1;
  k:= 0;

  a2[0]:= 0; //其他值能被正确赋值，无须初始化

   for i:= 1 to length(ss2) do //获取参数个数
    begin
      if ss2[i]= '''' then
       begin
        if not b then
          b:= true
          else begin
                if i= length(ss2) then
                    b:= false
                    else if (ss2[i+1]= ',') or (ss2[i+1]= ' ') or (ss2[i+1]= ')') then
                           b:= false;
               end;
       end;

      

       if not b then
        begin
         if ss2[i]= '(' then
         inc(k)
          else if ss2[i]= ')' then
              dec(k);
       if k > 0 then //如果在括号内，跳过参数个数统计
         Continue;
        if ss2[i]= ',' then
         begin
          a2[j]:= i; //保留参数分割符位置，从位置1开始
          inc(j);
         end;
        end;
    end;

       a2[j]:= length(ss2)+ 1;

    setlength(a,j); //为参数分配内存空间
    for i:= 0 to j-1 do
     begin
       if ss2[1]= '''' then
        begin
         ss3:= strFromstr2(copy(ss2,2,a2[i+1]- a2[i]-3));
         if ss3= '' then
           a[i].VAnsiString:= nil
           else
             a[i].VAnsiString:= @ss3[1];
         delete(ss2,1,FastCharPos(ss2,'''',2)+1);
        end else begin
                  if a2[i+1] > 0 then
                   begin
                    a[i].VInteger:= strtoint3(copy(ss2,1,a2[i+1]- a2[i]-1));
                    delete(ss2,1,a2[i+1]- a2[i]);
                   end else
                      a[i].VInteger:= strtoint3(ss2);
                 end;


     end;

    result:= ExecuteRoutine(self,ss,a);

    if ss4<> '' then
     begin
       //后续处理
       ss4:= trim(ss4);

       if ss4<> '' then
        begin
         case ss4[1] of
          '+': result:= result + ss2int(ss4);
          '-': result:= result - ss2int(ss4);
          '*': result:= result * ss2int(ss4);
          '/': begin
                if result= 0 then
                   result:= 0
                    else
                     result:= result div ss2int(ss4);
               end;
          end;
        end;
     end;

    if b_not then  //not 关键字存在
       if result= 0 then
          result:= 1
           else
            result:= 0;

    if game_debug_handle_g<> 0 then  //发送调试信息
       begin
        ss4:= f + ':'+ inttostr(result);
         debug_send_func_str(ss4,func_C);
       end;
end;

   {显示背单词窗口}
function TForm1.Game_pop(i: integer): integer;
begin
        if game_at_net_g and (game_player_head_G.duiwu_dg= 1) and (game_page_from_net_g= false) then
           begin
               //=0队员，自由模式，=1队员受限模式，=2，队员，仅战斗跟随
            //受限模式下，队员不能自己弹出窗口
            game_chat('您现在是完全跟随领队模式，不能自由行动。<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">更改设置</a>');
             result:= 0;
            exit;
           end;

    if checkbox1.Checked then
      begin
        result:= 1;  //调试模式，直接路过
        exit;
      end;

  form_pop.game_pop_count:= i;
  form_pop.game_pop_type:= 1; //被单词

   if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(1, i,0);

      result:= ord (form_pop.ShowModal= mrok);

   
end;

      {载入场景文件}
function TForm1.game_page(id: integer): integer;
begin


        if game_at_net_g and (game_player_head_G.duiwu_dg= 1) and (game_page_from_net_g= false) then
           begin
               //=0队员，自由模式，=1队员受限模式，=2，队员，仅战斗跟随
            //受限模式下，队员不能切换页面
            game_chat('您现在是完全跟随领队模式，不能自己切换页面。<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">更改设置</a>');
             result:= 0;
            exit;
           end;

     // Game_scr_clean2; //聊天窗口清屏

 // combobox2.ItemIndex:= -1;
 // combobox2.Text:= '伙伴列表';
  if id <> 0 then
   begin
    if id < 10000 then //如果id小于1万，则加上当前页号 比如id为 1 就相当于载入下一页
       game_show_scene(id + pscene_id)
       else
         game_show_scene(id);
   end;

   if id=0 then
    begin
     //显示迷宫内的广告
         if (Game_ad_count_G.X<> 1) or (Game_ad_count_G.Y < 10)then
           begin
           game_chat('<iframe src="http://www.finer2.com/wordgame/jiqiao'+inttostr(Random(20)+1)+'.htm"  width=100%  height=100% framespacing=0 frameborder=0></iframe>');
           //Game_ad_count_G.Y:= Game_ad_count_G.Y+ 1;
           end;

    end;
  result:= 1;
end;

    {弹出一个消息窗口}
function TForm1.game_infobox(s: string): integer;
begin
  messagebox(screen.ActiveForm.handle,pchar(s),'玩游戏背单词',mb_ok or MB_ICONINFORMATION);
  result:= 1;
end;

   {在聊天窗口内添加一句话}
function TForm1.game_chat(const s: string): integer;
begin

  Game_add_line_to_web2(s);
  result:= 1;
end;

   {显示交易窗口}
function TForm1.game_trade(id,flag: integer): integer;  //,flag=0表示买，1表示卖
begin
  if not Assigned(form_trade) then
     form_trade:= Tform_trade.Create(application);
  form_trade.game_trade_id:= id;
  form_trade.game_flag:= flag;
  form_trade.ShowModal;
  result:= 1;
end;

  {在聊天窗口内添加一句话，实现部分}
procedure TForm1.Game_add_line_to_web2(const s: string);
var ss: string;
begin
      visible_html_by_id('layer_chat1',true);
      //web1.WebView.RunJS('document.getElementById("layer_chat1").display="inline";');


     {if pdoc.getElementById('cell_chat1').innerText = '' then
       game_chat_cache_g:= s
     else }
      ss:= 'document.getElementById("cell_chat1").innerHTML=document.getElementById("cell_chat1").innerHTML+"<br>'+
        StringReplace(s,'"','\"',[rfReplaceAll]) +'";';
     // ss:= 'document.getElementById("cell_chat1").innerHTML="pppp";';

     web1.ExecuteJavascript(ss);



 {  if pdoc<> nil then
    begin

    for i := 0 to pdoc.all.length-1 do
     begin
       Disp := pdoc.all.item(i, 0);
       if (SUCCEEDED(Disp.QueryInterface(HTMLDivElement, dd)) ) then
          if dd.id= 'layer_chat1' then
             dd.style.display:= '""';
       if (SUCCEEDED(Disp.QueryInterface(HTMLTableCell, tt)) ) then
        begin
         if tt.id= 'cell_chat1' then
          begin
            tt.innerHTML:= tt.innerHTML + '<br>'+ s;
            break;
          end;
        end;
     end; //end for i
    end; }


end;
    {延时函数}
function TForm1.game_dec_scene_event(id, v: integer): integer;
begin
  result:= data2.game_memini_event.ReadInteger('EVENTS',inttostr(id),0);
  result:= result - v;
   data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),result);

   result:= 1;
end;

function TForm1.game_delay(i: integer): integer;
var t,t2: cardinal;
begin
  t:= GetTickCount;
  t2:= i;
    while GetTickCount - t < t2 do
     begin
      application.ProcessMessages;
       sleep(10);
     end;
 result:= 1;
end;
    {弹出一个询问窗口}
function TForm1.game_question(s: string): integer;
begin
   if messagebox(screen.ActiveForm.handle,pchar(s),'询问',mb_yesno or MB_ICONQUESTION)= mryes then
    result:= 1
    else
     result:= 0;
end;

           //修改游戏物品数量
function TForm1.game_goods_change(id, values: integer): integer;
begin
  Game_not_save:= true;
  result:= 1;
  write_goods_number(id, values);
 { showmessage(format('数量%d颗，名称：%s 类型%d，描述：%s',[Game_goods_G[id],pchar(Data2.get_game_goods_type(id,goods_name1)),
  Data2.get_game_goods_type(id,goods_type1),
  pchar(Data2.get_game_goods_type(id,goods_ms1))])); }
end;
         //修改当前对话人的姓名
function TForm1.game_write_name(s: string): integer;
var i: integer;
begin

Game_chat_index_G:= 0;
 Game_chat_id_G:= 0;
 Game_chat_name_G:= s;
 i:= combobox2.Items.IndexOf(s);
 if i<> -1 then
    combobox2.ItemIndex:= i;
 result:= 1;
end;
         //游戏保存
function TForm1.game_save(i: integer): integer;
begin
result:= 1;
 if game_at_net_g then  //联网游戏不用存盘
    exit;

 case i of
   0: game_save2;
   1: begin
       if not Game_not_save then
        Form_save.addr:= ''
         else
          Form_save.addr:= groupbox5.Caption;

         Form_save.Button1Click(form1);
      end;
   end;
end;
          //游戏角色数据清空
procedure TForm1.game_role_clean;
var i: integer;
begin
   for i:= 0 to game_role_list.Count-1 do
      Tplayer(game_role_list.Items[i]).Free;

   game_role_list.Clear;
end;

             //游戏聊天
function TForm1.game_talk(const n: string): integer;
         function get_talk_index(const s2: string): integer;
          var i2: integer;
          begin  //获取聊天文本内的index号
            i2:= fastcharpos(s2,']',2)+1;
            if i2= 1 then
              i2:= fastcharpos(s2,'=',2)+1;
            result:= strtoint2(Copy(s2,i2,fastcharpos(s2,',',i2)-i2));
          end;

var i,j,player_i: integer;

     ss: string;
     b: boolean;
begin

player_i:= -1;
    //获取当前人物的谈话index  Game_chat_index_G,Game_chat_id_G
 Game_chat_name_G:= n;

      for i:= 0 to game_get_role_H do
        if Assigned(game_role_list.Items[i]) then
           if Tplayer(game_role_list.Items[i]).pl_old_name= n then
              begin
               Game_chat_id_G:= game_read_values(i,22);  //22号记录，当前谈话前后文
               inc(Game_chat_id_G);  //谈话前后文加一
               game_write_values(i,22,Game_chat_id_G);
               Game_chat_index_G:= game_read_values(i,23); //谈话快速索引
               talkchar1:= Tplayer(game_role_list.Items[i]).pltalkchar1;
               talkchar2:= Tplayer(game_role_list.Items[i]).pltalkchar2;  //读取层次数据
               talkchar3:= Tplayer(game_role_list.Items[i]).pltalkchar3;
               talkchar4:= Tplayer(game_role_list.Items[i]).pltalkchar4;
               talkchar5:= Tplayer(game_role_list.Items[i]).pltalkchar5;
               player_i:= i; //如果该值不为负，表名本次聊天是在成员间的。
               break;
              end;


   if player_i < 0 then  //如果不是内部人物谈话，那么id加一
    begin
     inc(Game_chat_id_G);

    end;

  b:= false;
  for j:= 1 to 6 do
  begin
    case j of
    1: begin
        if talkchar5= #0 then Continue;
        ss:= n+ ','+ talkchar1+ ','+ talkchar2+ ','+talkchar3+ ','+talkchar4+ ','+talkchar5;
       end;
    2: begin
        if talkchar4= #0 then Continue;
        ss:= n+ ','+ talkchar1+ ','+ talkchar2+ ','+talkchar3+ ','+talkchar4;
       end;
    3: begin
        if talkchar3= #0 then Continue;
        ss:= n+ ','+ talkchar1+ ','+ talkchar2+ ','+talkchar3;
       end;
    4: begin
        if talkchar2= #0 then Continue;
        ss:= n+ ','+ talkchar1+ ','+ talkchar2;
       end;
    5: begin
        if talkchar1= #0 then Continue;
        ss:= n+ ','+ talkchar1;
       end;
    6: ss:= n;
    end;

   for i:= Game_chat_index_G to Game_Chat_list.Count - 1 do
    begin
      if fastpos(Game_Chat_list.Strings[i],ss,length(Game_Chat_list.Strings[i]),length(ss),1) =1 then
         begin
          if get_talk_index(Game_Chat_list.Strings[i])= Game_chat_id_G then   //已经找到
           begin
              Game_chat_index_G:= Game_talk_random(i,ss);
              Game_talk_run(Game_chat_index_G,player_i);
              inc(Game_chat_index_G); //保留新的索引值
            b:= true;
            break;
           end;
         end;
    end; //for i

   if b then
    break
     else if j= 6 then
         begin
            Game_scr_clean2;
          game_chat('.');

         // Button_talk.Enabled:= true;
         end;
 end; //for j

  if player_i > 0 then  //是内部人物谈话，那么保留新的索引值
    begin
    game_write_values(player_i,23,Game_chat_index_G);
    end;
  result:= 1;
end;

procedure TForm1.Game_action_exe_S(s: string);
var i,j: integer;
    s2: string;
begin
  s:= trim(s);
 { if pos('if ',s)> 0 then //函数串内有多个if语句，则只执行if前面的
    s:= copy(s,1,pos('if ',s)-1);   }

 if s[length(s)]<>';' then s:= s + ';';
   i:= 1;
   while FastCharPos(s,';',i)> 0 do
    begin
    s2:= copy(s,i,FastCharPos(s,';',i)-i);
     j:= Game_action_exe_A(s2);
     i:= FastCharPos(s,';',i)+1;

      if j = 0 then  //一个函数返回false，则中断执行
       break
       else if j= 1881 then
            begin //对 gamepop和popa做特殊处理
              if (game_bg_music_rc_g.mg_pop=false) and (Game_scene_type_G and 2=2) and
                  (pos('game_pop_a(',s2)=1) then
                begin

                  game_html_pop_str_g:= copy(s,i,1024); //如果是迷宫pop模式，先暂存数据
                  exit;
                end;
            end;


    end;

end;

procedure TForm1.Game_action_exe_S_adv(const s: string);
var ss2{,ss3}: string;
    //i,j: integer;
begin
  ss2:= StringReplace(s, '%20', ' ', [rfReplaceAll]); //%20 替换为空格

   data2.clean_if_then(ss2);

   if (game_bg_music_rc_g.mg_pop=false) and (Game_scene_type_G and 2=2)
      and (length(game_html_pop_str_g)= 3) then
      game_html_pop_str_g:= ss2; //如果是迷宫pop模式，先暂存数据

     if ss2 <> '' then
        Game_action_exe_S(ss2);

end;

procedure TForm1.Game_talk_run(id,role_id: integer); //聊天执行
var ss,ss2,ss3,ss4,ss5,ss6: string;
    i,j,k,k2: integer;
    b: boolean;
     function get_id: integer;
      var q2: integer;
      begin
        result:= fastcharpos(ss,']',2); //找到右中括号，定位谈话id
   if result > 0 then
    begin
     q2:= fastcharpos(ss,',',result); //找到右边的第一个逗号
     result:= strtoint2(copy(ss,result+1,q2- result-1));
    end else begin
              result:= fastcharpos(ss,'=',2);
              q2:= fastcharpos(ss,',',result);
              result:= strtoint2(copy(ss,result+1,q2- result-1));
             end;
      end;
begin
//

b:= false;
 ss:= Game_Chat_list.Strings[id];  //得到对方人物的对话并处理
  data2.clean_if_then(ss); //对人物谈话内的if then进行判断过滤
     k:= get_id;
   i:= fastcharpos(ss,',',2) +1;
  ss3:= Copy(ss,i,fastcharpos(ss,'=',2)-i);
  if ss3= '' then
    ss3:= 'I'
    else ss3:= 'I,'+ ss3;

 delete(ss,1,fastcharpos(ss,'=',2)); //删除等于号前的


  i:= fastcharpos(ss,'[',1);
  if (i >0)  and (i < 5) then
   begin
    inc(i);
     ss2:= copy(ss,i,fastcharpos(ss,']',i)-i);
     ss2:= trim(ss2);  //取得函数

    delete(ss,1,fastcharpos(ss,']',2)+1); //删除动作函数
   end;

   delete(ss,1,fastcharpos(ss,',',1)); //删除id前的
   ss:= trim(ss);
     if ss<> '' then
      begin
        k2:= fastcharpos(ss,'@',1);
         if k2 > 0 then
           begin
           ss6:= copy(ss,1,k2 -1);
            delete(ss,1,k2);
           end else
            ss6:= game_newname_from_oldname(Game_chat_name_G);

        ss:= ss6 +'：<strong>' +ss + '</strong>';
        game_chat(ss);   //显示一句话
      end;

      if ss2<> '' then   //执行函数
      begin
       if ss2[1]= 'D' then
       Game_action_exe(ss2) //执行聊天语句内的动作
        else begin
            // if ss2[length(ss2)]<> ';' then
              //  ss2:= ss2+ ';';
             Game_action_exe_S_adv(ss2); // 执行聊天语句内的直接函数
             end;
      end;

  for i:= Game_chat_index_G to Game_Chat_list.Count-1 do
   begin
    if fastpos(Game_Chat_list.Strings[i],ss3,length(Game_Chat_list.Strings[i]),length(ss3),1) =1 then
       begin
        b:= true;

        ss:= Game_Chat_list.Strings[i];
         if get_id<> k then
          break;

         j:= fastcharpos(ss,',',2) +1;  //获取参数 ss4
         ss4:= Copy(ss,j,fastcharpos(ss,'=',2)-j);
         if ss4= '' then
            ss4:= '0';

         //获取动作，如果有的话
         delete(ss,1,fastcharpos(ss,'=',2));
          data2.clean_if_then(ss); //对我方谈话内的if then进行判断过滤
          Data2.function_re_string(ss); //对返回字符串类型的函数进行处理

           j:= fastcharpos(ss,'[',1) +1;  //获取动作
           if j> 1 then
            begin
         ss5:= Copy(ss,j,fastcharpos(ss,']',j)-j);
         if ss5='' then
          Continue;

          if ss5[1]='D' then
            ss5:= Game_action_list.Values[ss5];
         delete(ss,1,fastcharpos(ss,']',j)+1);

          if (length(ss5)> 1) and (ss5[length(ss5)]<> ';') then
             ss5:=ss5+ ';';

            end else ss5:= '';

           delete(ss,1,fastcharpos(ss,',',1));

         ss5:= 'game_chat_cleans(0);'+ ss5 + 'game_talk_char_set('''+ ss4+''','+ inttostr(role_id)+ ');';
         ss:= trim(ss);
            if ss<> '' then //我方语句不为空时显示
           begin
            k2:= fastcharpos(ss,'@',1);
             if k2 > 0 then
               begin
                ss6:= copy(ss,1,k2 -1);
                delete(ss,1,k2);
               end else
                    ss6:= Tplayer(Game_role_list.Items[0]).plname;

              ss:= ss6 + '：<a href="'+ ss5+ '">'+ ss+ '</a>';
              game_chat(ss);
           end;
       end else begin
                  if b then
                   break;
                end;
   end; //end for i

    {
   if Game_scene_type_G and 8 <> 8 then  //场景属性8不存在，则可以结束聊天
      game_chat('<a href="game_talk_stop(0)">结束对话</a>');
     }

end;

function TForm1.game_talk_char_set(c1: string;
  role_id: integer): integer;
  var
     i,j: integer;
begin
 talkchar1:= #0;
talkchar2:= #0;
talkchar3:= #0;
talkchar4:= #0;
talkchar5:= #0;

  //Game_scr_clean2;  //清屏



   j:= 1;
      for i:= 1 to length(c1) do    //设置聊天层次参数，最多可以有5层
       begin
        if c1[i]= ',' then Continue;
         case j of
          1: talkchar1:= c1[i];
          2: talkchar2:= c1[i];
          3: talkchar3:= c1[i];
          4: talkchar4:= c1[i];
          5: talkchar5:= c1[i];
          end;
         inc(j);
       end; //end for

   if (role_id > 0) and (role_id <= game_get_role_H) then
    begin
      Tplayer(game_role_list.Items[role_id]).pltalkchar1:= talkchar1;
      Tplayer(game_role_list.Items[role_id]).pltalkchar2:= talkchar2;
      Tplayer(game_role_list.Items[role_id]).pltalkchar3:= talkchar3;
      Tplayer(game_role_list.Items[role_id]).pltalkchar4:= talkchar4;
      Tplayer(game_role_list.Items[role_id]).pltalkchar5:= talkchar5;
    end;

   game_talk(Game_chat_name_G);

result:= 1;
end;

function TForm1.game_talk_stop(i: integer): integer;
begin
      //中止聊天
//WebBrowser2.Navigate('about:blank');
Game_scr_clean3; //聊天窗口清屏
result:= 1;
end;

function TForm1.game_npc_talk(const n: string): integer; //npc talk
begin
 Game_chat_index_G:= 0;
 Game_chat_id_G:= 0;
 game_write_name(n);
   result:= game_talk(n); //调用talk过程

end;

function TForm1.Game_talk_random(id: integer; const n: string): integer;
var i: integer;
begin
result:= id;
    //返回一个随机的聊天语句，在多个聊天语句内
  for i:= id to Game_Chat_list.Count-1 do
   begin
     if fastpos(Game_Chat_list.Strings[i],n,length(Game_Chat_list.Strings[i]),length(n),1) <>1 then
       begin
        result:= id + Game_base_random(i-id);
        break;
       end;
   end;

end;

procedure TForm1.Game_scr_clean2;     //私聊窗口清屏

begin
   change_html_by_id('cell_chat1','');
   visible_html_by_id('layer_chat1',false);

   game_chat_cache_g:= ''; //清空聊天缓存
end;

function TForm1.game_accouter1_wid(i1: integer): integer;
begin
result:= 0;
 if game_role_list.Count=0 then
  begin
   messagebox(handle,'游戏没有开始，请点击上面的“开始单机游戏”或者“开始联网游戏”来进入游戏或者存取进度。','游戏没开始',mb_ok);
   exit;
  end;

    if not Assigned(Form_goods) then
     Form_goods:= TForm_goods.Create(application);

  Form_goods.ShowModal;
 result:= 1; 
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  game_accouter1_wid(0);
end;

function TForm1.game_get_roleByNmae(n: string): Tplayer;
var i: integer;
begin
result:= nil;

for i:= 0 to game_get_role_H do
     if Assigned(game_role_list.Items[i]) then
       if Tplayer(game_role_list.Items[i]).pl_old_name= n then
          result:= Tplayer(game_role_list.Items[i]);
end;

function TForm1.game_add_res_event(id: integer): integer;
begin
  if game_at_net_g then
   begin
    result:= 1;
    exit; //联网游戏时，该函数不做任何动作
   end;

    if id < 1001 then
   begin
     messagebox(handle,'错误，事件编号1000及以下为系统保留，请使用1000以上。','错误',mb_ok or MB_ICONERROR);
     result:= 0;
   end else begin
            Game_not_save:= true;
            data2.game_memini_event.WriteInteger('FOODS',inttostr(id),1);
            result:= 1;
           end;
end;

function TForm1.game_add_scene_event(id: integer): integer;
begin
  if (id < 1001) and (game_at_net_g= false) then
   begin
     messagebox(handle,'错误，事件编号1000及以下为系统保留，请使用1000以上。','错误',mb_ok or MB_ICONERROR);
     result:= 0;
   end else begin
             Game_not_save:= true;
            data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),1);
         if game_at_net_g then  //如果游戏处于联网状态，那么同时写入一个记录事件到物品表，因为物品事件表在网络下不用
             begin
               //发送事件
               Data_net.send_scene_bool(id,1);
             end;
             result:= 1;
            end;
end;

function TForm1.game_check_res_event(id: integer): integer;
begin
 if game_at_net_g then //联网时，物品事件总是返回 1
  result:= 1
  else
   result:= data2.game_memini_event.ReadInteger('FOODS',inttostr(id),0);

end;

function TForm1.game_check_scene_event(id: integer): integer;
begin
 result:= data2.game_memini_event.ReadInteger('EVENTS',inttostr(id),-1);
   if result= -1 then
    begin
      if game_at_net_g then
       begin
        //联网时，如果为-1，则从网络获取
        data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),1);
        result:= wait_scene_int_bool(true,id);
       end else result:= 0;
    end;
end;

function TForm1.game_del_res_event(id: integer): integer;
begin
 if not game_at_net_g then
    data2.game_memini_event.DeleteKey('FOODS',inttostr(id));
  result:= 1;
end;

function TForm1.game_del_scene_event(id: integer): integer;
begin
 data2.game_memini_event.DeleteKey('EVENTS',inttostr(id));
        if game_at_net_g then  //如果游戏处于联网状态，那么同时写入一个记录事件到物品表，因为物品事件表在网络下不用
             begin
               //发送事件
               Data_net.send_scene_bool(id,0);
             end;
 result:= 1;
end;

function TForm1.game_prop_enbd(b: integer): integer;
begin
  button1.Enabled:= (b= 1);
  result:= 1;
end;

function TForm1.Game_pop_dig(i: integer): integer;
begin
  form_pop.game_pop_count:= i;
  form_pop.game_pop_type:= 2; //挖矿
  
      if game_at_net_g and (game_player_head_G.duiwu_dg= 1) then
           begin
               //=0队员，自由模式，=1队员受限模式，=2，队员，仅战斗跟随
            //受限模式下，队员不能自己弹出窗口
            game_chat('您现在是完全跟随队长，不能自由行动。<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">更改设置</a>');
             result:= 0;
            exit;
           end;

   if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
    begin
     if i= 100 then
        data_net.send_dwjh_pop(5, i,0);  //挖矿
     if i= 200 then
        data_net.send_dwjh_pop(6, i,0);  //采药或者打坐
    end;
  if form_pop.game_pop_count >= 1000 then
   begin
   form_pop.ShowModal;
   if form_pop.game_kaoshi<= 35 then
      result:= Game_wakuan_zhengque_shu
      else
        result:= 0;
   end else
        result:= ord(form_pop.ShowModal= mrok);
end;

function TForm1.Game_pop_fight(i, i2: integer): integer;
begin
      if game_at_net_g and ((game_player_head_G.duiwu_dg= 1) or ((game_player_head_G.duiwu_dg= 2))) and (game_page_from_net_g= false) then
           begin
               //=0队员，自由模式，=1队员受限模式，=2，队员，仅战斗跟随
            //受限模式下，队员不能自己弹出窗口
            game_chat('您现在是完全跟随队长或者打怪跟随，不能自由行动。<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">更改设置</a>');
             result:= 0;
            exit;
           end;

  if checkbox1.Checked then
    begin
     result:= 1;    //调试时直接略过
     exit;
    end;

 if i< 1 then
    i:= 1;

   form_pop.game_pop_count:= i;
  form_pop.game_pop_type:= 3; //战斗
  form_pop.game_monster_type:= i2;  //怪物种类

  if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(3, i,i2);

     result:= ord( form_pop.ShowModal= mrok);
end;

function TForm1.Game_pop_game(i, i2: integer): integer;
begin
      if game_at_net_g and ((game_player_head_G.duiwu_dg= 1) or ((game_player_head_G.duiwu_dg= 2))) and (game_page_from_net_g= false) then
           begin
               //=0队员，自由模式，=1队员受限模式，=2，队员，仅战斗跟随
            //受限模式下，队员不能自己弹出窗口
            game_chat('您现在是完全跟随队长或者打怪跟随，不能自由行动。<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">更改设置</a>');
             result:= 0;
            exit;
           end;

  if i< 1 then
    i:= 1;
    
  form_pop.game_pop_count:= i; //对方人数
  form_pop.game_pop_type:= 4; //打擂
  form_pop.game_monster_type:= i2;  //人物种类种类
        if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(5, i,i2);

     result:= ord(form_pop.ShowModal= mrok);
end;

procedure TForm1.ComboBox2KeyPress(Sender: TObject; var Key: Char);
begin
  key:= #0;
end;

function TForm1.game_add_friend(n: string; new: integer): integer;
begin
   //添加一个朋友到列表 n为伙伴姓名
  if Game_friend_list.IndexOf(n)= -1 then
     begin
     
       //初始化伙伴数据
       Game_loading:= true;
       initialize_role(n,new);
       Game_friend_list.Append(n);
       combobox2.Items.Append(n);
       Game_loading:= false;
       messagebox(handle,pchar(n+ ' 加入了队伍。'),'消息',mb_ok or MB_ICONINFORMATION);
       
       result:= 1;
     end else result:= 0;

end;

procedure TForm1.game_load_friend_list(n: string);
var i: integer;
begin
//载入伙伴列表
  Game_friend_list.Clear;
  combobox2.Items.Clear;
  data2.Load_file_upp(n,Game_friend_list);
  combobox2.Items.Assign(Game_friend_list);

   for i:= 0 to Game_friend_list.Count-1 do
     initialize_role(Game_friend_list.Strings[i],1); //第二个参数为1，表示不读取dat表

end;

procedure TForm1.game_save_friend_list(n: string);
var i: integer;
    str1: Tstringlist;
    ss: string;
begin
 //保存伙伴列表,带密码的压缩文件
   data2.save_file_upp(n,Game_friend_list);

     str1:= Tstringlist.Create;
     data2.Load_file_upp(game_app_path_G+ 'persona\ext.upp',str1);
     Assert(str1.count > 0,'无效的人物对照表，保存游戏角色失败。');

   for i:= 1 to Game_role_list.Count-1 do  //保存伙伴数据，不包括玩家主角
    begin
      //保存列表内的每个伙伴的数据
      ss:= str1.Values[Tplayer(Game_role_list.Items[i]).pl_old_name]; //取得游戏人物的文件名
     Tplayer(Game_role_list.Items[i]).saveupp(Game_save_path + ss);
    end;

   str1.Free;
end;

procedure TForm1.initialize_role(n: string; new: integer);
var i: integer;
    str1: Tstringlist;
    ss: string;
begin
      for i:= 1 to Game_role_list.Count-1 do
        begin
         if Tplayer(Game_role_list.Items[i]).pl_old_name = n then
            exit;  //如果该角色已经存在，退出

        end;

 //载入对照表
   str1:= Tstringlist.Create;
     data2.Load_file_upp(game_app_path_G+ 'persona\ext.upp',str1);
     Assert(str1.count > 0,'无效的人物对照表，初始化游戏角色失败。');
     ss:= str1.Values[n]; //取得游戏人物的文件名
   str1.Free;

    //如果dat路径下文件存在，优先读取这里的，表示这个人物是离开过队伍的
    //如果new=1 忽略对dat文件的搜索，强制读取新文件
   //如果有读盘路径存在，优先读取此路径
   //如果读盘路径不存在或者路径下没有需要的文件，则读取原始位置
    if (new= 0) and fileExists(game_doc_path_g+ 'dat\'+ ss) then
       ss:= game_doc_path_g+ 'dat\'+ ss
       else
       if Game_save_path= '' then
          ss:= game_app_path_G+ 'persona\'+ ss
           else begin
             if FileExists(Game_save_path+ ss ) then
              ss:= Game_save_path+ ss
               else
                ss:= game_app_path_G+ 'persona\'+ ss;
                end;

   //初始化人物数据，并添加到人物列表
   if not FileExists( ss) then
     raise Exception.Create('严重错误，角色人物文件不存在。可能游戏安装不完整，请升级或者重装游戏试试。');

   game_role_list.Add(Tplayer.create(ss));

end;

function TForm1.game_not_res_event(id: integer): integer;
begin
       //事件不存在时返回true
 if game_at_net_g then          //联网时此事件返回0
 result:= 0
 else begin
 if data2.game_memini_event.ReadInteger('FOODS',inttostr(id),0)= 0 then
  result:= 1
   else
    result:= 0;
       end;
end;

function TForm1.game_not_scene_event(id: integer): integer;
begin
   //事件不存在时返回true
 if game_check_scene_event(id) = 0 then
  result:= 1
   else
    result:= 0;
end;

function TForm1.game_over(i: integer): integer;
begin
  //游戏结束
  game_kill_game_time(0); //停止可能的定时器
  Game_not_save:= false;
  combobox2.Items.Clear;
  game_page(14444);
   button_stat(false); //更改button状态
   game_role_clean; //清除角色数据。
   Game_scene_type_G:= 2;
  result:= 1;
end;

function TForm1.game_check_res_event_and(s: string): integer;

begin
    //多个物品全部都存在，返回 1
result:= 1;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_check_res_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 0 then
         begin
          //只要一个不存在，就返回 0 退出
         result:= 0;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //通过while循环后再检查最后一个
       if s<> '' then
        result:= game_check_res_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_not_res_event_and(s: string): integer;
begin
   //多个物品都 不 存在，返回 1
   result:= 1;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_not_res_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 0 then
         begin
          //只要一个不存在，就返回 0 退出
         result:= 0;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //通过while循环后再检查最后一个
       if s<> '' then
        result:= game_not_res_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_check_res_event_or(s: string): integer;
begin
   //多个物品有一个存在，返回 1
  result:= 0;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_check_res_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 1 then
         begin
          //只要一个存在，就返回 1 退出
         result:= 1;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //通过while循环后再检查最后一个
       if s<> '' then
        result:= game_check_res_event(strtoint2(s));

     end else result:= 0;

end;

function TForm1.game_not_res_event_or(s: string): integer;
begin
  //多个物品有一个 不 存在，返回 1
  result:= 0;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_not_res_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 1 then
         begin
          //只要一个不存在，就返回 1 退出
         result:= 1;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //通过while循环后再检查最后一个
       if s<> '' then
        result:= game_not_res_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_check_scene_event_and(s: string): integer;
begin
  result:= 1;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_check_scene_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 0 then
         begin
          //只要一个不存在，就返回 0 退出
         result:= 0;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //通过while循环后再检查最后一个
       if s<> '' then
        result:= game_check_scene_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_check_scene_event_or(s: string): integer;
begin
    //多个物品有一个存在，返回 1
  result:= 0;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_check_scene_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 1 then
         begin
          //只要一个存在，就返回 1 退出
         result:= 1;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //通过while循环后再检查最后一个
       if s<> '' then
        result:= game_check_scene_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_not_scene_event_and(s: string): integer;
begin
  //多个物品都 不 存在，返回 1
   result:= 1;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_not_scene_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 0 then
         begin
          //只要一个不存在，就返回 0 退出
         result:= 0;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //通过while循环后再检查最后一个
       if s<> '' then
        result:= game_not_scene_event(strtoint2(s));

     end else result:= 0;
end;

function TForm1.game_not_scene_event_or(s: string): integer;
begin
   //多个物品有一个 不 存在，返回 1
  result:= 0;

    if s<> '' then
     begin
      while fastcharpos(s,',',1)> 1 do
       begin
        if game_not_scene_event(strtoint2(copy(s,1,fastcharpos(s,',',1)-1)))= 1 then
         begin
          //只要一个不存在，就返回 1 退出
         result:= 1;
         exit;
         end;
         delete(s,1,fastcharpos(s,',',1));
       end; //end while
       //通过while循环后再检查最后一个
       if s<> '' then
        result:= game_not_scene_event(strtoint2(s));

     end else result:= 0;

end;

function TForm1.game_pop_love(i: integer; const n: string): integer;
var j,k,m: integer;
begin
result:= 0;
               //弹出只显示两个人的背单词窗口
    if game_at_net_g then
     begin
      //联网时，不可用
      game_chat('联网时，该功能不可用。');
       exit;
     end;
 form_pop.game_pop_count:= i;
  form_pop.game_pop_type:= 5; //两个人单词
  form_pop.game_love_word_role:= n;
  
    if  form_pop.ShowModal= mrok then
     begin
      //每背20个单词，有百分之一的机会使得爱情值增加一点
       k:= i div 20;
       for j:= 1 to game_get_role_H do
        begin
         if Tplayer(Game_role_list.Items[j]).pl_old_name = n then
            begin
             for m:= 1 to k do
              begin
              if Game_base_random(100)= 1 then
                begin
                game_write_values(j,14,game_read_values(j,14)+1);
                 game_write_values(j,15,game_read_values(j,15)+1);

                end;
              end; //end for m
            end;  //if
        end; //for j

      result:= 1;
     end;

end;

procedure TForm1.game_load_doc(path: string);

    function bianli_dir(Path2: string): boolean;
   var
  FindData: TWin32FindData;
  FindHandle: THandle;
  FileName: string;
   begin
  Result := false;

  Path2 := Path2 + '*.*';

  FindHandle := Windows.FindFirstFile(PChar(Path2), FindData);
  while FindHandle <> INVALID_HANDLE_VALUE do
  begin
    FileName := StrPas(FindData.cFileName);
    if (FileName <> '.') and (FileName <> '..') and
      ((FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) then
    begin
      if FileExists(Game_save_path+ FileName + '\Player0.upp') then
      begin
       Game_save_path:= Game_save_path + FileName +'\';
       result:= true;
       break;
      end else begin
                Game_save_path:= Game_save_path + FileName +'\';
                result :=bianli_dir(Game_save_path); //递归调用
                if result then
                  break;
               end;
    end;

    if not Windows.FindNextFile(FindHandle, FindData) then
      FindHandle := INVALID_HANDLE_VALUE;
  end;
  Windows.FindClose(FindHandle);
   end;

begin
    //载入存档，参数为存档目录
   if not game_doc_is_ok(path) then
    begin
      messagebox(handle,'无效的存盘文件，可能存盘文件被意外修改。','无效',mb_ok);
      exit;
    end;

    Game_loading:= true;
    
  Game_save_path:= path; //保存路径，供载入文件用
   temp_event_clean; //清空临时表

     if not FileExists(Game_save_path +'Player0.upp') then
      begin
        if not bianli_dir(Game_save_path) then
        begin
        messagebox(handle,'游戏主角文件不存在，读盘不成功。','无效',mb_ok);
        Game_loading:= false;
         exit;
         end;
      end;

   form_pop.load_game_progress(path+ 'default.sav');
   //载入玩家主角
   game_role_clean;
     
   game_role_list.Add(Tplayer.create(Game_save_path +'Player0.upp'));
  game_load_friend_list(Game_save_path + 'friend.fpp'); //载入伙伴列表

  if not FileExists(Game_save_path +'event.fpp') then
      begin
        messagebox(handle,'游戏记录文件不存在，读盘不成功。','无效',mb_ok);
        Game_loading:= false;
         exit;
      end;
  data2.load_event_file(Game_save_path + 'event.fpp');   //载入事件
  //载入头衔
    data2.Load_file_upp(game_app_path_G+'dat\touxian.upp',Game_touxian_list_G);

  Phome_id:= game_read_scene_event(999); //读取回车点
  Data2.load_goods_file; //载入游戏物品描述表
  Data2.game_load_goods; //载入物品
   game_load_image_to_imglist; //载入人物头像
   Data2.game_load_task_file; //载入任务列表
   Form_pop.laod_fashu_wupin_k(Game_save_path + 'fwk.dat');   //载入法术物品快捷键列表
  button_stat(true); //更改button状态
   form_pop.load_abhs; //载入abhs表
 // if (Game_scene_type_G and 2 = 2) or (Game_scene_type_G =1) then  //在迷宫
  //  Game_is_reload:= true; //忽略载入前后动作

    //如果out文件存在，那么重建guid，存盘时会清空目录然后out文件就被删除了。
    if FileExists(Game_save_path+'out.txt') then
           game_guid:= game_create_guid
           else
            game_guid:= game_read_scene_string(998); //读取guid，如果存在，用这个guid


  game_page(game_read_scene_event(1000)); //显示存盘的场景
  Game_loading:= false; //设置变量，重新开始文件id检查

end;

procedure TForm1.game_save_doc(path: string);
begin
           // 保存存档
  Game_save_path:= path; //保存路径，供载入文件用
  {
  1  保存玩家主角
  2  保存伙伴列表
  3  保存事件列表
  4  保存物品
  }


    DeleteDirNotEmpty(path); //清空目录
   Tplayer(Game_role_list.Items[0]).saveupp(Game_save_path + 'Player0.upp');
   game_save_friend_list(Game_save_path + 'friend.fpp');
    game_write_scene_string(998,game_guid); //保存guid
    game_write_scene_event(999,Phome_id);  //保存回城点
    game_write_scene_event(1000,pscene_id);          //保存当前场景id
   data2.save_file_event(Game_save_path + 'event.fpp');
   Data2.game_save_goods; //保存物品
   Data2.game_save_task_file; //保存任务列表
   Form_pop.save_fashu_wupin_k(Game_save_path + 'fwk.dat');   //保存法术物品快捷栏

      form_pop.save_abhs; //保存abhs表
      form_pop.save_set(path);
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   form_exit.Button2.Enabled:= Game_not_save and not game_at_net_g;
   //form_exit.Button1.Enabled:= game_bg_music_rc_g.desktop_word;
   
    case form_exit.ShowModal of
     mrcancel: canclose:= false;
     mrok: begin
             //启动桌面背单词
             canclose:= false;
             postmessage(handle,WM_SYSCOMMAND,SC_MINIMIZE,0);
           end;
     mryes: begin
             //存盘并退出
             game_save(0);
            end;
     //mrno: 直接退出
     end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if game_at_net_g then
     begin
      messagebox(handle,'联网游戏不需存取进度。','提示',mb_ok);
     exit;
     end;
   game_save2;
end;

function TForm1.game_read_scene_event(i: integer): integer;  //读取存盘的场景id或者别的数据
begin
 if Game_at_net_G then  //如果联网，读取另一个函数
  result:= game_read_scene_integer(i)
 else
  result:= data2.game_memini_event.readInteger('EVENTS',inttostr(i),10001);
end;

procedure TForm1.game_write_scene_event(i,v: integer);
begin
  if Game_at_net_G then  //如果联网，写入另一个函数
   game_write_scene_integer(i,v)
  else
  data2.game_memini_event.WriteInteger('EVENTS',inttostr(i),v);

end;

function TForm1.game_del_friend(n: string; b: integer): integer; //删除一个朋友，b=1 显示文字
var i: integer;
str1: Tstringlist;
    ss,ss2: string;
begin
     str1:= Tstringlist.Create;
     data2.Load_file_upp(game_app_path_G+ 'persona\ext.upp',str1);
     Assert(str1.count > 0,'无效的人物对照表，保存游戏角色失败。');
       ss:= str1.Values[n]; //取得游戏人物的文件名
     str1.Free;
  if Game_friend_list.IndexOf(n)> -1 then
     begin
     Game_friend_list.Delete(Game_friend_list.IndexOf(n));
     combobox2.Items.Delete(combobox2.Items.IndexOf(n));
     combobox2.Text:= '伙伴列表';
       for i:= 0 to game_role_list.Count- 1 do
        begin
          //定位
          //保存角色数据到dat文件夹下
          //从内存卸载数据
          if Tplayer(Game_role_list.Items[i]).pl_old_name = n then
           begin
            Tplayer(Game_role_list.Items[i]).
             saveupp(game_doc_path_g+ 'dat\'+ ss); //保存游被踢出的人物
              if b= 1 then  //b等于一，显示提示文字
               begin
               if game_read_values(i,ord(g_sex))= 1 then
                  ss2:= '夕阳西下，他独自一人默默的走了。'
                  else
                   ss2:= '她转身伤心的离去了。';
              messagebox(handle,pchar('您从退伍中踢出了'+ n +'，'+ ss2),
                      '尽在不言中',mb_ok or MB_ICONINFORMATION);
               end;
             Tplayer(Game_role_list.Items[i]).Free;
             game_role_list.Delete(i); //从列表内删除人物
             
             break;
           end;
        end;

       result:= 1;
     end else result:= 0;

end;

function TForm1.game_random_chance(i: integer): integer;
var a,b: integer;
begin
       //判断随机机会是否允许
   result:= ord( Game_base_random(i)= 1);
    if result= 0 then
     begin
      a:= i * 5;
      b:= i* 10;
           //智力和幸运值影响概率
       i:=a+ round(abs(1-abs((game_get_role_suxing(1,1) + game_get_role_suxing(1,7)-100)) /100) * b);
       result:= ord( Game_base_random(i)= 1);
       
     end;
end;

function TForm1.game_random_chance_at_sleep(i: integer): integer;
begin
     //判断随机机会是否允许，带延时以产生多次真随机

     sleep(1);
    result:= game_random_chance(i);
end;

function TForm1.game_rename(oldname: string): integer;
var b: boolean;
    i: integer;
    newname: string;
begin
result:= 0;
b:= false;

        newname:= inputbox('请输入一个新的姓名：','新的姓名：    ','');

   if trim(newname)= '' then
    begin
     exit;
    end else if pos('',newname)> 0 then
                 b:= true
                  else if pos('fuck',newname)> 0 then
                   b:= true
                   else if pos('kao',newname)> 0 then
                   b:= true
                   else if pos('cao',newname)> 0 then
                   b:= true
                   else if pos('靠',newname)> 0 then
                   b:= true
                   else if pos('操',newname)> 0 then
                   b:= true
                   else if pos('日你',newname)> 0 then
                   b:= true
                   else if pos('你妈',newname)> 0 then
                   b:= true
                   else if pos('鸡',newname)> 0 then
                   b:= true
                   else if pos('做爱',newname)> 0 then
                   b:= true
                   else if pos('妈的',newname)> 0 then
                   b:= true
                   else if pos('我日',newname)> 0 then
                   b:= true
                   else if pos('插',newname)> 0 then
                   b:= true
                   else if pos('你娘',newname)> 0 then
                   b:= true
                   else if pos('<!!!',newname)> 0 then
                   b:= true
                   else if pos('(',newname)> 0 then
                   b:= true
                   else if pos('（',newname)> 0 then
                   b:= true
                   else begin
                          if oldname= '' then
                            Tplayer(Game_role_list.Items[0]).plname:= trim(newname)
                             else begin  //修改其他人物的名字
                                   for i:= 0 to  Game_role_list.Count-1do
                                    begin
                                      if Tplayer(Game_role_list.Items[i]).pl_old_name= oldname then
                                       begin
                                        // if game_extfile_rename(oldname, newname) then
                                            Tplayer(Game_role_list.Items[i]).plname:= trim(newname);

                                         exit;
                                       end;
                                    end;
                                  end;
                        end;
  if b then
   messagebox(handle,'主角名字内含有不良词汇或者括号，请改正。','不好的名字',mb_ok or MB_ICONWARNING);

end;
 {

function TForm1.game_extfile_rename(oldname, newname: string): boolean;   //在人物对照表内添加新的内容
var str1: Tstringlist;
begin

     str1:= Tstringlist.Create;
     data2.Load_file_upp(ExtractFilePath(application.ExeName)+ 'persona\ext.upp',str1);

     Assert(str1.count > 0,'无效的人物对照表，修改伙伴名字失败。');

     if str1.Values[newname]<> '' then
      begin
       messagebox(handle,pchar(newname +' 已经有同名人物存在。'),'注意',mb_ok or MB_ICONWARNING);
       result:= false;
       str1.Free;
       exit;
      end;

      str1.Append(newname+ '='+ str1.Values[oldname]); //添加一行新的对照内容

      data2.save_file_upp(ExtractFilePath(application.ExeName)+ 'persona\ext.upp',str1); //保存
     str1.Free;

     result:= true;
end;
          }
function TForm1.game_checkname_abc(n: string): integer;
var i: integer;
begin
      //检查名字是否中文，参数为空表示检查主角，该函数主要是为游戏增添一点意思，
      //该函数判断第一个字节是否为中文前缀，仅此而已

result:= 0;
       if n= '' then
        n:= Tplayer(Game_role_list.Items[0]).pl_old_name;

      //名字内含有字母数字等，返回true
      for i:= 1 to length(n) do
       if ByteType(n,i)= mbSingleByte then
        begin
          result:= 1;
          exit;
        end;
end;

function TForm1.game_reload(i: integer): integer;  //重新载入当前场景
begin
   if game_auto_temp_g= 1 then
      game_auto_temp_g:= 2;  //发现有写入临时表操作的，设置重载标记
   result:= game_show_scene(pscene_id);
end;

function TForm1.game_add_message(const s: string): integer;
begin
        //添加一个提示消息
    if not Assigned(game_message_txt) then
       game_message_txt:= Tstringlist.Create;

      game_message_txt.Append(s);
result:= 1;
end;

function TForm1.game_add_task(id: integer): integer; //添加任务
begin

  //在事件记录内添加记录
   if self.game_not_res_event(id)=1 then  //事件不存在，添加，不重复添加
    begin
  self.game_add_res_event(id);
  Data2.game_addto_uncomplete(inttostr(id));//在未完成列表内添加记录
    end;

  game_reload_chatlist(0);
result:= 1;
end;

function TForm1.game_comp_task(id: integer): integer;    //完成任务
var ss: string;
   i,j,k,m,n: integer;
begin
    //完成任务
result:= 0;

    if self.game_not_res_event(id)=1 then    //如果任务事件不存在，退出
      exit;

  self.game_del_res_event(id);
  Data2.game_addto_complete(inttostr(id));

  //添加物品，金钱，经验值
   ss:= Data2.game_get_task_s(inttostr(id)); //取回具体内容

   if ss= '' then
    begin
     game_chat('读取任务失败，可能任务文件被删除。');
     exit;
    end;

j:= 0;
m:= 0;
n:= 0;
    for i:= 1 to length(ss) do
     begin
       if ss[i] in['0'..'9'] then
          begin
           if j= 0 then
             j:= i;
          end else begin
                    if (j<> 0) and (i>j) then
                     begin
                      k:= strtoint2(copy(ss,j,i-j));
                      j:= 0 ; //j恢复为零值
                      inc(m);
                       case m of
                        1: begin
                            game_write_values(0,0,game_read_values(0,0) +k); //添加金钱
                            game_chat('金钱增加：'+ inttostr(k));
                           end;
                        2: begin
                            game_write_values(0,19,game_read_values(0,19) +k);
                             //添加
                             game_chat('经验值增加：'+ inttostr(k));
                             k:= form_pop.game_upgrade(1);
                             if k> 0 then
                              game_chat('等级提升到：'+ inttostr(k));
                           end;
                        3: n:= k; //物品数量
                        end;
                     end;
                   end;

     end; //end for

     if n> 0 then
      begin
        j:= pos('“',ss);
        k:= pos('”',ss);
        if (j>0) and (k>j) then
         begin
           write_goods_number(form_goods.get_goods_id(copy(ss,j+2,k-j-2)),n);
            game_chat('得到物品'+copy(ss,j+2,k-j-2)+' 数量：'+ inttostr(n));
         end;
      end;
      game_write_values(0,ord(g_morality),game_read_values(0,ord(g_morality)) +1);
     //增加道德值一点
 game_reload_chatlist(0);
 result:= 1;
end;

function TForm1.game_create_guid: string;
 var g: tguid;
begin
     CoCreateGUID(g);
   result:= GUIDToString(g);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if game_role_list.Count=0 then
  begin
   messagebox(handle,'游戏没有开始，请点击上面的“开始单机游戏”或者“开始联网游戏”来进入游戏或者存取进度。','游戏没开始',mb_ok);
   exit;
  end;

  if not Assigned(form_task) then
     form_task:= Tform_task.Create(application);

     form_task.ShowModal;
end;

procedure TForm1.Game_scr_clean3;   //清屏并打几个点

begin
      change_html_by_id('cell_chat1','……');

  game_chat_cache_g:= ''; //清空聊天缓存

end;

procedure TForm1.button_stat(b: boolean);
begin
    button1.Enabled:= b;
  button5.Enabled:= b;
end;

procedure TForm1.change_html_by_id(const id, html: string);
var ss: string;
begin
   ss:= StringReplace(html,'\','/',[rfReplaceAll]);
   ss:= StringReplace(ss,'"','\"',[rfReplaceAll]);
   ss:= StringReplace(ss,#13#10,'',[rfReplaceAll]);
   ss:= 'document.getElementById("'+id+ '").innerHTML="'+ss+'";';



   web1.ExecuteJavascript(ss);
end;

function TForm1.game_check_goods_nmb(n: string; i: integer): integer;
var j: integer;
begin
       //检查某物品数量是否有几个，有，返回 1
     if n= '' then
      result:= 0
       else begin
              j:= form_goods.get_goods_id(n);
              if j= 0 then
               result:= 0
                else if read_goods_number(j)>= i then
                        result:= 1
                         else
                          result:= 0;
            end;

end;

procedure TForm1.temp_event_clean;
begin
   Game_migong_xishu:= 0; //清除怪物攻击系数
   Game_temp_event.Clear;
end;

function TForm1.game_check_temp(id, values: integer): integer;
begin
 //比较事件，看是否大于等于指定值
  if Game_temp_event.Values[inttostr(id)]= '' then
     result:= 0
      else if strtoint2(Game_temp_event.Values[inttostr(id)]) >= values then
       result:= 1
        else result:= 0;
end;

function TForm1.game_read_temp(id: integer): integer;
begin
  // 读取事件的值，不存在，返回0
   if Game_temp_event.Values[inttostr(id)]= '' then
     result:= 0
      else
       result:= strtoint2(Game_temp_event.Values[inttostr(id)]);
end;

function TForm1.game_write_temp(id, values: integer): integer;
begin
  //写入一个临时事件,id是事件名，values是事件内容
  game_auto_temp_g:= 1; 
  Game_temp_event.Values[inttostr(id)]:= inttostr(values);
  result:= 1;
end;

function TForm1.game_can_stop_chat(i: integer): integer;
begin
//1,可以结束聊天  0, 禁止结束聊天（用于必须进行下去的对话)
     //属性值 8 为禁止结束聊天
  if i= 0 then
   begin
   Game_scene_type_G:= Game_scene_type_G or 8;
    button3.Enabled:= false;
   end else begin
             Game_scene_type_G:= Game_scene_type_G and not 8;
             button3.Enabled:= true;
            end;
            
 game_enabled_scene(i);
result:= 1;
end;


function TForm1.game_enabled_scene(i: integer): integer;
var
    ss: string;
begin


     // 1,激活场景窗口，0，禁用场景窗口
    if i= 1 then
     begin
      game_reload_direct(0);

     end else begin
                 ss:= 'var div=document.createElement("<div style=width:100%;background:#cccccc;position:absolute;left:0;right:0;top:0;bottom:0;-moz-opacity:0.5;filter:alpha(opacity=50);z-index:63;height:100%;>");'+
                  'var iframe=document.createElement("<iframe style=width:100%;background:#cccccc;position:absolute;left:0;right:0;top:0;bottom:0;-moz-opacity:0.5;filter:alpha(opacity=50);z-index:62;height:100%;>");'+
                  'document.getElementsByTagName("body")[0].appendChild(iframe);'+
                  'document.getElementsByTagName("body")[0].appendChild(div);';
                web1.ExecuteJavascript(ss);
              { tt:= pdoc.createElement('div');
               tt.id:= 'sce_1';
               tt.style.backgroundColor:= clblue;
               tt.style.zIndex:= 2;   }

              // <script>
 // function   test()
  {
    var   div   =   document.createElement("<div   class='dis'   oncontextmenu='return   false;'>");
    var   iframe   =   document.createElement("<iframe   class='dis'   style='z-index:8;'>");
    document.getElementsByTagName("body")[0].appendChild(iframe);
    document.getElementsByTagName("body")[0].appendChild(div);
  }   
 // </script>
               //  (pdoc.body as DispHTMLGenericElement).appendChild(tt);
              // tt.parentElement:= pdoc.body;

              // (WebBrowser1.Document as IHTMLDocument2).body.all
             //  (WebBrowser1.Document as IHTMLDocument3).getElementsByTagName('body').appendChild(
                                               

              // (WebBrowser1.Document as IHTMLDocument3).getElementsByTagName('body').item[0].appendChild(
                             //    pdoc.createElement('iframe');
              end;

 result:= 1;
end;

function TForm1.game_functions_m(const s: string): integer;
var i,p_pos,p_end,j,k: integer;
    ss,ss_result: string;
     function get_L_integer(i_pos: integer): integer;
      var i9: integer;
      begin
        get_L_integer:= 0;
        for i9:= I_pos downto 1 do
         begin
          if not (ss[i9] in ['0'..'9','-']) then
            begin
             get_L_integer:= strtoint2(copy(ss,i9+ 1,I_pos-i9));
             break;
             end;
           if i9= 1 then
              get_L_integer:= strtoint2(copy(ss,1,I_pos));
         end;
      end; //end function
     function get_R_integer(i_pos: integer): integer;
      var i9: integer;
      begin
        get_R_integer:= 0;
        for i9:= I_pos to length(ss) do
         begin
          if not (ss[i9] in ['0'..'9','-']) then
            begin
             get_R_integer:= strtoint2(copy(ss,i_pos,i9-i_pos));
             break;
             end;
           if i9= length(ss) then
              get_R_integer:= strtoint2(copy(ss,i_pos,length(ss)));
         end;
      end; //end function
     procedure set_space(i_pos: integer; v: char); //设置其余位为空格，最后一位置值
       var i9: integer;
      begin
         ss[i_pos]:= ' ';
        for i9:= I_pos-1 downto 1 do
          if ss[i9] in ['0'..'9'] then
             ss[i9]:= ' '
             else break;

        for i9:= I_pos+1 to length(ss) do
         begin
            if ss[i9] in ['0'..'9'] then
            ss[i9]:= ' '
             else begin
                   ss[i9-1]:= v;
                   break;
                  end;
            if i9= length(ss) then
               ss[i9]:= v;
         end;
      end;
      procedure set_space_insert(i_pos: integer; v: integer); //设置其余位为空格，最后一位插值
       var i9: integer;
      begin
       ss[i_pos]:= ' ';
        for i9:= I_pos-1 downto 1 do
          if ss[i9] in ['0'..'9','-'] then
             ss[i9]:= ' '
             else break;

        for i9:= I_pos+1 to length(ss) do
         begin
            if ss[i9] in ['0'..'9','-'] then
            ss[i9]:= ' '
             else begin
                   insert(inttostr(v),ss,i9-1);
                   break;
                  end;
            if i9= length(ss) then
               insert(inttostr(v),ss,i9);;
         end;
      end;
     procedure ccc(L: integer);
      var i8: integer;
      begin
        for i8:= L to length(ss) do //首先处理not符
          begin
            case ss[i8] of
            '!': begin
                if ss[I8+ 1]='0' then
                    ss[I8+ 1]:='1'
                     else
                      ss[I8+ 1]:= '0';
                 ss[I8]:= ' ';
                 end;
            '*': begin
                  set_space_insert(i8, get_L_integer(I8-1) *
                                       get_R_integer(I8+1));
                 end;
            '/': begin
                  set_space_insert(i8, get_L_integer(I8-1) div
                                       get_R_integer(I8+1));
                 end;
            ')': begin
                   break;
                 end;
              end;
          end;

         ss:= stringReplace(ss, ' ', '', [rfReplaceAll]);  //过滤空格

          for i8:= L to length(ss) do //再处理 and or
          case ss[I8] of
            '+': begin
                  set_space_insert(i8, get_L_integer(I8-1) +
                                       get_R_integer(I8+1));
                 end;
            '-': begin
                  set_space_insert(i8, get_L_integer(I8-1) -
                                       get_R_integer(I8+1));
                 end;
           '&': begin  //and 判断，有一个为零，结果为零
                 if (ss[I8-1]= '1') and (ss[I8+1] = '1') then
                    ss[I8+1]:= '1'
                     else
                      ss[I8+1]:= '0';
                 ss[I8-1]:= ' ';
                 ss[I8] := ' ';
                end;
           '|': begin
                 if (ss[I8-1]='1') or (ss[I8+1]= '1') then
                    ss[I8+1]:= '1'
                     else
                      ss[I8+1]:= '0';
                 ss[I8-1]:= ' ';
                 ss[I8] := ' ';
                end;
           ')': break;
           end;

         ss:= stringReplace(ss, ' ', '', [rfReplaceAll]);  //过滤空格

        for i8:= L to length(ss) do   //最后处理 等于，不等于
          case ss[I8] of
           '<': begin
                 if get_L_integer(I8-1) < get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');

                end;
           '>': begin
                 if get_L_integer(I8-1) > get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');

                end;
           '=': begin
                 if get_L_integer(I8-1)= get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');
                end;
           '$': begin
                 if get_L_integer(I8-1)<= get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');
                end;
            '@': begin
                 if get_L_integer(I8-1) >= get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');
                end;
           '#': begin
                 if get_L_integer(I8-1)<> get_R_integer(I8+1) then
                    set_space(I8,'1')
                     else
                      set_space(I8,'0');
                end;
           ')': begin
                 ss[I8]:= ' ';
                 exit;
                end;
           end;
      end;
begin
     //一个执行参数内多函数，带or and关键字处理的
     //参数内为多个函数，可以用or and关键字，如 game_xxx(0)and game_xxx2(0)
     //把转义符^解释为单引号

ss_result:= '';
if s= '' then
 begin
  result:= 0;
  exit;
 end;
     if fastcharpos(s,'^',1)> 0 then
        ss:= stringReplace(s, '^', '''', [rfReplaceAll])
         else
           ss:= s;

      //预先计算函数返回值
         p_end:= 0;
         p_pos:= fastpos(ss,'game_',length(ss),5,1);
         while p_pos >0  do
          begin
           ss_result:= ss_result + copy(ss,p_end+1,p_pos-p_end-2);
                k:= 0; //括号配对
               for j:= p_pos to length(ss) do
                  if ss[j]= '(' then
                     inc(k)
                      else if ss[j]= ')' then
                             begin
                              dec(k);
                              if k= 0 then
                                begin
                                 p_end:= j;
                                 break; //退出for
                                end;
                             end;

              if p_end > p_pos then
               begin
                i:= Game_action_exe_A(copy(ss,p_pos,p_end-p_pos+1));
                if (i= 1881) and (pos('game_pop_a(',ss)= p_pos) then
                 begin
                   i:= 1;  //发现了game_pop_a
                   game_html_pop_str_g:= '123'; //返回一个3个字的值，对方用length=3来检测
                 end;
                 ss_result:= ss_result + inttostr(i);
               end;
           p_pos:= fastpos(ss,'game_',length(ss),5,p_end);
            if p_pos= 0 then
             begin
               if p_end < length(ss) then
                  ss_result:= ss_result + copy(ss,p_end+ 1,length(ss)-p_end);
             end;
          end; //end while
          if ss_result = '' then
             ss_result:= ss;
      //替换字符为操作符
         ss:= stringReplace(ss_result, ' ', '', [rfReplaceAll]);  //过滤空格
         ss:= stringReplace(ss, 'and', '&', [rfReplaceAll,rfIgnoreCase]);
         ss:= stringReplace(ss, 'or', '|', [rfReplaceAll,rfIgnoreCase]);
         ss:= stringReplace(ss, 'not', '!', [rfReplaceAll,rfIgnoreCase]);
         ss:= stringReplace(ss, '<>', '#', [rfReplaceAll,rfIgnoreCase]);
          ss:= stringReplace(ss, '<=', '$', [rfReplaceAll,rfIgnoreCase]);
          ss:= stringReplace(ss, '>=', '@', [rfReplaceAll,rfIgnoreCase]);
         ss:= stringReplace(ss, ';', '', [rfReplaceAll]);

        if length(ss)= 1 then //如果值只有一位，那么无须下一步处理
         begin
          result:= strtoint2(ss);  //返回
          exit;
         end;
      //括号处理
       for i:= length(ss) downto 1 do
        begin
          if ss[i]= '(' then
            begin
              ss[i]:= ' ';
              ccc(i + 1);
              ss:= stringReplace(ss, ' ', '', [rfReplaceAll]);  //过滤空格
            end;
        end;

          for i:= 0 to 10 do
           if length(ss)> 1 then
            ccc(1); //处理括号外的符号

         ss:= trim(ss);  //过滤空格

         if length(ss)<> 1 then
         result:= 0
         else
          result:= strtoint2(ss);  //返回


end;

function TForm1.game_role_is_exist(n: string): integer;
var i: integer;
begin
                 //如果这个人物存在，返回 1
result:= 0;

   for i:= 0 to Game_role_list.Count-1 do
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
        result:= 1;
        exit;
      end;

end;

function TForm1.game_set_role_0_hide(n: string; x: integer): integer;
var i: integer;
begin
        //设置隐藏，显示某个人物。手动隐藏的人物，需手动显示
        //因为隐藏与否，只是在战斗时是否显示而已，对话还是按场景文件来的。
        //主角的 n= 无名
result:= 1;

   for i:= 0 to Game_role_list.Count-1 do
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
        game_write_values(i,4, x);
        exit;
      end;



end;

function TForm1.game_role_only_show(n: string): integer; //仅显示此人，隐藏其他全部
var i: integer;
begin
  
  for i:= 0 to Game_role_list.Count-1 do
   begin
    game_write_values(i,29,
                game_read_values(i,4)); //保存原先的状态
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
        game_write_values(i,4,1);
      end else
           game_write_values(i,4,0);
   end; //end for

  Game_is_only_show_G:= true; //设置only show 标志，供goods窗口判断
 result:= 1;
end;

function TForm1.game_role_reshow: integer;  //恢复隐藏人物的显示
var i: integer;
begin
  for i:= 0 to Game_role_list.Count-1 do
    game_write_values(i,4,
                game_read_values(i,29)); //恢复原先的状态

    Game_is_only_show_G:= false; //恢复 only show 标志
result:= 1;
end;

function TForm1.game_bet(id, flag: integer): integer;
var m: integer;
begin
        //赌钱，参数为一个临时表id和押大小，1大，0小。赢了返回 1
result:= 0;

    m:= game_read_temp(id);  //取得押的金额
    if m= 0 then
     begin
      m:= game_read_values(0,0);
      game_write_temp(id,m);
     end;
    if game_pop(1)= 1 then
       begin

     if flag= 1 then
      begin
       //押大
       if Game_base_random(3)= 1 then   //赢的机会是三分之一
          result:= 1;
      end else begin
                 if Game_base_random(3)= 0 then
                    result:= 1;
               end;

       end;

      //赢了，金钱增加
    if result= 1 then
       game_write_values(0,0,
            game_read_values(0,0) + m)
            else
             game_write_values(0,0,
            game_read_values(0,0) - m);

end;

function TForm1.game_read_temp_string(id: integer): pchar;
begin

        Game_pchar_string_G:= Game_temp_event.Values[inttostr(id)];
        if Game_pchar_string_G='' then
           Game_pchar_string_G:= ' ';

        result:= pchar(Game_pchar_string_G);

end;

function TForm1.game_write_temp_string(id: integer; const values: string): integer;
begin
  game_auto_temp_g:= 1;
  Game_temp_event.Values[inttostr(id)]:= values;
  result:= 1;
end;

function TForm1.game_check_role_values(n: string; i, v: integer): integer;
var j: integer;
begin
       //检查某个人物的某属性值是否达到某值
result:= 0;
     for j:= 0 to game_get_role_H do
      begin
       if Tplayer(Game_role_list.Items[j]).pl_old_name= n then
        begin
          if game_read_values(j,i)>= v then
           begin
            result:= 1;
            exit;
           end;
        end;

      end; //end for
end;

function TForm1.game_newname_from_oldname(const n: string): pchar;
var i: integer;
begin

result:= pchar(n); //如果没有找到，那么返回原名

      for i:= 0 to Game_role_list.Count-1 do
      if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
        begin
         Game_pchar_string_G:= Tplayer(Game_role_list.Items[i]).get_name_and_touxian;
          result:= pchar(Game_pchar_string_G);
          exit;
        end;

        //根据原始名来获取新的人物名称，因为游戏允许玩家修改主角和配角的名称


end;

function TForm1.game_pop_a(i: integer): integer;
begin
        //弹出背单词窗口，带动画效果
  if checkbox1.Checked then //调试模式，直接路过
      begin
       result:= 1;
       exit;
      end;

         if game_at_net_g and (game_player_head_G.duiwu_dg= 1) and (game_page_from_net_g= false) then
           begin
               //=0队员，自由模式，=1队员受限模式，=2，队员，仅战斗跟随
            //受限模式下，队员不能自己弹出窗口
            game_chat('您现在是完全跟随领队模式，不能自由行动。<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">更改设置</a>');
             result:= 0;
            exit;
           end;

    form_pop.game_pop_count:= i;
    form_pop.game_is_a:= true;
    form_pop.game_pop_type:= 1; //背单词
    if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(2, i,0);

    if (game_bg_music_rc_g.mg_pop=false) and (Game_scene_type_G and 2=2) then
     begin

        html_pop(i); //迷宫内启用html模式的弹出背单词窗口
        result:= 1881;  //1881,约定的指令返回值

     
     end else
          result:= ord (form_pop.ShowModal= mrok);
   Perform($000B, 1, 0);
  // RedrawWindow(self.WebBrowser1.Handle, nil, 0, RDW_FRAME + RDW_INVALIDATE + RDW_ALLCHILDREN + RDW_NOINTERNALPAINT);
end;
   {
function   TForm1.WBLoadFromStream(const   AStream:   TStream;   WB:   TWebBrowser):   HRESULT;
  var
      PersistStream:   IPersistStreamInit;
  begin

        try
      PersistStream   :=   WB.Document   as   IPersistStreamInit;
      PersistStream.InitNew;
      AStream.seek(0,   0);
     // (WB.Document   as   IPersistStreamInit).Load(nil);
      Result   :=   (WB.Document   as   IPersistStreamInit).Load(TStreamadapter.Create(AStream));
       finally
      PersistStream._Release;
      PersistStream := nil;
       end;
  end;
       }
function TForm1.game_change_money(i: integer): integer; //修改金钱
begin
   game_write_values(0,0,
            game_read_values(0,0) + i);

  result:= 1;
end;

function TForm1.game_direct_page(id: integer): integer; //直接读入html，忽略脚本和转场效果，并聊天清屏
begin
        if game_at_net_g and (game_player_head_G.duiwu_dg= 1) and (game_page_from_net_g= false) then
           begin
               //=0队员，自由模式，=1队员受限模式，=2，队员，仅战斗跟随
            //受限模式下，队员不能自己弹出窗口
            game_chat('您现在是完全跟随领队模式，不能自由行动。<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">更改设置</a>');
             result:= 0;
            exit;
           end;

     Game_scr_clean2; //聊天窗口清屏
  game_direct_scene(id);
  result:= 1;
end;

function TForm1.game_direct_scene(id: integer): integer; //直接读入html，忽略脚本和转场效果
var str1: Tstringlist;

begin
  str1:= Tstringlist.Create;
  Game_action_list.Clear; //清除动作
  Game_chat_list.Clear;

      game_page_id_change(id);//保存场景id

      game_tianqi_G:= 0;  //设置战斗，背单词天气效果为自动
    data2.load_scene(inttostr(id),str1); //拆分出场景html

    if not game_reload_chat_g then  //如果仅重载聊天记录，则不动作
    begin
    web1.LoadHTML(str1.Text);
    end;

  str1.Free;
result:= 1;

end;

function TForm1.game_reload_direct(i: integer): integer; //忽略脚本和转场效果的重新载入当前页面
begin
   if game_auto_temp_g= 1 then
      game_auto_temp_g:= 2;  //发现有写入临时表操作的，设置重载标记
      
   Game_is_reload:= true; //忽略载入前后脚本的执行
   result:= game_direct_scene(pscene_id);

   if game_chat_cache_g<> '' then
     begin
      if pos('<iframe',game_chat_cache_g)> 0 then
         game_chat_cache_g:= ''
         else
          game_chat(game_chat_cache_g); //重新显示聊天语句
     end;
end;

function TForm1.game_read_scene_string(id: integer): pchar;
begin
     //从场景表读取字符串
     Game_pchar_string_G:= data2.game_memini_event.ReadString('EVENTS',inttostr(id),'');
   result:= pchar(Game_pchar_string_G);
end;

function TForm1.game_write_scene_string(id: integer;
  const values: string): integer;
begin
     //写入字符串到场景表
  Game_not_save:= true;
  data2.game_memini_event.WriteString('EVENTS',inttostr(id),values);
  result:= 1;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin

  form_langdu.CheckBox1.Checked:= game_bg_music_rc_g.yodao_sound;
 form_langdu.Show;
end;

procedure TForm1.Button13Click(Sender: TObject);
var ss: string;
begin
{$IFDEF game_downbank}
    // ss:= 'url.dll,FileProtocolHandler http://www.downbank.cn';
     ss:= 'http://www.downbank.cn';
   {$ELSE}
      ss:= 'http://tieba.baidu.com/f?ie=utf-8&kw=%E7%A5%9E%E9%95%9C%E4%BC%A0%E8%AF%B4';

    // ss:= 'url.dll,FileProtocolHandler http://hi.baidu.com/3030/blog/item/41bd36d19aa47b3a9b502783.html';
  {$ENDIF}

ShellExecute(Handle,
              'open',pchar(ss),nil,nil,sw_shownormal);
              
{ShellExecute(Handle,
  'open','rundll32.exe',
  pchar(ss),nil,sw_shownormal);}

end;

function TForm1.game_role_count(c: integer): integer;
begin
    //查询人物数，参数为零，返回人物数，参数非零，进行比较。如果大于等于c，返回1，否则返回零
    if c= 0 then
     result:= Game_role_list.Count
      else begin
       if Game_role_list.Count >= c then
          result:= 1
           else
            result:= 0;
       end;

end;

function TForm1.game_role_sex_count(x: integer): integer;
var i: integer;
begin
       //返回指定性别的人物数，参数1为男，0为女
result:= 0;

    for i:= 0 to Game_role_list.Count - 1 do
        begin
          if game_read_values(i,12)= x then
             inc(result);
        end; //end for i

end;

function TForm1.game_get_newname_at_id(x: integer): pchar;  //根据序列号返回新的名字，1为第一个，2为第二个
begin
if x<=0 then
x:= 1;


        if Game_role_list.Count >= x then
           Game_pchar_string_G:= Tplayer(game_role_list.Items[x-1]).get_name_and_touxian
           else
             Game_pchar_string_G:= ' ';

result:= pchar(Game_pchar_string_G);


end;

procedure TForm1.game_write_home_id;
begin
  //当前显示的场景id保存为回成点
    Phome_id:= pscene_id;
end;

function TForm1.game_goto_home(i: integer): integer;
begin
   //回城
   if (Game_scene_type_G and 8 = 8) or timer1.Enabled or Game_not_gohome_G then  //不允许结束对话，或者定时器环境下，不允许回城
    begin
     if i= 0 then
       messagebox(handle,'回城失败，当前环境不允许回城。','回城失败',mb_ok);
     result:= 0;
    end else begin
   if Phome_id= 0 then
    result:= 0
    else begin
          game_page(Phome_id);
          result:= 1;
         end;
            end;
end;

function TForm1.game_attribute_change(p, id, v: integer): integer;
var i: integer;
begin
 result:= 1;
     //修改属性值，第一个参数，角色，0表示全体,1表示第一个人物，2第二个，第二个参数属性编号，第三个参数，加减值

   if p= 0 then
    begin
     for i:= 0 to game_get_role_H do
        begin
           game_write_values(i,id,game_read_values(i,id) +v);
           if game_read_values(i,id)< 0 then
              game_write_values(i,id,0);

        end;
    end else begin
              if p<= game_get_role_H+1 then
               begin
                 game_write_values(p-1,id,game_read_values(p-1,id) +v);
                 if game_read_values(p-1,id)< 0 then
                     game_write_values(p-1,id,0);
               end  else
                  result:= 0;
             end;
end;

function TForm1.game_id_is_name(id: integer; n: string): integer; //看id是否等于指定人物，参数id为当前role列表的序列号+1
begin
   if Game_role_list.Count < id then
           result:=0
           else begin
                 if n=  Tplayer(game_role_list.Items[id-1]).pl_old_name then
                     result:= 1
                      else
                       result:= 0;
                end;
end;

function TForm1.game_goods_change_n(n: string; values: integer): integer; //通过物品名修改物品数量
var id: integer;
begin
    if values> 255 then
      values:= 1;

  id:= form_goods.get_goods_id(n);
  if id> 0 then
   begin
  Game_not_save:= true;

        write_goods_number(id, values);
  result:= 1;
  end else result:= 0;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  popupmenu3.Popup(button6.ClientOrigin.X,button6.ClientOrigin.Y+button6.Height);
 // popupmenu3.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure TForm1.N20Click(Sender: TObject);
begin
    //从队伍踢出一个朋友
 if Game_role_list.Count= 0 then
   begin
    messagebox(handle,'游戏还没开始，请先点击屏幕上的“开始游戏”链接。','游戏没开始',mb_ok);
    exit;
   end;

 if combobox2.ItemIndex >= 0 then
   begin
    if messagebox(handle,'是否把：从队伍中踢出，警告：并非每个人物都有缘分在后续的游戏中再次碰到。',
        '踢出人物',mb_yesno or MB_ICONQUESTION)= mryes then
         game_del_friend(combobox2.Items.Strings[combobox2.ItemIndex],1);
   end else begin
             messagebox(handle,'请在左边伙伴列表内选择一个。','请选择',mb_ok or MB_ICONWARNING);
            end;

end;

function TForm1.game_sex_from_id(id: integer): integer;
begin
  if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_sex));
                end;
end;

function TForm1.game_get_blood_h(id: integer): integer;
begin
 if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_gdsmz27));
                end;
end;

function TForm1.game_get_blood_l(id: integer): integer;
begin
 if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_life));
                end;
end;

function TForm1.game_get_ling_h(id: integer): integer;
begin
  if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_gdll26));
                end;
end;

function TForm1.game_get_ling_l(id: integer): integer;
begin
  if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_lingli));
                end;
end;

function TForm1.game_get_ti_h(id: integer): integer;
begin
  if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_gdtl25));
                end;
end;

function TForm1.game_get_ti_l(id: integer): integer;
begin
  if Game_role_list.Count < id then
           result:=0
           else begin
                 result:= game_read_values(id-1,ord(g_tili));
                end;
end;

procedure TForm1.N17Click(Sender: TObject);
begin
 if Game_role_list.Count= 0 then
   begin
    messagebox(handle,'游戏还没开始，请先点击屏幕上的“开始游戏”链接。','游戏没开始',mb_ok);
    exit;
   end;
  if combobox2.ItemIndex >= 0 then
   begin
    game_pop_love(20,combobox2.Items.Strings[combobox2.ItemIndex]);
   end else begin
             messagebox(handle,'请在左边伙伴列表内选择一个。如果列表为空，表明你没有开始游戏或者在游戏内还没加入队员，队员可在小镇上找到。','请选择',mb_ok or MB_ICONWARNING);
            end;

end;

procedure TForm1.N19Click(Sender: TObject);
begin
 if Game_role_list.Count= 0 then
   begin
    messagebox(handle,'游戏还没开始，请先点击屏幕上的“开始游戏”链接。','游戏没开始',mb_ok);
    exit;
   end;

 if combobox2.Items.Count= 0 then
   begin
    messagebox(handle,'您的队伍内目前没有队员，这个是和您队伍内的队员对话用的。','请选择',mb_ok or MB_ICONWARNING);

   exit;
   end;
 if ComboBox2.Tag < combobox2.Items.Count then
    combobox2.ItemIndex:= ComboBox2.Tag;

 if combobox2.ItemIndex >= 0 then
   begin
    if game_at_net_g then
     begin
       game_show_chat(game_read_values(combobox2.ItemIndex,34));

     end else
          game_talk(combobox2.Items.Strings[combobox2.ItemIndex]);
   end else begin
             messagebox(handle,'请在左边伙伴列表内选择一个人物。本按钮只能和队伍内的成员聊天，如果你在上面场景内点击了一个其他人物，那么看看下面的窗口是否已经出现了聊天语句？','请选择',mb_ok or MB_ICONWARNING);
        end;
end;

function TForm1.game_check_money(v: integer): integer;   //比对金钱，如果大于等于 v 返回 1
begin

   if  game_read_values(0,ord(g_money)) >= v then
      result:= 1
      else
       result:= 0;

end;

procedure TForm1.game_script_message(var msg: TMessage); //自定义消息，载入场景后运行
begin

   if msg.WParam= 29 then //载入场景后运行
    if (game_at_net_g=false) or (game_player_head_G.duiwu_dg<>1) then
     Game_action_exe_S_adv(Game_script_scene_after); //执行函数和语句，可带if then

   if msg.WParam= 30 then
     game_cmd_execute(Game_script_scene_G);

   if msg.WParam= 31 then
     if (game_at_net_g=false) or (game_player_head_G.duiwu_dg<>1) then
     Game_action_exe(Game_script_scene_G);

   if msg.WParam= 32 then     //点击链接时执行
     Game_action_exe_S_adv(Game_script_scene_G);

   if msg.WParam= 33 then
     Game_action_exe_S_adv(Game_script_scene_G);

   if msg.WParam= 34 then
     game_show_scene(strtoint2(Game_script_scene_G));

   if msg.WParam= 35 then
      form_net_set.ShowModal;

   if msg.WParam= 36 then
     begin
     Game_action_exe_S_adv(game_html_pop_str_g);  //html模式的pop背单词的后续命令
      game_html_pop_str_g:= ''; //清空此内容
     end;
   if msg.WParam= 37 then
     begin
      show_ad_error;
     end;

   if (msg.WParam= 1086) or (msg.WParam= 1087) then
    begin
      //表示当前场景需要更新
       if msg.WParam= 1087 then
         Game_show_error_image_G:= true;  //1087表示下载失败

      if msg.LParam= pscene_id then
         game_reload_direct(0)
         else if msg.LParam= pscene_id * 2 then //乘以2表示背景图片
                 game_reload(0);

    end;

    

end;

function TForm1.game_pop_fight_a(i, i2: integer): integer;  //带动画启动窗口的战斗
begin
   if checkbox1.Checked then //调试模式，直接路过
      begin
       result:= 1;
       exit;
      end;

       if game_at_net_g and ((game_player_head_G.duiwu_dg= 1) or ((game_player_head_G.duiwu_dg= 2))) and (game_page_from_net_g= false) then
           begin
               //=0队员，自由模式，=1队员受限模式，=2，队员，仅战斗跟随
            //受限模式下，队员不能自己弹出窗口
            game_chat('您现在是完全跟随队长或者打怪跟随，不能自由行动。<a href="game_show_dwjh('+inttostr(my_s_id_g)+',0)">更改设置</a>');
             result:= 0;
            exit;
           end;

 if i< 1 then
    i:= 1;

      form_pop.game_pop_count:= i;
  form_pop.game_pop_type:= 3; //战斗
  form_pop.game_is_a:= true;   //带动画启动
  form_pop.game_monster_type:= i2;  //怪物种类

    if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(4, i,i2);

     result:= ord( form_pop.ShowModal= mrok);
     
   Perform($000B, 1, 0);  //重新刷新屏幕，不然win10下面会有残留的画线
   //重画屏幕的代码先不用试试看
  // RedrawWindow(self.WebBrowser1.Handle, nil, 0, RDW_FRAME + RDW_INVALIDATE + RDW_ALLCHILDREN + RDW_NOINTERNALPAINT);

end;

function TForm1.game_read_scene_integer(id: integer): integer; //从scene事件表读取一个值
begin
  result:= data2.game_memini_event.ReadInteger('EVENTS',inttostr(id),-1);
  if result= -1 then
  begin
   if game_at_net_g then
       begin
        //联网时，如果为-1，则从网络获取
         result:= wait_scene_int_bool(false,id);
        data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),result);
        
       end else result:= 0;
  end;

end;

function TForm1.game_write_scene_integer(id, v: integer): integer; //往scene事件表写入一个值
begin
  if (id < 1001) and (game_at_net_g=false) then
   begin
     messagebox(handle,'错误，事件编号1000及以下为系统保留，请使用1000以上。','错误',mb_ok or MB_ICONERROR);
     result:= 0;
   end else begin
            Game_not_save:= true;
            if Assigned(data2.game_memini_event) then
            data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),v);
            if game_at_net_g then  //如果游戏处于联网状态，那么同时写入一个记录事件到物品表，因为物品事件表在网络下不用
             begin
               //发送事件
               Data_net.send_scene_integer(id,v);
             end;
            result:= 1;
            end;
end;

function TForm1.game_integer_comp(i1: integer; c: string;
  i2: integer): integer;
begin
               //对i1和i2进行比较，c可取比较符号如 =,>,<
result:= 0;

   if c= '=' then
     result:= ord(i1= i2)
      else if c= '>' then
       result:= ord(i1 > i2)
        else if c= '<' then
       result:= ord(i1 < i2)
        else if c= '<>' then
       result:= ord(i1 <> i2)
        else if c= '>=' then
       result:= ord(i1 >= i2)
        else if c= '<=' then
       result:= ord(i1 <= i2);

end;

procedure TForm1.game_reset_role_chatid; //人物聊天id清零
var i: integer;
begin
  for i:= 1 to Game_role_list.Count-1 do
        if Assigned(game_role_list.Items[i]) then
              begin
               game_write_values(i,22,0);
               game_write_values(i,23,0);
                 //22号记录，当前谈话前后文
                //谈话快速索引
               Tplayer(game_role_list.Items[i]).pltalkchar1:= #0;
               Tplayer(game_role_list.Items[i]).pltalkchar2:= #0;  //层次数据
               Tplayer(game_role_list.Items[i]).pltalkchar3:= #0;
               Tplayer(game_role_list.Items[i]).pltalkchar4:= #0;
               Tplayer(game_role_list.Items[i]).pltalkchar5:= #0;
              end;
end;

function TForm1.game_chat_cleans(i: integer): integer; //聊天窗口清屏
begin
  Game_scr_clean2;
  result:= 1;
end;

procedure TForm1.ComboBox2Select(Sender: TObject);
begin
   ComboBox2.Tag:= combobox2.ItemIndex;
  // Button_talk.Enabled:= true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//FDocHostUIHandler.Free;
 if Assigned(kill1) then
   if TerminateThread(kill1.Handle,0) then
      kill1.Free;

game_save_doc_net; //保存联网游戏内容

 UnregisterHotKey(Handle, GlobalAddAtom('wordgame_H'));
   GlobalDeleteAtom(GlobalAddAtom('wordgame_H')); //删除全局标识

   if game_debug_handle_g<> 0 then
      sendmessage(game_debug_handle_g,stop_c,88,0); //调试时发送中断消息
      
 Shell_NotifyIcon(NIM_DELETE, @MyTrayIcon);//删除托盘图标
end;
   (*
procedure TForm1.WebBrowser1NavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
{var
hr: HResult;
CustDoc: ICustomDoc; }
begin
   if pos('finer2', (pDisp as IWebbrowser2).LocationURL)> 0 then
    IEEvents1.ConnectTo(pDisp as IWebbrowser2);
{
hr := WebBrowser1.Document.QueryInterface(ICustomDoc, CustDoc);
if hr = S_OK then
CustDoc.SetUIHandler(FDocHostUIHandler); }

 
end;
 *)

procedure TForm1.OnAccept(const URL: String; var Accept: Boolean);
begin
 Accept:= true;
end;

procedure TForm1.OnContent(const url: String; var Stream: TStream);
begin
  //给自定义协议输送数据内容
  game_pic_from_text(stream,url);
end;
function min(arg1,arg2:integer):integer;
begin
    if arg1 < arg2 then
      result  := arg1
    else
      result := arg2;
end;
function max(arg1,arg2:integer):integer;
begin
    if arg1 < arg2 then
      result  := arg2
    else
      result  := arg1;
end;
//浮雕效果
procedure EmbossClick(BMP: Tbitmap);
var
   i, j: integer;
   p1, p2: pbyteArray;
   Value: integer;

begin

   for i := 0 to bmp.Height - 2 do
      begin
         p1 := Bmp.ScanLine[i];
         p2 := Bmp.ScanLine[i + 1];
         for j := 0 to Bmp.Width - 1 do
            begin
               Value := (p1[3 * j + 2] - p2[3 * j + 2]) + 156;
               p1[3 * j + 2] := Min(255, Max(0, Value));
               Value := p1[3 * j + 1] - p2[3 * j + 1] + 156;
               p1[3 * j + 1] := Min(255, Max(0, Value));
               Value := p1[3 * j] - p2[3 * j] + 156;
               p1[3 * j] := Min(255, Max(0, Value));
            end;
      end;
end;
// 直接缩放到给定大小 
function GDIBitmapGetThumbnailImage(Bmp:TGPBitmap;Width,Height:integer):TGPBitmap;
begin 
  Result:=TGPBitmap(Bmp.GetThumbnailImage(Width,Height));
end;

// 按居中与否，画 GDI+ 图形到 Delphi 的画布对象上 
procedure DrawGDIBitmapToCanvas(Canvas:TCanvas;Bmp:TGPBitmap;Center:Boolean); 
var 
Graphics:TGPGraphics; 
W,H:cardinal;
begin 
if Canvas.Handle<>0 then 
begin 
  Graphics:=TGPGraphics.Create(Canvas.Handle); 
  if Center then 
   begin 
    W:=Canvas.ClipRect.Right-Canvas.ClipRect.Left;
    H:=Canvas.ClipRect.Bottom-Canvas.ClipRect.Top;
    Graphics.DrawImage(Bmp,(W-Bmp.GetWidth) shr 1,(H-Bmp.GetHeight) shr 1,Bmp.GetWidth,Bmp.GetHeight);
   end 
  else 
    Graphics.DrawImage(Bmp,0,0); 
  Graphics.Free; 
end; 
end; 

function LockedFile(const Fn: string): Boolean;  //判断文件是否锁定
var 
AFile: THandle; 
SecAtrrs: TSecurityAttributes; 
begin 
FillChar(SecAtrrs, SizeOf(SecAtrrs), #0); 
SecAtrrs.nLength := SizeOf(SecAtrrs); //结构体长度 
SecAtrrs.lpSecurityDescriptor := nil; //安全描述 
SecAtrrs.bInheritHandle := True; //继承标志 
AFile := CreateFile(PChar(Fn), GENERIC_READ or GENERIC_WRITE, 
FILE_SHARE_Read, @SecAtrrs, OPEN_EXISTING, 
FILE_ATTRIBUTE_Normal, 0); 
if AFile = INVALID_HANDLE_VALUE then 
begin 
Result := True; //文件被锁定
//showmessage(SysErrorMessage(GetLastError));
end 
else begin
      CloseHandle(afile);
       Result := False;
      end;
end;

procedure TForm1.game_pic_from_text(Stream: TStream; s: string; path: string='');  //根据字符串返回图片数据
var aafont: TAAFontEx;
    bmp,bmp2 : TBitmap;
    text_e,w,h: integer; //文字效果
    afont: Tfont;
    acolor: Tcolor;
    atouming,afudiao,jpg_pos: integer;
    axiaoguo,atext,ss: string;
    sBlendFunction: BlendFunction; // 这是Alpha混合时需要的一个类型参数
    apos: integer; //是否输出文字时绝对定位
    apos_w,apos_h: integer; //绝对定位的位置
    apos_string: string;
    jpg: Tjpegimage;
    gdibmp: Tgpbitmap;
    aw,ah: integer;
    filestr: TMemoryStream;
    label pp;
begin
     {
          flag
          1000 无效果
          1001  轮廓
          1002  噪音
          1003  模糊
          1004  渐变
          1005  半透明
          1006  向右上倾斜
          1007  向右下倾斜
          1008  阴影
         }

   text_e:= fastpos(s,'://',length(s),3,1);
  if (text_e > 0) and (text_e < 9) then
     delete(s,1,text_e+ 2);  //删除字符串前面的多余gpic标志

    s:=StringReplace(s, '%20', ' ', [rfReplaceAll]); //%20 替换为空格

    if (length(s)< 50) and (length(s)> 0) then
     begin
      //单纯载入文件，文件不存在的，从指定页面下载
      if  Game_error_count_G < 100 then
      begin
      while s[length(s)]= '/' do
         delete(s,length(s),1);

       if FileExists(Game_app_img_path_G + s) then
        begin
        s:= Game_app_img_path_G + s;
         if LockedFile(s) then  //文件锁定
            s:= game_app_path_G + 'img\space'+ ExtractFileExt(s);
        end else begin
                   //文件不存在，下载，如果下载多次失败，直接显示下载失败
                   if Game_show_error_image_G or (Game_error_count_G >= Download_try_count) then   //下载尝试次数
                   begin
                   Game_show_error_image_G:= false;
                    s:= game_app_path_G + 'img\error'+ ExtractFileExt(s);

                    if Game_error_count_G >= Download_try_count then
                       inc(Game_error_count_G,10); //累计错误次数，让错误图片在显示几次后不再显示
                   end else begin
                               //启动下载
                              if Game_pscene_img_list.IndexOf(s)= -1 then
                               begin
                                Game_pscene_img_list.Append(s); //加入正在下载列表
                                gm_download.Create(s,pscene_id,form1.handle);
                               end;
                             s:= game_app_path_G + 'img\wait'+ ExtractFileExt(s);
                            end;
                 end;

       end else begin
                 //禁止了图片
                  s:= game_app_path_G + 'img\space'+ ExtractFileExt(s);
                end;
      if s[length(s)]='/' then
         delete(s,length(s),1);


      filestr:= TMemoryStream.Create;
      filestr.LoadFromFile(s);
      filestr.SaveToStream(Stream);
      filestr.Free;

      exit;
     end;

   //宽，高，字体，背景色，内容，效果，透明度

    try
     aw:= round(strtoint2(copy(s,1,fastcharpos(s,',',1)-1))* dpi_bilv);
      //aw:= strtoint2(copy(s,1,fastcharpos(s,',',1)-1));
     delete(s,1,fastcharpos(s,',',1));
    except
     aw:= 0;
    end;
     try
      ah:= round(strtoint2(copy(s,1,fastcharpos(s,',',1)-1))* dpi_bilv);
      // ah:= strtoint2(copy(s,1,fastcharpos(s,',',1)-1));
     delete(s,1,fastcharpos(s,',',1));
    except
     ah:= 0;
    end;

     if aw= 0 then
       aw:= web1.Width-20;
     if ah= 0 then
      ah:= web1.Height;

    afont:= Tfont.Create; //字体

       try
    StringToFont(copy(s,2,fastcharpos(s,')',1)-2),afont);
    delete(s,1,fastcharpos(s,')',1)+1);

     acolor:= StringTocolor(copy(s,1,fastcharpos(s,',',1)-1));
    delete(s,1,fastcharpos(s,',',1));  //背景颜色

     atext:= copy(s,1,fastcharpos(s,',',1)-1);
    delete(s,1,fastcharpos(s,',',1));  //内容
     if atext='' then
        atext:= ' ';

        axiaoguo:= copy(s,1,fastcharpos(s,',',1)-1);
    delete(s,1,fastcharpos(s,',',1));  //显示效果

         afudiao:= strtoint2(copy(s,1,fastcharpos(s,',',1)-1));
      delete(s,1,fastcharpos(s,',',1));  //是否浮雕

        atouming:= strtoint2(copy(s,1,fastcharpos(s,'/',1)-1));  //透明
        atouming:=255- round(255 * (100- atouming) /100);

       except
         acolor:= clwindow;
         axiaoguo:='AT1000';
         afudiao:= 0;
         atouming:= 0;
         atext:='$grass';
       end;

    bmp:=TBitmap.Create;

      bmp.PixelFormat:=pf24bit;
       jpg_pos:= FastPos(atext,'.jpg',length(atext),4,1); //是否需要载入图片,jpg 需小写 ，大写的作为动态生成图片

       if jpg_pos>0 then
         if FastPos(atext,':/',length(atext),2,1)> 1 then
            jpg_pos:= 9999;

      if jpg_pos > 1 then
       begin
        //载入jpg
       // jpg:= Tjpegimage.Create;
        //  jpg.LoadFromFile(data2.game_app_path + 'img\'+
            //  copy(atext,1,jpg_pos +3));
         if jpg_pos= 9999 then
            ss:= atext
            else
              ss:= game_app_path_G + 'img\'+ atext;

          atext:= '';

         ss:=StringReplace(ss, '/', '\', [rfReplaceAll]);

         if not FileExists(ss) then
             ss:= game_app_path_G + 'img\space.jpg';

           
            gdiBmp:=TGPBitmap.Create(ss);

          if (aw > 0) and (aw < 10) then //图片大小的倍数处理
             aw:= integer(gdiBmp.getWidth) * aw;
          if (ah > 0) and (ah < 10) then
             ah:= integer(gdiBmp.getHeight) * ah;

          bmp.Width:= aw;
          bmp.Height:= ah;

         //bmp.Canvas.StretchDraw(Rect(0,0,aw,ah), jpg);

           try
            if aw<> integer(gdiBmp.getWidth) then
              gdiBmp:=GDIBitmapGetThumbnailImage(gdiBmp,aw,ah);
           DrawGDIBitmapToCanvas(bmp.Canvas,gdiBmp,True);
           finally
           gdiBmp.Free;
           end;

       // jpg.Free;
      //  delete(atext,1,pos(',',atext)); //去除atext内的图片路径，剩余其他文字
       end else begin

                 bmp.Width:=aw;
                 bmp.Height:=ah;
                 bmp.Canvas.Brush.Color:= acolor;
                 bmp.Canvas.FillRect(rect(0,0,aw,ah));
                 if atext='$tree' then
                   begin
                     //画树
                     form_pop.draw_random_pic_base(bmp,true);
                     atext:=' ';
                   end else if atext='$grass' then
                              begin
                               form_pop.draw_random_grass(bmp);
                               atext:=' ';
                              end else if (atext[1]= '$') and (atext[2]= 'i') and (atext[3]= 'f') and(atext[4]= 's') then
                               begin
                                 if length(atext)= 4 then
                                  begin
                                   form_pop.draw_random_XX(bmp,0);
                                  end else begin
                                            if fastcharpos(atext,'-',1)> 0 then
                                             begin
                                              delete(atext,1,fastcharpos(atext,'-',1));
                                              if length(atext)> 0 then
                                                  form_pop.draw_random_XX(bmp,strtoint2(atext))
                                                  else
                                                    form_pop.draw_random_XX(bmp,0);
                                             end else
                                                form_pop.draw_random_XX(bmp,0);
                                           end;
                                  atext:= ' ';
                               end;
                end;

        if atouming > 0 then
                  begin
                   bmp2:= TBitmap.Create; //
                   bmp2.Width:=aw; //这个是仅仅作为透明处理的背景用的
                   bmp2.Height:=ah;  //
                  end;

       if atext= '' then
          goto pp;

      AAFont := TAAFontEx.Create(bmp.Canvas);
      aafont.Effect.LoadFromIni(game_effect_ini,axiaoguo);
      aafont.Effect.Shadow.Color:= clblack;
      aafont.Effect.Gradual.StartColor:= afont.Color;  //渐变色，设为文字颜色
      aafont.Effect.Gradual.EndColor:= not afont.Color;

        with bmp.Canvas do
        begin
          Font:= afont;

          Brush.Style := bsClear; // 设置透明绘制
        end;

        
        W := AAFont.TextWidth(atext);
        H := AAFont.TextHeight(atext);
         apos:= fastcharpos(atext,'{',1);
         if apos > 0 then
          begin
           //绝对定位
           while apos > 0 do
            begin
             delete(atext,1,apos);
             apos_w:= round(strtoint2(copy(atext,1,fastcharpos(atext,'@',2)-1)) * dpi_bilv); //取得宽度
              if apos_w < 0 then
                apos_w:= aw+ apos_w; //宽度为负值表示从右边开始算
              delete(atext,1,fastcharpos(atext,'@',2));
              apos_H:= round(strtoint2(copy(atext,1,fastcharpos(atext,'}',2)-1)) * dpi_bilv);   //取得高度
               if apos_H < 0 then
                apos_H:= ah+ apos_H; //高度为负值表示从下面开始算
              delete(atext,1,fastcharpos(atext,'}',2));
              apos:= fastcharpos(atext,'{',1);
              if apos> 0 then
                 begin
                 apos_string:= copy(atext,1,apos-1); //取得内容
                 end else
                       apos_string:= atext;

             AAFont.TextOut(apos_w, apos_H, apos_string);
             
            end;
          end else begin
                     //居中显示
                     with bmp do // 在控件中心输出文本
                      AAFont.TextOut((Width - W) div 2, (Height - H) div 2, atext);
                   end;
        
        afont.Free;
        AAFont.Free;

        
          pp:

         if afudiao= 1 then
            EmbossClick(bmp); //浮雕处理

        if atouming > 0 then //透明处理
         begin
        with sBlendFunction do // 设置初值
          begin
           BlendOp := AC_SRC_OVER; // 目前唯一支持的一种混合方式
           BlendFlags := 0; // 必须为零
           SourceConstantAlpha:= atouming;
           AlphaFormat := 0 // 缺省
          end;
          windows.AlphaBlend(bmp.Canvas.Handle,0,0,
           bmp.Width,bmp.Height,bmp2.Canvas.Handle,
             0,0, bmp.Width,bmp.Height,sBlendFunction); // Alpha混合处理
          bmp2.Free;//
         end;

          if path='' then
           begin
            Stream.Position:= 0;
            bmp.SaveToStream(Stream);
           end else begin
                   jpg:= Tjpegimage.Create;
                   jpg.Assign(bmp);
                   jpg.CompressionQuality:= 80;
                   jpg.Compress;
                   jpg.SaveToFile(path);
                   jpg.Free;
                 end;
      bmp.Free;

end;

function TForm1.game_grade(n: string; g: integer): integer;  //检查此人物是否大于等于这个等级了
var i: integer;
begin

result:= 0;

   for i:= 0 to game_get_role_H do
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
       if game_read_values(i,ord(g_grade))>= g then
             result:= 1;
        exit;
      end;
   

end;

function TForm1.game_change_sex(n: string; sex: integer): integer;
var i: integer;
begin
           //更改游戏人物性别
result:= 0;

   for i:= 0 to Game_role_list.Count-1 do
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
        game_write_values(i,ord(g_sex),sex);
        game_write_values(i,ord(g_icon_index),sex-1);
        result:= 1;
        exit;
      end;
  // if messagebox(handle,'您可以更改游戏主角的性别，按“确定”性别为男，按“取消”性别为女。','选择性别',mb_okcancel or MB_ICONQUESTION)= mrcancel then
end;

function TForm1.game_start_now(i: integer): integer;
begin
  game_start(i);
  result:= 1;
end;

function TForm1.game_sex_from_name(const n: string): integer;  //判断此名是男是女，男返回1
var i: integer;
begin

result:= 0;

   for i:= 0 to Game_role_list.Count-1 do
    if Tplayer(Game_role_list.Items[i]).pl_old_name= n then
      begin
       result:= game_read_values(i,ord(g_sex));
        exit;
      end;

end;

function TForm1.game_get_fm_1(sex: integer): integer;
var i: integer;
begin
result:= 1;
  for i:= 0 to Game_role_list.Count-1 do
       if game_read_values(i,ord(g_sex))= sex then
        begin
         result:= i + 1; //公开函数内的序数，都是从 1 开始的
         exit;
        end;

end;

function TForm1.game_id_exist(id: integer): integer; //检查指定序号人物是否存在，1表示第一个
begin
   if id <= Game_role_list.Count then
     result:= 1
     else
      result:= 0;
end;

function TForm1.game_del_friend_byid(a, b: integer): integer;
begin
  result:= 0;
   if (a > Game_role_list.Count) or (a= 1) then
    exit;

    result:= game_del_friend(Tplayer(Game_role_list.Items[a-1]).pl_old_name,b);
end;

function TForm1.game_move_money(id1, id2, m: integer): integer;
begin    //转移金钱，从id1转移到id2，1表示第一个人物
   if (id1<= Game_role_list.Count) and (id2<= Game_role_list.Count) and
      (game_read_values(id1-1,0) >= m) then
    begin
     game_write_values(id1-1,0,game_read_values(id1-1,0) -m);
     game_write_values(id2-1,0,game_read_values(id2-1,0) +m);
    end;
   result:= 1;
end;

function TForm1.game_get_oldname_at_id(x: integer): pchar;  //根据序列号返回老的名字，1为第一个，2为第二个
begin
 if Game_role_list.Count < x then
           Game_pchar_string_G:= ' '
           else
             Game_pchar_string_G:= Tplayer(game_role_list.Items[x-1]).pl_old_name;

 result:= pchar(Game_pchar_string_G);
end;

function TForm1.game_role_all_MTL(p: integer): integer; //命体灵全满，p=0表示全体，1表示第一个人物
var i: integer;
begin
 result:= 1;

   if p= 0 then
    begin
     for i:= 0 to game_get_role_H do
        begin
        game_write_values(i,ord(g_life),game_read_values(i,ord(g_gdsmz27)));
         game_write_values(i,ord(g_tili),game_read_values(i,ord(g_gdtl25)));
         game_write_values(i,ord(g_lingli),game_read_values(i,ord(g_gdll26)));

        end;
    end else begin
              if p<= game_get_role_H+1 then
                 begin
                  game_write_values(p-1,ord(g_life),game_read_values(p-1,ord(g_gdsmz27)));
                  game_write_values(p-1,ord(g_tili),game_read_values(p-1,ord(g_gdtl25)));
                  game_write_values(p-1,ord(g_lingli),game_read_values(p-1,ord(g_gdll26)));

                 end else
                      result:= 0;
             end;

end;

procedure TForm1.game_load_image_to_imglist; //载入人物头像
var i: integer;
  bmp,bmp_zoom: Tbitmap;
 sr: TSearchRec;
 f,k: integer;
begin
 bmp:= Tbitmap.Create;
  data2.ImageList_sml.Clear;
   k:= data2.ImageList_sml.Width;
  data2.ImageList_sml.Width:= round(16 * dpi_bilv);
  data2.ImageList_sml.Height:= round(16 * dpi_bilv);

   if k<> data2.ImageList_sml.Width then
     bmp_zoom:= Tbitmap.Create;

 f := FindFirst(game_app_path_G + 'sml\*.bmp', faAnyFile, sr);
 while f = 0 do
   begin
     if (sr.Name <> '.') and (sr.Name <> '..') then
       begin
         if sr.Attr and faDirectory = 0 then
          begin
            bmp.LoadFromFile(game_app_path_G + 'sml\'+ sr.Name);
             if k<> data2.ImageList_sml.Width then
              begin
                img_zoom(bmp,bmp_zoom,data2.ImageList_sml.Width,data2.ImageList_sml.Height);
                bmp.Assign(bmp_zoom);
              end;
            Game_goods_Index_G[strtoint2(copy(sr.Name,1,length(sr.Name)-4))]:=
                         data2.ImageList_sml.AddMasked(bmp,clfuchsia);
          end;
       end;
     f := FindNext(sr);
   end;
 FindClose(sr);

 data2.ImageList2.Clear;
   data2.ImageList2.Width:= round(48 * dpi_bilv);
  data2.ImageList2.Height:= round(48 * dpi_bilv);
  for i:= 0 to 199 do
   begin
     if FileExists(game_app_path_G +'img\'+ inttostr(i-1) + '.bmp') then
      begin
       if (i< 2) and game_at_net_g and FileExists(Game_save_path + inttostr(i-1) + '.bmp') then
        bmp.LoadFromFile(Game_save_path + inttostr(i-1) + '.bmp')
        else
         bmp.LoadFromFile(game_app_path_G +'img\'+ inttostr(i-1) + '.bmp');

         if k<> data2.ImageList_sml.Width then
              begin
                img_zoom(bmp,bmp_zoom,data2.ImageList2.Width,data2.ImageList2.Height);
                bmp.Assign(bmp_zoom);
              end;
        data2.ImageList2.AddMasked(bmp,clfuchsia);
       //data2.ImageList2.FileLoad(rtbitmap,,clfuchsia)
      end  else
         break;
   end;

 bmp.Free;

 if k<> data2.ImageList_sml.Width then
     bmp_zoom.Free;

 speedbutton1.Visible:= game_at_net_g;
 combobox2.Visible:= not game_at_net_g;
  if game_at_net_g then    //联网时显示小图
   begin
     speedbutton1.Enabled:= true;
     speedbutton1.Glyph.Width:=  speedbutton1.Width;
      speedbutton1.Glyph.Height:=  speedbutton1.Height;
     data2.imagelist2.Draw(speedbutton1.Glyph.Canvas,0,0,
     Tplayer(Game_role_list.Items[0]).plvalues[ord(g_Icon_index)]+ 1);
   end;

end;

function TForm1.game_clear_money(i: integer): integer;
begin
if i=0 then
  game_write_values(0,0,0)
  else if i=1 then
        game_write_values(0,0,game_read_values(0,0) div 2);

  result:= 1;
end;

function TForm1.game_get_money(i: integer): integer;
begin
 if i > Game_role_list.Count then
   result:= game_read_values(0,0)
 else if i > 0 then
       result:= game_read_values(i-1,0)
      else
       result:= game_read_values(0,0);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 if game_role_list.Count=0 then
  begin
   messagebox(handle,'游戏没有开始，请点击上面的“开始单机游戏”或者“开始联网游戏”来进入游戏或者存取进度。','游戏没开始',mb_ok);
   exit;
  end;

  if not Assigned(form_ZJ_LY) then
     form_ZJ_LY:= Tform_ZJ_LY.Create(application);

     form_ZJ_LY.ShowModal;
end;

function TForm1.game_get_role_suxing(i, v: integer): integer;
begin
 if i= 0 then
    i:= 1;

  if i > Game_role_list.Count then
   result:= 0
   else
       result:= game_read_values(i-1,v);

end;

function TForm1.game_get_goods_count(n: string): integer;
var j: integer;
begin
  //检查某物品数量是否有几个
     if n= '' then
      result:= 0
       else begin
              j:= form_goods.get_goods_id(n);
              if j= 0 then
               result:= 0
                else result:= read_goods_number(j);
            end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin

     Form_set.ShowModal;
end;

function TForm1.game_kill_game_time(i: integer): integer;
begin

   edit1.Visible:= false;
   timer1.Enabled:= false;

 result:= 1;
end;

function TForm1.game_set_game_time(t, page: integer): integer;
begin
//启动定时器，

   g_time_count:= t;
   g_time_page:= page;
   edit1.text:= '剩余：'+ inttostr(g_time_count) + '秒';
   edit1.Left:= web1.Width- edit1.Width- 18;
  edit1.Visible:= true;
  edit1.BringToFront;
  timer1.Enabled:= true;
result:= 1;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  dec(g_time_count);
  edit1.text:= '剩余：'+ inttostr(g_time_count) + '秒';
  if g_time_count <= 0 then
   begin
    edit1.Visible:= false;
    timer1.Enabled:= false;
    game_page(g_time_page);
   end;
end;

function TForm1.game_spk_string(const s: string): integer;
begin
 //朗读，如果checkbox2灰选，那么说明朗读功能不可用
  if form_pop.CheckBox2.Enabled and (s<> '') then
     form_pop.skp_string(s);
 result:= 1;    
end;

function TForm1.game_not_rename(i: integer): integer;
begin
if i= 0 then
   i:= 1;
   
   if Tplayer(Game_role_list.Items[i-1]).pl_old_name= Tplayer(Game_role_list.Items[i-1]).plname then
    result:= 1
     else
      result:= 0;
end;

function TForm1.game_clear_temp(i: integer): integer;
begin
   temp_event_clean; //清空临时表
   result:= 1;
end;

function TForm1.game_random_chance_2(i: integer): integer; //返回随机数
begin
   result:= Game_base_random(i);
end;

function TForm1.game_get_pscene_id(i: integer): integer; //返回当前页id和参数的累加值
begin
 result:= pscene_id + i;
end;

function TForm1.game_role_value_half(id: integer): integer;
var i: integer;
begin
 //生命值减半 id为0表示全体减半，为1表示第一个人物
    result:= 1;
    
   if id= 0 then
    begin
     for i:= 0 to game_get_role_H do
        begin
         game_write_values(i,ord(g_life),game_read_values(i,ord(g_life)) div 2);
        end;
    end else begin
              if id<= game_get_role_H+1 then
               begin
                 game_write_values(id-1,ord(g_life),game_read_values(id-1,ord(g_life)) div 2);

               end  else
                  result:= 0;
             end;


end;

function TForm1.game_get_pscene_id_s(i: integer): pchar;
begin
    //返回页号，字符形式，id和参数的累加值
    Game_scene_id_string:= inttostr(pscene_id + i);
    result:= pchar(Game_scene_id_string);
end;

function TForm1.game_inttostr(i: integer): pchar;
begin
    Game_inttostr_string_G:= inttostr(i);
    result:= pchar(Game_inttostr_string_G);
end;

function TForm1.game_doc_is_ok(s: string): boolean;
var vSearchRec: TSearchRec;
  fdate:integer;
  K: Integer;
begin
result:= true;
  fdate:= 0;

  K := FindFirst(s+'*.*', faDirectory, vSearchRec);
  while K = 0 do
  begin
    if not((vSearchRec.Attr and faDirectory)>0) then
    begin
     if fdate= 0 then
        fdate:=vSearchRec.Time
        else begin
              if (abs(fdate - vSearchRec.Time) > 30) and (vSearchRec.Name<>'out.txt') then
                begin

                  result:= false;
                  FindClose(vSearchRec);
                  exit;
                end;
             end;

    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

end;

function TForm1.game_get_read_txt(i: integer): pchar;
var t: integer;
    b: boolean;
    j: integer;
    ss: string;
begin

    if show_share_text='' then
     begin
      if not Game_is_reload then
      begin
      if i= 0 then
       read_text_index_g:= Random(game_read_stringlist.Count)
       else begin
             if i >= game_read_stringlist.Count then
               read_text_index_g:= Random(game_read_stringlist.Count)
               else
               read_text_index_g:= i;
            end;
      end;

     Game_pchar_string_G:= '<br>'+game_read_stringlist.Strings[read_text_index_g];
     end else begin
               Game_pchar_string_G:= show_share_text;
               show_share_text:= '';
               if (game_bg_music_rc_g.down_readfile= true) or (game_read_stringlist.Count=0) then
                down_tip1.Resume;
              end;
 //在英文符号上插入朗读按钮
 if Game_pchar_string_G= '' then
    Game_pchar_string_G:=' ';

 t:= 1;
 b:= false;
 j:= 0;
 while t < length(Game_pchar_string_G) do
  begin
   if Game_pchar_string_G[t] = '<' then
     b:= true //进入尖括号匹配等待
     else if Game_pchar_string_G[t] = '>' then
          b:= false
          else if (Game_pchar_string_G[t] in[' ','a'..'z','A'..'Z','$'..'@']) and (b=false) then
            begin
             if j= 0 then
              j:= t; //记录下最开始的英文位置
            end else if ((b= false) and (j> 0)) or b then
                      begin
                        //如果t大于j很多，则插入朗读链接
                         if b and (j> 0) then
                            dec(t);
                        if (j> 0) and (t- j > 15) then
                         begin
                          if Game_pchar_string_G[j+1]= ':' then
                             inc(j,2);
                          ss:= ' <a href="game_spk_string(''' + copy(Game_pchar_string_G,j,t-j) +''')" title="朗读该词条">朗读</a>';
                          insert(ss,Game_pchar_string_G,t);
                          t:= t + length(ss);
                         end;
                        if b and (j> 0) then
                            inc(t);
                        j:= 0;
                      end;
     inc(t);
  end;

  if CompareText(form_set.combobox1.Text,'Microsoft Sam')=0 then
     Game_pchar_string_G:= Game_pchar_string_G +'<p>小贴士：需要更自然流畅，没有机器味的语音朗读？查看<a href="http://www.finer2.com/wordgame/wordlib.htm#tts" target="_blank">如何设置</a>。<br>';

    if Game_base_random(10)=0 then
      Game_pchar_string_G:= Game_pchar_string_G + '<p>有好的学习心得或者英汉对照的精品阅读材料？点此<a href="game_showshare_readtext(0)">上传分享</a>';
 result:= pchar(Game_pchar_string_G);

end;

function TForm1.game_true(i: integer): integer;
begin
     if i= 0 then
      result:= 0
      else
       result:= 1;
end;

function TForm1.game_weather(i: integer): integer;
begin
   game_tianqi_G:= i;
   result:= 1;
end;

function TForm1.game_get_accoutre(i, idx: integer): integer; //取得装备类型
begin
 try
  result:= Tplayer(game_role_list.Items[i-1]).pl_accouter1[idx];
 except
  result:= 0;
 end;
end;

procedure TForm1.shell_exe(s: string);
var ss: string;
begin
   if s<>'' then
    showmessage(s);

    ss:= game_doc_path_G +'tmp\up.exe';
    if FileExists(ss) then
     ShellExecute(0,
               'open',pchar(ss),nil,nil,sw_shownormal);
  {
 if form_save.cunpan <> '' then
   begin
    ShellExecute(0,
  'open',pchar(game_app_path_G +'game.exe'),pchar(form_save.cunpan),nil,sw_shownormal);
   end else begin
              ShellExecute(0,
               'open',pchar(game_app_path_G +'game.exe'),nil,nil,sw_shownormal);
            end;
        }
end;

procedure TForm1.show_ad_error;
begin

end;

function TForm1.game_get_TickCount(i: integer): integer;
begin
  result:= GetTickCount;
  if i= 1 then
   result:= result div 1000;

end;

function TForm1.game_get_date(i: integer): pchar;
begin
  if i= 0 then
   Game_datetime_G:= datetostr(date)
   else
    Game_datetime_G:= datetostr(filedatetodatetime(i));

    result:= pchar(Game_datetime_G);

end;

function TForm1.game_get_datetime(i: integer): pchar; //取得字符型的时间日期，如参数不为零，返回参数值的字符类型
begin
   if i= 0 then
     Game_datetime_G:= datetimetostr(now)
   else
    Game_datetime_G:= datetimetostr(filedatetodatetime(i));

    result:= pchar(Game_datetime_G);
end;

function TForm1.game_get_time(i: integer): pchar;
begin
   if i= 0 then
   Game_datetime_G:= datetostr(time)
   else
    Game_datetime_G:= datetostr(filedatetodatetime(i));

    result:= pchar(Game_datetime_G);
end;

function TForm1.game_int_date(i: integer): integer;
begin
     result:= DateTimeToFileDate(date);
end;

function TForm1.game_int_datetime(i: integer): integer;
begin
   result:= DateTimeToFileDate(now);    //获得时间日期的整型类型
end;

function TForm1.game_int_time(i: integer): integer;
begin
  result:= DateTimeToFileDate(time);
end;

function TForm1.game_time_exe(i: integer; const s: string): integer;
begin
   //定时函数，在指定秒数后执行内容
   game_time_exe_list.Append(s);
   if game_time_exe_list.Count= 1 then
      Timer_exe.Enabled:= true;

             if game_time_exe_list.Count > 512 then
              begin
               game_time_exe_list.Delete(game_time_exe_list.Count-1);
                messagebox(handle,'定时器数量过多，同时运行的不能多于512个','注意',mb_ok);
                result:= 0;
              end else begin
                        if i > 60000 then
                         begin
                          i:= 60;
                          messagebox(handle,'一个定时函数的参数不正确，不能大于5万，已经被修改为60秒','注意',mb_ok);
                         end;
                        Game_time_exe_array_G[game_time_exe_list.Count-1]:= i;
                        result:= 1;
                       end;


end;

procedure TForm1.Timer_duihuaTimer(Sender: TObject);
begin
   if game_duihua_list.Count=0 then
    begin
      timer_duihua.Enabled:= false;
      exit;
    end;

  if baidu_busy=false then
      begin
        form_pop.skp_string(game_duihua_list.Strings[0]);
        game_duihua_list.Delete(0);
      end;
  
end;

procedure TForm1.Timer_exeTimer(Sender: TObject);
var i: integer;
begin

   for i:= 0 to game_time_exe_list.Count -1 do
    begin
     if Game_time_exe_array_G[i]> 1 then
        Game_time_exe_array_G[i]:= Game_time_exe_array_G[i]-1;
     if Game_time_exe_array_G[i]= 1 then
      begin
       Game_time_exe_array_G[i]:= 0;
       Game_action_exe(game_time_exe_list.Strings[i]);
      end;
    end;

  for i:= game_time_exe_list.Count -1 downto 0 do
   begin
    if Game_time_exe_array_G[i]= 0 then
       game_time_exe_list.Delete(i)
       else
        break;
   end;

  if game_time_exe_list.Count= 0 then
      Timer_exe.Enabled:= false;
end;

function TForm1.game_webform_isshow(i: integer): integer;
begin

  if Screen.ActiveForm= form1 then
    result:= 1
    else
     result:= 0;
end;

function TForm1.game_run_off_no(i: integer): integer;
begin
result:= 1;
     Game_cannot_runOff:= i=0;

end;

procedure TForm1.CheckBox1Click(Sender: TObject);
var str1: Tstringlist;
begin
  str1:= Tstringlist.Create;
    str1.Text:= web1.GetSource;
    str1.SaveToFile('e:\b.txt');
  str1.Free;
end;

procedure TForm1.ComboBox2DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
ComboBox2.Canvas.FillRect(Rect);
   ComboBox2.Canvas.CopyMode:=cmSrcCopy;
  ComboBox2.Canvas.TextOut(Rect.Left+26, Rect.Top+ 1, ComboBox2.Items[Index]);
 form_goods.draw22(ComboBox2.Canvas,Rect.Left,Rect.Top+ 1,24,24,game_read_values(Index+1,ord(g_Icon_index))+ 1);

end;

procedure TForm1.ComboBox2MeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  Height:= 26;
end;

function TForm1.game_read_factor(i: integer): integer;
begin
  result:= Game_migong_xishu;
end;

function TForm1.game_write_factor(i: integer): integer;
begin
    Game_migong_xishu:= i;
    result:= 1;
end;
function getlocalhost: string;
var 
 computername:pchar; 
 size:cardinal; 
begin 
 size:=MAX_COMPUTERNAME_LENGTH+1;   
 getmem(computername,size); 
 if getcomputername(computername,size) then 
   result:=strpas(computername) 
 else
   result:='';
 freemem(computername); 
end;
procedure TForm1.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
 // var ss: string;
begin

  if pos('参数错误',e.Message)> 0 then
   begin
    messagebox(screen.ActiveForm.Handle,pchar('您单词本内'+Form_pop.get_error_words+'没有等于号分割或者等于号前面包含有中文标点字符。或者如果您使用的是中文词库那么您需要安装并在游戏内设置使用中文朗读引擎。'),'错误',mb_ok);
   end else if pos('注册',e.Message)> 0 then
       begin
        game_bg_music_rc_g.yodao_sound:= true; //有道网络朗读
         if messagebox(screen.ActiveForm.Handle,'朗读引擎发出错误信息，类别没有注册，出现该问题，大多是由于tts引擎安装不正确引起，百度网络发音自动启用，如果本机能上网，单词朗读没问题。点击是，查看解决方法','错误',mb_yesno)=mryes then
            ShellExecute(Handle,
              'open','IEXPLORE.EXE','https://tieba.baidu.com/p/5005699423',nil,sw_shownormal);
       end else if pos('OLE',e.Message)> 0 then
          begin
           game_bg_music_rc_g.yodao_sound:= true; //有道网络朗读
         if messagebox(screen.ActiveForm.Handle,'朗读引擎发出错误信息，OLE 错误，出现该问题，大多是由于tts引擎安装不正确或者声卡驱动有问题(注：有些TTS朗读引擎安装时如果更改了安装路径也可能导致此问题)，有道网络发音自动启用，如果本机能上网，单词朗读没问题。点击是，查看解决方法','错误',mb_yesno)=mryes then
            ShellExecute(Handle,
              'open','IEXPLORE.EXE','https://tieba.baidu.com/p/5005699423',nil,sw_shownormal);
          end else if pos('mshtml',e.Message)> 0 then
          begin
            ApplicationEvents1.Tag:= ApplicationEvents1.Tag +1;
             if ApplicationEvents1.Tag= 1 then
              begin
           if messagebox(screen.ActiveForm.Handle,'浏览器组件出现错误信息，点击是，查看解决方法','错误',mb_yesno)=mryes then
            ShellExecute(Handle,
              'open','IEXPLORE.EXE','https://tieba.baidu.com/p/5005699423',nil,sw_shownormal);
              end;
          end else
           begin
           if messagebox(screen.ActiveForm.Handle,pchar('出错了，如果游戏能正常运行只是没有英文朗读声音，那么在游戏设置界面内勾选优先使用百度朗读即可正常发音,是否自动设置？错误信息为：'+ e.Message +'。'),'错误',mb_yesno)=mryes then
              game_bg_music_rc_g.yodao_sound:= true;
            ShellExecute(Handle,
              'open','IEXPLORE.EXE','https://tieba.baidu.com/p/5005705882',nil,sw_shownormal);
      { ss:= 'http://www.finer2.com/add_error.asp?tit='+application.Title+ '&err='+inttostr(pscene_id) +screen.ActiveControl.Name +  getlocalhost +e.Message;
        if messagebox(screen.ActiveForm.Handle,pchar('程序出现了错误，错误信息为：'+ e.Message +'。是否发送错误信息？'),'发送错误信息',MB_ICONWARNING or MB_YESNO)=mryes then
          begin
           ShellExecute(Handle,
              'open','IEXPLORE.EXE',pchar(ss),nil,sw_shownormal);
          end; }

            end;
end;

function TForm1.game_allow_gohome(i: integer): integer;
begin
   Game_not_gohome_G:= not(i=1); //等于1，允许回城
   result:= 1;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
if Game_ad_count_G.X= 0 then
 game_chat('请您先点击一次感兴趣的广告，然后再点此按钮就可关闭广告。注：点击广告能获得命体灵全满的奖励，但两次奖励至少需间隔40分钟。')
else begin
 if Game_ad_count_G.X= 2 then
    Game_ad_count_G.X:= 1;

 if Game_ad_count_G.Y >= 10 then
  messagebox(handle,'广告已经关闭','提示',mb_ok)
 else begin
       Game_ad_count_G.Y:= 10;
       game_chat('广告已关闭。注：如不关闭广告，那么每次点击广告将获得命体灵全满的奖励。40分钟内只能使用一次。');
       game_reload_direct(0);
      end
      end;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
showmessage('按住CTRL键 然后滚动鼠标滚轮就可以调整字体大小，向上滚变大先下滚变小。');
end;

procedure TForm1.WebBrowser2StatusTextChange(Sender: TObject;
  const Text: WideString);
begin
   game_url:= text;
end;

function TForm1.game_id_from_oldname(const s: string): integer;
var i: integer;
begin
result:= -1;
   for i:= 0 to Game_role_list.Count-1 do
       if s=  Tplayer(game_role_list.Items[i]).pl_old_name then
        begin
         result:= i + 1;
         exit;
        end;

end;

function TForm1.game_lingli_add(p,t: integer): integer;
var i: integer;
begin
 result:= 1;

   if p= 0 then
    begin
     for i:= 0 to game_get_role_H do
        begin
       // game_write_values(i,ord(g_life),game_read_values(i,ord(g_gdsmz27)));
        // game_write_values(i,ord(g_tili),game_read_values(i,ord(g_gdtl25)));
         game_write_values(i,ord(g_lingli),game_read_values(i,ord(g_lingli))+
                          round(game_read_values(i,ord(g_gdll26)) * t / 100));
         if game_read_values(i,ord(g_lingli)) > game_read_values(i,ord(g_gdll26)) then
            game_write_values(i,ord(g_lingli),game_read_values(i,ord(g_gdll26)));
         if game_read_values(i,ord(g_lingli)) < 0 then
            game_write_values(i,ord(g_lingli),0);
        end;
    end else begin
              if p<= game_get_role_H+1 then
                 begin
                //  game_write_values(p-1,ord(g_life),game_read_values(p-1,ord(g_gdsmz27)));
                 // game_write_values(p-1,ord(g_tili),game_read_values(p-1,ord(g_gdtl25)));
                  game_write_values(p-1,ord(g_lingli),game_read_values(p-1,ord(g_lingli))+
                                         round(game_read_values(p-1,ord(g_gdll26)) * t / 100));

                  if game_read_values(p-1,ord(g_lingli)) > game_read_values(p-1,ord(g_gdll26)) then
                      game_write_values(p-1,ord(g_lingli),game_read_values(p-1,ord(g_gdll26)));
                  if game_read_values(p-1,ord(g_lingli)) < 0 then
                      game_write_values(p-1,ord(g_lingli),0);
                 end else
                      result:= 0;
             end;

end;

procedure TForm1.N6Click(Sender: TObject);
begin
   if Game_role_list.Count= 0 then
    messagebox(handle,'游戏还没开始，请先点击屏幕上的“开始游戏”链接。','游戏没开始',mb_ok)
    else
           game_pop_dig(300);


end;

procedure TForm1.PopupMenu3Popup(Sender: TObject);
begin
  n6.Enabled:= not Game_at_net_G;
  n17.Enabled:= not Game_at_net_G;
  n19.Enabled:= not Game_at_net_G;
  n20.Enabled:= not Game_at_net_G;
end;


procedure TForm1.game_error_net_user(ip:cardinal;pt: integer);
begin
     //网络错误，断开了用户的连接

end;

function TForm1.game_rename_byid(id: integer;
  const newname: string): integer;
begin
   if Assigned(Game_role_list.Items[id-1]) then
    begin
    // if game_extfile_rename(Tplayer(Game_role_list.Items[id-1]).pl_old_name, newname) then
        Tplayer(Game_role_list.Items[id-1]).plname:= newname;
    end;
result:= 1;
end;

function TForm1.game_check_role_values_byid(id, id2,
  values: integer): integer;
begin
       //检查某个人物的某属性值是否达到某值，
result:= 0;
if id= 0 then
   id:= 1;

       if Game_role_list.Count<= id then
        begin
          if game_read_values(id-1,id2)>= values then
           begin
            result:= 1;
           end;
        end;


end;

procedure TForm1.game_page_id_change(new_id: integer);
begin
   if game_debug_handle_g<> 0 then
      sendmessage(game_debug_handle_g,page_c1,new_id,0);

    if new_id <> pscene_id then
     begin
      old_pscene_id:= pscene_id;
      pscene_id:= new_id;
      Game_pscene_img_list.Clear; //清除页面已经下载的文件列表
          if game_at_net_g then
           begin
               //=0队员，自由模式，=1队员受限模式，=2打怪跟随，100=领队
            if game_player_head_G.duiwu_dg= 100 then
             Data_net.send_page_and_home_id(pscene_id,Phome_id,old_pscene_id,true)
            else
              Data_net.send_page_and_home_id(pscene_id,Phome_id,old_pscene_id,false); //发送当前页面和home页面到服务器。
           end;
     end;
end;

function TForm1.game_goto_oldpage(i: integer): integer;
begin

   result:= game_page(old_pscene_id);
    
end;

procedure TForm1.N8Click(Sender: TObject);
begin
  //飞行地图
 if game_role_list.Count=0 then
  begin
   messagebox(handle,'游戏没有开始，请点击屏幕上的“开始单机游戏”或者“开始联网游戏”来进入游戏或者存取进度。','游戏没开始',mb_ok);
   exit;
  end;

 if game_check_res_event(5232)=1 then
 begin
 if game_can_fly(0)= 0 then  //不允许结束对话，或者定时器环境下，不允许回城

       messagebox(handle,'当前环境不允许飞行。','飞行失败',mb_ok)
     else
        game_page(14445);
 end else begin
            messagebox(handle,'您没有学会飞行之术。','飞行失败',mb_ok);
          end;
end;

function TForm1.game_is_net_hide(i: integer): integer;
begin
  if Game_net_hide_g then
    result:= 1
    else
     result:= 0;
end;

function TForm1.game_show_logon(const ip: string): integer;
begin
   Game_server_addr_g:= ip;
   postmessage(form1.Handle,game_const_script_after,35,0);
   result:= 1;
end;

function TForm1.game_is_online(i: integer): integer;
begin
   if Game_at_net_G then
    result:= 1
    else
     result:= 0;
end;

function TForm1.game_show_note(const s: string): integer;
begin
   form_note.add_and_show(s);
   result:= 1;
end;

procedure TForm1.WMHotKey(var Msg: TWMHotKey);
begin
  if msg.HotKey= hot_wordgame_h then
   begin
    if game_hide_windows_h then
     begin
       ShowWindow(screen.ActiveForm.Handle, SW_show);
      ShowWindow(application.Handle, SW_show);
     end else begin
                 ShowWindow(screen.ActiveForm.Handle, SW_HIDE);
                ShowWindow(application.Handle, SW_HIDE);
              end;
     game_hide_windows_h:= not game_hide_windows_h;
   end;
end;

procedure TForm1.game_load_doc_net;
var i: integer;
begin
   Game_loading:= true;
    Game_save_path:= game_doc_path_G+ 'save\'+ form_net_set.Edit2.Text;
    if not DirectoryExists(Game_save_path) then
       MkDir(Game_save_path);
   Game_save_path:= Game_save_path + '\';
      //登录id为目录名

   temp_event_clean; //清空临时表
   form_pop.load_game_progress(Game_save_path+ 'default.sav');

   //初始化事件，网络版要创建两个事件文件
  data2.load_event_file('');   //载入事件，为空，创建一个空的事件

  //载入头衔
    data2.Load_file_upp(game_app_path_G+'dat\touxian.upp',Game_touxian_list_G);
    
  Phome_id:= game_read_scene_event(999); //读取回城点
  if Phome_id= 0 then
     Phome_id:= 14447; //网络版首页

  Data2.load_goods_file; //载入游戏物品描述表

 // Data2.game_load_goods; //载入物品

   game_load_image_to_imglist; //载入人物头像

   Data2.game_load_task_file; //载入任务列表

   Form_pop.laod_fashu_wupin_k(Game_save_path + 'fwk.dat');   //载入法术物品快捷键列表

  button_stat(true); //更改button状态

   form_pop.load_abhs; //载入abhs表

 // if (Game_scene_type_G and 2 = 2) or (Game_scene_type_G =1) then  //在迷宫
  //  Game_is_reload:= true; //忽略载入前后动作

  i:= game_read_scene_event(1000); //显示最后的场景
  if i= 0 then
     i:= 14447;

  game_page(i); 

  Game_loading:= false; //设置变量，重新开始文件id检查
end;

function TForm1.wait_scene_int_bool(b: boolean; id: integer): integer;
var t: cardinal;
     pk: Tmsg_cmd_pk;
begin
   Game_wait_ok2_g:= false; //等待场景事件值
    game_wait_integer2_g:= 0;
    t:= GetTickCount;
       if b then
        pk.hander:= byte_to_integer(g_secne_rq_bl_c,false)
       else
        pk.hander:= byte_to_integer(g_scene_rq_int_c,false);

      pk.pak.data1:= id;
      pk.pak.s_id:= my_s_id_g;

      g_send_msg_cmd(@pk,sizeof(pk)); //向服务器发送

    while (Game_wait_ok2_g= false) and (GetTickCount -t < 10000) do
      begin
        application.ProcessMessages;
        sleep(10);
      end;

        if Game_wait_ok2_g then
        begin
         //收到人物数据
         if game_wait_integer2_g= -1 then
          result:= 0
         else
         result:= game_wait_integer2_g;

        end else begin
                  // label9.Caption:= '获取角色数据超时，失败';
                   result:= 0;
                 end;
end;

procedure TForm1.game_save_doc_net;
var pk: Tmsg_cmd_pk;
begin

 if not game_at_net_g then
   exit;

    Game_save_path:= game_doc_path_G+ 'save\'+ form_net_set.Edit2.Text + '\'; //保存路径，供载入文件用

    DeleteDirNotEmpty(Game_save_path); //清空目录

    game_write_scene_event(999,Phome_id);  //保存回城点
    if pscene_id= 14444 then
       pscene_id:= old_pscene_id;
    game_write_scene_event(1000,pscene_id);          //保存当前场景id

  // data2.save_file_event(Game_save_path + 'event.fpp');
  // Data2.game_save_goods; //保存物品

   Data2.game_save_task_file; //保存任务列表
   Form_pop.save_fashu_wupin_k(Game_save_path + 'fwk.dat');   //保存法术物品快捷栏

      form_pop.save_abhs; //保存abhs表
      form_pop.save_set(Game_save_path);

      pk.hander:= byte_to_integer(g_player_exit_c,false);  //退出
      pk.pak.s_id:= my_s_id_g;
      g_send_msg_cmd(@pk,sizeof(pk)); //向服务器发送
      sleep(100);
       Data_net.MasterClient.Client.Disconnect(0,0); //断开连接
end;

procedure TForm1.game_reshow_net_id(all : boolean);
var
    ss: string;
    i,j,k: integer;
    t: cardinal;
    w: array of word;
begin
    //刷新网络id显示

    j:= 0;
    ss:= '';


    //1合成串，2添加
    for i:= 0 to high(user_info_time) do
     begin
      if (user_info_time[i].page= pscene_id) and (user_info_time[i].s_id<> -1) then
       begin
        if user_info_time[i].u_id= '' then
          begin
           user_info_time[i].nicheng:= '正在接收数据';
          end;
        ss:= ss + '<a href="game_netuserinfo(' +inttostr(user_info_time[i].s_id)  + ')" title="'+user_info_time[i].u_id +'">'+user_info_time[i].nicheng +'</a>&nbsp;';
         inc(j);
       end;
      if all= false then
       begin
        if j= 10 then
          begin
            ss:= ss+ '……显示全部用户';
            break;
          end;
       end;
     end;  //end for 合成

      change_html_by_id('cell_net1',ss);


      //发送请求用户名数据
      //取得数量
      k:= 0;
      t:= GetTickCount;
      for i:= 0 to high(user_info_time) do
       begin
          if (user_info_time[i].page= pscene_id) and (t - user_info_time[i].time > refresh_time_C) then
             inc(k)
              else if (user_info_time[i].page= pscene_id) and (user_info_time[i].u_id= '') then
                      inc(k);
       end;

    //分配内存，填充
    if k= 0 then
      exit;

      k:= k+2;
     setlength(w,k);
       for i:= 0 to high(user_info_time) do
       begin

          if (user_info_time[i].page= pscene_id) and (t - user_info_time[i].time > refresh_time_C) then
           begin
             dec(k);
             w[k]:= user_info_time[i].s_id;
           end
              else if (user_info_time[i].page= pscene_id) and (user_info_time[i].u_id= '') then
                  begin
                    dec(k);
                       w[k]:= user_info_time[i].s_id;
                  end;

       end;
   //发送
   pinteger(w)^:= byte_to_integer(g_rep_online_page_data_c,false);
   g_send_msg_cmd(pointer(w),(high(w)+1)*2);

end;

function TForm1.game_netuserinfo(i: integer): integer;
var j: integer;
    ss: string;

begin
     //在对话区域显示玩家信息  i 是网友id
    //显示国家，组织，小队名称在这里
    for j:= 0 to high(user_info_time) do
     begin
        if user_info_time[j].s_id= i then
         begin
          ss:= '玩家ID：<a href="game_show_dwjh('+ inttostr(i)+',0)" title="查看信息">' + user_info_time[j].u_id + '</a>，昵称：'+ user_info_time[j].nicheng;
           ss:= ss + '，所在小队：'+net_get_dwjhming(user_info_time[j].xiaodui,1);
           ss:= ss + '，所在组织：'+net_get_dwjhming(user_info_time[j].zhuzhi,2);
           ss:= ss + '，所在国家：'+net_get_dwjhming(user_info_time[j].guojia,3);
             ss:= ss + '，<a href="game_show_chat('+ inttostr(i)+')" title="与该网友聊天">聊天</a>';
             ss:= ss + '，<a href="game_show_trade('+ inttostr(i)+')" title="与该网友交易物品">交易</a>';
             ss:= ss + '，<a href="game_send_game_msg('+ inttostr(i)+')" title="与该网友友谊比赛">竞赛</a>';
             ss:= ss + '，<a href="game_send_pk_msg('+ inttostr(i)+')" title="与该网友生死对决">PK</a>';
               
          game_chat(ss);
          break;
         end;
     end; // end for
   result:= 1;
end;

function TForm1.game_reshow_online(i: integer): integer;
begin
   //重新显示在线人物
   Data_net.send_page_and_home_id(pscene_id,Phome_id,old_pscene_id,false); //发送当前页面和home页面到服务器。
  result:= 1;
end;

function TForm1.game_show_dwjh(id,tp: integer): integer;
begin
    //显示队伍，国家，组织的信息窗口 参数id为dwjh的id
   if not Assigned(Form_dwjh) then
       Form_dwjh:= TForm_dwjh.Create(application);

     Form_dwjh.PageControl1.Parent:= Form_dwjh;
     Form_dwjh.show_tp:= tp;
       Form_dwjh.show_data_sid:= g_nil_user_c;
       Form_dwjh.show_data_xiaodui:=0;
       Form_dwjh.show_data_zhuzhi:=0;
       Form_dwjh.show_data_guojia:=0;
     case tp of
     0: Form_dwjh.show_data_sid:=id;
     1: Form_dwjh.show_data_xiaodui:= id;
     2: Form_dwjh.show_data_zhuzhi:= id;
     3: Form_dwjh.show_data_guojia:= id;
     end;
     Form_dwjh.Show;
  result:= 1;
end;

function TForm1.game_send_pk_msg(id: integer): integer;
begin
    //发送pk邀请 ，如果是受保护地区，pk不能发送，如果是需应答地区，等待对方答应，如果是自由区，随意
    result:= 0;
end;

function TForm1.game_showshare_readtext(i: integer): integer;
begin
  button10.Click;
end;

function TForm1.game_show_chat(id: integer): integer;
begin
    //显示网络对话窗口
   with Tform_chat.Create(application) do
    begin
     player_chat_id:= id; //网络的id
     Show;
    end;
result:= 1;
end;

function TForm1.game_send_game_msg(id: integer): integer;
begin
//发送竞赛邀请
   result:= 0;
end;

function TForm1.game_show_trade(id: integer): integer;
begin
     //显示交易窗口
  result:= 0;
end;

function TForm1.game_add_user_dwjh(tp, sid, dwjh_id: integer): integer;
begin
    //同意了请求，向服务器发送加入请求，然后让服务器再广播给申请者
     
    if tp= 1 then
     begin
      if (game_player_head_G.duiyuan[0]< g_nil_user_c) and (game_player_head_G.duiyuan[1]< g_nil_user_c) and
          (game_player_head_G.duiyuan[2]< g_nil_user_c) and (game_player_head_G.duiyuan[3]< g_nil_user_c) then
           begin
            game_chat('队员数量已达上限（一个小队只能5人，包括自己）。');
             result:= 0;
            exit;
           end;
     end;

           send_pak_tt(g_xiaodui_jr_c,tp,sid,dwjh_id,0);
           result:= 1;
end;
//*****************************************************调试消息
procedure TForm1.msg_event_c1(var msg: TMessage);
begin
   //收到剧情事件查询
   if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else
     msg.Result:= game_check_scene_event(msg.WParam);
end;

procedure TForm1.msg_event_c2(var msg: TMessage);
begin
   //收到剧情事件设置
   if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else begin
            msg.Result:= game_write_scene_integer(msg.WParam,msg.LParam);
         end;
end;

procedure TForm1.msg_goods_c1(var msg: TMessage);
begin
   //物品查询
   if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else
     msg.Result:= read_goods_number(msg.WParam);
end;

procedure TForm1.msg_goods_c2(var msg: TMessage);
begin
    //物品修改
   if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else begin
            msg.Result:= ord(write_goods_number(msg.WParam,msg.LParam));
         end;
end;

procedure TForm1.msg_page_c2(var msg: TMessage);
begin
    //goto 页面
   if game_at_net_g or (game_debug_handle_g=0) or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else begin
           game_page(msg.WParam);
            msg.Result:= 1;
         end;
end;

procedure TForm1.msg_player_c1(var msg: TMessage);
begin
   //查询人物  game_read_values
   if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else
     msg.Result:= game_read_values(msg.WParam,msg.LParam);
end;

procedure TForm1.msg_player_c2(var msg: TMessage);
begin
   //写入人物值
    if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else begin
            msg.Result:= ord(game_write_values(msg.WParamLo,msg.WParamHi,msg.LParam));
         end;
end;

procedure TForm1.msg_res_c1(var msg: TMessage);
begin
  //查询物事件
  if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else
     msg.Result:= game_check_res_event(msg.WParam);
end;

procedure TForm1.msg_res_c2(var msg: TMessage);
begin
   //写入物事件
    if game_at_net_g or (game_debug_handle_g=0)or(Game_role_list.Count= 0) then
    msg.Result:= -1
    else begin
            msg.Result:= 1;
           if msg.LParam= 1 then
             game_add_res_event(msg.WParam)
            else
             game_del_res_event(msg.WParam);  //物品事件只能写入1或者零
         end;
end;

procedure TForm1.msg_stop_c(var msg: TMessage);
begin
  //结束游戏
  if game_at_net_g or (game_debug_handle_g=0) then
    msg.Result:= -1
    else begin
           msg.Result:= 1;
           TerminateProcess(GetCurrentProcess, 1);
         end;
end;

procedure TForm1.debug_send_func_str(const s: string; flag: integer); //发送调试文本
var
  Data: TCopyDataStruct;
begin
 if game_debug_handle_g= 0 then
    exit;
    //发送调试文本，flag指名了类型 html_C func_C
  Data.dwData := flag;
  Data.cbData := Length(s);
  Data.lpData := AllocMem(Length(s));
  move(pointer(s)^, pchar(Data.lpData)^, length(s));
  SendMessage(game_debug_handle_g, wm_copyData,handle, Integer(@Data));
  freemem(Data.lpData, length(s));

end;

//*************************************************调试消息结束

function TForm1.game_reload_chatlist(i: integer): integer;
begin
       //重新载入聊天记录
       game_reload_chat_g:= true;
          game_direct_scene(pscene_id);
       game_reload_chat_g:= false;

  result:= 1;
end;

function TForm1.game_chat_cleans2(i: integer): integer; //聊天窗口关闭按钮
begin
     if Game_scene_type_G and 8= 8 then
      game_chat('本次对话禁止中途退出，请先结束对话。')
      else
       game_scr_clean2;
result:= 1;
end;

function TForm1.game_chat_spk_add(const s: string): integer;
begin
  game_duihua_list.Add(s);
  timer_duihua.Enabled:= true;
result:= 1;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
    if game_at_net_g then  //显示小队信息
   begin
    game_show_dwjh(my_s_id_G,0);
   end else begin
              messagebox(handle,'该功能在不联网游戏时不可用。','不可用',mb_ok);
            end;
end;

procedure TForm1.WebBrowser1NewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
begin

 if (pos('finer2',game_url)=0) then
    begin
      if Game_ad_count_G.X<> 1 then
         Game_ad_count_G.X:= 2;

     if GetTickCount - ad_mtl_time > 2400000 then
        begin
         game_role_all_mtl(0);
         ad_mtl_time:= GetTickCount;
         game_chat('命体灵全满！再次使用此技能，需间隔40分钟，到'+ timetostr(time + 0.02774));
        end else begin
                  game_chat('技能无效，下次使用此技能的时间为：'+ timetostr(time +
                  ((2400000 -(GetTickCount - ad_mtl_time)) /86405530)
                  ));
                 end;
    end;
end;

function TForm1.game_asw_html_in_pop(i: integer): integer;
var ss: string;
begin

     //visible_html_by_id('layer_chat1',true);
     //change_html_by_id('cell_chat1','');
     ss:= form_pop.html_asw_string(i);
     change_html_by_id('cell_chat1',ss);

   game_chat_cache_g:= ''; //清空聊天缓存
    result:= 1;
end;

procedure TForm1.html_pop(i: integer);
var ss: string;
begin
    ss:='document.getElementById("layer_chat1").height=368;'+
        'document.getElementById("layer_chat1").top='+ inttostr((web1.height-268) div 2)+ ';'+
        'document.getElementById("layer_chat1").style.display="block";'+
        'document.getElementById("cell_chat1").innerHTML="'+StringReplace(form_pop.get_pop_string(i),'"','\"',[rfReplaceAll])+'";';

   web1.ExecuteJavascript(ss);

   game_chat_cache_g:= ''; //清空聊天缓存

end;

function HexToStr(s:ansistring):string; //16进制转字串
var
    HexS,TmpStr:ansistring;
    i:Integer;
    a:Byte;
begin
    HexS:=s;
    if Length(HexS) mod 2=1 then
    begin
        HexS:=HexS+'0';
    end;
    TmpStr:='';
    for i:=1 to(Length(HexS)div 2)do
    begin
        a:=StrToInt('$'+HexS[2*i-1]+HexS[2*i]);
        TmpStr:=TmpStr+ansiChar(a);
    end;
    Result:=TmpStr;
end;

{
procedure TForm1.show_ad_error;
var pDoc:  IHTMLDocument3;
    tt: IHTMLElement;
begin
  pdoc:= Form1.WebBrowser1.Document as IHTMLDocument3;
    if pdoc<> nil then
     begin
      tt:= pdoc.getElementById('ad_layer1');
       if tt= nil then
        begin
         sleep(200);
         tt:= pdoc.getElementById('ad_layer1');
        end;

       if tt<> nil then
        tt.style.display:='none';

        if Game_ad_count_G.Y < 14 then
        Game_ad_count_G.Y:= Game_ad_count_G.Y + 2
        else
          Game_ad_count_G.X:= 1; //连续错误7次，禁止显示广告

     end;

end;
     }
function TForm1.game_set_var(i, v: integer): integer;
begin
     case i of
     1: not_show_img_tip_g:= (v=1);  //i=1 设在”不显示图片提示“变量
     2: game_bg_music_rc_g.sch_enable:= (v=1); //设置图片是否显示
     3: game_bg_music_rc_g.bg_img:= (v=1);   //背景图启用，值为 1，表示启用
     4: game_bg_music_rc_g.bg_music:= (v=1);    //背景音乐启用
     5: game_bg_music_rc_g.mg_pop:= (v=1);    // ;迷宫弹出式背单词窗口启用
     6: game_bg_music_rc_g.pop_img:= (v=1);   // ;网页式背单词窗口背景图启用
     7: game_bg_music_rc_g.sch_enable:= (v=1);   // ;图片搜索开启
     8: game_bg_music_rc_g.not_tiankong:= (v=1);    // ;禁止填空式选择
     9: game_bg_music_rc_g.type_word:= (v=1); //;启用键盘输入背单词
     10: game_bg_music_rc_g.type_word_flash:= (v=1);  //单词闪烁
     11: game_bg_music_rc_g.type_char_spk:= (v=1);   //字母发音
     end;

     result:= 1;
end;

function TForm1.game_show_set(i: integer): integer;
begin

 form_set.PageControl1.ActivePageIndex:= i;
  form_set.ShowModal;
  result:= 1;
end;

procedure TForm1.loadurlbegin(Sender: TObject; sUrl: string; out bHook,
  bHandled: boolean);
begin
  showmessage(surl);
end;

procedure TForm1.load_sch_pic;  //刷新下载的图片
var ss: string;
begin
  down_http.Create(get_down_img_url,'',false);
  ss:= 'document.getElementById("img_shc").height='+game_bg_music_rc_g.sch_img_height.tostring+';'+
                 'document.getElementById("img_shc").src="+temp_pic_file_g +";';
  ss:= StringReplace(ss,'"','\"',[rfReplaceAll]);
  web1.ExecuteJavascript(ss);

        temp_pic_file_g:= '';
         temp_sch_key_g:= '';



end;


function TForm1.game_include_str(const s: string): pchar;
var str1: Tstringlist;
begin
      //读取不需执行的内容
      str1:= Tstringlist.Create;
      Data2.Load_file_upp(game_app_path_G + 'dat\'+ s, str1);
    if str1.Count= 0 then
       Game_pchar_string_G:= 'no string find'
       else
        Game_pchar_string_G:= str1.Text;

        str1.Free;
     result:= pchar(Game_pchar_string_G);
end;

function TForm1.game_inc_scene_event(id, v: integer): integer;
begin
    result:= data2.game_memini_event.ReadInteger('EVENTS',inttostr(id),0);
  result:= result + v;
   data2.game_memini_event.WriteInteger('EVENTS',inttostr(id),result);

   result:= 1;
end;

function TForm1.game_inner_html(i: integer; s: string): integer;

begin

                                                    //输入html
  change_html_by_id('bo_'+ inttostr(i),s);
  result:=1;


end;

function TForm1.game_biao_html(i: integer): integer; //做标记
var ss: string;
begin
  result:= 0;
     if i= 1 then
           ss:= '<a href="game_write_temp(game_get_pscene_id(0),0);game_biao_html(0)" title="取消标记">'
                         +'<img src="file:///'+game_app_path_G+'img\img_flag.gif" border="0">'+ inttostr(pscene_id -10000)+ '</a>'
                         else
           ss:= '<a href="game_write_temp(game_get_pscene_id(0),1);game_biao_html(1)"'
                         +'title="在这里做个标记，表明到过这里了。">点此<b>做个标记</b></a>';

     change_html_by_id('biao_1',ss);

    // file:///'+game_app_path_G+'img/img_flag.gif
            result:=1;


end;

function TForm1.game_res_goods(i,sl: integer; const s: string): pchar;

 function get_pic: string;
  begin
  // 1=装备，2=食物药品，4=投掷攻击类，8=冶炼类，16=武器,32=炼药
  //，64=特殊物品,128=技能书籍,256=消耗增强类
     case data2.get_game_goods_type(form_goods.get_goods_id(s),goods_type1) of
     1: result:= 'img_w_1.gif';
     2: result:= 'img_w_2.gif';
     4: result:= 'img_w_4.gif';
     8: result:= 'img_w_8.gif';
     16: result:= 'img_w_16.gif';
     32: result:= 'img_w_32.gif';
     64: result:= 'img_w_64.gif';
     128:result:= 'img_w_128.gif';
     256:result:= 'img_w_256.gif';
     else
        result:= 'img_w_0.gif';
     end;
     result:= '<img src="file:///'+game_app_path_G+'img/'+ result +'" border="0">';
  end;
begin    //返回一个物品是否捡到的标准字符串
        {
        i值，小于等于零的，和game pscene id 相加
        大于零，小于等于100的，表示一个随机包裹
        大于100的，表示一个物品事件id
        }

       if (i> 0) and (i <= 100) then  //返回随机物品
           begin
             if (game_random_chance(i)=1) and (not Game_at_net_G) then
               begin
                i:= i+ random(100); //span id 设置一个随机id
                Game_pchar_string_G:='<span id="bo_'+inttostr(i)+
       '"><a href="game_goods_change_n('''+ s +''','+inttostr(sl)+
       ');game_chat(''捡到'+s + inttostr(sl)+''');'+
       'game_inner_html('+inttostr(i)+','' '')" title="捡起">'+get_pic+'</a></span>';

               end else Game_pchar_string_G:= ' ';

           end else begin  //***********************************

                      if i<= 0 then
                        i:= game_get_pscene_id(i);
    if game_not_res_event(i)=1 then
      begin
       Game_pchar_string_G:='<span id="bo_'+inttostr(i)+
       '"><a href="game_goods_change_n('''+ s +''','+inttostr(sl)+
       ');game_chat(''捡到'+s + inttostr(sl)+''');game_add_res_event('+inttostr(i)+
       ');game_inner_html('+inttostr(i)+','' '')" title="捡起">'+get_pic+'</a></span>';
      end else
            Game_pchar_string_G:= ' ';
                   end;  //*************************************

    result:= pchar(Game_pchar_string_G);
end;

function TForm1.game_can_fly(i: integer): integer;
begin
    result:= ord(not (
    (Game_scene_type_G and 8 = 8) or timer1.Enabled or Game_not_gohome_G));
end;

procedure TForm1.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
   if (Msg.message = WM_RBUTTONDOWN) and IsChild(Web1.Handle, Msg.Hwnd) then
  begin
  popupmenu3.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);//自己定义的菜单
  Handled := True;
  end;

end;

function TForm1.game_bubble(bb: integer): integer;  //泡泡龙，参数是泡泡数量
begin
   {
    弹出泡泡龙窗口
   }
   showmessage('泡泡龙暂时不能使用，请等待新版本。');
   result:= ord (false);
   exit;

   form_pop.game_pop_count:= bb;
  form_pop.game_pop_type:= 6; //泡泡龙

    {泡泡龙目前不联网
   if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(1, i,0);  }

      result:= ord (form_pop.ShowModal= mrok);
end;

procedure TForm1.N10Click(Sender: TObject);
begin
  //泡泡龙
    if Game_role_list.Count= 0 then
   begin
    messagebox(handle,'游戏还没开始，请先点击屏幕上的“开始游戏”链接。','游戏没开始',mb_ok);
    exit;
   end;
   game_bubble(Tmenuitem(sender).Tag);
end;

procedure TForm1.N14Click(Sender: TObject);
begin
   if Game_role_list.Count= 0 then
   begin
    messagebox(handle,'游戏还没开始，请先点击屏幕上的“开始游戏”链接。','游戏没开始',mb_ok);
    exit;
   end;
   game_wuziqi(Tmenuitem(sender).Tag);
end;

function TForm1.game_wuziqi(bb: integer): integer;
begin
    {
    弹出五子棋窗口
   }
   showmessage('五子棋暂时不能使用，请等待新版本。');
   result:= ord (false);
   exit;

   form_pop.game_pop_count:= bb;
  form_pop.game_pop_type:= 7; //五子棋

    {五子棋目前不联网
   if game_at_net_g and (game_player_head_G.duiwu_dg= 100) then
     data_net.send_dwjh_pop(1, i,0);  }

      result:= ord (form_pop.ShowModal= mrok);
end;

procedure TForm1.TrayShow(Sender: TObject);
begin
//设定 TNotifyIconData 的记录长度
  MyTrayIcon.cbSize :=SizeOf(tnotifyicondata);
  //确定调用程序的窗体句柄
  MyTrayIcon.Wnd :=Handle;
  //确定图标的 uID
  MyTrayIcon.uID :=1;
  //设定显示标记
  MyTrayIcon.uFlags :=NIF_ICON or NIF_TIP or NIF_MESSAGE;
  //用户自定义消息
  MyTrayIcon.uCallbackMessage := WM_MYTRAYICONCALLBACK;
  //托盘图标的句柄
  MyTrayIcon.hIcon := Application.Icon.Handle;
  //托盘图标的提示信息
   strcopy(MyTrayIcon.szTip,pchar(application.title));
  //向托盘中添加图标
  Shell_NotifyIcon(NIM_ADD,@mytrayicon);
end;
procedure show_gamewordow;
begin
  form_chinese.close;
   Application.Restore;  //恢复窗体
   Application.BringToFront; //提到前面显示
    Form1.N24.Visible:= false;
   Shell_NotifyIcon(NIM_DELETE, @MyTrayIcon);//删除托盘图标
end;

procedure TForm1.WMMyTrayIconCallBack(var Msg: TMessage);
var
  CursorPos : TPoint;
begin
  case Msg.lParam of
    //左键按下
    WM_LBUTTONDOWN : begin
                      // application.MainForm.BringToFront;   窗体置前
                      show_gamewordow;
                     end;
    //左键双击
    WM_LBUTTONDBLCLK : begin                                //窗体隐含或显示
                         //Application.MainForm.Visible := not Application.MainForm.Visible;
                         //SetForegroundWindow(Application.Handle);
                         if IsIconic(Application.Handle) = True then  //窗体是否最小化
                          begin
                           show_gamewordow;
                          end;
                       end;
    //右键按下
    WM_RBUTTONDOWN :   begin                                //显示弹出菜单
                         GetCursorPos(CursorPos);
                         PopupMenu3.Popup(CursorPos.x,CursorPos.y);
                       end;
   end//case

end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
    //最小化时的操作 本窗口当前不是最前面的窗口时不执行桌面背单词操作
    if game_bg_music_rc_g.desktop_word then
    begin
    TrayShow(sender);
    N24.Visible:= true;
    ShowWindow(Application.Handle, SW_HIDE);
    if not Assigned(form_chinese) then
       form_chinese:= TForm_chinese.Create(application);  //创建中文朗读引擎
       form_chinese.show;
       SetWindowPos(form_chinese.handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove or swp_NoSize);
       //form_chinese.FormStyle:= fsStayOnTop;
       //SetactiveWindow(form_chinese.Handle);
    end;
end;

procedure TForm1.N24Click(Sender: TObject);
begin
   show_gamewordow;
end;

function TForm1.game_save_count(i: integer): integer;  //取得存档数量
var vSearchRec: TSearchRec;
  vPathName: string;
  K: Integer;
  ct: integer;
begin
   ct:= 0;

   vPathName := game_doc_path_G+'save\*.*';
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      inc(ct);
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

   vPathName := game_app_path_G+'save\*.*';
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      inc(ct);
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

  vPathName := form_save.get_app_data_path + '\背单词游戏存盘数据\*.*';  //再次搜索app路径
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      inc(ct);
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

  result:= ct;
end;

function TForm1.game_chinese_spk(const s: string): integer;
begin

     form_pop.skp_string(s);
  result:= 1;
end;

procedure TForm1.update_caption(i: integer);
begin
   caption:= application.Title + ' '+ '已背单词数' + inttostr(i);
   if part_size_g<> nil then
     caption:= caption + '/' + inttostr(high(part_size_g));

end;

procedure TForm1.visible_html_by_id(const id: string; canshow: boolean);
var ss: string;
begin
      ss:= 'document.getElementById("'+id+ '").';
       if canshow then
        ss:= ss+ 'style.display="block";'
        else
         ss:= ss+ 'style.display="none";';

   web1.ExecuteJavascript(ss);
end;

end.
