unit Unit_pop;

interface
 //{$DEFINE IBM_SPK}
  {$DEFINE MS_SPK}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  Unit_player,Unit_data,jpeg,KSVOICELib_TLB,
  {$IFDEF MS_SPK}OleServer,SpeechLib_TLB,{$ENDIF} AsphyreDb, AsphyreFonts,
  AsphyreImages, AsphyreSubsc, AsphyreDevices, Asphyre2D, AsphyreCanvas,
  AsphyreTimers,AsphyreDef,shellapi, ActnList, AsphyreParticles, Menus,
  DXSounds,unit_glb,Unit_wuziqi,SHDocVw;



 const
  um_ontimer=wm_user+259;
  um_quitthread=wm_user+261;
   pic_start= 5;
   jit_delay= 60;
   jit_words_i_c= 2; //默认连续显示的数量为3

   game_bmp_h1= 42;  // 单词的高度

   game_bmp_h2= 32;   //解释的高度
   game_bmp_role_width= 80; //怪和我方人物的宽度
   game_bmp_role_h= 48;  //怪和我方人物的高度
   G_all_pic_n= 0;  //全局gl对象禁止选中
   G_words_Pic_y=1; //单词答案gl对象可选
   G_g_pic_y=2; //怪物gl对象可选中
   G_my_pic_y=3; //我方人员对象图片可选中
   gl_count_plane= 14; //glplane的总数
   gl_role_show_count= 5; //全部可上场战斗的允许人物数
   game_amt_length= 60; //动画帧
   game_amt_delay= 30; //延时毫秒
   g_result_w1= 256;  //结果显示 384
   g_result_h1= 128;

    G_C_role_top= 400;  //我方人物顶点
    G_C_guai_top= 40;    //怪物顶点
    G_C_role_left1= 20;   //我方人物和怪物的左边坐标
    G_C_role_left2= 140;
    G_C_role_left3= 260;
    G_C_role_left4= 380;
    G_C_role_left5= 500;

    G_checked_color:TColor4 =($00FFFFFF, $00FFFFFF, $FFFFAF00, $FFFFAF00); //单词选中后的颜色
    G_right_color:TColor4 =($00FFFFFF, $00FFFFFF, $FFFF00AF, $FFFF00AF); //单词正确的颜色
    G_checked_guai_color:TColor4 =($FF8060A0, $FF8060A0, $FF8060A0, $FF8060A0); //怪选中后的颜色
    G_checked_role_color:TColor4 =($FF8060A0, $FF8060A0, $FF8060A0, $FF8060A0); //role选中后的颜色

    G_C_danci_top= 170;
    G_C_jieshi1_top= 220;
    G_C_jieshi2_top= 260;
    G_C_jieshi3_top= 300;

    g_C_DonghuaQianWenZi= 400; //动画前文字显示时间 毫秒
    g_boll_w_cn= 30; //球网格的宽和高
    g_boll_h_cn= 26;
    g_boll_21_cn= 20;  //球的列数 21列
    g_boll_14_cn= 14; //球的行数 15行
    g_ball_color_cpt= 1;
    g_ball_color_me= 3; //我方五子棋颜色

type
      T_caoshi_list= record
       sid: word;
       caoshi: word;
       end;

      ttime_list= record
       Timer_wo_gongji: boolean;
       Timer_guai_gongji: boolean;
       Timer_wo_fashugongji: boolean;
       Timer_guai_fashugongji: boolean;
       Timer_wupin_gongji: boolean;
       Timer_wupin_huifu: boolean;
       Timer_fashu_huifu: boolean;
       Timer_gong: boolean;
       Timer_donghua: boolean;
       Timer_bubble: boolean; //泡泡龙，泡泡运行
       Timer_show_jit_word: integer; //隔3秒后重新显示
       Timer_show_jit_alpha: integer; //单词和解释的透明变换
       end;
      Tbubble_data= record
       boll_show: boolean;  //显示运动的球
       boll_color: integer;   //颜色索引
       boll_left: integer;
       boll_top: integer;
       next_color: integer; //下一个等待的球的颜色，索引值
       arrow_Angle: real; //箭头角度
       boll_path_length: integer; //球长度
       sycs: integer; //剩余的打泡泡次数
       start_X: integer; //原点
       start_Y: integer;
       zt: integer; //状态，0表示球移动，1表示球消失
       last_y: integer;
       last_x: integer; //最后一个发射上去的球
       dot_line_count: integer; //可显示虚线次数
       end;
      twuziqi_rec= record
       me_row: integer;  //我方最后落子位置
       me_col: integer;
       cpt_row: integer; //电脑最后落子位置
       cpt_col: integer;
       row: integer;    //最后落子，不管是我方或者电脑，用于画虚线
       col: integer;
       cpt_count: integer; //对方棋子数量
       me_count: integer; //我方棋子数量
       xy0: boolean;
       x0,y0,x1,y1: integer; //画线
       word_showing: boolean; //单词显示过程中
       word_time: integer;   //显示的时间
       cpt_win: boolean; //是否电脑赢棋
       end;
     TBranchColor=record
      r,g,b:Byte;
      end;
     Tparticle_rec=record
      xian: boolean;
      xuli: integer;
      xiaoguo: integer;
      end;
     {PError_word= ^TError_word;
     TError_word= packed record
      wordid: word;
      RepCount: word;
      next: perror_word;
      end; }
      //当前游戏状态 wuziqi1=可下子状态，wuziqi2=显示单词状态
      T_game_Status=(g_start,G_word,G_chelue,G_animation,g_bubble,g_boll_move,g_wuziqi1,g_wuziqi2,G_end);
        //当前鼠标位置
      T_Mouse_at=(mus_nil,mus_guai1,mus_guai2,mus_guai3,mus_guai4,mus_guai5,
                  mus_role1,mus_role2,mus_role3,mus_role4,mus_role5,
                  mus_danci1,mus_jieshi1,mus_jieshi2,mus_jieshi3,mus_wuziqi);
      T_word_QianHouZhui= record
       qian_start: word;
       qian_end: word;
       hou_start: word;
       hou_end: word;
       end;
      T_donghua_weizhi= record
        weizhi: TRect;   //动画当前位置
        xianshi: boolean;    //是否需要显示
        zhen: integer;    //当前图第几帧
        time: integer; //动画定时时间，为零表示结束
        alpha: byte; //透明度
        end;
      T_zhi_piaodong= record
       xianshi: boolean;
       left1: integer;
       top1: integer;
       peise: cardinal;
       xiaoguo: cardinal;
       zhi: string[12];
       end;
      T_word_weizi= record
       weizi: Trect;
       alpha: byte;
       end;

 TGameSave= record
     me_win: integer; //我方赢棋数量
    sch_count:integer;
    koucu: integer;
    leiji: integer; //累计游戏时间
    cpt_win: integer;          //电脑赢棋数量
    music_index:integer;
    img_index: integer;
    zhuangtai: integer;
    index: integer;
    tip1: integer;
    tip2: integer;
    tip3: integer;
    tip4: integer;
    tip5: integer;
    tip6: integer;
    tip7: integer; //记录顺序值
    zqbs: integer;
    cwbs: integer;
  end;
    Lon_SmallInt_rec= packed record
      case Integer of
      0: (Lo, Hi: SmallInt);
      1: (Words: array [0..1] of Word);
      2: (int: integer);
     end;
    Tmtl_rec=packed record   //命体灵结构块，差值
     m: Lon_SmallInt_rec;  //返回差值，高端为攻防，速差值，低端为命体另差值 SmallInt
     t: Lon_SmallInt_rec;  //防
     l: Lon_SmallInt_rec;   //速 低端为灵
     end;
     
  TForm_pop = class(TForm)
    GroupBox3: TGroupBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    CheckBox8: TCheckBox;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    SaveDialog1: TSaveDialog;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ListBox1: TListBox;
    StatusBar1: TStatusBar;
    Timer2: TTimer;
    Timer3: TTimer;
    Timer4: TTimer;
    Label1: TLabel;
    Panel1: TPanel;
    AsphyreDevice1: TAsphyreDevice;
    AsphyreTimer1: TAsphyreTimer;
    AsphyreCanvas1: TAsphyreCanvas;
    AsphyreImages1: TAsphyreImages;
    AsphyreFonts1: TAsphyreFonts;
    Timer_donghua: TTimer;
    ASDb1: TASDb;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Action9: TAction;
    Action10: TAction;
    Action11: TAction;
    Action12: TAction;
    Action13: TAction;
    Action14: TAction;
    Action15: TAction;
    AsphyreParticles1: TAsphyreParticles;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Action16: TAction;
    Action17: TAction;
    Action18: TAction;
    Action19: TAction;
    Action20: TAction;
    Button11: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    DXSound1: TDXSound;
    DXWaveList1: TDXWaveList;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    Timer_auto_attack: TTimer;
    Timer5: TTimer;
    Action21: TAction;
    Timer_daojishi: TTimer;
    Edit1: TEdit;
    Action_az1: TAction;
    Action_az2: TAction;
    Action_az3: TAction;
    Action22: TAction;
    Action23: TAction;
    Action24: TAction;
    Action25: TAction;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox1KeyPress(Sender: TObject; var Key: Char);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CheckBox8MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer4Timer(Sender: TObject);
    procedure ListBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBox1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure AsphyreDevice1Initialize(Sender: TObject;
      var Success: Boolean);
    procedure AsphyreTimer1Timer(Sender: TObject);
    procedure AsphyreDevice1Render(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer_donghuaTimer(Sender: TObject);
    procedure Timer_wo_gongjiTimer;
    procedure Timer_guai_gongjiTimer;
    procedure Timer_wo_fashugongjiTimer;
    procedure Timer_guai_fashugongjiTimer;
    procedure Timer_wupin_gongjiTimer;
    procedure Timer_wupin_huifuTimer;
    procedure Timer_fashu_huifuTimer;
    procedure Timer_gongTimer;
    procedure Timer_bubbleTimer; //泡泡龙，球动画
    procedure Action1Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action9Execute(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
    procedure Action11Execute(Sender: TObject);
    procedure Action12Execute(Sender: TObject);
    procedure Action13Execute(Sender: TObject);
    procedure Action14Execute(Sender: TObject);
    procedure Action15Execute(Sender: TObject);
    procedure AsphyreTimer1Process(Sender: TObject);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Button6DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Button6DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Button6Click(Sender: TObject);
    procedure Action16Execute(Sender: TObject);
    procedure Action17Execute(Sender: TObject);
    procedure Action18Execute(Sender: TObject);
    procedure Action19Execute(Sender: TObject);
    procedure Action20Execute(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N7Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure Timer_auto_attackTimer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure Action21Execute(Sender: TObject);
    procedure Timer_daojishiTimer(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ActionList1Execute(Action: TBasicAction;
      var Handled: Boolean);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Action_az1Execute(Sender: TObject);
    procedure Action_az2Execute(Sender: TObject);
    procedure Action_az3Execute(Sender: TObject);
    procedure Action22Execute(Sender: TObject);
    procedure Action23Execute(Sender: TObject);
    procedure Action24Execute(Sender: TObject);
    procedure Action25Execute(Sender: TObject);
    procedure SpVoice1EndStream(Sender: TObject; StreamNumber: Integer;
      StreamPosition: OleVariant);
    procedure N15Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
  private
    { Private declarations }
    jit_koucu: integer; //已经扣除，用作升级的金钱
     jit_leiji: integer;
     jit_time: integer;
    // jit_total: integer; //累计次数
     jit_num: integer; //背单词已背数量
     goods_time_list: Tstringlist; //在一段时间内有效的物品列表，过期后删除
     fashu_wupin_kuaijie_list: Tstringlist; //法术物品快捷键记录
     jit_tmp_3: integer;
     Jit_kssj: tdatetime; //开始时间
     jit_del: boolean; //是否有删除过单词
     jit_word_p: integer; //指向单词表当前单词的指针
     //jit_game_start: boolean; //游戏是否开始
     
       game_E_color_R,game_E_color_G,game_E_color_B: byte;
       game_C_color_R,game_C_color_G,game_C_color_B: byte;
       game_BE_color_R,game_BE_color_G,game_BE_color_B: byte;
       game_BC_color_R,game_BC_color_G,game_BC_color_B: byte;

       game_WA_color_R,game_WA_color_G,game_WA_color_B: byte;
       game_WB_color_R,game_WB_color_G,game_WB_color_B: byte;

       Jit_words: string; //当前显示的单词
       game_word_1,game_word_2,game_word_3: string; //缓存

       game_pic_check_area: integer; //gl对象哪些允许鼠标选中
       Fgame_guai_cu,Fgame_my_cu: integer; //当前怪编号 ,当前战斗人物编号
       F_Attack_type: integer;
       F_is_Attack: boolean; //是否攻击状态
       F_time_role_id: integer; //用于添加到定时器内的，被作用人物编号
       game_can_close: boolean; //是否允许关闭窗口
       // guai_lifeblood1: array[0..4] of integer;  //怪物血值
      // guai_list1: array[0..4] of string; //怪物列表
       game_p_list: array[0..9] of integer; //速度值列表
       blood_show_list: array[0..4] of integer;
       game_musmv_ready: boolean;
       game_guai_escape: boolean; //怪物最后一只是否逃跑的
        game_dangqian_word_id: integer; //当前单词编号，用于发现错误时插入错误重复列表用
      // game_tts_index: integer; //当前使用的tts引擎
       game_beijing_index_i,game_beijing_index_cur: integer; //背景编号
       g_guai_show1,g_guai_show2,g_guai_show3,g_guai_show4,g_guai_show5: boolean;
       g_role_show1,g_role_show2,g_role_show3,g_role_show4,g_role_show5: boolean;
       g_guai_jialiang1,g_guai_jialiang2,g_guai_jialiang3,g_guai_jialiang4,g_guai_jialiang5: boolean; //怪可加亮
       g_role_jialiang1,g_role_jialiang2,g_role_jialiang3,g_role_jialiang4,g_role_jialiang5: boolean; //我方可加亮
       g_show_result_b: boolean; //显示结束时图片
       g_dangqian_zhuangtai: T_game_Status; //当前显示状态
       g_show_text_up,g_show_text_down: boolean;
       g_danci_weizhi,g_jieshi_weizhi1,g_jieshi_weizhi2,g_jieshi_weizhi3: T_word_weizi;
       G_mus_at: T_Mouse_at; //当前鼠标所在的位置
       g_danci_donghua_id,G_danci_donghua_count: integer; //动画编号和动画即时
       game_word_qianzhui,game_word_houzhui: Tstringlist;
       image_word,image_cn1,image_cn2,image_cn3,image_up,image_down :TAsphyreImage;
       image_guai1,image_guai2,image_guai3,image_guai4,image_guai5: TAsphyreImage;
       image_role1,image_role2,image_role3,image_role4,image_role5: TAsphyreImage;
       image_result1: TAsphyreImage; //场景结束图片
       g_icon_image: TAsphyreImage;
       image_bg_1_1,image_bg_1_2: TAsphyreImage; //背景图片
       image_bubble,imgae_arrow: TAsphyreImage;

       //单体法术攻击，单体物品攻击，单体法术恢复，单体物品恢复
       g_DanTiFaShuGongJi,G_dantiWuPinGongji,G_DanTiFaShuHuiFu,G_DanTiWuPinHuiFu: T_donghua_weizhi;
       G_QuanTiFaShuGongji,G_Quantifashuhuifu,G_Guai_Fashu: T_donghua_weizhi;
       G_PuTongGongji,G_Guai_PuTongGongji: T_donghua_weizhi;
       g_gong,g_gong_xiaoguo,g_icon: T_donghua_weizhi;
       g_particle_rec: Tparticle_rec;
       g_is_tingli_b,g_Dragging,g_tiankong: boolean; //是否处于听力状态
       g_wo_guai_dangqian: integer; //从速度列表返回的值
       g_auto_attack: integer; //自动攻击定时
       g_is_word_right: boolean; //单词在鼠标下正确
       g_timer_count_5: integer; //5秒定时
       g_time_5,g_time_30,g_time_240: integer; //艾宾浩斯单日指针
       g_day_1,g_day_2,g_day_4,g_day_7,g_day_15: integer; //艾宾浩斯日期指针
       g_string_abhs: string;
       g_on_abhs: boolean; //当前的单词由abhs表提供，防止重复加入
       g_abhs_index,g_abhs_count: integer;
       time_list1: ttime_list;
       game_guai_xishu_f: integer; //怪物攻击系数，比如回答正确与否
       game_guai_fanghu_xishu_f: integer; //怪防护系数
       game_state_answer: boolean; //为false表示初始显示，为true表示答案显示
       game_edit1_bmp: Tbitmap;
          // WebBrowser1: TWebBrowser;
      procedure word_lib_save;
      function get_filename_ck(isNew: boolean): string; //返回词库文件名
      procedure show_check(i: integer);  //显示关闭时的选择项状态
      procedure save_check;
      procedure My_FindFiles(sPath: string);

      function check_asw(i: integer;h_b: boolean): string;
      procedure save_game_progress(filename: string);
      procedure draw_asw(s: string; flag: integer; c: integer=0); //画出待选答案，flag 1到3共3个
      procedure game_intl_pic; //初始化贴图
      procedure draw_random_pic; //显示延迟显示前的随机图
      procedure after_check_asw(b: boolean);
      procedure after_check_asw1(b: boolean);  //1，背单词后续处理
      procedure after_check_asw2(b: boolean);  //   挖矿后续处理
      procedure after_check_asw3(b: boolean);   //  战斗后续处理
      procedure show_text(up: boolean; const s: string); //显示文字，up表示在上部显示
      procedure show_text_hint(const s: string); //显示中文hint
      procedure draw_game_role(p: integer); //画出游戏人物，-1，画出全部，其余的按rolelist内的序号画
      procedure draw_game_role_base(p: integer);
      procedure draw_game_role_base2(p: integer; tpl: Tplayer);
      procedure create_guai_list; //创建怪物列表
      procedure draw_game_guai(p: integer); //画出怪物，-1 画出全部，其余的按guailist内的编号画
      procedure draw_game_guai_base(p: integer);
      procedure game_star_fight_message(var msg: TMessage); message game_const_star_war;
      procedure guai_Attack(t,z: integer); //怪物攻击，参数为怪物编号，参数为攻击指数
      function game_p_list_ex: integer; //速度，并清空最大值，返回其编号
      function game_get_role_su(i: integer): integer; //根据上场人物编号来取得其速度
      function game_get_role_from_i(i: integer): Tplayer; //根据上场人物的编号来获得人物实例
      function game_get_role_from_sid(i: integer): Tplayer; //根据sid的编号来获得人物实例
      function game_get_guai_su(i: integer): integer; //根据上场怪物编号来取得其速度
      procedure My_Attack(m,p,d: integer); //我方攻击，参数为攻击者,怪物id和攻击方式，0为普通攻击
      procedure My_comeback(m,p,d: integer); //恢复术
      procedure highlight_guai(id: integer); //加亮指定怪物，-1,加亮全部
      procedure highlight_guai_base(id: integer); //加亮指定怪物
      procedure un_highlight_guai(id: integer); //恢复加亮指定怪物，-1,回复加亮全部
      procedure un_highlight_guai_base(id: integer); //恢复加亮指定怪物
      procedure highlight_my(id: integer); //加亮指定人物，-1,加亮全部
      procedure highlight_my_base(id: integer); //加亮指定人物
      procedure un_highlight_my(id: integer); //恢复加亮指定人物，-1,回复加亮全部
      procedure un_highlight_my_base(id: integer); //恢复加亮指定人物
      function  get_pid_from_showId(i: integer): integer; //通过上场id返回人物的rolelist的编号
      function  get_r_role_id: integer; //获得一个随机上场人物的id
      function  get_r_role_all_count: integer; //取得我方全部上场人物数量，包括已死角色
      function  get_r_role_all_count_NoDead: integer; //取得我方全部上场人物数量，不包括已经死亡的
      procedure game_Animation(up: boolean; p1,p2,p3:integer); //攻击方向，up表示我方向怪攻击
      procedure game_blood_add_one; //战斗结束后，死亡角色血点恢复为一
      function game_fight_result: integer;  //判断战斗结果,result:= 1 //我方阵亡
      procedure game_fight_result_adv;
      procedure game_guai_Attack_blood; //被怪攻击后扣除我方血点
      procedure game_my_Attack_blood; //我方攻击后扣除怪血点
      function game_get_Attack_value(z1,z2: integer): Tmtl_rec; //根据攻击指数和攻击类型返回攻击力
      function game_get_my_Attack_value(z1: integer): Tmtl_rec; //取得我方攻击力 参数为攻击类型
      procedure game_fight_keep; //下一轮战斗，继续战斗
      procedure game_word_amt; //单词动画
      procedure go_amt_00(t: integer);
      procedure go_amt_01(t: integer);
      procedure go_amt_02(t: integer);
      procedure go_amt_03(t: integer);
      procedure go_amt_04(t: integer);
       procedure go_amt_05(t: integer);
       procedure go_amt_06(t: integer);
      procedure game_victory; //战斗胜利，加经验，升级，动画
      procedure game_up_role; //判断升级
      function get_guai_count: integer; //获取怪物个数
      function get_guai_only: integer; //获取仅剩的怪编号
      function can_escape: boolean; //是否允许逃走
      procedure listbox1_click1;   //点击后确实攻击类型
      procedure procedure_2(const s: string);  //食品药品类处理
      procedure procedure_4(const s: string);  //投掷攻击类处理
      procedure procedure_128(const s: string); //法术类处理
      procedure procedure_256(const s: string); //增强消耗类处理
      procedure draw_text_17(const s: string; flag: integer; c: Tcolor; f_size: integer=32); //画出特效文字
                           //画多行文字
       procedure draw_text_17_m(st1: Tstringlist; flag: integer; c: Tcolor);
      procedure game_Animation_base1(up: boolean);  //文字的动画，用于攻击等过程
      procedure game_Animation_base2(up: boolean);
      procedure game_Animation_base3(up: boolean);
      procedure game_Animation_base4(up: boolean);
      procedure game_Animation_base5(up: boolean);
                              {显示血值，显示位置（上下），值，人物编号，类型（血，体力，灵力}
      procedure game_show_blood(up: boolean; value: integer; id: integer; type1: integer);
                               //添加一个物品到定时作用列表,参数物品id，人物编号
      procedure game_add_to_goods_time_list(id: integer);
      function game_get_xtl_values(p,v,t: integer): integer; //根据v值来决定返回我方人物全值，半值，原值
                     //根据v值来决定返回怪物全值，半值，原值
      function game_get_xtl_values_guai(p,v,t: integer): integer;
      function game_return_filter(p: integer;type1: integer): Tmtl_rec; //返回运速攻防定时过滤器的值

      function is_can_jingyan(p: integer): boolean; //是否可接受经验值，参数是上场人物编号

      procedure game_hide_role(n: string); //两个人被单词时，临时隐藏其他人，参数为需要显示的人
      procedure game_unhide_role; //取消临时隐藏

                 //法术的等级过滤，返回值为等级，无等级的返回10，法术的升级在此过程内
      function game_fashu__filter(var i: integer): integer;
      procedure game_wordow_Animate(form: Tform); //动画显示窗口
      function lingli_is_ok(const s: string): boolean; //比对当前人物的灵力是否够发挥法术
      procedure tili_add_100; //体力增加百分之一
      procedure add_to_errorword_list(id: integer); //添加一个错误单词到列表
      procedure clear_errorword_list; //清空链表

      function get_Random_EXX: integer;
      function get_abhs_value: integer;
      procedure get_word_fen(out f: T_word_QianHouZhui;const s: string); //取得单词分色
      procedure g_game_delay(i: integer); //延迟
      procedure g_guai_A_next; //怪物动画过后的后续操作
      procedure g_wo_A_next; //我方动画过后的后续操作
      procedure G_huifu_next; //恢复术后续操作
      function g_get_roleAndGuai_left(i: integer): integer; //取得怪或者人物的左边坐标
      procedure g_miao_shou(g_id,s_id: integer); //偷窃术
      procedure kuaijie_12345(id: integer); //快捷键1-5
      function need_wait: boolean;  //攻击或者法术是否进行中
      procedure clean_lable2_11; //清除排名
      procedure write_label2_11; //刷新排名
      procedure show_fashuwupin_k(const s: string); //显示法术物品快捷内容到按钮
      procedure show_hint_button; //显示按钮的快捷键
      procedure play_sound(i: integer); //播放音效
      function create_net_guai(id: integer): boolean; //创建来自网络的怪列表
      function sid_to_roleId(sid: integer): integer; // 从sid转换为role或者guai的屏幕id
      function roleId_to_sid(roleid: integer): integer; // 从role或者guai的屏幕id转换为sid
      procedure gong_js(f,j,w: integer;guai: boolean); //计算我方攻击伤害值，最后一个参数，表明是否计算怪
      procedure huifu_js(f,j,w: integer); //计算恢复值
      procedure huifu_donghua; //恢复动画
      procedure HandleCTLColorEdit(var Msg: TWMCTLCOLOREDIT);message WM_CTLCOLOREDIT;
      procedure wuziqi_msg(var Msg: TMessage);message wuziqi_msg_c;  //五子棋引擎来的消息
      procedure wuziqi_sendstr(s: string); //发送五子棋命令
      procedure create_edit_bmp(s: string); //给edit 贴个底图
      function get_comp_word: boolean;
      procedure set_Action_az; //设置快捷键
      procedure show_bubble_on_scr; //显示泡泡龙到屏幕
      procedure show_wuziqi_on_src; //显示五子棋到屏幕
      procedure show_a_word_on_wzq; //在五子棋时显示一个单词
      procedure create_top_ad; //创建一个网页广告小窗口
  public
    { Public declarations }
    game_pop_count: integer; //单词显示的次数
    game_pop_type: integer;  //1，背单词，2，挖矿，3，战斗，4，打擂台，5两个人背单词
    game_is_a: boolean; //是否动画显示窗口
    game_monster_type: integer; //怪物类型，该值不为零时，pop_count为怪物的数量
    game_en_size,game_cn_size: integer;
    game_speed_a: boolean; //过场动画速度
    game_is_sooth: boolean; //优先使用真人发音
    game_opengl_d: boolean; //opengl当前不支持硬件加速，禁用动画
    game_rep: integer;//单词错误重复，单词分色
    game_m_color: integer;//单词错误重复，单词分色
    game_tingli_i: integer; //听力练习
    game_not_bg_black: boolean; //黑色背景是否开启
    game_bmp_width: integer;   // 单词和解释的宽度
    g_word_show_left: integer; //单词和解释显示的左边位置
    game_love_word_role: string; //两个人背单词时需要显示的另一个人
    stringlist_abhs5,stringlist_abhs30,stringlist_abhs240: Tstringlist; //艾宾浩斯记录
    stringlist_abhs_d1,stringlist_abhs_d2,stringlist_abhs_d4,stringlist_abhs_d7,stringlist_abhs_d15: Tstringlist;
      game_kaoshi: integer; //考试次数的倒计时
      wordlist1: Tstringlist;
      SpVoice1: TSpVoice;
     function get_word_safe(i: integer): string;  //带错误检查的获取单词，一般用此函数返回
     procedure show_ck;    //载入词库
     procedure show_ad(add_i: integer); //刷新广告显示
     procedure skp_string(const s: string);
     procedure skp_string_tongbu(const s: string);
     procedure draw_random_pic_base(b: Tbitmap;one: boolean=false); //随机画树木
     procedure draw_random_grass(b: Tbitmap); //随机画草
     procedure draw_random_XX(bt: Tbitmap;flag: integer); //随机画多种植物
     procedure leiji_show; //显示累计正确或者错误的信息
     procedure del_word_in_lib; //删除一个单词
     procedure add_lib;  //导入词库
     procedure out_Lib; //导出词库
     function start_show_word(h_b: boolean): string; //显示随机单词
     function game_upgrade(p: integer): integer; //游戏人物升级，返回值为新的级数，为零表示没有升
     procedure game_kptts_init; //初始化金山真人发音单元
     function game_can_spvoice1: boolean; //检测tts模块是否存在
     function game_get_opengl_info: string;
     procedure del_a_word;
     procedure gong; //攻击
     procedure laod_fashu_wupin_k(const s: string); //载入法术物品快捷键
     procedure save_fashu_wupin_k(const s: string); //保存法术物品快捷键
     procedure init_weizi;  //初始化单词位置
     procedure init_tiame_day_abhs; //初始化艾宾浩斯指针
     procedure save_abhs; //保存abhs表
     procedure del_abhs; //删除abhs表
     function get_error_words: string; //返回当前有错误的单词
     procedure load_abhs;
     procedure save_set(const s: string); //保存部分设置
     procedure load_game_progress(const filename: string);
     procedure CreateParams(var Para:TCreateParams);override;
     function get_pop_string(c: integer): string; //返回字符串类型的弹出窗口
     function html_asw_string(c: integer): string; //返回答案回答后的html
     procedure net_cmd_center(c,d1,d2: integer; sid: word); //联网时，控制权接受命令中心
     procedure net_cmd_send_center; //联网时，命令发送中心
     function get_Word_id:integer; //获取一个单词号 有错误单词时会优先取得

                     {联网时动画指令接收}
     procedure      net_rec_game_cmd(fq_sid: word;   //发起方sid
                                  js_sid: word;    //接受方（受攻击方）sid
                                  fq_m: integer;
                                  fq_t: integer;   //命体灵，发起方传送的是新值
                                  fq_l: integer;
                                  js_m: integer;   //接受方传送的是差值
                                  js_t: integer;
                                  js_l: integer;
                                  flag: word;    //类型，指名是0无动画，1，物理攻击，2法术攻击，3物品攻击，4物品恢复，5法术恢复，6,防7逃
                                  wu: word);
  end;

 {$IFDEF IBM_SPK}
 type
  Tjit_spk = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    spk: string;
    constructor create(COM_232:string);
  end;

  function eciSpeakText(text: pchar; annot: boolean): integer; stdcall; external 'ibmeci.dll';
  function eciNew: thandle; stdcall; external 'ibmeci.dll';
   function eciDelete(h: thandle): integer; stdcall; external 'ibmeci.dll';
  function eciSynthesize(h: thandle): integer; stdcall; external 'ibmeci.dll';
  function eciAddText(h: thandle ; s: pchar): integer; stdcall; external 'ibmeci.dll';
  function eciSynchronize(h: thandle): integer; stdcall; external 'ibmeci.dll';
  function eciCopyVoice(h: thandle; i: word; j: word): integer; stdcall; external 'ibmeci.dll';
  function eciSetVoiceParam(h: thandle; i: word; j: word; k: word): integer; stdcall; external 'ibmeci.dll';
  {$ENDIF}

  function get_caoshi_list_value(sid: word): boolean;     //取得是否超时，默认2次即被托管
  procedure set_caoshi_list_value(sid: word); //增加超时次数一，如果sid为无效值，则初始化
var
  Form_pop: TForm_pop;
  GameSave1:TGameSave;
  f_type_g: integer; //选择的类型，攻，防，速，物，逃
  speed_limt_G: integer; //速度上限
//  kp_tts: TKDVoice;
  game_init_Success_G: boolean;
  game_tianqi_G: integer; //是否指定天气效果
  game_error_word_list_G: array[0..63] of word; //错误单词数组

  text_show_array_G: array[0..5] of T_zhi_piaodong; //飘动值 5用于倒计时显示
  g_hint_array_g: array[0..14] of string;  //提示信息，0-4我方提示，5-9怪提示 10-15攻，防……提示
  mouse_down_xy: Tpoint;
  caoshi_list1: array[0..9] of T_caoshi_list; //超时列表
  mtl_game_cmd_dh1: Tgame_cmd_dh; //命体灵功放参数
  bubble_boll_g_array: array[0..g_boll_14_cn,0..g_boll_21_cn] of dword; //泡泡龙球数组，0表示无球，其他表示某个颜色的球
       {bubble_boll_g_array,0..3byte，3表示颜色球索引，1表示宽，2表示高，0表示是否处于同色统计内}
  bubble_data1: Tbubble_data;
  wuziqi_tread: Twuziqi;
  wuziqi_rec1: twuziqi_rec; //五子棋状态记录
  {$IFDEF IBM_SPK}
  jit_spk1: Tjit_spk;
  jit_h: thandle;
  {$ENDIF}
implementation
   uses { VectorGeometry, } unit1, Unit_goods, AAFont, inifiles,FastStrings,
        Registry,unit_net,unit_chinese,unit_mp3_yodao,unit_show,unit_msg;
{$R *.dfm}
function get_caoshi_list_value(sid: word): boolean;     //取得是否超时，默认2次即被托管
var i: integer;
begin
result:= false;

  for i:= 0 to 9 do
   if (caoshi_list1[i].sid= sid) and (caoshi_list1[i].caoshi >= 2) then
      result:= true; //超时两次的，就返回true
end;

procedure set_caoshi_list_value(sid: word); //增加超时次数一，如果sid为无效值，则初始化
var i: integer;
begin
     if sid= g_nil_user_c then
      begin
        for i:= 0 to 9 do
           begin
            caoshi_list1[i].sid:= g_nil_user_c;
            caoshi_list1[i].caoshi:= 0;
           end;
      end else begin
                for i:= 0 to 9 do
                  if caoshi_list1[i].sid= sid then
                      begin
                        caoshi_list1[i].caoshi:= caoshi_list1[i].caoshi + 1;
                        exit;
                      end else if caoshi_list1[i].sid= g_nil_user_c then
                                  begin
                                   caoshi_list1[i].sid:= sid;
                                   caoshi_list1[i].caoshi:= 1;
                                  end;
               end;

end;

{ jit_spk }
 {$IFDEF IBM_SPK}
constructor Tjit_spk.create(COM_232: string);
begin
  inherited create(false);
  freeonterminate:=false;
end;

procedure Tjit_spk.Execute;
var m: TMsg;
begin
 jit_h:= eciNew; //创建语音实例
 eciSetVoiceParam(jit_h, 0, 7, 99); //设置音量
 while not Terminated do
  begin
    while getMessage(M,0,0,0) do
    begin
      if m.message=um_ontimer  then
      begin
       eciAddText(jit_h, pchar(spk));
       eciSynthesize(jit_h);
       eciSynchronize(jit_h);
       // eciSpeakText(pchar(spk),false);//处理
      end;
      if m.message=um_quitthread then
        break;
    end;
  end;

 eciDelete(jit_h); //删除语音实例
end;
{$ENDIF}

function boll_can_stk(y,x,by: integer): boolean;   //参数为 row，col 行在前，列在后
begin
    {bubble_boll_g_array,0..3byte，3表示颜色球索引，1表示宽，2表示高，0表示是否处于同色统计内}
result:= false;
if (y> g_boll_14_cn) or (x >g_boll_21_cn) or
   (y<0) or (x <0)then
  exit;

   if LongRec(bubble_boll_g_array[y,x]).Bytes[3] > 0 then
     result:= false
     else if y=0 then
           result:= true
           else if x=0 then
                 begin
                   if y mod 2= 0 then
                    begin //偶数行 少判断一球
                     if (LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]> 0) or
                        (LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]> 0)  then
                        result:= true;

                    end else begin  //奇数行
                               if (LongRec(bubble_boll_g_array[y-1,x]).Bytes[3] > 0)or
                                  (LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3] > 0) or
                                  (LongRec(bubble_boll_g_array[y,x+1]).Bytes[3] > 0)  then
                               result:= true;
                             end;
                 end else if g_boll_21_cn- y mod 2 = x then //到了右边缘，奇数行少一个球
                           begin
                            if y mod 2= 0 then
                            begin //偶数行 少判断一球
                                 if (LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3] > 0) or
                                    (LongRec(bubble_boll_g_array[y,x-1]).Bytes[3] > 0)  then
                                    result:= true;

                            end else begin  //奇数行
                                           if x= g_boll_21_cn then
                                            result:= false
                                            else
                                           if (LongRec(bubble_boll_g_array[y-1,x]).Bytes[3] > 0)or
                                              (LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3] > 0) or
                                              (LongRec(bubble_boll_g_array[y,x-1]).Bytes[3] > 0)  then
                                           result:= true;
                                     end;
                           end else begin
                                     //中间位置
                                     if y mod 2= 0 then
                                     begin //偶数行 少判断一球
                                          if (LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3] > 0) or
                                             (LongRec(bubble_boll_g_array[y-1,x]).Bytes[3] > 0) or
                                             (LongRec(bubble_boll_g_array[y,x-1]).Bytes[3] > 0) or
                                             (LongRec(bubble_boll_g_array[y,x+1]).Bytes[3] > 0) then
                                             result:= true;

                                     end else begin  //奇数行
                                                   if x= g_boll_21_cn then
                                                   result:= false
                                                   else
                                                    if (LongRec(bubble_boll_g_array[y-1,x]).Bytes[3] > 0)or
                                                       (LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3] > 0) or
                                                       (LongRec(bubble_boll_g_array[y,x-1]).Bytes[3] > 0) or
                                                       (LongRec(bubble_boll_g_array[y,x+1]).Bytes[3] > 0) then
                                                    result:= true;
                                              end;

                                    end;
end;

procedure Random_boll(r: integer);
var i,j: integer;
begin
  //随机球设置
    {bubble_boll_g_array,0..3byte，3表示颜色球索引，1表示宽，2表示高，0表示是否处于同色统计内}
  for i:= 0 to g_boll_14_cn -1 do //最多设置12行，空两行
   begin
     for j:= 0 to g_boll_21_cn do
      begin
       if r= 0 then
          exit;
        
       if (Random(2)= 1) and boll_can_stk(i,j,0) then
          begin
           dec(r);
           LongRec(bubble_boll_g_array[i,j]).Bytes[3]:= Random(7)+1;
           LongRec(bubble_boll_g_array[i,j]).Bytes[1]:= 32; //宽
           LongRec(bubble_boll_g_array[i,j]).Bytes[2]:= 32; //高
          end;
      end;
   end;


end;

procedure TForm_pop.FormShow(Sender: TObject);
var i: integer;
    p2: p_user_id_time;
begin
  button14.Visible:= DebugHook=1;
 //如果联网的，设置本小队内的自由派人物隐藏
 AsphyreTimer1.Enabled:= true;
    set_caoshi_list_value(g_nil_user_c);
  if game_at_net_g then
   begin
     set_caoshi_list_value(g_nil_user_c); //初始化超时
     for i:= 1 to Game_role_list.Count- 1 do
       begin
         if Assigned(Game_role_list.Items[i]) then
          begin
            p2:= get_user_id_time_type(Tplayer(game_role_list.Items[i]).plvalues[34]);
            if p2<> nil then
             begin
              if p2.xiaodui_dg= 0 then
                 Tplayer(game_role_list.Items[i]).plvalues[ord(g_hide)]:= 0
                 else
                   Tplayer(game_role_list.Items[i]).plvalues[ord(g_hide)]:= 1; //玩家自由行动的，隐藏，否则，显示
             end;
          end;
       end;
   end;
      
   if game_speed_a then
          Timer_donghua.Interval:= game_amt_delay div 2
          else
            Timer_donghua.Interval:= game_amt_delay; //动画速度

 Game_wakuan_zhengque_shu:= 0; //挖矿正确数清零

 game_musmv_ready:= false;
 clean_lable2_11; //清除排队显示

    g_guai_show1:= false; //怪物不显示
    g_guai_show2:= false;
    g_guai_show3:= false;
    g_guai_show4:= false;
    g_guai_show5:= false;

 Game_not_save:= true;


     //根据类型初始化场面
  show_text(false,'');
  show_text(true,'');
  g_show_result_b:= false;
   groupbox3.Visible:= false;
   g_gong.xianshi:= false;
    un_highlight_my(-1);
    un_highlight_guai(-1);


    for i:= 0 to 9 do
        game_p_list[i]:= 0;

     //下雨雪天气效果
     if game_tianqi_G > -1 then
      begin
     if (Random(9)= 0) or (game_tianqi_G > 0) then
      begin
      g_particle_rec.xian:= true;
        if game_tianqi_G > 0 then
           i:= game_tianqi_G
           else
            i:= Random(5);
      case i of
      0,1: begin
        g_particle_rec.xuli:= 0; //大雪，飘落
        g_particle_rec.xiaoguo:= 0; //随机漂落
       end;
       2: begin
         g_particle_rec.xuli:= 1; //大雨
        g_particle_rec.xiaoguo:= 1; //固定方向漂落
       end;
       3: begin
        g_particle_rec.xuli:= 2; //火焰，随机飘落
        g_particle_rec.xiaoguo:= 0;
       end;
       4: begin
        g_particle_rec.xuli:= 3; //小雪，飘落
        g_particle_rec.xiaoguo:= 0; //随机漂落
       end;
       end; //end case
      end else g_particle_rec.xian:= false;
      end; //end if game_tianqi_G

   //pk_zhihui_g.game_zt: integer;   //0场景状态，1，背单词，2挖矿，3采药，4，打坐，5比赛，6战斗
    jit_num:= 1;

     if game_pop_type<> 7 then
       wuziqi_rec1.word_showing:= false;
       
  case game_pop_type of
   1: begin//背单词，
        //隐藏怪物
          pk_zhihui_g.game_zt:= 1; //当前状态

          game_beijing_index_i:= Random(2)+ 1; //背景图编号
         game_kaoshi:= game_pop_count * 3+5;
        caption:= '背单词'+ inttostr(game_pop_count) + '个';
        game_can_close:= true;
        dec(game_pop_count);
       // start_show_word;
        postmessage(handle,game_const_star_war,6,8);
        //显示剩余单词数
      end;
   2: begin//挖矿
        pk_zhihui_g.game_zt:= 2;

        game_beijing_index_i:= Random(2)+ 3; //背景图
       game_can_close:= true;
       if game_pop_count= 200 then
       begin
       caption:= '采药，可随时结束';
       pk_zhihui_g.game_zt:= 3;
       end else  if game_pop_count= 300 then
        begin
         caption:= '打坐，可随时结束';
         pk_zhihui_g.game_zt:= 4;
        end else if game_pop_count> 1000 then
        begin
         caption:= '考试 '+ inttostr(game_pop_count- 1000) + '个';
         game_kaoshi:= (game_pop_count- 1000) * 3+5;
        end else
             caption:= '挖矿，可随时结束';
       //dec(game_pop_count);
      // start_show_word;
       postmessage(handle,game_const_star_war,6,8);
      end;
   3,4: begin//战斗，打擂
         
         game_beijing_index_i:= Random(3)+ 5; //背景图
        game_can_close:= false;
        if game_pop_type= 3 then
          begin
            caption:= '战斗';
            pk_zhihui_g.game_zt:= 6;
          end   else  begin
                        caption:= '战斗'; //打擂
                        pk_zhihui_g.game_zt:= 5;
                      end;
        groupbox3.Visible:= false;
        g_gong.xianshi:= false;
       create_guai_list; //创建怪物列表
       draw_game_guai(-1); //画出全部怪物
       //启动战斗
       Fgame_guai_cu:= 0; //默认第一个怪参战
       Fgame_my_cu:= get_r_role_id; //取得一个上场人物的随机id

          //初始速度减去
       dec(game_p_list[0],game_get_role_su(0));
       dec(game_p_list[5],game_get_guai_su(0));
         speed_limt_G:= game_get_role_su(0) * 20; //速度统计的上限，为20倍。
         {速度统计的倍数越高，统计误差越小，但要相应调整每秒的统计次数，20倍时误差约为5%}
         Timer4.Enabled:= true; //速度统计定时器开始
       postmessage(handle,game_const_star_war,6,6);
      end;
   5: begin//两个人背单词，隐藏其他人
         game_beijing_index_i:= Random(2)+ 1; //背景图
        caption:= '两人背单词'+ inttostr(game_pop_count) + '个';
        game_can_close:= true;
        game_hide_role(game_love_word_role);
        dec(game_pop_count);
       // start_show_word;
        postmessage(handle,game_const_star_war,6,8);
        //显示剩余单词数
      end;
   6: begin //泡泡龙
        game_beijing_index_i:= 2; //背景图
        caption:= '泡泡龙 - '+ inttostr(game_pop_count);
        game_can_close:= true;
        game_hide_role('无');
        //清空泡泡龙数组
        fillchar(bubble_boll_g_array,sizeof(bubble_boll_g_array),0);
        //初始化泡泡
         Random_boll(game_pop_count);
        //状态设置为进入泡泡龙
        pk_zhihui_g.game_zt:= 1; //背单词状态
        show_text(false,'左右箭头移动，向上箭头发射');

        //加载泡泡龙图片
        if not assigned(image_bubble) then
          begin
           image_bubble:= tasphyreimage.Create;
           with image_bubble do
           begin
           Size:= point(128,64);
           VisibleSize:= point(128,64); //设置大小
           PatternSize:= point(128,64);
           end;
            image_bubble.LoadFromFile(game_app_path_G+ 'img\bubble2.bmp',true,0,0);
           imgae_arrow:= tasphyreimage.Create;
           with imgae_arrow do
           begin
           Size:= point(64,64);
           VisibleSize:= point(64,64); //设置大小
           PatternSize:= point(64,64);
           end;
            imgae_arrow.LoadFromFile(game_app_path_G+ 'img\zhizhen.bmp',true,0,0);

           AsphyreImages1.AddFromFile(game_app_path_G+ 'img\bubble.png',point(32,32),point(32,32),point(64,128),aqMedium,alMask,true,$FF000000,0);
          end;
        bubble_data1.next_color:= Random(7); //初始化待发射泡泡颜色
        bubble_data1.arrow_Angle:= 0; //初始化箭头位置
        bubble_data1.boll_show:= false; //移动的球隐藏
        postmessage(handle,game_const_star_war,6,8); //最后一个参数为8时，仅仅启动背单词，不会再修改当前游戏状态
      end;
      7: begin
           //五子棋
           // game_pop_count:= 0;  //据说白痴级的最厉害，所以五子棋都用这个了
            if game_pop_count>0 then
               dec(game_pop_count);

          case game_pop_count of
          0: begin
              wuziqi_tread:= twuziqi.Create(game_app_path_G+'pela.exe',handle);  //白痴级，思考最多1秒
              caption:= '五子棋 - 白痴级';
              sleep(500);
              wuziqi_sendstr('info timeout_turn 1000');
             end;
          1: begin
              wuziqi_tread:= twuziqi.Create(game_app_path_G+'pela.exe',handle);  //初级，思考最多4秒
              caption:= '五子棋 - 入门级';
              sleep(500);
              wuziqi_sendstr('info timeout_turn 4000');
             end;
          2: begin
              wuziqi_tread:= twuziqi.Create(game_app_path_G+'pela.exe',handle); //中级，思考最多8秒
               caption:= '五子棋 - 熟练级';
               sleep(500);
               wuziqi_sendstr('info timeout_turn 8000');
             end;
          3: begin
              wuziqi_tread:= twuziqi.Create(game_app_path_G+'Tito.exe',handle); //高级，思考最多5秒
               caption:= '五子棋 - 中级';
               sleep(500);
              wuziqi_sendstr('info timeout_turn 5000');
              end;
          else
            //最高
            wuziqi_tread:= twuziqi.Create(game_app_path_G+'Tito.exe',handle);//思考最多18秒
             caption:= '五子棋 - 高级';
             sleep(500);
              wuziqi_sendstr('info timeout_turn 18000');
          end;
          fillchar(wuziqi_rec1,sizeof(Twuziqi_rec),0);
          game_beijing_index_i:= 8; //背景图
          game_can_close:= true;
         //清空五子棋数组
          fillchar(bubble_boll_g_array,sizeof(bubble_boll_g_array),0);
        //初始化五子棋

        //状态设置为进入泡泡龙
        pk_zhihui_g.game_zt:= 1; //背单词状态
        //加载图片
        if AsphyreImages1.Image['bubble.png']=nil then
          begin
           AsphyreImages1.AddFromFile(game_app_path_G+ 'img\bubble.png',point(32,32),point(32,32),point(64,128),aqMedium,alMask,true,$FF000000,0);
          end;
         g_dangqian_zhuangtai:= g_wuziqi1; //设置状态为可下子
         if not Assigned(form_chinese) then
            form_chinese:= TForm_chinese.Create(application);  //创建中文朗读引擎
         end; //end 7
   end; //end case


try
   draw_game_role(-1); //显示人物
except
 raise Exception.Create('错误位置，5.1');
end;


  if game_is_a then
     game_wordow_Animate(self);


  game_is_a:= false; //显示完成后设置为不显示
    game_musmv_ready:= true;
     AsphyreTimer1.Enabled:= game_init_Success_G;

    if game_beijing_index_cur <> game_beijing_index_i then
     begin
     image_bg_1_1.LoadFromFile(game_app_path_G+ 'img\bg'+ inttostr(game_beijing_index_i)+'-1.jpg',false,0,0);
     image_bg_1_2.LoadFromFile(game_app_path_G+ 'img\bg'+ inttostr(game_beijing_index_i)+'-2.jpg',false,0,0);

      game_beijing_index_cur:= game_beijing_index_i;
     end;

  show_hint_button; //显示按钮提示;

  Timer_donghua.Enabled:= true;
end;

function kongge2(const s: string): integer;
var i: integer;
begin
 if length(s)<= 2 then
 result:= 2
 else
   result:= 0;

   for i:= 1 to length(s) do
       if s[i]= ' ' then
         inc(result);

   if result= 0 then
     if ByteType(s,1)= mbLeadByte then
        result:= 2; //如果是中文，也不朗读
end;

procedure TForm_pop.skp_string(const s: string);
var b: boolean;
begin
 {$IFDEF IBM_SPK}
  if not Assigned(jit_spk1) then
    begin
    jit_spk1:= Tjit_spk.create('hello');
    sleep(500);
    end;

  jit_spk1.spk:= s;
  postthreadmessage(jit_spk1.ThreadID,um_ontimer,0,0);
  {$ENDIF}

 {$IFDEF MS_SPK}
  //语音合成 ,其中bd_vsp=参数仅支持百度语音
   if game_bg_music_rc_g.yodao_sound=false then
      b:= pos('bd_vsp=',s)>0;

   if game_bg_music_rc_g.yodao_sound or b then
    begin
      //1，用udp取得id，2，用id取得声音，3，声音加入base.dll，4，朗读
      //改用百度的mp3文件
      if not Assigned(mp3_yodao1) then
     begin
      if token='' then
       begin
        if not assigned(form_msg) then
         form_msg:= tform_msg.Create(application);

         form_msg.Timer1.Enabled:= true;
         form_msg.Show;
       end;

     mp3_yodao1:= Tmp3_yodao.Create(game_doc_path_G+'tmp\',form_chinese.Handle);

           if game_guid='' then
                game_guid:= form1.game_create_guid;


     mp3_yodao1.guid:= game_guid;
     end;

      mp3_yodao1.file_name:= trim(s); //下载的文件名
      mp3_yodao1.Resume;

      //空格替换为%20，然后替换掉支付串内的word位置，然后发出
      //等收到消息后，再次获得mp3，然后朗读
    end else
    
   if game_is_sooth then
   begin
    showmessage('金山词霸朗读已不支持，请启用百度在线语音合成。');
  {   if kp_tts= nil then exit;
    if kp_tts.IsExistSoundEx(s) then
     begin
      try
       kp_tts.PlaySound(s);
      except
       game_is_sooth:= false;
      end;
     end else begin
                try
               if SpVoice1= nil then
                  SpVoice1:= TSpVoice.Create(application);

                SpVoice1.Speak(s, SVSFlagsAsync);
                except
                  game_bg_music_rc_g.yodao_sound:= true;
                  showmessage('初始化tts组件出错，已经启动百度语音，接下来可以继续朗读。');

                end;
              end; }
   end else     
           begin
                try
                if SpVoice1= nil then
                  SpVoice1:= TSpVoice.Create(application);


                 SpVoice1.Speak(s, SVSFlagsAsync);
                except
                  game_bg_music_rc_g.yodao_sound:= true;
                  showmessage('初始化tts组件出错，已经启动百度语音，接下来可以继续朗读。');
                  skp_string(s); //再次递归调用
                end;
             end;
 {$ENDIF}
end;

procedure TForm_pop.skp_string_tongbu(const s: string);
begin
   SpVoice1.Speak(s, SVSFDefault);
end;

procedure TForm_pop.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
edit1.Visible:= false;

 if not game_can_close then
  begin
   if not can_escape then
     begin
     if Game_cannot_runOff then
     show_text(false,'禁止逃跑。')
     else
      show_text(false,'逃跑失败。');
      CanClose:= false;
      if g_gong.xianshi then
         button5click(sender)
         else
           check_asw(2,false);
     end;
  end else begin
              if Game_wakuan_zhengque_shu > 0 then
               begin
                if Game_wakuan_zhengque_shu > 100 then
                   Game_wakuan_zhengque_shu:= 100;

                form1.game_attribute_change(0,19,Game_wakuan_zhengque_shu * Game_wakuan_zhengque_shu
                                                 div 10); //全体增加经验值1000
                 show_text(false,'额外奖励经验值：'+ inttostr(Game_wakuan_zhengque_shu * Game_wakuan_zhengque_shu
                                                 div 10));
                 G_game_delay(1000);

                 game_up_role; //人物升级
               end;
              // AnimateWindow(Handle,400,AW_BLEND or AW_HIDE);
           end;

end;

procedure TForm_pop.word_lib_save;
var ss: string;
begin
  {保存词库}
  case messagebox(handle,'选择“是”替换当前词库为更改后的内容，选择“否”保存更新后的词库为一个新词库名。','保存词库', mb_yesnocancel or MB_ICONWARNING) of
  mrno: begin
          ss:= get_filename_ck(true);
          wordlist1.SaveToFile(ss);
          jit_del:= false;
          messagebox(handle,pchar('改动后的词库已经保存为新文件：'+ ss +' 当程序重新启动后会出现在可选择的词库列表内。'),'已保存', mb_ok or MB_ICONINFORMATION);

         end;
  mryes:  begin
         ss:= get_filename_ck(false);
          wordlist1.SaveToFile(ss);
          jit_del:= false;
          messagebox(handle,pchar('当前词库文件：'+ ss +' 已经更新。'),'已保存', mb_ok or MB_ICONINFORMATION);
         end;
  end;

end;

function TForm_pop.get_filename_ck(isNew: boolean): string;
var ss: string;
    i: integer;
begin
result:= '';

ss:= game_app_path_G+'Lib\'+ ComboBox1.Text;


 if isnew then
  begin
   {创建一个新文件名}
     ss:= copy(ss,1,length(ss)-4);
     if pos('\Lib\',ss)= 0 then
      begin
        {如果是默认voa则插入搜索库目录}
        insert('\Lib',ss,pos('\words',ss));
      end;
     i:= 1;
      Repeat
       if not FileExists(ss + inttostr(i) + '.ini')then
        begin
         result:= ss + inttostr(i) + '.ini';
         break;
        end;
        inc(i);
      until i= 1024;
  end else begin
             {返回原文件名}
            result:= ss;
           end;

end;

procedure TForm_pop.del_word_in_lib;
var i : integer;
begin
 if messagebox(handle,'是否从词库中删除当前单词？','确认',mb_yesno or MB_ICONWARNING)= mryes then
  begin
   screen.Cursor:= crhourglass;
   wordlist1.Delete(jit_word_p);
      if part_size_g<> nil then
       begin
         for i:= 1 to high(part_size_g) do
          if part_size_g[i]= jit_word_p then
             begin
             part_size_g[i]:= 0;
             part_size_g[0]:= 0; //清空进度指示
             end;
       end;
      for i:= stringlist_abhs5.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs5.Strings[i],fastcharpos(stringlist_abhs5.Strings[i],',',1)+1,5)) then
             stringlist_abhs5.Delete(i);
        for i:= stringlist_abhs_d15.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs_d15.Strings[i],fastcharpos(stringlist_abhs_d15.Strings[i],',',1)+1,5)) then
             stringlist_abhs_d15.Delete(i);
        for i:= stringlist_abhs_d7.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs_d7.Strings[i],fastcharpos(stringlist_abhs_d7.Strings[i],',',1)+1,5)) then
             stringlist_abhs_d7.Delete(i);
       for i:= stringlist_abhs_d4.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs_d4.Strings[i],fastcharpos(stringlist_abhs_d4.Strings[i],',',1)+1,5)) then
             stringlist_abhs_d4.Delete(i);
      for i:= stringlist_abhs_d2.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs_d2.Strings[i],fastcharpos(stringlist_abhs_d2.Strings[i],',',1)+1,5)) then
             stringlist_abhs_d2.Delete(i);
     for i:= stringlist_abhs_d1.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs_d1.Strings[i],fastcharpos(stringlist_abhs_d1.Strings[i],',',1)+1,5)) then
             stringlist_abhs_d1.Delete(i);
    for i:= stringlist_abhs240.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs240.Strings[i],fastcharpos(stringlist_abhs240.Strings[i],',',1)+1,5)) then
             stringlist_abhs240.Delete(i);
      for i:= stringlist_abhs30.Count- 1  downto 0 do
          if jit_word_p = strtoint2(copy(stringlist_abhs30.Strings[i],fastcharpos(stringlist_abhs30.Strings[i],',',1)+1,5)) then
             stringlist_abhs30.Delete(i);
   jit_del:= true;
   start_show_word(false);
   screen.Cursor:= crdefault;
  end;

end;

procedure TForm_pop.leiji_show;  //显示累计信息
var ss: string;
   i,j: integer;
begin

  gamesave1.leiji:= gamesave1.leiji + Trunc((now - jit_kssj) *24*60*60); //更新时间
   jit_kssj:= now; //保存新的起始时间点
   i:= gamesave1.leiji div 86400;
   ss:= inttostr(i) + '天 ';
    j:= gamesave1.leiji - i * 86400;   //一天内的秒数
    i:= j div 3600;
    ss:= ss + inttostr(i) + '小时：';
    j:= j - i * 3600; //剩下的秒数
    i:= j div 60;
    ss:= ss + inttostr(i) + '分：';
    j:= j- i * 60;
    ss:= ss + inttostr(j) + '秒';
  messagebox(handle,pchar('累计游戏时间：'+ ss + #13#10 +
  '累计正确的点击：'+ inttostr(gamesave1.zqbs)+ #13#10 +
  '累计错误的点击：'+inttostr(gamesave1.cwbs)),'信息',mb_ok or MB_ICONINFORMATION);


end;

procedure TForm_pop.FormDestroy(Sender: TObject);
begin

  if jit_del then
  begin
  if messagebox(handle,'词库文件被更改，是否保存此更改？','保存词库', mb_yesno or MB_ICONWARNING)= mryes then
     word_lib_save;

  end;

  {$IFDEF IBM_SPK}
  if Assigned(jit_spk1) then
   begin
    jit_spk1.Terminate;
    postthreadmessage(jit_spk1.ThreadID,um_quitthread,0,0);
    jit_spk1.Free;
   end;
   {$ENDIF}

   wordlist1.Free;

   if Assigned(goods_time_list) then
   goods_time_list.Free;

 game_word_qianzhui.Free;
 game_word_houzhui.Free;
      stringlist_abhs5.Free;
     stringlist_abhs30.Free;
    stringlist_abhs240.Free;
    stringlist_abhs_d1.Free;
    stringlist_abhs_d2.Free;
    stringlist_abhs_d4.Free;
    stringlist_abhs_d7.Free;
   stringlist_abhs_d15.Free;

 fashu_wupin_kuaijie_list.Free;

    image_word.Free;
    image_cn1.Free ;
    image_cn2.Free ;
    image_cn3.Free ;
    image_up.Free  ;
    image_down.Free;

    image_guai1.Free;
    image_guai2.Free;
    image_guai3.Free;
    image_guai4.Free;
    image_guai5.Free;

       image_role1.Free;
       image_role2.Free;
       image_role3.Free;
       image_role4.Free;
       image_role5.Free;

    image_result1.Free;
     g_icon_image.Free;
     image_bg_1_1.Free;
     image_bg_1_2.Free;
  if assigned(image_bubble) then
     image_bubble.Free;
  if assigned(imgae_arrow) then
     imgae_arrow.Free;
  if Assigned(game_edit1_bmp) then
        game_edit1_bmp.Free;

 AsphyreDevice1.Finalize();
end;

procedure TForm_pop.show_check(i: integer);
begin

  checkbox2.Checked:= false;
  checkbox3.Checked:= false;
  checkbox8.Checked:= false;


  if GameSave1.zhuangtai and 2 = 2 then
   checkbox2.Checked:= true;
  if GameSave1.zhuangtai and 4 = 4 then
   begin
   checkbox2.Checked:= false;
    checkbox2.Enabled:= false;
    checkbox3.Checked:= true;
   end;
 { if GameSave1.zhuangtai and 8 = 8 then
   checkbox4.Checked:= true;
  if GameSave1.zhuangtai and 16 = 16 then
   checkbox5.Checked:= true; 
  if GameSave1.zhuangtai and 32 = 32 then
   checkbox6.Checked:= true;
  if GameSave1.zhuangtai and 64 = 64 then
   checkbox7.Checked:= true;  }
  if GameSave1.zhuangtai and 128 = 128 then
   checkbox8.Checked:= true;
 { if GameSave1.zhuangtai and 256 = 256 then
   checkbox9.Checked:= true; }
end;

procedure TForm_pop.save_check;
begin
GameSave1.zhuangtai:= 0;

  if checkbox2.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai or 2;
 if checkbox3.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai or 4;
     {
 if checkbox4.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai + 8;
 if checkbox5.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai + 16;
 if checkbox6.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai + 32;
   if checkbox7.Checked then  }
   GameSave1.zhuangtai:= GameSave1.zhuangtai or 64;
  if checkbox8.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai or 128;
{  if checkbox9.Checked then
   GameSave1.zhuangtai:= GameSave1.zhuangtai + 256;  }
end;

procedure TForm_pop.My_FindFiles(sPath: string);
var
  sr:TSearchRec;
begin

  if FindFirst(sPath,faAnyFile,sr)=0 then
  begin
    if not((sr.Attr and faDirectory)>0) then
      combobox1.Items.Add(sr.Name);
    while FindNext(sr)=0 do
    begin
      if not((sr.Attr and faDirectory)>0) then
        combobox1.Items.Add(sr.Name);
    end;
  end;
  FindClose(sr);

end;

procedure TForm_pop.ComboBox1Change(Sender: TObject);
begin
if combobox1.ItemIndex= -1 then
   exit;
   
      if combobox1.text= '编辑下载更多词库……' then
            begin
             ShellExecute(Handle,
         'open','IEXPLORE.EXE',pchar('http://www.finer2.com/wordgame/wordlib.htm'),nil,sw_shownormal);
             ShellExecute(Handle,
         'open','IEXPLORE.EXE',pchar(game_app_path_G+'lib\'),nil,sw_shownormal);
             combobox1.ItemIndex:= combobox1.Tag;
            end else
               begin

            if FileExists(game_app_path_G+'Lib\'+ ComboBox1.Text) then
             begin
               if pos('句',combobox1.Text)> 0 then
                 begin
                  if game_bmp_width<> 512 then
                   begin
                    messagebox(handle,'您启用的词库包含句子，词条可能比较长,会显示不完全。建议您在游戏的“系统设置页面”内开启“单词栏双倍宽度”功能。','提示',mb_ok);
                   end;
                 end;
             combobox1.Tag:= combobox1.ItemIndex;
              wordlist1.Clear;
                wordlist1.LoadFromFile(game_app_path_G+'Lib\'+ ComboBox1.Text);
             g_string_abhs:= ComboBox1.Text + '.abhs';
             end else messagebox(handle,'词库文件被移走，请选择其他的试试。','文件不存在',mb_ok or MB_ICONERROR);
                     end;

    if g_string_abhs<> '' then
    load_abhs;

  if wordlist1.Count < 3 then
   begin
    messagebox(handle,'词库单词数过少，可能导致选词循环死锁。','严重错误',mb_ok or MB_ICONERROR);
    wordlist1.Add('aa=请修改词库');
    wordlist1.Add('bb=单词太少了');
    wordlist1.Add('cc=请增加单词');
   end;
end;

procedure TForm_pop.show_ck;
begin
  combobox1.Items.Clear;
 if DirectoryExists(game_app_path_G+'Lib') then
  begin
   My_FindFiles(game_app_path_G+ 'Lib\*.ini');
  end;

 combobox1.Items.Add('编辑下载更多词库……');
 if combobox1.Tag> 0 then
 combobox1.ItemIndex:= combobox1.Tag
 else
 combobox1.ItemIndex:= 0;
end;

procedure TForm_pop.CheckBox3Click(Sender: TObject);
begin
 if checkbox3.Checked then
  begin
  checkbox2.Checked:= false;
  checkbox2.Enabled:= false;
  end else begin
            checkbox2.Checked:= true;
            checkbox2.Enabled:= true;
           end;
end;

procedure TForm_pop.add_lib;  //导入词库文件
begin
  opendialog1.FilterIndex:= 1;
   if opendialog1.Execute then
    begin
     if not DirectoryExists(game_app_path_G+'Lib') then
        mkdir(game_app_path_G+'Lib');

    copyFile(pchar(opendialog1.FileName),pchar(game_app_path_G+'Lib\'+ExtractFileName(opendialog1.FileName)),false);
      show_ck;
     end;
end;

procedure TForm_pop.out_Lib;
begin
  savedialog1.DefaultExt:='.ini';
  savedialog1.FilterIndex:= 1;
   if savedialog1.Execute then
    begin

            if FileExists(game_app_path_G+'Lib\'+ ComboBox1.Text) then
             begin
              copyFile(pchar(game_app_path_G+'Lib\'+ ComboBox1.Text),pchar(savedialog1.FileName),false);
             end else messagebox(handle,'词库文件被移走，请选择其他的试试。','文件不存在',mb_ok or MB_ICONERROR);

    end;
end;

function TForm_pop.check_asw(i: integer; H_b: boolean): string;
//var int1:int64;
begin
result:= '';
game_state_answer:= true;
  g_tiankong:= false;
  
 if jit_tmp_3= -1 then
  exit;

      if h_b then
      begin
       game_pic_check_area:= G_all_pic_n; //禁止选中

       timer5.Enabled:= false;
       show_text(false,'');
      end;

    //绿色
    if not h_b then
    begin
    case jit_tmp_3 of
    0: draw_asw(game_word_1,1,2);
    1: draw_asw(game_word_2,2,2);
    2: draw_asw(game_word_3,3,2);
    end;
    end;

   if g_is_tingli_b and (not h_b) then
                begin
                     //听力状态 重新显示解释
                   draw_asw(Jit_words,0,0);
                   AsphyreTimer1Timer(self); //重画
                 end;

 if i= jit_tmp_3 then
  begin

    jit_time:= -1;
    inc(GameSave1.zqbs);
    if (g_on_abhs= false) and game_abhs_g then
    stringlist_abhs5.Append(inttostr(DateTimeToFileDate(now))+
                           ','+ inttostr(game_dangqian_word_id)); //增加一个记录到abhs表

     g_on_abhs:= false; //重新设置为false
    //选择正确，进一步处理
    inc(game_bg_music_rc_g.number_count); //本局背单词数量加一
       //显示到页面标题
       Form1.update_caption(game_bg_music_rc_g.number_count);
       
    if h_b then
    begin  //*************************************发送html
        tili_add_100; //体力增加
        
    if game_pop_count > 0 then
     begin
     dec(game_pop_count);
     inc(jit_num);
     result:= start_show_word(true);
     end else begin
               result:= '<tr><td>pass!</td></tr>';
               pk_zhihui_g.game_zt:=0;
               //执行后续命令
                postmessage(form1.Handle,game_const_script_after,36,0);
              end;
           //*********************************************
    end else after_check_asw(true);

  end else begin

              if h_b then
              begin
               result:= '<tr><td>答案错误</td></tr><tr><td>'+Jit_words +' 正确答案是：';
               pk_zhihui_g.game_zt:=0;
                  case jit_tmp_3 of
                    0: result:= result + game_word_1;
                    1: result:= result + game_word_2;
                    2: result:= result + game_word_3;
                    end;
                  result:= result + '</td></tr>';
              end else begin
               case i of
               0: draw_asw(game_word_1,1,1);
               1: draw_asw(game_word_2,2,1);
               2: draw_asw(game_word_3,3,1);
               end;
               jit_time:= -1;
             jit_tmp_3:= -1;
             inc(GameSave1.cwbs);
             //选择错误，红色显示，进一步处理
            if game_rep>= 0 then
               add_to_errorword_list(game_dangqian_word_id);
               
             after_check_asw(false);
                        end;
           end;


end;

function TForm_pop.start_show_word(h_b: boolean): string;
var ss,ss2,s_s: string;
    a,b,c,d,I_I: integer;
begin
//a:= 0;  h_s表示当 H_b为真时，向h_s写入html
   {
   在联网状态，且没有控制权，且不是自由模式，那么退出
   }
   game_state_answer:= false; //初始显示答案
   if edit1.Visible then
      edit1.Visible:= false;
   
    if game_at_net_g then
     begin
       if (game_player_head_G.duiwu_dg= 1) and (pk_zhihui_g.is_kongzhi= false) and (pk_zhihui_g.game_zt<>4) then
          exit;  //如果是完全跟随，且没有控制权，且不是打坐，那么单词不显示
       if (game_player_head_G.duiwu_dg= 2) and (pk_zhihui_g.is_kongzhi= false) and (pk_zhihui_g.game_zt >4) then
          exit;  //如果是打怪跟随，且没有控制权，且是战斗状态，那么单纯不显示
     end;


result:= '';
 time_list1.Timer_show_jit_word:= 0;
 time_list1.Timer_show_jit_alpha:= 0;
 
b:= 0; //使用在易错词库内，起到混淆作用

  game_pic_check_area:= G_all_Pic_n;


 jit_tmp_3:= Random(3);
 jit_time:= 0;
 I_I:= 0; //是否有填空出现

 jit_word_p:= get_Word_id; //取得单词编号，如果有错误重复选项，则会取回错误单词编号


  ss:= get_word_safe(jit_word_p);
  while ss='' do
   begin
    jit_word_p:= get_Word_id;
    ss:= get_word_safe(jit_word_p);
   end;

    c:= fastcharpos(ss,'=',1);

    if checkbox3.Checked then
     Jit_words:= copy(ss,c+1,64)    //反向学习
      else
       Jit_words:= copy(ss,1,c-1);

       if Jit_words= '' then
         Jit_words:='第'+ inttostr(jit_word_p)+'行缺=符号';

     ss2:= copy(ss,c+1,256);
     a:= fastpos(ss2,';+',length(ss2),2,1);
     if a= 0 then
       a:= fastpos(ss2,';-',length(ss2),2,1);

     if a > 0 then
      begin
       b:= fastpos(ss2,';+',length(ss2),2,a+1);
        if b= 0 then
          b:= fastpos(ss2,';-',length(ss2),2,a+1);
        if b= 0 then
          b:= fastpos(ss2,';-',length(ss2),2,1); //由于减号有可能在前面，所以要多测试一次
        if b= a then
           b:= 0; //如果是重复的，为零
      end;

      if a > b then
       begin
          
          if ss2[a+ 1]= '-' then
            a:= strtoint2(ss2[a+ 2]) * -1
          else
           a:= strtoint2(ss2[a+ 2]);


         if b> 0 then
          begin
           if ss2[b+ 1]= '-' then
           b:= strtoint2(ss2[b+ 2]) * -1
            else
            b:= strtoint2(ss2[b+ 2]);
          end;
       end else if b> a then
                 begin
                   
                    if ss2[b+ 1]= '-' then
                      b:= strtoint2(ss2[b+ 2]) * -1
                      else
                      b:= strtoint2(ss2[b+ 2]);

                    if a> 0 then
                     begin
                      if ss2[a+ 1]= '-' then
                      a:= strtoint2(ss2[a+ 2]) *-1
                      else
                       a:= strtoint2(ss2[a+ 2]);
                     end;
                 end;

     s_s:= Jit_words;
     g_tiankong:= false;
     if (not game_bg_music_rc_g.not_tiankong) and (ByteType(Jit_words,1)<> mbLeadByte) and
        (not checkbox3.Checked) and (Random(4)=0) then
        begin //填空
        //  if (length(Jit_words) > 32) and (pos(' ',Jit_words)> 0) then 是句子
          i_i:=  Random(length(Jit_words))+1;
          while s_s[i_i]= ' ' do
              i_i:=  Random(length(Jit_words))+1;

         // s_s:= s_s +'(填空)';
          s_s[i_i]:= '_';
          g_tiankong:= true;
        end;
        //智能判断是否需要拼写练习
     if length(Jit_words)>= 15 then
        g_tiankong:= true;
     if wordlist1.Count< 2000 then
        begin
          if length(Jit_words)<= 3 then
             g_tiankong:= true;
        end else if wordlist1.Count< 5000 then
                  begin
                    if length(Jit_words)<= 4 then
                      g_tiankong:= true;
                  end else 
                           begin
                             if length(Jit_words)<= 5 then
                                g_tiankong:= true;
                           end;
     if h_b then
     begin
       result:= '<tr><td><a href="game_spk_string('''+ Jit_words+''')" title="再次朗读" style="color:#000000;text-decoration:none">';
       if (I_I=0) and (game_tingli_i> 0) and (Game_base_random(game_tingli_i)=0) and (checkbox3.Checked= false) then
          result:= result +'听力测试</a></td></tr>'
          else
           result:= result +s_s +'</a></td></tr>';
      skp_string(Jit_words); //朗读
     end else
        draw_asw(s_s,0);

     if (a= 0) and (b= 0) and game_shunxu_g then
      begin
        //没有加减号指示，然后顺序背，那么才使用顺序功能 tip7已经加一了，所以减去一
        //顺序背单词时，以3个为一组。
        case (gamesave1.tip7- 1) mod 3 of
         0: begin
             a:= 1;
             b:= 2;
            end;
         1: begin
             a:= -1;
             b:= 1;
            end;
         2: begin
             a:= -1;
             b:= -2;
            end;
         end;
      end;

  if jit_tmp_3= 0 then
    begin    //111-------****
     if checkbox3.Checked then
        game_word_1:= copy(ss,1,pos('=',ss)-1)
        else
        game_word_1:= copy(ss,pos('=',ss)+1,128);

      if a <> 0 then
       c:= jit_word_p + a
      else
        c:= Random(wordlist1.Count);

      while c= jit_word_p do   //重复，在读取一次
           c:= Random(wordlist1.Count);

         ss:= get_word_safe(c);
         d:= c; //保存下来，作为重复检查用

         if checkbox3.Checked then
            game_word_2:= copy(ss,1,pos('=',ss)-1)
              else
               game_word_2:= copy(ss,pos('=',ss)+1,128);
      if b <> 0 then
      c:= jit_word_p + b
      else
       c:= Random(wordlist1.Count);

      while (c= d) or (c= jit_word_p) do
            c:= Random(wordlist1.Count);

          ss:= get_word_safe(c);
          if checkbox3.Checked then
              game_word_3:= copy(ss,1,pos('=',ss)-1)
                else
                 game_word_3:= copy(ss,pos('=',ss)+1,128);
      if i_i >0 then  //填空
        begin
          c:= Random(26);
           while Jit_words[i_i]= chr(c+97) do
                 c:= Random(26);
         game_word_2:= chr(c+97)+ ' (填空)'+ game_word_1;
          c:= Random(26);
           while (Jit_words[i_i]= chr(c+97)) or (game_word_2[1]=chr(c+97) ) do
                 c:= Random(26);
         game_word_3:= chr(c+97)+ ' (填空)'+ game_word_1;
         game_word_1:= Jit_words[i_i]+ ' (填空)'+ game_word_1;
        end; //ned 填空
    end else if jit_tmp_3= 1 then begin   //111 222 -------------- ****

     if checkbox3.Checked then
      game_word_2:= copy(ss,1,pos('=',ss)-1)    //反向学习
        else
            game_word_2:= copy(ss,pos('=',ss)+1,128);

        if a <> 0 then
      c:= jit_word_p + a
      else
        c:= Random(wordlist1.Count);
        while c= jit_word_p do
             c:= Random(wordlist1.Count);

          ss:= get_word_safe(c);
          d:= c;

         if checkbox3.Checked then
            game_word_1:= copy(ss,1,pos('=',ss)-1)
             else
               game_word_1:= copy(ss,pos('=',ss)+1,128);

       if b <> 0 then
      c:= jit_word_p + b
      else
       c:= Random(wordlist1.Count);
       while (c= d) or (c=jit_word_p) do
          c:= Random(wordlist1.Count);
       ss:= get_word_safe(c);

           if checkbox3.Checked then
              game_word_3:= copy(ss,1,pos('=',ss)-1)
               else
                game_word_3:= copy(ss,pos('=',ss)+1,128);

      if i_i >0 then  //填空
        begin
         
          c:= Random(26);
           while Jit_words[i_i]= chr(c+97) do
                 c:= Random(26);
         game_word_1:= chr(c+97)+ ' (填空)'+ game_word_2;
          c:= Random(26);
           while (Jit_words[i_i]= chr(c+97)) or (game_word_1[1]=chr(c+97) ) do
                 c:= Random(26);
         game_word_3:= chr(c+97)+ ' (填空)'+ game_word_2;
         game_word_2:= Jit_words[i_i]+ ' (填空)'+ game_word_2;
        end; //ned 填空
    end else begin   ///222 333 ---------------  ************

               if checkbox3.Checked then
                game_word_3:= copy(ss,1,pos('=',ss)-1)   //反向学习
                  else
                   game_word_3:= copy(ss,pos('=',ss)+1,128);

        if a <> 0 then
      c:= jit_word_p + a
      else
        c:= Random(wordlist1.Count);
        while (c= jit_word_p) do
           c:= Random(wordlist1.Count);
           ss:= get_word_safe(c);
           d:= c;
             if checkbox3.Checked then
               game_word_1:= copy(ss,1,pos('=',ss)-1)
                else
                 game_word_1:= copy(ss,pos('=',ss)+1,128);

       if b <> 0 then
      c:= jit_word_p + b
      else
       c:= Random(wordlist1.Count);
       while (c= d) or (c= jit_word_p) do
           c:= Random(wordlist1.Count);
          ss:= get_word_safe(c);
       
             if checkbox3.Checked then
                game_word_2:= copy(ss,1,pos('=',ss)-1)
                 else
                  game_word_2:= copy(ss,pos('=',ss)+1,128);

        if i_i >0 then  //填空
        begin
         
          c:= Random(26);
           while Jit_words[i_i]= chr(c+97) do
                 c:= Random(26);
         game_word_2:= chr(c+97)+ ' (填空)'+ game_word_3;
          c:= Random(26);
           while (Jit_words[i_i]= chr(c+97)) or (game_word_2[1]=chr(c+97) ) do
                 c:= Random(26);
         game_word_1:= chr(c+97)+ ' (填空)'+ game_word_3;
         game_word_3:= Jit_words[i_i]+ ' (填空)'+ game_word_3;
        end; //ned 填空

             end;      ///333


   // button1.SetFocus;
     //清理 ;+ ;-
     a:= fastpos(game_word_1,';+',length(game_word_1),2,1);
     b:= fastpos(game_word_1,';-',length(game_word_1),2,1);
     if (a > b) and (b > 0) then
      a:= b;
     if (a < b) and (a= 0) then
      a:= b;
     if a > 0 then
        game_word_1:= copy(game_word_1,1,a-1);
     a:= fastpos(game_word_2,';+',length(game_word_2),2,1);
     b:= fastpos(game_word_2,';-',length(game_word_2),2,1);
     if (a > b) and (b > 0) then
      a:= b;
     if (a < b) and (a= 0) then
      a:= b;
     if a > 0 then
        game_word_2:= copy(game_word_2,1,a-1);
     a:= fastpos(game_word_3,';+',length(game_word_3),2,1);
     b:= fastpos(game_word_3,';-',length(game_word_3),2,1);
     if (a > b) and (b > 0) then
      a:= b;
     if (a < b) and (a= 0) then
      a:= b;
     if a > 0 then
        game_word_3:= copy(game_word_3,1,a-1);

     if H_b then
     begin
      result:= result +'<tr><td><a href="game_asw_html_in_pop(0)">' +game_word_1 +'</a></td></tr>'+
                 '<tr><td><a href="game_asw_html_in_pop(1)">' +game_word_2 +'</a></td></tr>'+
                 '<tr><td><a href="game_asw_html_in_pop(2)">' +game_word_3 +'</a></td></tr>';
     end else begin
               //处理延迟显示。
               if (checkbox8.Checked= true) or
                  (game_read_values(0,ord(g_30_yanchi)) = 0) then
                 begin
                   checkbox8.Checked:= true;
                   if game_pop_type in[1,2,5] then
                      show_text(true,'请稍等，备选答案延迟几秒后显示。');

                   //画随机图
                   draw_random_pic;
                  //延迟显示开始计时
                  timer1.Enabled:= true;
                 end else begin
                           timer1.Enabled:= false;
                          if game_pop_type in[1,2,5] then
                             show_text(true,'请选择一个正确的答案。');

                            draw_asw(game_word_1,1);
                            draw_asw(game_word_2,2);
                            draw_asw(game_word_3,3);

                            game_write_values(0,ord(g_30_yanchi),game_read_values(0,ord(g_30_yanchi))-1);
                            //扣减立即显示次数

                            checkbox8.Hint:= '当前剩余时间加速次数：' +
                                            inttostr(game_read_values(0,ord(g_30_yanchi)));
                          end;

              end; //end h_b

  game_word_amt;   //动画
  set_Action_az;
end;

procedure TForm_pop.Timer1Timer(Sender: TObject);
begin
  //立即显示
  if game_pop_type in[1,2,5] then
     show_text(true,'请选择一个正确的答案。');
 draw_asw(game_word_1,1);
 draw_asw(game_word_2,2);
 draw_asw(game_word_3,3);
  timer1.Enabled:= false;

  if game_bg_music_rc_g.type_word and
      (g_is_tingli_b=false) and (g_tiankong=false) then
      if timer1.Enabled= false then
        begin

         edit1.Visible:= true;
         create_edit_bmp(game_word_1); //创建底图
         edit1.Repaint;
         edit1.SetFocus;
         Timer_daojishi.Tag:= 600;
         Timer_daojishi.Enabled:= true;
        end;

end;

procedure TForm_pop.save_game_progress(filename: string);
var File1: File Of TGameSave;
begin


             GameSave1.sch_count:=game_bg_music_rc_g.sch_count1;

             GameSave1.music_index:= game_bg_music_rc_g.bg_music_index;
             GameSave1.koucu:=jit_koucu;
             GameSave1.img_index:= game_bg_music_rc_g.bg_img_index;
            // GameSave1.leiji:=jit_leiji;
             GameSave1.index:= combobox1.ItemIndex;
 if not DirectoryExists(ExtractFileDir(filename)) then
     mkdir(ExtractFileDir(filename));

 AssignFile(File1,filename);
 Rewrite(File1);
 try
   write(File1,GameSave1);
 finally
   CloseFile(File1);
   end;


end;
function GetFileSize(const FileName: string): LongInt;
var
  SearchRec: TSearchRec;
begin
  try
    if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
      Result := SearchRec.Size
    else Result := -1;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;
procedure TForm_pop.load_game_progress(const filename: string);
var File1: File Of TGameSave;
begin
 if GetFileSize(filename) = sizeof(GameSave1) then
  begin
  AssignFile(File1,filename);
  Reset(File1);
 try
   if not Eof(File1) then
   Read(File1,GameSave1);
 finally
   CloseFile(File1);
   end;
            game_bg_music_rc_g.sch_count1:= GameSave1.sch_count;
            game_bg_music_rc_g.bg_music_index:=GameSave1.music_index;
             
            jit_koucu:= GameSave1.koucu;
            game_bg_music_rc_g.bg_img_index:= GameSave1.img_index;
            jit_leiji:= GameSave1.leiji;
            
     if gamesave1.index= -1 then
        gamesave1.index:= 0;
     combobox1.ItemIndex:= gamesave1.index;
     ComboBox1Change(combobox1); //载入单词本

  end else begin
            GameSave1.me_win:= 0;
            GameSave1.cpt_win:= 0;
            jit_koucu:= 0;
            jit_leiji:= 0;
            GameSave1.zhuangtai:= 195;
            GameSave1.index:= 0; //初始化单词本为基础900
            GameSave1.tip1:= 0;
            GameSave1.tip2:= 0;
            GameSave1.tip3:= 0;
            GameSave1.tip4:= 0;
            GameSave1.tip5:= 0;
            GameSave1.tip6:= 0;
            GameSave1.tip7:= 0;
            GameSave1.zqbs:= 0;
            GameSave1.cwbs:= 0;
           end;

end;
procedure CreateMutexes(const MutexName: String);
const
  SECURITY_DESCRIPTOR_REVISION = 1;  { Win32 constant not defined in Delphi 3 }
var
  SecurityDesc: TSecurityDescriptor;
  SecurityAttr: TSecurityAttributes;
begin
  { By default on Windows NT, created mutexes are accessible only by the user
    running the process. We need our mutexes to be accessible to all users, so
    that the mutex detection can work across user sessions in Windows XP. To
    do this we use a security descriptor with a null DACL. }
  InitializeSecurityDescriptor(@SecurityDesc, SECURITY_DESCRIPTOR_REVISION);
  SetSecurityDescriptorDacl(@SecurityDesc, True, nil, False);
  SecurityAttr.nLength := SizeOf(SecurityAttr);
  SecurityAttr.lpSecurityDescriptor := @SecurityDesc;
  SecurityAttr.bInheritHandle := False;
  CreateMutex(@SecurityAttr, False, PChar(MutexName));
  //CreateMutex(@SecurityAttr, False, PChar('Global\' + MutexName));
end;
function create_guid: string;
var  T:Tguid;
begin
  createguid(T);
  result := Guidtostring(t);
  result := StringReplace(result,'-','',[rfReplaceAll]);
  result:= copy(result,2,17);
end;

procedure TForm_pop.FormCreate(Sender: TObject);
var str1: Tstringlist;
    ss,ss2: string;
    i: integer;
begin

   jit_kssj:= now;  //保存开始时间
   game_beijing_index_cur:= -1;
// 初始化 Asphyre Device
   form_show.show_info('初始化DirectX设备……3%');
  AsphyreDevice1.WindowHandle:= panel1.Handle;
  if (not AsphyreDevice1.Initialize()) then begin
    if Messagebox(handle,'游戏初始化DirectX环境失败，请确认显卡的硬件加速已启用。或者请先重新启动电脑试试，点击“是”查看常见原因和解决方法。', '初始化失败',mb_yesno)
       =mryes then
       ShellExecute(handle,'open',pchar(game_app_path_G+'dat\error.txt'),nil,nil,sw_shownormal);

    application.Terminate;
    Exit;
  end;

  form_show.show_info('加载配置信息……20%');
   //初始化随机数
   Randomize; //初始化随机数
   str1:= Tstringlist.Create;  //初始化背单词文本和背景颜色
   if not FileExists(game_app_path_G+'dat\set.txt') then
    begin
     messagebox(handle,'set.txt，设置文件不存在，可能游戏安装不完成。请从http://www.finer2.com/wordgame/ 下载完整版本。','错误',mb_ok);
     application.Terminate;
    end;

   if FileExists(game_doc_path_g+'dat\set.txt') then
     str1.LoadFromFile(game_doc_path_g+'dat\set.txt')
     else
      str1.LoadFromFile(game_app_path_G+'dat\set.txt');

    game_E_color_R:= strtoint2(str1.Values['game_E_color_R']);
    game_E_color_G:= strtoint2(str1.Values['game_E_color_G']);
    game_E_color_B:= strtoint2(str1.Values['game_E_color_B']);
       game_C_color_R:= strtoint2(str1.Values['game_C_color_R']);
       game_C_color_G:= strtoint2(str1.Values['game_C_color_G']);
       game_C_color_B:= strtoint2(str1.Values['game_C_color_B']);
       game_BE_color_R:= strtoint2(str1.Values['game_BE_color_R']);
       game_BE_color_G:= strtoint2(str1.Values['game_BE_color_G']);
       game_BE_color_B:= strtoint2(str1.Values['game_BE_color_B']);
       game_BC_color_R:= strtoint2(str1.Values['game_BC_color_R']);
       game_BC_color_G:= strtoint2(str1.Values['game_BC_color_G']);
       game_BC_color_B:= strtoint2(str1.Values['game_BC_color_B']);
                   //下面是单词分色颜色
       game_WB_color_R:= strtoint2(str1.Values['game_WB_color_R']);
       game_WB_color_G:= strtoint2(str1.Values['game_WB_color_G']);
       game_WB_color_B:= strtoint2(str1.Values['game_WB_color_B']);
       game_WA_color_R:= strtoint2(str1.Values['game_WA_color_R']);
       game_WA_color_G:= strtoint2(str1.Values['game_WA_color_G']);
       game_WA_color_B:= strtoint2(str1.Values['game_WA_color_B']);

       game_en_size:= strtoint2(str1.Values['game_en_size']);
       game_cn_size:= strtoint2(str1.Values['game_cn_size']);
        game_speed_a:= str1.Values['game_speed_a']='1'; //动画是否快速显示
       // game_tts_index:= strtoint2(str1.Values['game_tts_index']); 这些值在unit_set 单元内设置


          game_not_bg_black:= (str1.Values['game_bk'] <> '1');  //是否使用黑色背景
          game_shunxu_g:=  (str1.Values['game_shunxu'] = '1');
         game_abhs_g:= (str1.Values['game_abhs'] = '1');

          if str1.Values['game_width'] = '1' then
           begin
             game_bmp_width:= 512;
             g_word_show_left:= 64; //单词和解释显示的左边位置
           end   else  begin
                game_bmp_width:= 256; //单词兰宽度系数
                g_word_show_left:= 192; //单词和解释显示的左边位置
                       end;
    if strtoint2(str1.Values['delay_show_word']) < 3000 then
       timer1.Interval:= 3000
       else
        timer1.Interval:= strtoint2(str1.Values['delay_show_word']);

     game_m_color:= strtoint2(str1.Values['game_m_color']); //单词分色
     game_tingli_i:= strtoint2(str1.Values['game_tingli_i']); //随机听力开启
     game_rep:= strtoint2(str1.Values['game_rep']) -1; //错误重复学习

     Game_net_hide_g:= str1.Values['game_net_hide'] = '1';

      game_pstringw:= str1.Values['game_id']; //保存游戏场景密码标志
      Game_app_img_url_G:= str1.Values['image_path'];
      if str1.Values['no_image']= '1' then
         Game_error_count_G:= 100;

      Game_update_file_G:= str1.Values['update_file'];
      Game_update_url_G:=  str1.Values['update_url'];
      game_NoRevealTrans_g:= (str1.Values['No_RevealTrans']= '1');
       with game_bg_music_rc_g do
       begin
       bg_img:= (str1.Values['bg_img']= '1');
       bg_tm:= strtoint2(str1.Values['bg_tm']);
       bg_music:= (str1.Values['bg_music']= '1');
       bg_yl:= strtoint2(str1.Values['bg_yl']);
       bg_lrc:= (str1.Values['bg_lrc']= '1');
       mg_pop:= (str1.Values['mg_pop']= '1');
       pop_img:= (str1.Values['pop_img']= '1');
       pop_img_tm:= strtoint2(str1.Values['pop_img_tm']);
       bg_img_radm:= (str1.Values['bg_img_radm']= '1');
       bg_music_radm:= (str1.Values['bg_music_radm']= '1');
       bg_music_base:= (str1.Values['bg_music_base']= '1');
       lrc_dir:= str1.Values['lrc_dir'];
       sch_enable:=  (str1.Values['sch_enable']= '1');
       sch_max:=strtoint2(str1.Values['sch_MAX']); //最多允许的单个关键字搜索次数
       sch_key:= str1.Values['sch_key'];
       sch_pic:= str1.Values['sch_pic']; //搜索的图片路径
       gum_path:= str1.Values['gum_path'];
       gum_only:= (str1.Values['gum_only']= '1'); //仅搜索gum路径
       sch_img_sty:= strtoint2(str1.Values['sch_img_sty']);
       sch_img_height:=  strtoint2(str1.Values['sch_img_height']);
       not_tiankong:=    (str1.Values['not_tiankong']='1');
       type_word:=       (str1.Values['type_word']= '1');
       type_word_flash:=  (str1.Values['type_word_flash']='1');
       type_char_spk:=  (str1.Values['type_char_spk']='1');
       desktop_word:=  (str1.Values['desktop_word']='1');
       show_ad_web:=  (str1.Values['show_ad_web']='1');
       yodao_sound:=  (str1.Values['yodao_sound']='1');
       down_readfile:=  (str1.Values['down_readfile']='1');
       en_type_name:= str1.Values['en_type_name'];
       cn_type_name:= str1.Values['cn_type_name'];
       baidu_vol:= strtoint2(str1.Values['baidu_vol']);
        if baidu_vol=0 then
           baidu_vol:= 5;
        baidu_sex:= strtoint2(str1.Values['baidu_sex']);
        baidu_spd:= strtoint2(str1.Values['baidu_spd']);
         if baidu_spd=0 then
           baidu_spd:= 5;
        baidu_pit:= strtoint2(str1.Values['baidu_pit']);
         if baidu_pit=0 then
           baidu_pit:= 5;
       end;

         token:= str1.Values['token'];  //百度语音的授权码
         if token<>'' then
          begin
           //检查token是否过期
            ss2:= str1.Values['expires'];
            if ss2<>'' then
             begin
              if strtoint64(ss2)- get_second < 72000 then
                 token:= ''; //有效期小于20小时的清空

             end else token:= '';
          end;
         {
         yodao_udp_host:= create_guid; //取得一个guid标志
       yodao_udp_g:= StringReplace(str1.Values['yodao_udp_path'],'$guid$',yodao_udp_host,[]);
       yodao_tcp_g:= StringReplace(str1.Values['yodao_tcp_path'],'$guid$',yodao_udp_host,[]);

       yodao_udp_host:= str1.Values['yodao_udp_host'];   }

       if (game_bg_music_rc_g.sch_key= '') or (game_bg_music_rc_g.sch_pic= '') then
          game_bg_music_rc_g.sch_enable:= false;   //如果关键字为空火灾搜索地址为空,则不激活此功能

      if game_rep >= 0 then
         game_error_word_list_G[0]:= game_rep;

         form_show.show_info('注册快捷键……35%');
         //设置热键
      Action1.ShortCut:= TextToShortCut(str1.Values['game_gong']);
      Action2.ShortCut:= TextToShortCut(str1.Values['game_fang']);
      Action3.ShortCut:= TextToShortCut(str1.Values['game_shu']);
      Action4.ShortCut:= TextToShortCut(str1.Values['game_wu']);
      Action5.ShortCut:= TextToShortCut(str1.Values['game_tao']);
      Action6.ShortCut:= TextToShortCut(str1.Values['game_word1']) ;
      Action7.ShortCut:= TextToShortCut(str1.Values['game_word2']) ;
      Action9.ShortCut:= TextToShortCut(str1.Values['game_word3']) ;
      Action8.ShortCut:= TextToShortCut(str1.Values['game_del']); //ShortCutToText



      form_show.show_info('初始化单词表……50%');
      clear_errorword_list; //初始化单词错误列表

    form_show.show_info('加载图片资源……65%');
   image_word := TAsphyreImage.Create; //创建图
    image_cn1 := TAsphyreImage.Create;
    image_cn2 := TAsphyreImage.Create;
    image_cn3 := TAsphyreImage.Create;

    image_up  := TAsphyreImage.Create;
    image_down:= TAsphyreImage.Create;


    image_guai1 := TAsphyreImage.Create;
     with image_guai1 do begin
      Size:= point(128,64);
      VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
    image_guai2 := TAsphyreImage.Create;
     with image_guai2 do begin
       Size:= point(128,64);
       VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
    image_guai3 := TAsphyreImage.Create;
     with image_guai3 do begin
     Size:= point(128,64);
     VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
    image_guai4 := TAsphyreImage.Create;
     with image_guai4 do begin
     Size:= point(128,64);
     VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
    image_guai5 := TAsphyreImage.Create;
     with image_guai5 do begin
     Size:= point(128,64);
     VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;

       image_role1 := TAsphyreImage.Create;
        with image_role1 do begin
        Size:= point(128,64);
        VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
        PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
        end;
       image_role2 := TAsphyreImage.Create;
        with image_role2 do begin
        Size:= point(128,64);
        VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
        PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
        end;
       image_role3 := TAsphyreImage.Create;
        with image_role3 do begin
        Size:= point(128,64);
        VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
       image_role4 := TAsphyreImage.Create;
        with image_role4 do begin
        Size:= point(128,64);
        VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
      end;
       image_role5 := TAsphyreImage.Create;
        with image_role5 do begin
        Size:= point(128,64);
        VisibleSize:= point(game_bmp_role_width,game_bmp_role_h);
      PatternSize:= point(game_bmp_role_width,game_bmp_role_h);
       end;

       image_result1:= TAsphyreImage.Create;
        with image_result1 do begin
        Size:= point(256,128);
        VisibleSize:= point(g_result_w1,g_result_h1);
        PatternSize:= point(g_result_w1,g_result_h1);
       end;
        g_icon_image:= TAsphyreImage.Create;
          with g_icon_image do begin
          Size:= point(64,64);
          VisibleSize:= point(48,48);
          PatternSize:= point(48,48);
         end;

        image_bg_1_1:= TAsphyreImage.Create;
         image_bg_1_1.Size:= point(512,512);
        image_bg_1_2:= TAsphyreImage.Create;
         image_bg_1_2.Size:= point(128,512);

         image_bg_1_1.VisibleSize:= point(512,480); //设置大小
     image_bg_1_1.PatternSize:= point(512,480);
      image_bg_1_2.VisibleSize:= point(128,480);
     image_bg_1_2.PatternSize:= point(128,480);

  form_show.show_info('载入abhs表……80%');

  if fileExists(game_doc_path_G+'save\default.sav') then
    load_game_progress(game_doc_path_G+'save\default.sav')
   else
     load_game_progress(game_app_path_G+'save\default.sav');
     
 wordlist1:= Tstringlist.Create;
 stringlist_abhs5:= Tstringlist.Create;
  stringlist_abhs30:= Tstringlist.Create;
  stringlist_abhs240:= Tstringlist.Create;
    stringlist_abhs_d1:= Tstringlist.Create;
    stringlist_abhs_d2:= Tstringlist.Create;
    stringlist_abhs_d4:= Tstringlist.Create;
    stringlist_abhs_d7:= Tstringlist.Create;
    stringlist_abhs_d15:= Tstringlist.Create;
 show_ck; //载入词库
 if gamesave1.index= -1 then
    gamesave1.index:= 0;
  combobox1.ItemIndex:= gamesave1.index;
 ComboBox1Change(combobox1); //载入单词本
  show_check(gamesave1.zhuangtai);


  GroupBox3.Left:= 216; //攻击法术选择窗口靠右边

    init_weizi; //初始化单词位置

  //载入背景图片
                
    ss:= game_app_path_G;
  fashu_wupin_kuaijie_list:= Tstringlist.Create;

 //载入单词前缀和后缀
 game_word_qianzhui:= Tstringlist.Create;
 game_word_houzhui:= Tstringlist.Create;
  game_word_qianzhui.LoadFromFile(ss+ 'dat\qian.txt');
   game_word_houzhui.LoadFromFile(ss+ 'dat\hou.txt');
      game_init_Success_G:= true;

   form_show.show_info('载入声音效果……85%');
   //载入声音 效果
   for i:= 1 to 16 do
   with DXWaveList1 do
    begin
    Items.add;
    Items[i-1].Wave.LoadFromFile(ss+'music\w'+ inttostr(i)+'.wav');
    Items[i-1].Restore;
    end;

  if DebugHook = 0 then
     CreateMutexes('finer_gameword'); //内核互斥对象，安装检测用，程序退出时会自动清理

  if not game_bg_music_rc_g.show_ad_web then
   create_top_ad;

   form_show.show_info('初始化语音合成组件……90%');

   if game_bg_music_rc_g.yodao_sound=false then
    begin
     //如果使用百度语音的，则不加载这些设置
     if game_can_spvoice1 then
      begin
         try
           //SpVoice1.Rate:= round(5 / 0);
          SpVoice1:= TSpVoice.Create(application);
          SpVoice1.Rate:=  strtoint2(str1.Values['game_tts_rate']);
            SpVoice1.Volume:= strtoint2(str1.Values['game_tts_vol']);

            if str1.Values['game_tts_sooth'] = '1' then
              game_kptts_init;   //初始化金山真人朗读控件

          except
           SpVoice1:= nil;
          // checkbox2.Checked:= false; //初始化tts组件出错，则禁止
           //checkbox2.Enabled:= false;

           game_bg_music_rc_g.yodao_sound:= true; //默认启用百度语音
           if Messagebox(handle,'语音合成组件初始化失败，百度网络朗读自动启用，可以正常发音。点击“是”查看常见原因和解决方法。', 'TTS加载失败',mb_yesno)
              =mryes then
           ShellExecute(handle,'open',pchar(game_app_path_G+'dat\ttserror.txt'),nil,nil,sw_shownormal);
         end;
      end else begin
                game_bg_music_rc_g.yodao_sound:= true; //默认启用百度语音
                showmessage('微软tts发音安装不正确，现自动启用了百度语音合成，游戏已可以正常朗读中英文。');
               end;
   end;

   game_guid:= str1.Values['guid'];
    if game_guid='' then
      begin
         game_guid:= form1.game_create_guid;
         str1.Values['guid']:= game_guid;
         str1.saveToFile(game_doc_path_g+'dat\set.txt');
      end;
   str1.Free;
end;

procedure TForm_pop.draw_asw(s: string; flag: integer; c: integer=0); //参数c为1表示红色，2表示绿色文字
var
   bmp : TBitmap;
   r1: Trect;
   qianhouzhui: T_word_QianHouZhui; //返回前后坠的位置
   a,b: string;
begin
 game_pic_check_area:= G_words_Pic_y; //单词可被选中

 bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
         if flag= 0 then
          begin
           bmp.Width:=game_bmp_width;
           bmp.Height:=game_bmp_h1;
           bmp.Canvas.Font.Name:=game_bg_music_rc_g.en_type_name;
           bmp.Canvas.Font.Size:= game_en_size;
           bmp.Canvas.Font.Color:= rgb(game_E_color_R,game_E_color_G,game_E_color_B);
           bmp.Canvas.Brush.Style:= bsClear;
            bmp.Canvas.Brush.Color:=rgb(game_BE_color_R,game_BE_color_G,game_BE_color_B);
            bmp.Canvas.FillRect(rect(0,0,game_bmp_width,game_bmp_h1));
             if (timer_daojishi.Enabled=false) and (g_tiankong=false) and (game_tingli_i> 0)
                 and (Game_base_random(game_tingli_i)=0) and (checkbox3.Checked= false) then
              begin
               bmp.Canvas.TextOut(5, 8, '听力测试(按R键重听)'); //有斜杠的表示有填空出现 不听力
               g_is_tingli_b:= true;
              end else  begin
                         g_is_tingli_b:= false;
                         if bmp.Canvas.TextWidth(s)> bmp.Width then
                      begin
                       //分行
                       if game_cn_size > 14 then
                          bmp.Canvas.Font.Size:= 14;  //缩小字体
                          r1:= rect(2,1,bmp.Width,bmp.Height);
                        DrawTextEx(bmp.Canvas.Handle,pchar(s),length(s),r1,DT_WORDBREAK,nil);

                      end else begin
                           bmp.Canvas.TextOut(5, 8, s);
                            if (game_m_color > 0) and (pos(' ',s)=0) then
                             begin
                              //下面开始单词分色显示
                            get_word_fen(qianhouzhui,s); //取得单词分色位置
                             if qianhouzhui.qian_start > 0 then
                               begin
                               //前缀着色
                               b:= copy(s,qianhouzhui.qian_start,qianhouzhui.qian_end);
                               bmp.Canvas.Font.Color:= rgb(game_WB_color_R,game_WB_color_G,game_WB_color_B);
                               bmp.Canvas.TextOut(5, 8, b);
                               end;
                             if qianhouzhui.hou_start > 0 then
                               begin
                               //后缀着色
                               a:= copy(s,qianhouzhui.hou_start,qianhouzhui.hou_end);
                               bmp.Canvas.Font.Color:= rgb(game_WA_color_R,game_WA_color_G,game_WA_color_B);
                               bmp.Canvas.TextOut(5+ bmp.Canvas.TextWidth(copy(s,1,qianhouzhui.hou_start-1)), 8, A);
                               end;
                             end;
                                end; //end 换行
                        end;
              with image_word do
               begin
                LoadFromBitmap(bmp,false,0,0); //更新到屏幕
               end;
          end else begin
                    bmp.Width:=game_bmp_width;
                    bmp.Height:=game_bmp_h2;
                    bmp.Canvas.Font.Name:=game_bg_music_rc_g.cn_type_name;
                      bmp.Canvas.Font.Size:= game_cn_size;
                       case c of
                        0:bmp.Canvas.Font.Color:= rgb(game_C_color_R,game_C_color_G,game_C_color_B);
                        1: bmp.Canvas.Font.Color:= clred;
                        2: bmp.Canvas.Font.Color:= clgreen;
                       end;
                    bmp.Canvas.Brush.Style:= bsClear;
                     bmp.Canvas.Brush.Color:=rgb(game_BC_color_R,game_BC_color_G,game_BC_color_B);
                    bmp.Canvas.FillRect(rect(0,0,game_bmp_width,game_bmp_h2));
                    if not game_state_answer then
                    begin
                    //初始显示
                    if game_bg_music_rc_g.type_word and
                       (g_is_tingli_b=false) and (g_tiankong=false) then
                       begin
                        if flag=1 then
                          begin
                           if jit_tmp_3> 0 then //正确值始终为第一个
                              begin
                               case jit_tmp_3 of
                                1: game_word_1:= game_word_2;
                                2: game_word_1:= game_word_3;
                                end;
                                jit_tmp_3:= 0;
                                s:= game_word_1;
                              end;
                          end else if flag=3 then
                                       begin
                                       if not edit1.Visible then
                                          s:= '请输英文 或按下Ctrl + P 关闭拼写';
                                       end{ else if flag=2 then s:= ''};
                       //edit1.Visible:= true;
                       end;
                       end else begin
                                 //正确答案显示，三个全部显示正确答案
                                   case jit_tmp_3 of
                                  0: s:= game_word_1;
                                  1: s:= game_word_2;
                                  2: s:= game_word_3;
                                  end;

                                end;
                     if bmp.Canvas.TextWidth(s)> bmp.Width then
                      begin
                       //分行
                       if game_cn_size > 11 then
                          bmp.Canvas.Font.Size:= 11;  //缩小字体
                          r1:= rect(2,1,bmp.Width,bmp.Height);
                        DrawTextEx(bmp.Canvas.Handle,pchar(s),length(s),r1,DT_WORDBREAK,nil);

                      end else
                            bmp.Canvas.TextOut(5, 8, s);

                     case flag of
                      1: begin
                          with image_cn1 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
                      2: begin
                          with image_cn2 do
                          LoadFromBitmap(bmp,false,0,0);

                         end;
                      3: begin
                          with image_cn3 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
                      end;
                   end;


      // GLMaterialLibrary1.Materials.Items[flag].Material.Texture.image.Assign(bmp);
      bmp.Free;
// G_dangqian_zhuangtai:=G_word;  转移到动画内
end;

procedure TForm_pop.game_intl_pic;
var
   bmp : TBitmap;
begin
   // 初始化图片

      bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;

     // bmp.LoadFromFile(game_app_path_G+ 'sg.BMP');
        bmp.Width:=game_bmp_width;
        bmp.Height:=game_bmp_h1;
      bmp.Canvas.Font.Name:='宋体';
      bmp.Canvas.Font.Size:= 21;
      bmp.Canvas.Brush.Style:= bsClear;

         bmp.Canvas.TextOut(5, 8, '武侠游戏背单词');
     // bmp.Canvas.TextOut(3, 65, 'ufo2003@126.com');
         with image_word do
         begin
         LoadFromBitmap(bmp,false,0,0);
         end;



        bmp.Canvas.Font.Size:= 16;
        bmp.Width:=game_bmp_width;
        bmp.Height:=game_bmp_h2;
        bmp.Canvas.Brush.Color:=rgb(165,255,255);
        bmp.Canvas.FillRect(rect(0,0,game_bmp_width,game_bmp_h2));
         bmp.Canvas.TextOut(5, 5, 'ufo2003@126.com');

       with image_cn1 do
         begin
         LoadFromBitmap(bmp,false,0,0);
         end;
       with image_cn2 do
         begin
         LoadFromBitmap(bmp,false,0,0);
         end;
        with image_cn3 do
         begin
         LoadFromBitmap(bmp,false,0,0);
         end;


       //怪物和人物区域初始化
         bmp.Canvas.Font.Size:= 12;
        bmp.Width:=game_bmp_role_width;
        bmp.Height:=game_bmp_role_h;
        bmp.Canvas.Brush.Color:=rgb(255,255,255);
        bmp.Canvas.FillRect(rect(0,0,game_bmp_role_width,game_bmp_role_h));
         bmp.Canvas.TextOut(5, 2, '人物');


      bmp.Free;


end;

procedure TForm_pop.draw_random_pic; //生成随机图像
var
   bmp : TBitmap;
begin
game_pic_check_area:= G_all_pic_n; //答案显示等待期，全局gl对象禁止选中。
 bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
                    bmp.Width:=game_bmp_width;
                    bmp.Height:=game_bmp_h2;
                         //背景填充随机颜色
                     bmp.Canvas.Brush.Color:=rgb(220,218,232);
                    bmp.Canvas.FillRect(rect(0,0,game_bmp_width,game_bmp_h2));

              draw_random_pic_base(bmp);

                          with image_cn1 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;

                          with image_cn2 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;


                          with image_cn3 do
                           begin
                          
                          LoadFromBitmap(bmp,false,0,0);
                            end;

      bmp.Free;

end;

procedure TForm_pop.draw_random_pic_base(b: Tbitmap;one: boolean=false);
var FGenPointFrom: tpoint;
     FBranchColor: TBranchColor;
     FBranchWidth: integer;
     FGenLength: single;
  const
       PI   =   3.14159;
      PI2   =   2   *   PI;
      GEN_ANGLE_DEVIATION   =   PI2   /   16;
      BRANCH_RATIO   =   0.80;
      PROBABILITY_THREASHOLD   =   0.1;
       FGenAngle   =   PI2   *   3   /   4;

 procedure DrawFractalTree(GenPointFrom:   TPoint;   GenLength,
      GenAngle:   Real;   BranchWidth:   Integer;   BranchColor:   TBranchColor);   
    function   CanTerminate(GenPoint:   TPoint;   GenLength:Real):   Boolean;   
      begin   
          if   (GenPoint.X   <   0)   or   (GenPoint.X   >   b.Width)
              or   (GenPoint.Y   <   0)   or   (GenPoint.Y   >   b.Width)
              or   (GenLength   <   1)   then   
              Result   :=   True   
          else   
              Result   :=   False;   
      end;   
    
      function   ToPoint(GenPointFrom:   TPoint;   GenLength,   GenAngle:   Real;   IsLeft:   Boolean):   TPoint;   
      begin   
          if   IsLeft   then   
          begin   
              Result.X   :=   GenPointFrom.X   +   Trunc(GenLength   *   cos(GenAngle   -   GEN_ANGLE_DEVIATION));   
              Result.Y   :=   GenPointFrom.Y   +   Trunc(GenLength   *   sin(GenAngle   -   GEN_ANGLE_DEVIATION));   
          end   
          else   
          begin   
              Result.X   :=   GenPointFrom.X   +   Trunc(GenLength   *   cos(GenAngle   +   GEN_ANGLE_DEVIATION));
              Result.Y   :=   GenPointFrom.Y   +   Trunc(GenLength   *   sin(GenAngle   +   GEN_ANGLE_DEVIATION));   
          end;   
      end;

  var   
      GenPointTo:   TPoint;   
  begin   
      if   CanTerminate(GenPointFrom,   GenLength)   then   
      begin   //   中断绘制   
          System.Exit;   
      end   
      else   
      begin   //   绘制左右树干   
         // Application.ProcessMessages();
          if   BranchWidth   >   2   then   Dec(BranchWidth,   2)   else   BranchWidth   :=   1;   
          if   BranchColor.g   <   222   then   Inc(BranchColor.g,   8)   else   BranchColor.g   :=   229;
          if   System.Random   >   PROBABILITY_THREASHOLD   then   
          begin     //   绘制左树干   
              GenPointTo   :=   ToPoint(GenPointFrom,   GenLength,   GenAngle,   True);   
              b.Canvas.Pen.Width   :=   BranchWidth;
              b.Canvas.Pen.Color   :=   RGB(BranchColor.r,   BranchColor.g,   BranchColor.b);
              b.Canvas.MoveTo(GenPointFrom.X,   GenPointFrom.Y);
              b.Canvas.LineTo(GenPointTo.X,   GenPointTo.Y);
              DrawFractalTree(GenPointTo,   GenLength*BRANCH_RATIO,   GenAngle-GEN_ANGLE_DEVIATION,   BranchWidth,   BranchColor);
          end;   
          if   System.Random   >   PROBABILITY_THREASHOLD   then   
          begin     //   绘制右树干   
              GenPointTo   :=   ToPoint(GenPointFrom,   GenLength,   GenAngle,   False);   
              b.Canvas.Pen.Width   :=   BranchWidth;
              b.Canvas.Pen.Color   :=   RGB(BranchColor.r,   BranchColor.g,   BranchColor.b);
              b.Canvas.MoveTo(GenPointFrom.X,   GenPointFrom.Y);
              b.Canvas.LineTo(GenPointTo.X,   GenPointTo.Y);
              DrawFractalTree(GenPointTo,   GenLength*BRANCH_RATIO,   GenAngle+GEN_ANGLE_DEVIATION,   BranchWidth,   BranchColor);   
          end;   
      end;   
  end;
begin
      //添加延迟显示时等待图片的特效
       FGenPointFrom.Y   :=   b.Height;
       FBranchColor.r   :=   45;   //
       FBranchColor.g   :=   45;   //
       FBranchColor.b   :=   45;   //
       if one then
        begin  //画一颗树
          FGenLength   :=   b.Height   /   3.1;
         FGenPointFrom.X   :=   b.Width div 3;
       FBranchWidth   :=   Random(b.Width div 20)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
        end else begin //画5颗树
                   FGenLength   :=   b.Height   /   2.4;
       FGenPointFrom.X   :=   round(game_bmp_width  /   6);
       FBranchWidth   :=   Random(6)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
      FGenPointFrom.X   :=   round(game_bmp_width  /   2.75);
      FBranchWidth   :=   Random(6)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
     FGenPointFrom.X   :=   round(game_bmp_width  /   2);
     FBranchWidth   :=   Random(6)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
      FGenPointFrom.X   :=   round(game_bmp_width  /   1.5);
      FBranchWidth   :=   Random(6)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
     FGenPointFrom.X   :=   round(game_bmp_width  /   1.2);
     FBranchWidth   :=   Random(6)+5;
        DrawFractalTree(FGenPointFrom,FGenLength*BRANCH_RATIO*BRANCH_RATIO,FGenAngle,FBranchWidth,FBranchColor);
                  end;
end;

procedure TForm_pop.after_check_asw(b: boolean);
begin
//答案选择后进一步操作
 game_pic_check_area:= G_all_pic_n; //禁止选中

 case game_pop_type of
   1: after_check_asw1(b);//背单词，
   2: after_check_asw2(b);//挖矿，
   3,4: after_check_asw3(b);//战斗，打擂台
   5: after_check_asw1(b);//背单词，love
   6: begin
       //泡泡龙
       if b then
       begin
        G_game_delay(500);
        g_dangqian_zhuangtai:= g_bubble;
        bubble_data1.sycs:= 2;
        show_ad(1);
       end
       else begin
             G_game_delay(1000);
             start_show_word(false);
             end;
      end;
  end;

end;

procedure TForm_pop.after_check_asw1(b: boolean);
begin
   //背单词后续处理
  if b then
   begin
     //显示信息
     show_text(true,
                    format('正确！ 完成 %d 总计 %d',[jit_num,game_pop_count+ jit_num]));
     G_game_delay(1000);
     tili_add_100; //体力增加
    if game_pop_count > 0 then
     begin
     dec(game_pop_count);
     inc(jit_num);
      start_show_word(false);
     end else begin
               self.ModalResult:= mrok;
              end;
   end else begin
             //显示错误信息
              show_text(true,'您没有答对。');
             G_game_delay(2000);
             self.ModalResult:= mrcancel;
            end;
end;

procedure TForm_pop.after_check_asw2(b: boolean);
var i,j: integer;
    str1: Tstringlist;
    ss: string;
begin

  //挖矿后续处理
  
    dec(game_kaoshi,3);

  if (not b) or (game_pop_count= 1000)  then
   begin
    if game_pop_count=200 then
     show_text(true,'您没有答对，采药结束。')
     else  if game_pop_count=300 then
     show_text(true,'您没有答对，打坐结束。')
     else if game_pop_count> 1000 then
     show_text(true,'考试错了一题。')
     else
       show_text(true,'您没有答对，挖矿结束。');

    G_game_delay(2000);
     if game_pop_count<= 1000 then
       begin  //小于等于1000且单词错误，退出
       self.ModalResult:= mrcancel;
       exit;
       end;
   end;

      if game_pop_count=300 then
      begin
      show_text(false,'恢复灵力1%');
      end else if game_pop_count > 1000 then
       begin
        if b then
           show_text(false,'考试正确'+ inttostr(Game_wakuan_zhengque_shu+ 1)+ '题剩余'+ inttostr(game_pop_count-1001) +'题');
       end  else  begin  //************************************
       show_text(false,'增加经验值5');

    str1:= Tstringlist.Create;
    if game_pop_count=200 then
     Data2.Load_file_upp(game_app_path_G+ 'dat\const_cy.upp',str1)
    else
     Data2.Load_file_upp(game_app_path_g+ 'dat\const.upp',str1);
  for i:= 0 to str1.Count- 1 do
   begin
    j:= fastcharpos(str1.Strings[i],'=',1);
    if j > 0 then
      begin
       ss:= copy(str1.Strings[i],1,j-1);
       if ss<> '' then
        begin
          if Trystrtoint(ss,j) then
            begin
             if Game_base_random(j)= 1 then
               begin
                ss:= str1.Values[ss];
                break;
               end else ss:= '';
            end else ss:= '';
        end;
      end;
   end;
  str1.Free;

     if ss<> '' then
      begin
       if gamesave1.tip5= 0 then
          play_sound(6);
          
       draw_text_17(ss+' 挖到一',1000,clgreen,18);
       G_game_delay(2500);
      end else begin
           show_text(true,
                    format('选择正确！ 当前 %d 个',[jit_num]));
                    show_ad(0);

            end;

  if ss<> '' then
    begin
     form1.game_goods_change_n(ss,1); //增加该物品
    end;
                     end; //*************************************************
   G_game_delay(1000);
   G_show_result_b:= false;
 // dec(game_pop_count);
  inc(jit_num);
   show_text(false,'');

    if game_pop_count=300 then
    begin
    Form1.game_lingli_add(0,1);
    draw_game_role(-1);
    end else if b then
              begin
              form1.game_attribute_change(0,19,5); //全体增加经验值5

              inc(Game_wakuan_zhengque_shu); //挖矿正确的加一
            if (Game_wakuan_zhengque_shu= 100) and (game_pop_count < 1000) then
              begin
                Game_wakuan_zhengque_shu:= 0;
                form1.game_attribute_change(0,19,1000); //全体增加经验值1000
               show_text(false,
                    '奖励经验值1000');
              G_game_delay(1000);
              end;
               game_up_role; //人物升级
              end;
  G_show_result_b:= false;
  
    if game_pop_count> 1000 then
      dec(game_pop_count); //大于1000，表示考试

     if game_pop_count= 1000 then
      begin
      show_text(true,'考试结束，正确'+ inttostr(Game_wakuan_zhengque_shu));
       G_game_delay(2000);
       self.ModalResult:= mrcancel;
      end else
           start_show_word(false);
end;

procedure TForm_pop.after_check_asw3(b: boolean);
begin
  //战斗后续处理
  if b then
   show_text(true,'回答正确。')
   else
      show_text(true,'您错了，俺从不手下留情。');

   if b then
    game_guai_xishu_f:= Game_base_random(6)+ 2 //回答正确，最多7成功力
    else
     game_guai_xishu_f:= Game_base_random(6)+ 10; //回答错误,怪可能超水平发挥，10-15成功力
     
  G_game_delay(1000);
  guai_Attack(Fgame_guai_cu,game_guai_xishu_f); //怪物攻击
end;

procedure TForm_pop.show_text(up: boolean; const s: string);
var
   bmp : TBitmap;
begin

  if s= '' then
   begin
    if up then
      g_show_text_up:= false
      else
       g_show_text_down:= false;
    exit;
   end;
 bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
        bmp.Canvas.Font.Name:='宋体';

           bmp.Width:=game_bmp_width;
           bmp.Height:=game_bmp_h2;
           bmp.Canvas.Font.Name:='宋体';
           bmp.Canvas.Font.Size:= 14;
           bmp.Canvas.Font.Color:= clwindow;
           bmp.Canvas.Brush.Style:= bsClear;
            bmp.Canvas.Brush.Color:=clwindowtext;
            bmp.Canvas.FillRect(rect(0,0,game_bmp_width,game_bmp_h2));
            bmp.Canvas.TextOut(5, 8, s);
       if up then
        begin
          with image_up do
         begin

         LoadFromBitmap(bmp,true,0,0);
         end;

        g_show_text_up:= true;
        end else begin
                  with image_down do
         begin
         
         LoadFromBitmap(bmp,true,0,0);
         end;

           g_show_text_down:= true;
                 end;
      bmp.Free;

end;

procedure TForm_pop.show_text_hint(const s: string);
begin
  StatusBar1.Panels[0].Text:= s;
end;

procedure TForm_pop.draw_game_role(p: integer);
var i: integer;
begin
//参数为-1，表示全部显示（5个）
//其他的参数，表示绘制指定的人物，参数零表示玩家，其他类推
 if p= -1 then
  begin
   g_role_show1:= false;
   g_role_show2:= false;
   g_role_show3:= false;
   g_role_show4:= false;
   g_role_show5:= false;
   for i:= 0 to 4 do
     draw_game_role_base(i);

  end else begin
              draw_game_role_base(p);
           end;

end;

procedure TForm_pop.draw_game_role_base(p: integer); //绘制人物图标
var i,j: integer;
begin

j:= 0;
  for i:= 0 to Game_role_list.Count-1 do
    begin
      if game_read_values(i,4)= 1 then
        inc(j);  //跳过不被允许上场的人，只有等于1的，才计数

      if j = p + 1 then
       begin //画出人物
        if Assigned(Game_role_list.Items[i]) then
           draw_game_role_base2(p,Game_role_list.Items[i]);
        exit;
       end;
    end; //end for

end;
procedure M_bmp_bw(bmp: Tbitmap); //彩色转黑白
var
  p :PByteArray;
  Gray,x,y :Integer;
begin

  for y:=0 to Bmp.Height-1 do
  begin
    p:=Bmp.scanline[y];
    for x:=0 to Bmp.Width-1 do
    begin
      Gray:=Round(p[x*3+2]*0.3+p[x*3+1]*0.59+p[x*3]*0.11);
      p[x*3]:=Gray;
      p[x*3+1]:=Gray;
      p[x*3+2]:=Gray;
    end;
  end;


end;
procedure TForm_pop.draw_game_role_base2(p: integer; tpl: Tplayer);   //绘制人物图标
  const lt= 32;
var
      bmp : TBitmap;
      ss: string;
      i: integer;

begin
      if not Assigned(tpl) then
         exit;
      try
        if tpl.plvalues[ord(g_gdsmz27)]< 1 then
           tpl.plvalues[ord(g_gdsmz27)]:= 1;
        if tpl.plvalues[ord(g_gdtl25)]< 1 then
           tpl.plvalues[ord(g_gdtl25)]:= 1;
        if tpl.plvalues[ord(g_gdll26)]< 1 then
           tpl.plvalues[ord(g_gdll26)]:= 1;
      except
        exit;
      end;


      bmp:=TBitmap.Create;

      bmp.PixelFormat:=pf24bit;
      bmp.Width:=game_bmp_role_width;
      bmp.Height:=game_bmp_role_h;
      with bmp.Canvas do
       begin
      Font.Name:='宋体';
      Font.Size:= 9;
       

       if tpl.plvalues[ord(g_life)]> 0 then
          Brush.Color:=rgb(213,206,180)   //正常背景色
          else begin
               Brush.Color:=rgb(255,255,255); //角色死亡后背景色
               game_p_list[p]:= 0; //死亡角色的速度为零
               end;
      FillRect(rect(0,0,game_bmp_role_width,game_bmp_role_h));
      data2.ImageList2.Draw(bmp.Canvas,33,0,tpl.plvalues[ord(g_Icon_index)]+ 1);
      //把当前人物图像拷贝到一个icon内，画入攻击策略窗口用
      Brush.Style:= bsClear;

      TextOut(3, 2, tpl.get_name_and_touxian);
      Pen.Mode:=pmCopy;
         Pen.Color:= clwhite;
         MoveTo(3,game_bmp_role_h);
         LineTo(3,game_bmp_role_h-lt);
         MoveTo(4,game_bmp_role_h);
         LineTo(4,game_bmp_role_h-lt);
         MoveTo(5,game_bmp_role_h);
         LineTo(5,game_bmp_role_h-lt);

        // 生命值
          if tpl.plvalues[ord(g_life)]<= 0 then
             begin
               Pen.Color:= clred;
               ss:= '状态：已死亡。';
             end else if tpl.plvalues[ord(g_gdsmz27)]* 4 > tpl.plvalues[ord(g_life)]* 10 then
             begin
               Pen.Color:= clred;
               ss:= format('状态：虚弱 |生命值：%d / %d',[tpl.plvalues[ord(g_life)],tpl.plvalues[ord(g_gdsmz27)]]);
             end else if tpl.plvalues[ord(g_gdsmz27)]* 7 > tpl.plvalues[ord(g_life)]* 10 then
                       begin
                        Pen.Color:= clyellow;
                        ss:= format('状态：一般 |生命值：%d / %d',[tpl.plvalues[ord(g_life)],tpl.plvalues[ord(g_gdsmz27)]]);
                       end else begin
                                 Pen.Color:= clgreen;
                                 ss:= format('状态：良好 |生命值：%d / %d',[tpl.plvalues[ord(g_life)],tpl.plvalues[ord(g_gdsmz27)]]);
                                end;
          i:= round(tpl.plvalues[ord(g_life)] / tpl.plvalues[ord(g_gdsmz27)] * (lt-3))+3;
         if tpl.plvalues[ord(g_life)] > 0 then
          begin
          MoveTo(3,game_bmp_role_h);
         LineTo(3,game_bmp_role_h-i);
         MoveTo(4,game_bmp_role_h);
         LineTo(4,game_bmp_role_h-i);
         MoveTo(5,game_bmp_role_h);
         LineTo(5,game_bmp_role_h-i);
          end;
        // 体力
          
          i:= round(tpl.plvalues[ord(g_tili)] / tpl.plvalues[ord(g_gdtl25)] * (lt-3))+3;

            ss:= ss + format(' |体力：%d / %d',[tpl.plvalues[ord(g_tili)],tpl.plvalues[ord(g_gdtl25)]]);
         if tpl.plvalues[ord(g_tili)]> 0 then
          begin
          Pen.Color:= clwhite;
          MoveTo(12,game_bmp_role_h);
         LineTo(12,game_bmp_role_h-lt);
         MoveTo(13,game_bmp_role_h);
         LineTo(13,game_bmp_role_h-lt);
         MoveTo(14,game_bmp_role_h);
         LineTo(14,game_bmp_role_h-lt);
          Pen.Color:= clblue;
          MoveTo(12,game_bmp_role_h);
         LineTo(12,game_bmp_role_h-i);
         MoveTo(13,game_bmp_role_h);
         LineTo(13,game_bmp_role_h-i);
         MoveTo(14,game_bmp_role_h);
         LineTo(14,game_bmp_role_h-i);
          end;
        // 灵力
          
          i:= round(tpl.plvalues[ord(g_lingli)] / tpl.plvalues[ord(g_gdll26)] * (lt-3))+3;
          if i<= 3 then
             i:= 3;

            ss:= ss + format(' |灵力：%d / %d',[tpl.plvalues[ord(g_lingli)],tpl.plvalues[ord(g_gdll26)]]);
          if tpl.plvalues[ord(g_lingli)]> 0 then
          begin
          Pen.Color:= clwhite;
          MoveTo(21,game_bmp_role_h);
         LineTo(21,game_bmp_role_h-lt);
         MoveTo(22,game_bmp_role_h);
         LineTo(22,game_bmp_role_h-lt);
         MoveTo(23,game_bmp_role_h);
         LineTo(23,game_bmp_role_h-lt);
           Pen.Color:= clpurple;
           MoveTo(21,game_bmp_role_h);
         LineTo(21,game_bmp_role_h-i);
         MoveTo(22,game_bmp_role_h);
         LineTo(22,game_bmp_role_h-i);
         MoveTo(23,game_bmp_role_h);
         LineTo(23,game_bmp_role_h-i);
          end;
        end; //end with

          if tpl.plvalues[ord(g_life)]<= 0 then
             M_bmp_bw(bmp); //彩色转黑白

       case p of
          0: begin
                          with image_role1 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          1: begin
                          with image_role2 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          2: begin
                          with image_role3 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          3: begin
                          with image_role4 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          4: begin
                          with image_role5 do
                           begin
                          
                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          end;
      bmp.Free;
       
      ss:= ss + format(' |速度：%d |防：%d',[tpl.plvalues[ord(g_speed)],tpl.plvalues[ord(g_defend)]]);
      g_hint_array_g[p]:= ss;
   case p of
    0: begin
        g_role_show1:= true;
      //  GLPlane10.Hint:= ss; //添加提示
       end;
    1: begin
        g_role_show2:= true;
       // GLPlane11.Hint:= ss;
       end;
    2: begin
        g_role_show3:= true;
       // GLPlane12.Hint:= ss;
       end;
    3: begin
        g_role_show4:= true;
      //  GLPlane13.Hint:= ss;
       end;
    4: begin
        g_role_show5:= true;
      //  GLPlane14.Hint:= ss;
       end;
    end;
end;

procedure TForm_pop.create_guai_list;
var
    ss,ss2: string;
    i,j: integer;

    function get_s: string;
     begin
      if pos(',',ss)> 0 then
       begin
       result:= copy(ss,1,pos(',',ss)-1);
       delete(ss,1, pos(',',ss));
       end else begin
             result:= ss;
             ss:= '';
            end;
     end;
     {

  Tgame_goods_type=(
  名称goods_name1,攻击goods_type1,防护值goods_f1,血值goods_t1,
  所会魔法goods_L1,经验值goods_s1,
  掉落物品goods_m1,掉落金钱goods_g1,
  掉落物品数goods_z1,掉落物概率goods_y1,
  速度goods_n1,头像序号goods_j1,goods_ms1);
            }
    procedure set_guai(k: integer; const ss3: string);
    begin
       with net_guai_g[k] do
                 begin
                 sid:= g_nil_user_c- k -1; //设置怪的sid为高端
                 ming:= strtoint2(data2.get_game_goods_type_s(ss3,goods_t1));
                     if ming < 0 then
                        ming:= game_read_values(0,ord(g_attack))* ming * -1; //倍数命
                     if Game_migong_xishu > 0 then
                       ming:= ming * Game_migong_xishu div 10;  //怪物血系数

                 ti:= ming div 2; //体力，默认为命除以2
                 ling:= ming * 2; //灵力默认为命乘以2
                 ming_gu:= ming;
                  if ming_gu<= 0 then
                     ming_gu:= 1;
                 ti_gu:= ti;
                   if ti_gu<= 0 then
                      ti_gu:= 1;
                   
                 ling_gu:= ling;
                  if ling_gu<= 0 then
                     ling_gu:= 1;

                 shu:= strtoint2(data2.get_game_goods_type_s(ss3,goods_n1));
                 gong:= strtoint2(data2.get_game_goods_type_s(ss3,goods_type1));
                         if Game_migong_xishu > 0 then
                          gong:= gong * Game_migong_xishu div 10;  //怪物攻系数
                 fang:= strtoint2(data2.get_game_goods_type_s(ss3,goods_F1));
                 L_fang:= 0;
                 end;
              with loc_guai_g[k] do
              begin
               name1:= data2.get_game_goods_type_s(ss3,goods_name1);
               fa_wu:= strtoint2(data2.get_game_goods_type_s(ss3,goods_L1));
               wu_shu:= net_guai_g[k].ming div 100; //默认物品数量为命的100分之一
               wu_diao:= strtoint2(data2.get_game_goods_type_s(ss3,goods_m1));
               wu_diao_shu:= strtoint2(data2.get_game_goods_type_s(ss3,goods_z1));
               wu_diao_gai:= strtoint2(data2.get_game_goods_type_s(ss3,goods_y1));
               qian:= strtoint2(data2.get_game_goods_type_s(ss3,goods_g1));
               qian_diao_gai:= 1; //钱概率，总是掉
               jingyan:= strtoint2(data2.get_game_goods_type_s(ss3,goods_s1));
                  if Game_migong_xishu > 0 then
                       jingyan:= jingyan * Game_migong_xishu div 10;  //打怪掉落的经验
               icon:= strtoint2(data2.get_game_goods_type_s(ss3,goods_j1));
              end;
    end;
begin
        //创建怪物列表
         zeromemory(@loc_guai_g,sizeof(T_loc_guai)* length(loc_guai_g));
         zeromemory(@net_guai_g,sizeof(Tnet_guai)* length(net_guai_g));
        for i:= 0 to 4 do
           net_guai_g[i].sid:= g_nil_user_c;


        if (game_monster_type< 0) or (game_monster_type > 10000) then
         begin
          //创建来自网络的怪
          pk_zhihui_g.is_pk:= create_net_guai(game_monster_type); //只要是来自网络的怪创建了，那么不管是否pk，都要设置为pk
          if pk_zhihui_g.is_pk then
              exit
              else
               game_monster_type:= 1; //如果创建网络怪不成功，那么随意指定了一个其他的怪

         end;

           {如果创建了网络怪物，那么流程已经退出，否则，继续创建本地怪物档}

        if Game_guai_list_G.Count= 0 then
          data2.Load_file_upp(game_app_path_G+'dat\guai.upp',Game_guai_list_G);
        Assert(Game_guai_list_G.Count> 0,'怪物文件无效。');
        ss:= Game_guai_list_G.Values[inttostr(game_monster_type)];
        j:= pos('(',ss);
        if j > 0 then
        begin
          ss:= copy(ss,j+ 1,pos(')',ss)-j-1);
          j:= 0;
         for i:= 0 to game_pop_count - 1 do
          begin
            ss2:= ss;
            while length(ss2)> 0 do
             begin
              set_guai(j,Game_guai_list_G.Values[get_s]);

              inc(j);        
              if j= 5 then
               exit; //怪物最多5个
             end; //end while
          end; //end for
        end else begin
                  for i:= 0 to game_pop_count - 1 do
                     begin
                       if i= 5 then
                        exit;  //怪物最多5个

                         set_guai(i,ss);
                     end; //end for
                 end;
     


end;

procedure TForm_pop.draw_game_guai(p: integer); //画出怪物，-1画出全部
var i: integer;
begin

  if p= -1 then
  begin
   g_guai_show1:= false;
   g_guai_show2:= false;
   g_guai_show3:= false;
   g_guai_show4:= false;
   g_guai_show5:= false;
   for i:= 0 to 4 do
     draw_game_guai_base(i);

  end else begin
              draw_game_guai_base(p);
           end;
end;

procedure TForm_pop.draw_game_guai_base(p: integer);
const lt= 32;
var
      bmp : TBitmap;
      ss: string;
      i: integer;
begin
if p>= 5 then
   p:= p -5;

     if net_guai_g[p].ming<= 0 then
        begin
         game_p_list[p+5]:= 0; //死亡怪的速度为零
          case p of
          0: g_guai_show1:= false;
          1: g_guai_show2:= false;
          2: g_guai_show3:= false;
          3: g_guai_show4:= false;
          4: g_guai_show5:= false;
          end;
         exit;
        end; //怪物死亡

      bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
      bmp.Width:=game_bmp_role_width;
      bmp.Height:=game_bmp_role_h;

     with bmp.Canvas do    //命值底色
       begin
           Pen.Color:= clwhite;
          MoveTo(3,game_bmp_role_h);
         LineTo(3,game_bmp_role_h-lt);
         MoveTo(4,game_bmp_role_h);
         LineTo(4,game_bmp_role_h-lt);
         MoveTo(5,game_bmp_role_h);
         LineTo(5,game_bmp_role_h-lt);
       end;
        // 生命值
          if net_guai_g[p].ming_gu* 4 > net_guai_g[p].ming * 10 then
             begin
               bmp.Canvas.Pen.Color:= clred;
               ss:= format('怪物：虚弱 |生命值：%d / %d',[net_guai_g[p].ming,net_guai_g[p].ming_gu]);
             end else if net_guai_g[p].ming_gu* 7 > net_guai_g[p].ming* 10 then
                       begin
                        bmp.Canvas.Pen.Color:= clyellow;
                        ss:= format('怪物：一般 |生命值：%d / %d',[net_guai_g[p].ming,net_guai_g[p].ming_gu]);
                       end else begin
                                 bmp.Canvas.Pen.Color:= clgreen;
                                 ss:= format('怪物：强壮 |生命值：%d / %d',[net_guai_g[p].ming,net_guai_g[p].ming_gu]);
                                end;

          ss:= ss + format(' |速度：%d |防：%d',[game_get_guai_su(p),net_guai_g[p].fang]);

          i:= round(net_guai_g[p].ming / net_guai_g[p].ming_gu * (lt-3))+3;

     with bmp.Canvas do
       begin
      Font.Name:='宋体';
      Font.Size:= 10;
      //Brush.Color:=rgb(213,206,180);   //怪物正常背景色
      FillRect(rect(0,0,game_bmp_role_width,game_bmp_role_h));

      if loc_guai_g[p].icon > 0 then
          data2.ImageList2.Draw(bmp.Canvas,33,0,loc_guai_g[p].icon + 1);

      Brush.Style:= bsClear;
      TextOut(3, 2, loc_guai_g[p].name1);
      
          MoveTo(3,game_bmp_role_h);  //画出命
         LineTo(3,game_bmp_role_h -i);
         MoveTo(4,game_bmp_role_h);
         LineTo(4,game_bmp_role_h -i);
         MoveTo(5,game_bmp_role_h);
         LineTo(5,game_bmp_role_h -i);

         //画出体和灵

        // 体力

          i:= round(net_guai_g[p].ti / net_guai_g[p].ti_gu * (lt-3))+3;

           // ss:= ss + format(' |体力：%d / %d',[tpl.plvalues[ord(g_tili)],tpl.plvalues[ord(g_gdtl25)]]);

          Pen.Color:= clwhite;
          MoveTo(12,game_bmp_role_h);
         LineTo(12,game_bmp_role_h-lt);
         MoveTo(13,game_bmp_role_h);
         LineTo(13,game_bmp_role_h-lt);
         MoveTo(14,game_bmp_role_h);
         LineTo(14,game_bmp_role_h-lt);
          Pen.Color:= clblue;
          MoveTo(12,game_bmp_role_h);
         LineTo(12,game_bmp_role_h-i);
         MoveTo(13,game_bmp_role_h);
         LineTo(13,game_bmp_role_h-i);
         MoveTo(14,game_bmp_role_h);
         LineTo(14,game_bmp_role_h-i);

        // 灵力
          
          i:= round(net_guai_g[p].ling / net_guai_g[p].ling_gu * (lt-3))+3;

           // ss:= ss + format(' |灵力：%d / %d',[tpl.plvalues[ord(g_lingli)],tpl.plvalues[ord(g_gdll26)]]);

          Pen.Color:= clwhite;
          MoveTo(21,game_bmp_role_h);
         LineTo(21,game_bmp_role_h-lt);
         MoveTo(22,game_bmp_role_h);
         LineTo(22,game_bmp_role_h-lt);
         MoveTo(23,game_bmp_role_h);
         LineTo(23,game_bmp_role_h-lt);
           Pen.Color:= clpurple;
           MoveTo(21,game_bmp_role_h);
         LineTo(21,game_bmp_role_h-i);
         MoveTo(22,game_bmp_role_h);
         LineTo(22,game_bmp_role_h-i);
         MoveTo(23,game_bmp_role_h);
         LineTo(23,game_bmp_role_h-i);
       end;

         case p of
          0: begin
                          with image_guai1 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          1: begin
                          with image_guai2 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          2: begin
                          with image_guai3 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          3: begin
                          with image_guai4 do
                           begin

                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          4: begin
                          with image_guai5 do
                           begin
                          
                          LoadFromBitmap(bmp,false,0,0);
                            end;
                         end;
          end;
      // GLMaterialLibrary1.Materials.Items[p+ 4].Material.Texture.image.Assign(bmp);
      bmp.Free;
    g_hint_array_g[p+ 5]:= ss; //添加提示
   case p of
    0: begin
        g_guai_show1:= true;
       // GLPlane5.Hint:= ss;  //添加提示
       end;
    1: begin
        g_guai_show2:= true;
      //  GLPlane6.Hint:= ss;
       end;
    2: begin
        g_guai_show3:= true;
       // GLPlane7.Hint:= ss;
       end;
    3: begin
        g_guai_show4:= true;
      //  GLPlane8.Hint:= ss;
       end;
    4: begin
        g_guai_show5:= true;
      //  GLPlane9.Hint:= ss;
       end;
    end;

end;

procedure TForm_pop.game_star_fight_message(var msg: TMessage);  //进入战斗
var b: boolean;
begin
game_musmv_ready:= false;
time_list1.Timer_donghua:= false;

  if (msg.WParam<> 6) or (msg.LParam<> 6) then
    begin
     if msg.LParam= 8 then
        start_show_word(false);

     exit;
    end;
   b:= (Random(2)= 1);
  //画出一个战斗开场动画
  // boll_show(b);

  if b then
   begin
   g_wo_guai_dangqian:= Fgame_my_cu;
   show_text(true,'您可以用法术，物品或者攻击');
   G_dangqian_zhuangtai:=G_chelue;
   //groupbox3.Visible:= true;
   g_gong.weizhi.Top:= 165;
   g_gong.weizhi.Left:= 640-180;
   g_gong.time:= game_amt_length;

   time_list1.timer_gong:= true;
   //reshow_su; //如果是“术”，重新显示
   show_text(true,'');
   //show_text(false,'看我的。');
   highlight_my(Fgame_my_cu);
   end else begin
              g_wo_guai_dangqian:= 5;
              show_text(true,'若能答对，怪只使2-8成功力');
              show_text(false,'');
             G_dangqian_zhuangtai:=G_word;
             g_gong.xianshi:= false;
             groupbox3.Visible:= false;
             time_list1.Timer_gong:= false;
             highlight_guai(Fgame_guai_cu);  //加亮
             start_show_word(false);
            end;
  game_musmv_ready:= true;
  write_label2_11; //刷新排序
end;

function get_min_guai_f: integer;  //获取一个血值最低的怪
var i,j: integer;
    function min_guai(a,b: integer): integer;
     begin
       if net_guai_g[a].ming> net_guai_g[b].ming then
        begin
         if net_guai_g[b].ming= 0 then
          result:= a
           else result:= b;

        end else  begin
                    if net_guai_g[a].ming= 0 then
                       result:= b
                       else
                        result:= a;
                  end;

     end;
begin
   j:= -1;
     for i:= 0 to 3 do //遍历怪，找出血值最低的。
        begin
         if j= -1 then
           j:= min_guai(i,i+1)
           else
            j:= min_guai(j,i+1);
        end;
   result:= j;
end;

procedure TForm_pop.guai_Attack(t,z: integer); //怪物攻击，参数为怪物编号，攻击指数
var g,g_mofa: integer; //攻击对象编号，-1表示全体,g2为零表示物理攻击，其他值表示法术攻击
    b: boolean;
begin
  //
  {
   1。自动选择一个攻击对象或者全体攻击
   2。加亮怪物本身和被攻击者
   3。播放动画
   4。扣除被攻击者血点
   5。去除加亮，重画
   6。判断结果
  }
  if t>= 5 then
     t:= t-5;
  b:= false; //是否敌人自己
  game_guai_escape:= false; //初始化为怪物没有逃跑
g:= 0;


   //highlight_guai(t);  //加亮，在攻击前就已经加亮了



       // 选择攻击方式，确定要攻击id
       g_mofa:= loc_guai_g[t].fa_wu;
      if g_mofa > 0 then //大于零表示此怪会魔法，有一定概率使用魔法
       begin
        if Game_base_random(4)= 1 then
           begin
            //根据法术或者物品，来决定是群攻，单攻，群恢复，单恢复
              case data2.get_game_goods_type(g_mofa,goods_type1) of
                2:   begin  //恢复
                      g:= get_min_guai_f;
                      b:= true;
                     end;
                4:   begin   //攻击
                       g:= get_r_role_id;
                     end;
                128: begin    //法术
                      if data2.get_game_goods_type(g_mofa,goods_j1)=1 then
                         begin  //攻击
                          if data2.get_game_goods_type(g_mofa,goods_y1)=1 then  //为一表示单体
                            g:= get_r_role_id
                            else  g:= -1;
                         end else begin  //恢复
                                   if data2.get_game_goods_type(g_mofa,goods_y1)=1 then
                                      g:= get_min_guai_f
                                      else  g:= -1;
                                      b:= true;
                                  end;
                     end;
                256: begin    //增强
                       g:= get_min_guai_f;
                       b:= true;
                     end;
                end;

           end else begin
                      g:= get_r_role_id;
                      g_mofa:= 0;
                     end;
       end else begin
                  g:= get_r_role_id;
                  mtl_game_cmd_dh1.wu:= 0;
                  if g_mofa < 0 then //小于零表示此怪会逃跑
                    begin
                     if Game_base_random(abs(g_mofa))=1 then
                       begin
                        loc_guai_g[t].wu_diao:= 0; //逃跑的没有东西掉的
                        loc_guai_g[t].qian:= 0;
                        net_guai_g[t].ming:= 0;
                        net_guai_g[t].shu:= 0;
                        game_p_list[t+5]:= 0;
                        show_text(true,'跑了');
                          draw_game_guai(t);
                        game_guai_escape:= true; //怪物已经逃跑
                        G_game_delay(800);
                        g_guai_A_next;  //进入攻击动画后续处理过程
                        exit;
                       end;
                    end;
                end;
   


      //在物品定时器内使用的变量，0-4，我方人物，5-9，敌方人物
         if b and (g<> -1) then
          g:= g+ 5;


   application.ProcessMessages;

       { //设定扣血参数
        sid_to_roleId(mtl_game_cmd_dh1.fq_sid):= t;
        sid_to_roleId(mtl_game_cmd_dh1.js_sid):= g;
        g_sub_boold_array_G[2]:= z;
        g_sub_boold_array_G[3]:= g2;  }

        //设定怪物攻击力
          gong_js(t+5, g,g_mofa,true);  //算出怪的攻击力，设置好怪参数

          //播放动画
        game_Animation(false,t,g,g_mofa); //向下攻击，怪编号，被攻击者编号，攻击类型

        //动画结束后，定时器将流程转入动画后续处理  g_guai_A_next

end;

function TForm_pop.game_p_list_ex: integer;   //速度，清空最大值，返回速度最高的编号
var i: integer;
    t: Tplayer;
begin
    //速度的累加在速度统计定时器内进行，20倍时中止
  //0--4，我方编号，5--9，敌方编号
result:= 0;

  for i:= 0 to 9 do
   begin
     if game_p_list[i] > game_p_list[result] then
       result:= i;
   end; //end for i

       if (result= 0) and (game_p_list[result]= 0) then
          begin
            //异常情况速度都为零  那么判断一下是否游戏需要结束了
           result:= -1;
           exit;
          end
          else
           game_p_list[result]:= 0; //返回最大的，并清零
      if result > 4 then
       begin
       if net_guai_g[result-5].ming= 0 then
          result:= game_p_list_ex;
       end else begin
                 t:= game_get_role_from_i(result);
                 if t<>nil then
                    if t.plvalues[ord(g_life)]<= 0 then
                       result:= game_p_list_ex;
                end;
end;

function TForm_pop.game_get_role_from_i(i: integer): Tplayer; //根据上场人物的编号来获得人物实例
var j,k: integer;
begin
k:= 0;
result:= nil;
  for j:= 0 to Game_role_list.Count-1 do
    begin
      if game_read_values(j,4)= 1 then
        inc(k);  //跳过不被允许上场的人，只有等于1的，才计数

      if k = i + 1 then
       begin
        result:= Tplayer(Game_role_list.Items[j]);
        exit;
       end;
    end;

end;

function TForm_pop.game_get_role_su(i: integer): integer; //根据上场人物编号来取得其速度
var t: Tplayer;
    k: Tmtl_rec;
begin
result:= 0;

  t:= game_get_role_from_i(i);

  if t<> nil then
    if t.plvalues[ord(g_life)]> 0 then //已经死亡的角色速度不累计
        result:= t.plvalues[2];
 if result> 0 then
  begin
   //透过物品定时过滤器，看看是否有偏移值，
    //第一个参数，人物，0-4我方，5-9敌方，第二个参数，1=运，2=速。3=攻，4防
    k:= game_return_filter(i,1);
   result:= result + k.l.Hi;
   if result< 0 then
      result:= 0;
  end;
end;

function TForm_pop.game_get_guai_su(i: integer): integer; //根据上场怪物编号来取得其速度
var k: Tmtl_rec;
begin

   //guai_lifeblood1: array[0..4] of integer;  //怪物血值
   //    guai_list1: array[0..4] of string; //怪物列表
    result:= 0;
   if i > 4 then
     i:= i-5;

   if (net_guai_g[i].shu > 0) and (net_guai_g[i].ming > 0) then
    result:= net_guai_g[i].shu;
      

  if result> 0 then
  begin
   //透过物品定时过滤器，看看是否有偏移值，
    //第一个参数，人物，0-4我方，5-9敌方，第二个参数，1=运，2=速。3=攻，4防
    k:= game_return_filter(i+ 5,1);
   result:= result +  k.l.Hi;
   if result< 0 then
      result:= 0;
  end;

end;

procedure TForm_pop.My_Attack(m,p, d: integer);
begin
     //我方攻击，参数为攻击者，怪物id和攻击方式，0为普通攻击，其他值为法术或者物体
     //怪物id-1，表示攻击怪物全体
     //攻击过程，根据对方的防值，减去合适的血值
    {
    攻击的完整过程
    1。加亮本人和被攻击对象
    2。播放动画
    3。扣除攻击者灵力或者体力
    4。扣除对方血点
    5。去除加亮 ，重画
    6。判断结果
    }



    //计算扣血参数
     if p<> -1 then
        p:= p + 5;
     gong_js(m, p,d,false); //我方攻击，计算出攻击参数（三个参数为 攻击者，被攻击者，攻击类型）




          //播放动画
        if d> 0 then
         begin
          if data2.get_game_goods_type(d,goods_z1)= 3 then //盗窃术
            g_miao_shou(p, d)
          else
            game_Animation(true,m,p,d);
         end else
               game_Animation(true,m,p,d); //向下攻击，怪编号，被攻击者编号，攻击类型

        //动画完毕后，定时器将把流程转入动画后处理 g_wo_a_next 判断结果，重画人员等




end;

procedure TForm_pop.highlight_guai(id: integer); //加亮指定怪物，-1,加亮全部
var i: integer;
begin
  if id= -1 then
   begin
    for i:= 0 to 4 do
       highlight_guai_base(i);

   end else highlight_guai_base(id);
end;

procedure TForm_pop.highlight_guai_base(id: integer);
begin
  if (id= 0) then
   G_guai_jialiang1:= true
   else if (id= 1) then
   G_guai_jialiang2:= true
   else if (id= 2) then
   G_guai_jialiang3:= true
   else if (id= 3) then
   G_guai_jialiang4:= true
   else if (id= 4) then
   G_guai_jialiang5:= true;

end;

procedure TForm_pop.un_highlight_guai(id: integer); //恢复加亮指定怪物，-1,回复加亮全部
var i: integer;
begin
  if id= -1 then
   begin
    for i:= 0 to 4 do
       un_highlight_guai_base(i);

   end else un_highlight_guai_base(id);

end;

procedure TForm_pop.un_highlight_guai_base(id: integer);
begin

  if (id= 0) then
   G_guai_jialiang1:= false
   else if (id= 1) then
   G_guai_jialiang2:= false
   else if (id= 2) then
   G_guai_jialiang3:= false
   else if (id= 3) then
   G_guai_jialiang4:= false
   else if (id= 4) then
   G_guai_jialiang5:= false;

end;

procedure TForm_pop.highlight_my(id: integer);
var i: integer;
begin
  if id= -1 then
   begin
    for i:= 0 to 4 do
       highlight_my_base(i);

   end else highlight_my_base(id);

end;

procedure TForm_pop.highlight_my_base(id: integer);
begin
  if (id= 0) then
   g_role_jialiang1:= true
   else if (id= 1) then
   g_role_jialiang2:= true
   else if (id= 2) then
   g_role_jialiang3:= true
   else if (id= 3) then
   g_role_jialiang4:= true
   else if (id= 4) then
   g_role_jialiang5:= true;
end;

procedure TForm_pop.un_highlight_my(id: integer);
var i: integer;
begin
  if id= -1 then
   begin
    for i:= 0 to 4 do
       un_highlight_my_base(i);

   end else un_highlight_my_base(id);

end;

procedure TForm_pop.un_highlight_my_base(id: integer);
begin
   if (id= 0) then
   g_role_jialiang1:= false
   else if (id= 1) then
   g_role_jialiang2:= false
   else if (id= 2) then
   g_role_jialiang3:= false
   else if (id= 3) then
   g_role_jialiang4:= false
   else if (id= 4) then
   g_role_jialiang5:= false;
end;
            {通过上场id 0--4 来获得在人物列表内的编号，因为有不上场人物的存在，才需要这样做}
function TForm_pop.get_pid_from_showId(i: integer): integer;
var j,k: integer;
begin
k:= 0;
result:= -1;

if i= -1 then
 begin
   //-1，直接返回，不继续判断
 exit;
 end;

  for j:= 0 to Game_role_list.Count-1 do
    begin
      if game_read_values(j,4)= 1 then
        inc(k);  //跳过不被允许上场的人，只有等于1的，才计数

      if k = i + 1 then
       begin
        result:= j;
        exit;
       end;
    end;

end;

function TForm_pop.get_r_role_id: integer; //获得一个随机上场人物的id
var j,k,m: integer;
    label pp;
begin

   k:= get_r_role_all_count; //获取全部上场人物数

m:= 0;

     pp:
   result:= Random(k);  //取得一个随机id
   inc(m);
   if m > 100 then
    begin
     result:= 0;
     exit; //退出死循环
    end;

      j:= get_pid_from_showId(result); //根据上场id获得实例id
      if j= -1 then
        goto pp;
        
    if game_read_values(j,ord(g_life))<= 0 then
        goto pp; //如果此角色死亡，再做随机选择

end;

procedure TForm_pop.game_Animation(up: boolean; p1, p2, p3: integer);
var ss: string;
    c1: Tcolor;
    i,fq1,js1: integer;
    function shezhi_fx:boolean;
     var j,g2,w2: integer;
     begin
      g2:= 0;
      w2:= 0;
       for j := 0 to 4 do
         begin
          if net_guai_g[j].sid= mtl_game_cmd_dh1.fq_sid then
             g2:= 1
              else if net_guai_g[j].sid= mtl_game_cmd_dh1.js_sid then
                       w2:= 1;

         end;
       for j := 0 to 4 do
         begin
          if game_player_head_G.duiyuan[j]= mtl_game_cmd_dh1.fq_sid then
             g2:= 2
              else if net_guai_g[j].sid= mtl_game_cmd_dh1.js_sid then
                       w2:= 2;

         end;
       result:= w2 > g2;
     end;
begin
        //攻击方向，up表示我方向怪攻击
        //p123表示，攻击者编号，被攻击者编号（均为上场显示编号），攻击类型，0表示物理攻击
     g_gong.xianshi:= false;
     groupbox3.Visible:= false;
     // g_show_text_up:= false;
     //g_show_text_down:= false;
     { if p3= 0 then
       begin
        show_text(not up,'攻击');
       end else begin
                ss:= data2.get_goods_all_s(p3);
                show_text(not up,data2.get_game_goods_type_s(ss,goods_name1));
                end;   }
        {
        动画过程 根据 mtl_game_cmd_dh1  的值重新定义参数  动画过程的参数
        然后重设发起方人物数据
        动画完毕后重设被攻击方人物数据
        }

        Timer_auto_attack.Enabled:= false; //自动攻击停止
        g_auto_attack:= 0;
        game_pic_check_area:= G_all_Pic_n; //全局gl对象禁止选中


         fq1:= sid_to_roleId(mtl_game_cmd_dh1.fq_sid);
         js1:= sid_to_roleId(mtl_game_cmd_dh1.js_sid);


        p1:= sid_to_roleId(mtl_game_cmd_dh1.fq_sid);   //mtl数组内的值是s_id,需转换
        // p2:= sid_to_roleId(mtl_game_cmd_dh1.js_sid);   //这里的roleid是按屏幕序号来的
           if mtl_game_cmd_dh1.wu > 1023 then
              mtl_game_cmd_dh1.wu := 0;
              
          p3:= mtl_game_cmd_dh1.wu;  //物，法术，编号
        if game_at_net_g then
         begin
           //如果是联网游戏，那么需要重新设定up的值
           up:= shezhi_fx;
         end;

        if fq1>= 5 then
          highlight_guai(fq1-5)
          else
            highlight_my(fq1); //加亮人物

         if js1>= 5 then
          highlight_guai(js1-5)
          else if js1= -1 then
                begin
                 if up then
                   highlight_guai(js1)
                   else
                     highlight_my(js1);
                end else
                 highlight_my(js1); //加亮人物

         //重设发起方的人物值****************************************
        if game_at_net_g then
         begin
           //如果是联网游戏，重新设置发起人物的值
           if mtl_game_cmd_dh1.fq_sid= my_s_id_g then
             begin
              game_write_values(0,8,mtl_game_cmd_dh1.fq_m);
              game_write_values(0,5,mtl_game_cmd_dh1.fq_t);
              game_write_values(0,6,mtl_game_cmd_dh1.fq_l);
             end else begin
                        for i := 0 to 4 do
                          begin
                            if net_guai_g[i].sid= mtl_game_cmd_dh1.fq_sid then
                               begin
                                net_guai_g[i].ming:= mtl_game_cmd_dh1.fq_m;
                                net_guai_g[i].ti:= mtl_game_cmd_dh1.fq_t;
                                net_guai_g[i].ling:= mtl_game_cmd_dh1.fq_l;
                                 break;
                               end;
                          end;
                        for I := 0 to 4 do
                          begin
                            if game_read_values(get_pid_from_showId(i),34)= mtl_game_cmd_dh1.fq_sid then
                               begin
                                game_at_net_g:= false; //设置为false，准备更新其他人物的值
                                game_write_values(get_pid_from_showId(i),8,mtl_game_cmd_dh1.fq_m);
                                game_write_values(get_pid_from_showId(i),5,mtl_game_cmd_dh1.fq_t);
                                game_write_values(get_pid_from_showId(i),6,mtl_game_cmd_dh1.fq_l);
                                 game_at_net_g:= true;
                                 break;
                               end;
                          end;
                      end;
           
         end else begin
                   //如果是单机，那么根据up的值来确定人物，并设置新值
                    if up then
                     begin
                      //我方是攻击方
                      game_write_values(get_pid_from_showId(p1),8,mtl_game_cmd_dh1.fq_m);
                      game_write_values(get_pid_from_showId(p1),5,mtl_game_cmd_dh1.fq_t);
                      game_write_values(get_pid_from_showId(p1),6,mtl_game_cmd_dh1.fq_l);
                     end else begin
                                //怪是攻击方
                                if p1> 4 then
                                  dec(p1,5);
                                net_guai_g[p1].ming:= mtl_game_cmd_dh1.fq_m;
                                net_guai_g[p1].ti:= mtl_game_cmd_dh1.fq_t;
                                net_guai_g[p1].ling:= mtl_game_cmd_dh1.fq_l;
                              end;
                  end;

         //重设发起方的人物值****************************************结束

      show_text(true,'');
      show_text(false,'');
     if up then
      c1:= clblue
       else
        c1:= clblack;
     if p3= 0 then
      begin
      i:= 1001;
      ss:= '';
      end else begin
                ss:= data2.get_goods_all_s(p3);
                i:= strtoint2(data2.get_game_goods_type_s(ss,goods_type1));
                 if i and 2= 2 then
                   i:= 1004
                    else if i and 4= 4 then
                     i:= 1003
                      else if i and 128 = 128 then
                        begin
                          if strtoint2(data2.get_game_goods_type_s(ss,goods_j1))= 0 then
                             i:= 1005
                             else
                              i:= 1012;
                        end;

                 ss:= data2.get_game_goods_type_s(ss,goods_name1);

               end;
   {
          flag
          1000 无效果
          1001  轮廓
          1002  噪音
          1003  模糊
          1004  渐变
          1005  半透明
          1006  纹理（未用）

         }

       if ss<> '' then
         draw_text_17(ss,i,c1);

  game_musmv_ready:= false;

   g_dangqian_zhuangtai:= G_animation; //游戏处于动画状态


   if mtl_game_cmd_dh1.flag= 8 then
      begin
       draw_text_17('Miss',1000,clmaroon,18);
       G_game_delay(1000);
       G_show_result_b:= false;
        un_highlight_my(-1);  //恢复加亮
        un_highlight_guai(-1);
        game_fight_result_adv; //判断结果
        mtl_game_cmd_dh1.flag:= 0;
      end else begin
               case i of
                1001: game_Animation_base1(up);
                1012: game_Animation_base2(up);
                1003: game_Animation_base3(up);
                1004: game_Animation_base4(up);
                1005: game_Animation_base5(up);
               end;
              end;
   game_musmv_ready:= true;

end;

procedure TForm_pop.game_blood_add_one; //战斗结束后，死亡角色血点恢复为一
var j: integer;

begin

  for j:= 0 to Game_role_list.Count-1 do
      if game_read_values(j,ord(g_life))<= 0 then
         game_write_values(j,ord(g_life),1);



end;

function GetWinDir: string;
var
dir: array [0..MAX_PATH] of Char;
begin
GetWindowsDirectory(dir, MAX_PATH);
Result := StrPas(dir);
end;

function GetSystemDir: string;
var
dir: array [0..MAX_PATH] of Char;
begin
GetSystemDirectory(dir, MAX_PATH);
Result := StrPas(dir);
end;

function TForm_pop.game_can_spvoice1: boolean;
var Reg: TRegistry;
   ss: string;
begin

result:= false;

  Reg := TRegistry.Create;
    with Reg do
     begin
    RootKey := HKEY_LOCAL_MACHINE;
    if KeyExists('SOFTWARE\Classes\CLSID\{96749377-3391-11D2-9ee3-00c04f797396}\InProcServer32') then
      begin
       if OpenKeyReadOnly('SOFTWARE\Classes\CLSID\{96749377-3391-11D2-9ee3-00c04f797396}\InProcServer32') then
        begin
        ss:= readstring('');
        if pos('%',ss)>0 then
         begin
           delete(ss,1,pos('%',ss));
           delete(ss,1,pos('%',ss));
           if pos('ystem',ss)>0 then
             ss:= GetWinDir+ ss
             else
               ss:= GetSystemDir+ ss;
         end;
        if FileExists(ss) then
           result:= true;
        closekey;
        end;
      end;
    Free;
    end;

end;

function TForm_pop.game_fight_result: integer;  //判断战斗结果,result:= 1 //我方阵亡
var i,j: integer;
    b1,b2: boolean;
begin
 if button14.Tag=1 then
  begin
    result:= 2;
    exit; //调试，直接胜利
  end;

b1:= false;
b2:= false;
   for i:= 0 to 4 do
    begin
     if net_guai_g[i].ming > 0 then
        b1:= true;
        j:= get_pid_from_showId(i);
        if j>= 0 then
         if game_read_values(j,ord(g_life))> 0 then
           b2:= true;
    end; //end for

    if b1 and b2 then
    result:= 0
     else if b1 then
          result:= 1 //我方阵亡
           else result:= 2; //怪物死亡
end;

procedure TForm_pop.game_guai_Attack_blood;   //怪攻击，扣除我方血值
    procedure blood2(t: integer); //内嵌过程，我方编号，怪物攻击力
      var p: Tplayer;
      begin
         p:= game_get_role_from_i(t);
         if p= nil then
           exit;

            if p.plvalues[ord(g_life)]= 0 then
               exit;  //已经死亡角色退出值飘动


             p.plvalues[ord(g_linshifang)]:= 1; //每次使用后临时防护系数归零



               //伤害值，飘动
              //伤害值，飘动，飘动方向，false向下，飘动的值，人物id，类型（1血，二体力，三灵力）
              
                 game_show_blood(true,mtl_game_cmd_dh1.js_m,t,1);
                 p.plvalues[ord(g_life)]:=  p.plvalues[ord(g_life)] +mtl_game_cmd_dh1.js_m;

                 //发出声音 ********************************************
                 if p.plvalues[ord(g_life)] <= 0 then
               begin
                p.plvalues[ord(g_life)]:= 0; //血值最低为零
                if gamesave1.tip5= 0 then
                 begin
                  if p.plvalues[ord(g_sex)]= 0 then
                     play_sound(11)
                     else
                      play_sound(10); //男的死亡声音
                 end;
               end else begin
                          if (game_guai_fanghu_xishu_f<= 10) and (mtl_game_cmd_dh1.js_m < 0) then
                          begin
                           if gamesave1.tip6= 0 then
                            begin
                             if p.plvalues[ord(g_sex)]= 0 then
                                play_sound(13)
                                else
                                 play_sound(12); //男的被攻击
                            end;
                          end;
                        end;
               //声音结束 ××××××××××××××××××××××××××××××××

               if mtl_game_cmd_dh1.js_t<> 0 then
                begin
                 G_game_delay(500);
                 game_show_blood(true,mtl_game_cmd_dh1.js_t,t,2);
               end;
               
              if mtl_game_cmd_dh1.js_l<> 0 then
              begin
              G_game_delay(500);
              game_show_blood(true,mtl_game_cmd_dh1.js_l,t,3);
              end;

             p.plvalues[ord(g_tili)]:=  p.plvalues[ord(g_tili)] +mtl_game_cmd_dh1.js_t;
             p.plvalues[ord(g_lingli)]:=  p.plvalues[ord(g_lingli)] +mtl_game_cmd_dh1.js_l;
               if p.plvalues[ord(g_tili)]< 0 then
                  p.plvalues[ord(g_tili)]:= 0;
               if p.plvalues[ord(g_lingli)]< 0 then
                  p.plvalues[ord(g_lingli)]:= 0;



      end;
var i,t2: integer;
begin
    //被怪攻击后扣除我方血点
    //t1，怪编号，t2,我方编号-1，表示全体，t3攻击力（攻击指数和攻击力运算后结果）

   t2:= sid_to_roleId(mtl_game_cmd_dh1.js_sid);
   if t2 >= 5 then
      t2:= t2 -5;

  if t2= -1 then
   begin
    for i:= 0 to 4 do
        blood2(i);

   end else blood2(t2);

end;

function TForm_pop.game_get_Attack_value(z1, z2: integer): Tmtl_rec; //获取当前怪的攻击力
var i,j,m: integer;
    k: Tmtl_rec;
    b: boolean;

begin
      //根据攻击指数和攻击类型返回攻击力
      //这个过程总是本地怪使用，因为网络怪（也就是对方是真实的人），不会调用到这个过程
 result.m.int:= 0;
 result.t.int:= 0;
 result.l.int:= 0;
  b:= false;

     mtl_game_cmd_dh1.fq_m:= net_guai_g[Fgame_guai_cu].ming;
      mtl_game_cmd_dh1.fq_t:= net_guai_g[Fgame_guai_cu].ti;
      mtl_game_cmd_dh1.fq_l:= word(net_guai_g[Fgame_guai_cu].ling);

      if z2<= 0 then
       begin
         //物理攻击,获取当前怪的攻击力
         i:= net_guai_g[Fgame_guai_cu].gong;
         if i < 0 then //攻击力为负数时，该值除以10 乘以主角生命值
            i:= i * game_read_values(0,ord(g_gdsmz27)) div 10;

         result.m.lo:= i;
       end else begin
                  //判断是法术攻击，还是物品攻击
                  b:= true;
                  i:= data2.get_game_goods_type(z2,goods_type1); //取得类型
               if i and 128= 128 then
                begin
                 //法术，直接得到攻击值
                // result:= data2.get_game_goods_type(z2,goods_m1) * z1 div 10;
                  //扣除灵力，取得灵力新值
                   j:= data2.get_game_goods_type(z2,goods_L1);
                   if j > mtl_game_cmd_dh1.fq_l then
                      mtl_game_cmd_dh1.fq_l:= 0
                      else
                        mtl_game_cmd_dh1.fq_l:= mtl_game_cmd_dh1.fq_l- j;


                 //法术，直接得到扣血值
                 result.m.Lo:= data2.get_game_goods_type(z2,goods_m1);  //命
                 result.t.Lo:= data2.get_game_goods_type(z2,goods_t1);   //体
                 result.m.Hi:= data2.get_game_goods_type(z2,goods_g1);   //攻
                 result.t.Hi:= data2.get_game_goods_type(z2,goods_z1);   //防
                 result.l.Hi:= data2.get_game_goods_type(z2,goods_s1);   //速
                end else if (i and 4= 4) or (i and 2= 2) or (i and 256= 256) then
                          begin

                            //扣除物品数量
                             if loc_guai_g[Fgame_guai_cu].wu_shu<= 0 then
                                exit;
                             loc_guai_g[Fgame_guai_cu].wu_shu:= loc_guai_g[Fgame_guai_cu].wu_shu-1;
                            //攻击类物品，除返回直接攻击值外，还要定时
                                m:= net_guai_g[Fgame_guai_cu].shu + 1;
                                m:= round((game_read_values(get_pid_from_showId(Fgame_my_cu),ord(g_defend))
                                          /m+1) * 10);
                              if Random(m)> 10 then
                                begin
                                   //计算出了 我方防护相对对方速度的系数，现在我方防护起作用，对方投掷失败
                                   mtl_game_cmd_dh1.flag:= 8; //攻击被躲避
                                  exit;
                                end;

                             {减命}
                            m:= data2.get_game_goods_type(z2,goods_m1);
                               if (m<> game_m_quan) then
                                 m:= game_read_values(0,ord(g_gdsmz27));
                               if (m<>game_m_ban) then
                                 m:= game_read_values(0,ord(g_gdsmz27)) div 2;
                              result.m.lo:= m;
                              {减攻 仅定时器内有效}
                            // result.m.Hi:= data2.get_game_goods_type(z2,goods_g1);
                              {减防，仅定时器内有效}
                            //  result.t.Hi:=  data2.get_game_goods_type(z2,goods_f1);

                              {减速，仅定时器内有效}
                            //   result.l.Hi:= data2.get_game_goods_type(z2,goods_s1);
                               {减体}
                           m:= data2.get_game_goods_type(z2,goods_t1);
                              if (m<> game_m_quan) then
                                 m:= game_read_values(0,ord(g_gdtl25));
                               if (m<>game_m_ban) then
                                 m:= game_read_values(0,ord(g_gdtl25)) div 2;
                             result.t.lo:= m;
                               {减灵}
                            m:=  data2.get_game_goods_type(z2,goods_l1);
                               if (m<> game_m_quan) then
                                 m:= game_read_values(0,ord(g_gdll26));
                               if (m<>game_m_ban) then
                                 m:= game_read_values(0,ord(g_gdll26)) div 2;
                              result.l.lo:= m;   

                           if data2.get_game_goods_type(z2,goods_n1)<>0 then
                              begin
                                //安插定时器
                                game_add_to_goods_time_list(z2);
                              end;

                          end;
                end; //end if


     result.m.lo:= result.m.lo * z1 div 10;  //攻击系数，比如回答的正确与否
     result.t.Lo:= result.t.Lo * z1 div 10;
     result.l.Lo:= result.l.Lo * z1 div 10;
     
   //攻击，处理为负数 包括物品类型为4或者j1类型为 1
      if not b then   //法术，物品攻击不受影响
     begin
      k:= game_return_filter(Fgame_guai_cu +5 ,3);
      result.m.Lo:= result.m.Lo + k.m.Lo;
        if result.m.Lo < 0 then
           result.m.Lo:= 0;
      result.t.Lo:= result.t.Lo + k.t.Lo;
        if result.t.Lo < 0 then
           result.t.Lo:= 0;
      result.l.Lo:= result.l.Lo + k.l.Lo;
         if result.l.Lo < 0 then
           result.l.Lo:= 0;
      result.m.Hi:= result.m.Hi + k.m.hi;
        if result.m.Hi < 0 then
           result.m.Hi:= 0;
      result.t.Hi:= result.t.Hi + k.t.hi;
        if result.t.Hi < 0 then
           result.t.Hi:= 0;
      result.l.Hi:= result.l.Hi + k.l.hi;
        if result.l.Hi < 0 then
           result.l.Hi:= 0;
    end;

   if (z2<= 0) or (i and 4= 4) or (data2.get_game_goods_type(z2,goods_j1)=1) then
   begin
   result.m.Lo:= result.m.Lo * -1;
   result.t.Lo:= result.t.Lo * -1;
   result.l.Lo:= result.l.Lo * -1;
   result.m.Hi:= result.m.Hi * -1;
   result.t.Hi:= result.t.Hi * -1;
   result.l.Hi:= result.l.Hi * -1;
   end;
        //透过物品定时过滤器，看看是否有偏移值，
    //第一个参数，人物，0-4我方，5-9敌方，第二个参数，1=运，2=速。3=攻，4防

     
end;

procedure TForm_pop.game_fight_keep;
begin
       //下一轮战斗

       if game_at_net_g then
     begin
       if (game_player_head_G.duiwu_dg= 1) and (pk_zhihui_g.is_kongzhi= false) and (pk_zhihui_g.game_zt<>4) then
          exit;  //如果是完全跟随，且没有控制权，且不是打坐，那么单词不显示
       if (game_player_head_G.duiwu_dg= 2) and (pk_zhihui_g.is_kongzhi= false) and (pk_zhihui_g.game_zt >4) then
          exit;  //如果是打怪跟随，且没有控制权，且是战斗状态，那么单纯不显示
     end;


  g_wo_guai_dangqian:=  game_p_list_ex; //得到轮到战斗的人物id，按速度排

      // 0--4，我方人员，5--9，敌方人员
   {============================================= }
     //根据需要添加过场动画


  { ==============================================}
    if g_wo_guai_dangqian= -1 then
       g_wo_guai_dangqian:= 5;

   if g_wo_guai_dangqian> 4 then
     begin
     show_text(true,'如选择正确，怪攻击力将降低');
      Fgame_guai_cu:= g_wo_guai_dangqian- 5;   //保存当前怪编号
      //怪物发起战斗
      //加亮此怪
       highlight_guai(Fgame_guai_cu);  //加亮
       time_list1.timer_gong:= false;
       g_gong.xianshi:= false;
       //显示单词窗口
       start_show_word(false);
     end else begin
                //我方发起战斗

                show_text(true,'您可以用法术，物品或者攻击');
               Fgame_my_cu:= g_wo_guai_dangqian;
               highlight_my(Fgame_my_cu);  //加亮
                g_gong.weizhi.Top:= 165;
                   g_gong.weizhi.Left:= 640-180;
                   g_gong.time:= game_amt_length;

               time_list1.Timer_gong:= true;
               //groupbox3.Visible:= true;

              end;
  write_label2_11; //排序显示
end;

procedure TForm_pop.game_word_amt;
begin
  g_danci_donghua_count:= 0; //动画开始帧数

 game_musmv_ready:= false;

  g_danci_donghua_id:= Game_base_random(7);


   time_list1.Timer_donghua:= true;
end;

function weizhi_get_alpha(t: integer):byte;
 begin
  result:= round((t / game_amt_length) * (t / game_amt_length)* 245)+10;
 end;
function weizhi_get_nn(t: integer):integer;
 begin
  result:= (game_amt_length -t) div 2;
 end;

procedure TForm_pop.go_amt_00(t: integer);
begin   //从左到右移动
     if GameSave1.tip1= 0 then
      begin
    g_danci_weizhi.weizi.Left:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width))- game_bmp_width;
    g_danci_weizhi.weizi.Right:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width));
     

    g_jieshi_weizhi1.weizi.Left:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width))- game_bmp_width;
    g_jieshi_weizhi1.weizi.Right:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width));

    g_jieshi_weizhi2.weizi.Left:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width))- game_bmp_width;
    g_jieshi_weizhi2.weizi.Right:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width));

    g_jieshi_weizhi3.weizi.Left:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width))- game_bmp_width;
    g_jieshi_weizhi3.weizi.Right:= round(t / game_amt_length * (g_word_show_left+ game_bmp_width));
       end;
      if GameSave1.tip2= 0 then
       begin
      g_danci_weizhi.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_01(t: integer);
begin    //从小到大，从左向右弹出
       if GameSave1.tip1= 0 then
      begin
     g_danci_weizhi.weizi.right:= round(t / game_amt_length * game_bmp_width) + g_word_show_left;

     g_jieshi_weizhi1.weizi.right:=  round(t / game_amt_length * game_bmp_width)+ g_word_show_left;

     g_jieshi_weizhi2.weizi.right:=  round(t / game_amt_length * game_bmp_width)+ g_word_show_left;

     g_jieshi_weizhi3.weizi.right:= round(t / game_amt_length * game_bmp_width)+ g_word_show_left;
      end;
      if GameSave1.tip2= 0 then
      begin
      g_danci_weizhi.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_02(t: integer);
begin  //从右到左
     if GameSave1.tip1= 0 then
      begin
    g_danci_weizhi.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    g_danci_weizhi.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
      
    g_jieshi_weizhi1.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    g_jieshi_weizhi1.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;

    g_jieshi_weizhi2.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));

    g_jieshi_weizhi2.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;

    g_jieshi_weizhi3.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    g_jieshi_weizhi3.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
      end;
      if GameSave1.tip2= 0 then
      begin
    g_danci_weizhi.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_03(t: integer);
begin //从上到下
       if GameSave1.tip1= 0 then
      begin
  g_danci_weizhi.weizi.top:= round(t / game_amt_length * G_C_danci_top);
   g_danci_weizhi.weizi.Bottom:= round(t / game_amt_length * G_C_danci_top)+ game_bmp_h1;
         
  g_jieshi_weizhi1.weizi.top:= round(t / game_amt_length * G_C_jieshi1_top);
  g_jieshi_weizhi1.weizi.Bottom:= round(t / game_amt_length * G_C_jieshi1_top)+ game_bmp_h2;

  g_jieshi_weizhi2.weizi.top:= round(t / game_amt_length * G_C_jieshi2_top);
  g_jieshi_weizhi2.weizi.Bottom:= round(t / game_amt_length * G_C_jieshi2_top)+ game_bmp_h2;

  g_jieshi_weizhi3.weizi.top:= round(t / game_amt_length * G_C_jieshi3_top);
  g_jieshi_weizhi3.weizi.Bottom:= round(t / game_amt_length * G_C_jieshi3_top)+ game_bmp_h2;
       end;
       if GameSave1.tip2= 0 then
      begin
      g_danci_weizhi.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
      g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_04(t: integer);
begin
  //从下到上
   if GameSave1.tip1= 0 then
      begin
  g_danci_weizhi.weizi.top:= 480- round(t / game_amt_length *(480 - G_C_danci_top))- weizhi_get_nn(t);
  g_danci_weizhi.weizi.Bottom:= 480- round(t / game_amt_length *(480 - G_C_danci_top))+ game_bmp_h1- weizhi_get_nn(t);
      

  g_jieshi_weizhi1.weizi.top:= 480- round(t / game_amt_length *(480 - G_C_jieshi1_top))- weizhi_get_nn(t);
  g_jieshi_weizhi1.weizi.Bottom:= 480- round(t / game_amt_length *(480 - G_C_jieshi1_top))+ game_bmp_h2- weizhi_get_nn(t);

  g_jieshi_weizhi2.weizi.top:= 480- round(t / game_amt_length *(480 - G_C_jieshi2_top))- weizhi_get_nn(t);
  g_jieshi_weizhi2.weizi.Bottom:= 480- round(t / game_amt_length *(480 - G_C_jieshi2_top))+ game_bmp_h2- weizhi_get_nn(t);

  g_jieshi_weizhi3.weizi.top:= 480- round(t / game_amt_length *(480 - G_C_jieshi3_top))- weizhi_get_nn(t);
  g_jieshi_weizhi3.weizi.Bottom:= 480- round(t / game_amt_length *(480 - G_C_jieshi3_top))+ game_bmp_h2- weizhi_get_nn(t);
      end;
      if GameSave1.tip2= 0 then
      begin
     g_danci_weizhi.alpha:= weizhi_get_alpha(t);
     g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
     g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
     g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_05(t: integer);
begin  //从右到左，翻转
     if GameSave1.tip1= 0 then
      begin
    g_danci_weizhi.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    //g_danci_weizhi.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
      
    g_jieshi_weizhi1.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
   // g_jieshi_weizhi1.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;

    g_jieshi_weizhi2.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));

   // g_jieshi_weizhi2.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;

    g_jieshi_weizhi3.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    //g_jieshi_weizhi3.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
      end;
      if GameSave1.tip2= 0 then
      begin
    g_danci_weizhi.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
    g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.go_amt_06(t: integer);
begin  //从位置不变
      if GameSave1.tip2= 0 then
      begin
   // g_danci_weizhi.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    //g_danci_weizhi.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
      g_danci_weizhi.alpha:= weizhi_get_alpha(t);
   // g_jieshi_weizhi1.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
   // g_jieshi_weizhi1.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
       g_jieshi_weizhi1.alpha:= weizhi_get_alpha(t);
  //  g_jieshi_weizhi2.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
       g_jieshi_weizhi2.alpha:= weizhi_get_alpha(t);
   // g_jieshi_weizhi2.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;

   // g_jieshi_weizhi3.weizi.Left:= 640- round(t / game_amt_length *(640 - g_word_show_left));
    //g_jieshi_weizhi3.weizi.Right:= 640- round(t / game_amt_length *(640 - g_word_show_left))+ game_bmp_width;
    g_jieshi_weizhi3.alpha:= weizhi_get_alpha(t);
      end;
end;

procedure TForm_pop.game_victory;  //战斗胜利，加经验，升级，动画
var i,j,k,k2,k3: integer;
    jingyan,jinqian: integer;
    wp: array[0..4,0..1] of integer; //掉落物品
    jyz: array[0..4] of integer; //分配的经验值
    b: boolean;
    t: Tplayer;
    str1: Tstringlist;
begin
    show_text(true,'');
        show_text(false,'');

         if GameSave1.tip5= 0 then
            play_sound(14);

        draw_text_17('战斗胜利',1000,clgreen);
        G_game_delay(1000);
        
   //加经验值
  jingyan:= 0;
  jinqian:= 0;
  b:= false;
  k2:= 0;
  
   for i:= 0 to 4 do
    begin
     wp[i,0]:= 0;
      wp[i,1]:= 0;
      jyz[i]:= 0;
    end;

 for i:= 0 to 4 do
  begin

       jingyan:= jingyan + loc_guai_g[i].jingyan;
       jinqian:= jinqian + loc_guai_g[i].qian;
       if (loc_guai_g[i].wu_diao > 0) and(loc_guai_g[i].wu_diao_shu > 0) then
          begin
           b:= true;
          wp[i,0]:=loc_guai_g[i].wu_diao; //掉落物品名称
          //掉落物品数量，概率
           j:= loc_guai_g[i].wu_diao_gai;
            //掉落物品数量
           wp[i,1]:= loc_guai_g[i].wu_diao_shu;
            if j> 1 then
             begin
              if random(j)<> 1 then
                 wp[i,1]:= 0;
             end;

         end;

  end; //end for

   t:= game_get_role_from_i(0);
   t.plvalues[0]:= t.plvalues[0] + jinqian; //增加金钱
   
   //分配经验
       k3:= get_r_role_all_count_NoDead;  //取得需分配经验值的人数
       if k3> 1 then
        begin  //多人分配
         k2:= jingyan div k3; //取得平均值
         k:= round(k2 * 1.2); //最后战斗人员经验值1.2倍
          k2:= k2 - (k-k2) div (k3-1); //其他人员减少了经验值
        end else k:= jingyan;  //单人分配


     for i:= 0 to 4 do
      begin
      if is_can_jingyan(i) then
       begin
        if i= Fgame_my_cu then
         jyz[i]:= k  //最后战斗人员经验值要高一些
          else
           jyz[i]:= k2;
       end;
      end;

      //创建列表
      //增加经验值

      str1:= Tstringlist.Create;
       str1.Append(format('得到金钱：%d',[jinqian]));
         for i:= 0 to 4 do
         begin
          if jyz[i] > 0 then
           begin
             t:= game_get_role_from_i(i);
             t.plvalues[19]:= t.plvalues[19] + jyz[i];
             str1.Append(t.plname + ' 增加经验值：'+ inttostr(jyz[i]));
           end;
         end;

    if b then
     begin
       //显示掉落的物品
      for i:= 0 to 4 do
       begin
        if wp[i,1]> 0 then
          begin
           write_goods_number(wp[i,0],wp[i,1]); //增加物品数量

             str1.Append(pchar(data2.get_game_goods_type(wp[i,0],goods_name1)) +'：'+inttostr(wp[i,1]));
          end;
       end; //end for
     end;

      //显示文字
       draw_text_17_m(str1,1000,clblack);
       G_game_delay(3000);
       str1.Free;
     //判断升级
      game_up_role;
     
end;

procedure TForm_pop.Button1Click(Sender: TObject);
var t: Tplayer;
begin

if need_wait then
 exit;

       
   //攻 按钮
   {
   1。加亮我方人员
   2。如果有多个敌人，等待玩家选一个敌人
   3。如果是单个敌人，直接攻击
   4。调用攻击过程
   }
      t:= game_get_role_from_i(Fgame_my_cu); //获取当前人物的实例
       if t=nil then
         exit;

     if t.plvalues[ord(g_tili)]= 0 then
      begin
       messagebox(handle,'体力不足。','体力不足',mb_ok);
       exit;
      end else begin
                t.plvalues[ord(g_tili)]:= t.plvalues[ord(g_tili)] - t.plvalues[ord(g_gdtl25)] div 50 -1;
                if t.plvalues[ord(g_tili)] < 0 then
                   t.plvalues[ord(g_tili)]:= 0;
               end;
   f_type_g:= 1;

   listbox1.Visible:= false;
   groupbox3.Visible:= false;
   time_list1.timer_gong:= false;
   g_gong.xianshi:= false;
   //highlight_my(Fgame_my_cu);  //加亮

   if get_guai_count > 1 then
    begin
     F_Attack_type:= 0; //攻击类型为物理攻击
     show_text(true,'请点击一个怪来攻击。');
      game_pic_check_area:= G_g_pic_y; //怪物允许被选中
      Timer_auto_attack.Enabled:= true;
    end else
         My_Attack(Fgame_my_cu,get_guai_only,0);

  f_type_g:= 1;
   
end;

function TForm_pop.get_guai_count: integer;//获取还在的怪的个数
 var i: integer;
begin
result:= 0;

   for i:= 0 to 4 do
     if net_guai_g[i].ming> 0 then
       inc(result);
end;

function TForm_pop.get_guai_only: integer;   //获取仅剩的怪id
  var i: integer;
begin
result:= 0;

   for i:= 0 to 4 do
     if net_guai_g[i].ming> 0 then
       result:= i;
end;

procedure TForm_pop.Button2Click(Sender: TObject);
var t: Tplayer;
begin
 // 防，按钮
 if need_wait then
 exit;
 
   listbox1.Visible:= false;
   groupbox3.Visible:= false;
   time_list1.timer_gong:= false;
   g_gong.xianshi:= false;
    un_highlight_my(Fgame_my_cu);  //恢复加亮

    t:= game_get_role_from_i(Fgame_my_cu);
    t.plvalues[ord(g_linshifang)]:= 2; //防护值临时加倍
   //调用继续战斗过程
  //game_fight_keep;
     game_fight_result_adv; //判断结果
 f_type_g:= 2; 
end;

procedure TForm_pop.Button5Click(Sender: TObject);
begin
   //逃跑 按钮
   if need_wait then
 exit;
 
   un_highlight_my(sid_to_roleId(mtl_game_cmd_dh1.fq_sid));  //恢复加亮

    if can_escape then
     begin
      game_can_close:= true;
      g_gong.xianshi:= false;
      self.Close;
     end else begin
                if Game_cannot_runOff then
                show_text(false,'决一死战，坚决不逃。')
                else
                show_text(false,'逃跑失败。');
                groupbox3.Visible:= false;
                time_list1.timer_gong:= false;
                g_gong.xianshi:= false;
                //game_fight_keep;
                game_fight_result_adv; //判断结果
              end;
 listbox1.Visible:= false;             
 f_type_g:= 5;
end;

function TForm_pop.can_escape: boolean;   //是否允许逃跑
var i: integer;
begin
 if Game_cannot_runOff then
   begin
    //禁止逃跑
    result:= false;
    exit;
   end;

 if form1.game_check_goods_nmb('迷踪蛊',1)=1 then
  begin
   if messagebox(handle,'是否使用一个迷踪蛊来逃跑。','逃跑',mb_yesno or MB_ICONQUESTION)= mryes then
    begin
     form1.game_goods_change_n('迷踪蛊',-1);
     result:= true;
     exit;
    end;
  end;
  if game_get_role_su(Fgame_my_cu) > game_get_guai_su(Fgame_guai_cu) then
     i:= 5
     else
      i:= 30; //如果我方速度比怪大，逃跑概率是5分之一，否则是30分之一

    result:=( Game_base_random(i)= 1);
end;

procedure TForm_pop.Button3Click(Sender: TObject);
var i,j,k: integer;
    t: Tplayer;
begin
if need_wait then
 exit;
       //法术攻击
       
       listbox1.Items.BeginUpdate;
        listbox1.Items.Clear;
        t:= game_get_role_from_i(Fgame_my_cu); //获取当前人物的实例

       listbox1.Items.Append('--恢复类法术--');
       for i:= 0 to 63 do
        begin
         if t.pl_fa_array[i]> 0 then
           begin
             j:= get_L_16(t.pl_fa_array[i]); //得到法术编号
             k:= get_H_8(t.pl_fa_array[i]); //得到法术等级
            if Data2.get_game_goods_type(j,goods_j1)= 0 then
               listbox1.Items.Append(Data2.get_game_fa(j)+' 等级'+ inttostr(k));
           end;
        end;
      listbox1.Items.Append('--攻击类法术--');
       for i:= 0 to 63 do
        begin
         if t.pl_fa_array[i]> 0 then
          begin
           j:= get_L_16(t.pl_fa_array[i]); //得到法术编号
             k:= get_H_8(t.pl_fa_array[i]); //得到法术等级
            if Data2.get_game_goods_type(j,goods_j1)= 1 then
               listbox1.Items.Append(Data2.get_game_fa(j)+' 等级'+ inttostr(k));
          end;
        end;
      listbox1.Items.EndUpdate;

  g_gong.time:= 0;
  time_list1.timer_gong:= false;
  g_gong.xianshi:= false;
  
  groupbox3.Visible:= true;
  listbox1.Visible:= true;
  listbox1.SetFocus;
 f_type_g:= 3;
end;

procedure TForm_pop.Button4Click(Sender: TObject);
var i,j: integer;
    str1,str2: Tstringlist;

begin
if need_wait then
 exit;
 f_type_g:= 4;
       //物品
       listbox1.Items.BeginUpdate;
       listbox1.Items.Clear;

       str1:= Tstringlist.Create;
       str2:= Tstringlist.Create;
       listbox1.Items.Append('--食品药品--');
       for i:= 1 to 1023 do
        begin
         if read_goods_number(i)> 0 then
          begin
           j:= Data2.get_game_goods_type(i,goods_type1); //取得物品类型
            if j and 2= 2 then
               listbox1.Items.Append(game_add_shuliang_string(Data2.get_game_goods_type_a(i),read_goods_number(i)))
               else if j and 256= 256 then
                     str1.Append(game_add_shuliang_string(Data2.get_game_goods_type_a(i),read_goods_number(i)))
                     else if j and 4= 4 then
                       str2.Append(game_add_shuliang_string(Data2.get_game_goods_type_a(i),read_goods_number(i)));
          end;
        end;
       if str1.Count > 0 then
       begin
       listbox1.Items.Append('--增强类--');
        for i:= 0 to str1.Count- 1 do
           listbox1.Items.Append(str1.Strings[i]);

       end;
       
       if str2.Count > 0 then
       begin
       listbox1.Items.Append('--投掷攻击类--');
        for i:= 0 to str2.Count- 1 do
           listbox1.Items.Append(StringReplace(str2.Strings[i],'+','-',[rfReplaceAll]));

       end;
       str1.Free;
       str2.Free;
       
     listbox1.Items.EndUpdate;

     g_gong.time:= 0;
  time_list1.timer_gong:= false;
  g_gong.xianshi:= false;

  groupbox3.Visible:= true;
  listbox1.Visible:= true;
  listbox1.SetFocus;
end;

procedure TForm_pop.ListBox1KeyPress(Sender: TObject; var Key: Char);
begin
  listbox1_click1;
end;

procedure TForm_pop.listbox1_click1;
var ss: string;
    id,j: integer;
begin
 if (listbox1.ItemIndex= -1) or need_wait then
    exit;

  ss:= listbox1.Items.Strings[listbox1.ItemIndex];
  if (ss= '') or (ss[1]= '-') then
   begin
    if listbox1.Items.Count<= 2 then
     if f_type_g = 4 then
      messagebox(handle,'您没有可用的物品（药材），物品可以在野外捡到或者在城镇的店铺内买到。','加油',mb_ok or MB_ICONWARNING)
     else
     messagebox(handle,'您没有学会法术，法术秘籍可以在迷宫找到或者在一些特定人物处获得。','继续冒险',mb_ok or MB_ICONWARNING);
   exit;   //分割线，退出
   end;
   //灵力不够时退出，首先获得法术名称，然后取id，然后取灵力，然后和当前人物比对剩余灵力
    if not lingli_is_ok(ss) then
     begin
      messagebox(handle,'灵力不够，不能使用此法术。','灵力不够',mb_ok or MB_ICONWARNING);
       exit;
     end;
  groupbox3.Visible:= false;
  g_gong.xianshi:= false;
  id:= Form_goods.get_goods_id(ss); //获取物品id

   F_Attack_type:= id; //保存当前物品或者法术的id

  ss:= Data2.get_goods_all_s(id);  //取得了物品字符串的内容

   j:= strtoint2(data2.get_game_goods_type_s(ss,goods_type1)); //取得类型


   if j and 2=2 then
     procedure_2(ss)
     else if j and 4=4 then
          procedure_4(ss)
          else if j and 128= 128 then
           procedure_128(ss)
            else if j and 256 = 256 then
                procedure_256(ss);

end;

procedure TForm_pop.procedure_128(const s: string); //法术类处理
var i: integer;
begin
  // 获取法术类型，区分全体，单体，攻击类型，恢复类型
  i:= strtoint2(data2.get_game_goods_type_s(s,goods_j1));
  if i= 0 then
   begin
    //恢复术
    F_is_Attack:= false;
    i:= strtoint2(data2.get_game_goods_type_s(s,goods_y1));
    if i= 1 then
     begin
        //单体恢复
      procedure_2(s);
     end else begin
                //全体恢复
                My_comeback(Fgame_my_cu,-1,F_Attack_type);
              end;
   end else begin
             //攻击术
             F_is_Attack:= true;
              i:= strtoint2(data2.get_game_goods_type_s(s,goods_y1));
              if i= 1 then
                 begin
                  //单体攻击
                  procedure_4(s);
                 end else begin
                            //全体攻击
                           //我方攻击，参数为攻击者，怪物id和攻击方式，0为普通攻击，其他值为法术或者物体
                            My_Attack(Fgame_my_cu,-1,F_Attack_type);
                          end;
            end;
end;

procedure TForm_pop.procedure_2(const s: string);  //食品药品类处理
begin
  //食品药品，都是针对单个人的
  //首先判断我方有几人，包括已死亡角色
  F_is_Attack:= false;
  if get_r_role_all_count > 1 then
   begin
    game_pic_check_area:= G_my_pic_y; //我方允许被选中
    show_text(false,'请点击一个我方人物');
   end else begin
              //我方恢复
              My_comeback(Fgame_my_cu,Fgame_my_cu,F_Attack_type);
            end;
end;

procedure TForm_pop.procedure_256(const s: string);  //增强消耗类处理
begin
   procedure_2(s);
end;

procedure TForm_pop.procedure_4(const s: string);   //投掷攻击类处理
begin
  //投掷类都是针对个人的
 // get_guai_count: integer; //获取怪物个数
  //get_guai_only: integer; //获取仅剩的怪编号
  if pos('迷踪蛊',s)=1 then
    begin
      close;
      exit;
    end;
  F_is_Attack:= true;
  if get_guai_count > 1 then
   begin
    game_pic_check_area:= G_g_pic_y; //怪允许被选中
    Timer_auto_attack.Enabled:= true; //一秒钟后自动攻击
    show_text(false,'请点击一个要攻击的怪');
   end else begin
             My_Attack(Fgame_my_cu,get_guai_only,F_Attack_type);
            end;
end;

function TForm_pop.get_r_role_all_count: integer;  //取得我方全部上场人物数量，包括已死角色
var j: integer;
begin
result:= 0;
      for j:= 0 to Game_role_list.Count-1 do
    begin
      if game_read_values(j,4)= 1 then
        inc(result);  //跳过不被允许上场的人，只有等于1的，才计数
    end;

  if result> 5 then
   result:= 5;

end;

procedure TForm_pop.My_comeback(m, p, d: integer);//恢复术

begin
   //参数为恢复发起者，恢复接受者，恢复类型
   //判断是物品恢复还是法术恢复，扣除物品数量，扣除法术消耗的灵力
   //p等于-1，表示全体恢复

   {恢复术的计算过程
   恢复术的动画过程}

             //设置法术和物品恢复的动画参数

      huifu_js(m, p, d);   //计算恢复值

       huifu_donghua;  //恢复时动画

 {  un_highlight_my(-1);            这些内容已经移动到定时器内
   draw_game_role(-1); //重画全部
   game_pic_check_area:= G_all_pic_n; //全局禁止选中
   show_text(false,'');


   game_fight_result_adv; //判断结果       }
end;

procedure TForm_pop.game_my_Attack_blood; //我方攻击后扣除怪血点
     procedure blood2(t: integer); //内嵌过程，我方编号，攻击力
      begin
           if net_guai_g[t].ming<= 0 then
             exit;  //死亡或不存在的怪退出

             net_guai_g[t].ming:= net_guai_g[t].ming + mtl_game_cmd_dh1.js_m;
             net_guai_g[t].ti:= net_guai_g[t].ti + mtl_game_cmd_dh1.js_t;
             net_guai_g[t].ling:= net_guai_g[t].ling + mtl_game_cmd_dh1.js_l;

             //伤害值，飘动，飘动方向，false向下，飘动的值，人物id，类型（1血，二体力，三灵力）
               game_show_blood(false,mtl_game_cmd_dh1.js_m,t,1);
                 // 发出声音 **************************************
                   if net_guai_g[t].ming<= 0 then
                begin
                net_guai_g[t].ming:= 0;
                net_guai_g[t].shu:= 0;
                if gamesave1.tip5= 0 then
                  play_sound(9); //怪死亡声音
                end else begin
                          if (game_guai_fanghu_xishu_f<= 10) and (mtl_game_cmd_dh1.js_m < 0) then
                            begin
                            if gamesave1.tip6= 0 then
                               play_sound(7);

                            end;
                         end;
                 //声音结束 *****************************************
               if mtl_game_cmd_dh1.js_t <> 0 then
               begin
              G_game_delay(500);
              game_show_blood(false,mtl_game_cmd_dh1.js_t,t,2);
               end;
              if mtl_game_cmd_dh1.js_l <> 0 then
              begin
              G_game_delay(500);
              game_show_blood(false,mtl_game_cmd_dh1.js_l,t,3);
              end;
                  if net_guai_g[t].ti< 0 then
                     net_guai_g[t].ti:= 0;
                  if net_guai_g[t].ling< 0 then
                     net_guai_g[t].ling:= 0;
              if not game_at_net_g then //不是联网时，可以扣除怪物的功防速
               begin
                 net_guai_g[t].gong:= net_guai_g[t].gong+ mtl_game_cmd_dh1.js_g;
                 net_guai_g[t].fang:= net_guai_g[t].fang+ mtl_game_cmd_dh1.js_f;
                 net_guai_g[t].shu:= net_guai_g[t].shu+ mtl_game_cmd_dh1.js_shu;
                  if net_guai_g[t].gong< 0 then
                     net_guai_g[t].gong:= 0;
                  if net_guai_g[t].fang< 0 then
                     net_guai_g[t].fang:= 0;
                  if net_guai_g[t].shu< 0 then
                     net_guai_g[t].shu:= 0;
               end;
              

      end;
var i, t2: integer;
begin
  t2:= sid_to_roleId(mtl_game_cmd_dh1.js_sid);
   if t2 >= 5 then
      t2:= t2 -5;

  if t2= -1 then
   begin
    for i:= 0 to 4 do
        blood2(i);

   end else blood2(t2);
    //t1，我方编号，t2,怪编号-1，表示全体，t3攻击力（攻击指数和攻击力运算后结果

end;

function TForm_pop.game_get_my_Attack_value(z1: integer): Tmtl_rec;  //取得我方攻击力 参数为攻击类型
var
    i: integer;
    j,w: integer; //等级
    k: Tmtl_rec;
    b: boolean;
begin
result.m.int:= 0;
 result.t.int:= 0;
 result.l.int:= 0;
 i:= 0;
  b:= false;
              {mtl高端为攻防速，低端为命体灵，都是差值}
 // t:= game_get_role_from_i(Fgame_my_cu);

 //获得我方的命体灵
      mtl_game_cmd_dh1.fq_m:= game_read_values(get_pid_from_showId(Fgame_my_cu),ord(g_life));
      mtl_game_cmd_dh1.fq_t:= game_read_values(get_pid_from_showId(Fgame_my_cu),ord(g_tili));
      mtl_game_cmd_dh1.fq_l:= game_read_values(get_pid_from_showId(Fgame_my_cu),ord(g_lingli));

   if z1= 0 then
    begin

       result.m.Lo:= game_read_values(get_pid_from_showId(Fgame_my_cu),3);

    end else begin
                b:= true;
               i:= data2.get_game_goods_type(z1,goods_type1); //取得类型
               if i and 128= 128 then
                begin
                  j:= game_fashu__filter(z1); //返回等级，并处理物品编号
                 //扣除灵力，取得灵力新值
                   i:= data2.get_game_goods_type(z1,goods_L1);
                   if i > mtl_game_cmd_dh1.fq_l then
                      mtl_game_cmd_dh1.fq_l:= 0
                      else
                        mtl_game_cmd_dh1.fq_l:= mtl_game_cmd_dh1.fq_l- i;


                 //法术，直接得到扣血值
                 result.m.Lo:= data2.get_game_goods_type(z1,goods_m1) * (j-1 + 10) div 10;  //命
                 result.t.Lo:= data2.get_game_goods_type(z1,goods_t1) * (j-1 + 10) div 10;   //体
                 result.m.Hi:= data2.get_game_goods_type(z1,goods_g1) * (j-1 + 10) div 10;   //攻
                 result.t.Hi:= data2.get_game_goods_type(z1,goods_z1) * (j-1 + 10) div 10;   //防
                 result.l.Hi:= data2.get_game_goods_type(z1,goods_s1) * (j-1 + 10) div 10;   //速
                end else if (i and 4= 4) or (i and 2= 2) or (i and 256= 256) then
                          begin

                            //扣除物品数量
                            write_goods_number(z1,-1);
                            w:= game_read_values(get_pid_from_showId(Fgame_my_cu),ord(g_speed))+1; //得到速，防止除零

                            w:=  round((net_guai_g[Fgame_guai_cu].fang
                                /w+1) * 10); //怪物的防

                             if Random(w)> 10 then
                                begin
                                   //计算出了 系数，现在对方防护起作用，投掷失败
                                  mtl_game_cmd_dh1.flag:= 8; //攻击被躲避
                                  exit;
                                end;

                            //攻击类物品，除返回直接攻击值外，还要定时
                             {减命}
                           result.m.Lo:= data2.get_game_goods_type(z1,goods_m1);

                              {减攻，定时器内有效}
                            // result.m.Hi:= data2.get_game_goods_type(z1,goods_g1);
                              {减防 定时器内有效}
                             // result.t.Hi:=  data2.get_game_goods_type(z1,goods_f1);

                              {减速，定时器内有效}
                             //  result.l.Hi:= data2.get_game_goods_type(z1,goods_s1);
                               {减体}
                           result.t.Lo:= data2.get_game_goods_type(z1,goods_t1);
                               {减灵}
                            result.l.Lo:=  data2.get_game_goods_type(z1,goods_l1);

                           if data2.get_game_goods_type(z1,goods_n1)<>0 then
                              begin
                                //安插定时器
                                game_add_to_goods_time_list(z1);
                              end;

                          end;
             end;
    
     //攻击，处理为负数
   if (z1= 0) or (i and 4= 4) or (data2.get_game_goods_type(z1,goods_j1)=1) then
     begin
   result.m.Lo:= result.m.Lo * -1;
   result.t.Lo:= result.t.Lo * -1;
   result.l.Lo:= result.l.Lo * -1;
   result.m.Hi:= result.m.Hi * -1;
   result.t.Hi:= result.t.Hi * -1;
   result.l.Hi:= result.l.Hi * -1;
     end;
        //透过物品定时过滤器，看看是否有偏移值，
    //第一个参数，人物，0-4我方，5-9敌方，第二个参数，1=运，2=速。3=攻，4防
    if not b then   //法术，物品攻击不受影响
    begin
    k:= game_return_filter(Fgame_my_cu,3);
   result.m.Lo:= result.m.Lo + k.m.Lo;
   result.t.Lo:= result.t.Lo + k.t.Lo;
   result.l.Lo:= result.l.Lo + k.l.Lo;
   result.m.Hi:= result.m.Hi + k.m.hi;
   result.t.Hi:= result.t.Hi + k.t.hi;
   result.l.Hi:= result.l.Hi + k.l.hi;
    end;

end;

procedure TForm_pop.game_fight_result_adv; //判断结果
begin
   case game_fight_result of
    0: begin
         //继续战斗
         game_can_close:= false;
        game_fight_keep;
       end;
    1: begin
        //我方阵亡，如果不是打擂，游戏结束
        if GameSave1.tip5= 0 then
            play_sound(15);

        game_can_close:= true;
        show_text(true,'');
        show_text(false,'');

        draw_text_17('战斗失败',1000,clred);
        G_game_delay(2000);
        G_show_result_b:= false;
        self.ModalResult:= mrcancel;
          game_blood_add_one; //战斗结束后，死亡角色血点恢复为一

        if game_at_net_g then
         form1.game_goto_home(0)
        else
        if game_pop_type= 3 then
           form1.game_over(0);  //战斗失败，游戏结束

       end;
    2: begin
         //战斗胜利，加经验值
         game_can_close:= true;
         game_victory;
          game_blood_add_one; //战斗结束后，死亡角色血点恢复为一
          //在战斗状态如果最后一只怪是跑掉的，窗体返回false值
          if game_guai_escape and (game_pop_type= 3) then
           self.ModalResult:= mrcancel
          else
           self.ModalResult:= mrok;
       end;
    end;
end;

procedure TForm_pop.draw_text_17(const s: string; flag: integer; c: Tcolor; f_size: integer=32);
var aafont: TAAFontEx;
    bmp : TBitmap;
    w,h: integer;
begin

  if s= '' then
   begin
   G_show_result_b:= false;
    exit;
   end;

    bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
           bmp.Width:=g_result_w1;
           bmp.Height:=g_result_h1;
         {
          flag
          1000 无效果
          1001  轮廓
          1002  噪音
          1003  模糊
          1004  渐变
          1005  半透明
          1006  纹理（未用）

         }

      AAFont := TAAFontEx.Create(bmp.Canvas);

      aafont.Effect.LoadFromIni(game_effect_ini,'AT'+ inttostr(flag));
      aafont.Effect.Shadow.Color:= clblack;
      aafont.Effect.Gradual.StartColor:=c;
      aafont.Effect.Gradual.EndColor:= not c;
      try
        with bmp.Canvas do
        begin
          Font.Name := '宋体'; // 设置字体
          Font.Size := f_size;
          Font.Color := c;
          Brush.Style := bsClear; // 设置透明绘制
        end;
        W := AAFont.TextWidth(S);
        H := AAFont.TextHeight(S);
        with bmp do // 在控件中心输出文本
          AAFont.TextOut((Width - W) div 2, (Height - H) div 2, S);
        //AAFont.Canvas := Image1.Canvas; // 也可以切换到另一画布
        //AAFont.TextOut(10, 10, S); // 绘制时将使用Image1.Canvas的字体属性
      finally
        AAFont.Free;
      end;

         with image_result1 do
         begin
         LoadFromBitmap(bmp,false,$FFFFFFFF,0);
         end;
      bmp.Free;
      //画出特效文字

   G_show_result_b:= true;
   g_dangqian_zhuangtai:= G_animation; //游戏处于动画状态
end;

procedure TForm_pop.game_Animation_base1(up: boolean);

begin
    //普通攻击动画 ，由近到远
  // game_amt_length= 60; //动画帧
   //game_amt_delay


       G_PuTongGongji.time:= game_amt_length;
       G_Guai_PuTongGongji.time:= game_amt_length;


      g_game_delay(g_C_DonghuaQianWenZi); //延迟
     G_show_result_b:= false;

     if up then
       time_list1.timer_wo_gongji:= true
       else
         time_list1.timer_guai_gongji:= true;



end;

procedure TForm_pop.game_Animation_base2(up: boolean);

begin
  //法术攻击动画，由蓝到淡

       g_DanTiFaShuGongJi.time:= game_amt_length;
       G_QuanTiFaShuGongji.time:= game_amt_length;
       G_Guai_Fashu.time:= game_amt_length;


      g_game_delay(g_C_DonghuaQianWenZi); //延迟
     G_show_result_b:= false;

     if up then
       time_list1.timer_wo_fashugongji:= true
       else
         time_list1.timer_guai_fashugongji:= true;

    


end;

procedure TForm_pop.game_Animation_base3(up: boolean);

begin
    //使用物品攻击动画

             G_dantiWuPinGongji.time:= game_amt_length;


          g_game_delay(g_C_DonghuaQianWenZi); //延迟
     G_show_result_b:= false;

         time_list1.Timer_wupin_gongji:= true;
end;

procedure TForm_pop.game_Animation_base4(up: boolean);

begin
    // 物品恢复动画，逐渐透明
            G_DanTiWuPinHuiFu.time:= game_amt_length;



                  g_game_delay(g_C_DonghuaQianWenZi); //延迟
     G_show_result_b:= false;

         time_list1.Timer_wupin_huifu:= true;
end;

procedure TForm_pop.game_Animation_base5(up: boolean);

begin
   //法术恢复动画，由红变淡
       G_DanTiFaShuHuiFu.time:= game_amt_length;
       G_Quantifashuhuifu.time:= game_amt_length;


                  g_game_delay(g_C_DonghuaQianWenZi); //延迟
     G_show_result_b:= false;

         time_list1.Timer_fashu_huifu:= true;
end;

procedure TForm_pop.game_show_blood(up: boolean; value, id,
  type1: integer);
  var c: Cardinal;
begin
      {显示血值，显示位置（上下），值，人物编号，类型（血，体力，灵力}
 c:= 0;
   case type1 of
    1: if value > 0 then
       c:= $FF008800
        else
         c:= $FF;
    2: if value > 0 then
        c:= $FFFF0000
         else
          c:= $FFFFFFFF;
    3: if value > 0 then
        c:= $FF000080
         else
          c:= $FF000000;
    end;

    if id<0 then
       id:= 0;

    if up then
     begin
      text_show_array_G[id].top1:= g_C_role_top;
     end else begin
                  text_show_array_G[id].top1:= g_C_guai_top+ 40;

              end;

     text_show_array_G[id].peise:= c;
      text_show_array_G[id].left1:= g_get_roleAndGuai_left(id);
      text_show_array_G[id].xiaoguo:= fxAdd;
   if value > 0 then
      text_show_array_G[id].zhi:= '+'+ inttostr(value)
       else
         text_show_array_G[id].zhi:= inttostr(value);

   text_show_array_G[id].xianshi:= true;

    if up then //向上或者向下飘
     blood_show_list[id]:= 10
      else
       blood_show_list[id]:= -10;

       //启动定时器
       
       if not timer2.Enabled then
         timer2.Enabled:= true;
end;

procedure TForm_pop.Timer2Timer(Sender: TObject);
var i: integer;
    b: boolean;
begin
   //血值飘动定时器
   //检测每个id的飘动值，不为零的都飘动其位置
   //全部为零，则停止定时器
b:= false;
   for i:= 0 to 4 do
    begin
      if blood_show_list[i]<> 0 then
       begin
        //查找实例
        b:= true;
         if blood_show_list[i] > 0 then
           begin
            text_show_array_G[i].top1:= text_show_array_G[i].top1 -3; //我方上飘
            dec(blood_show_list[i]);
           end else begin
             text_show_array_G[i].top1:= text_show_array_G[i].top1 +3;  //敌方下飘
             inc(blood_show_list[i]);
                    end;
        if blood_show_list[i]= 0 then
          begin
          text_show_array_G[i].xianshi:= false;
           b:= false;
          end;
       end;
    end; //end for

  timer2.Enabled:= b;
end;

procedure TForm_pop.game_add_to_goods_time_list(id: integer);  //添加一个物品到定时作用列表
var ss: string;
begin         
   //参数为物品id
  // F_time_role_id: integer; //用于添加到定时器内的，被作用人物编号
  //0-4，我方人物，5-9，敌方人物

  ss:= data2.get_goods_all_s(id);
   if ss= '' then
    exit;


    //将物品的第一个参数（名称）改为被作用者编号，并添加一个计时到首位置，满10发挥作用

    delete(ss,1,pos(',',ss));
    ss:= '0,'+ inttostr(F_time_role_id)+','+ss;

    if not Assigned(goods_time_list) then
       goods_time_list:= Tstringlist.Create;

       //添加到定时物品列表
     goods_time_list.Append(ss);

     //启动定时器
     if timer3.Enabled= false then
      timer3.Enabled:= true;

end;

procedure TForm_pop.Timer3Timer(Sender: TObject);
var i,j,tm,k,m,p: integer;
    ss: string;
     procedure ppp2(add: boolean);
      var t: Tplayer;
          i2,i3: integer;
      begin
       if add then
        i3:= 1
         else
          i3:= -1;
        if p< 5 then
         begin
          //取得我方实例，增减值
          t:= game_get_role_from_i(p);
          if t<> nil then
           begin

              //血值
              i2:= strtoint2(data2.get_game_goods_type_s(ss,goods_m1));
              i2:= game_get_xtl_values(p,i2,3)* i3;
              game_show_blood(true,i2,p,1); //飘动增减的值

              t.plvalues[ord(g_life)]:= t.plvalues[ord(g_life)] + i2;
                if t.plvalues[ord(g_life)] > t.plvalues[ord(g_gdsmz27)] then
                   t.plvalues[ord(g_life)]:= t.plvalues[ord(g_gdsmz27)]
                    else if t.plvalues[ord(g_life)] < 0 then
                            t.plvalues[ord(g_life)]:= 0;
               G_game_delay(500); //飘动时间
              //体
               i2:= strtoint2(data2.get_game_goods_type_s(ss,goods_t1));
               i2:= game_get_xtl_values(p,i2,1)* i3;
                game_show_blood(true,i2,p,2);   //飘动增减的值

              t.plvalues[ord(g_tili)]:= t.plvalues[ord(g_tili)] + i2;
                if t.plvalues[ord(g_tili)] > t.plvalues[ord(g_gdtl25)] then
                   t.plvalues[ord(g_tili)]:= t.plvalues[ord(g_gdtl25)]
                    else if t.plvalues[ord(g_tili)] < 0 then
                            t.plvalues[ord(g_tili)]:= 0;
                G_game_delay(500); //飘动时间
              //灵
              i2:= strtoint2(data2.get_game_goods_type_s(ss,goods_l1));
              i2:= game_get_xtl_values(p,i2,2) * i3;
              t.plvalues[ord(g_lingli)]:= t.plvalues[ord(g_lingli)] + i2;
               game_show_blood(true,i2,p,3); //飘动增减的值
                if t.plvalues[ord(g_lingli)] > t.plvalues[ord(g_gdll26)] then
                   t.plvalues[ord(g_lingli)]:= t.plvalues[ord(g_gdll26)]
                    else if t.plvalues[ord(g_lingli)] < 0 then
                            t.plvalues[ord(g_lingli)]:= 0;
            draw_game_role_base(p); //重画
           end;
         end else begin
                    //取得敌方实例，增减值
                    dec(p,5); //设为合适的敌方id值
                    if net_guai_g[p].ming<= 0 then
                       exit;
                       
                    i2:=strtoint2(data2.get_game_goods_type_s(ss,goods_m1)) ;
                    i2:= game_get_xtl_values_guai(p,i2,3)* i3;
                    game_show_blood(false,i2,p,1); //飘动增减的值,怪，向下飘

              net_guai_g[p].ming:= net_guai_g[p].ming + i2;

               if net_guai_g[p].ming < 0 then
                            net_guai_g[p].ming:= 0;

                   draw_game_guai_base(p); //重画怪
                  end;
      end;
begin

  for i:= goods_time_list.Count- 1 downto 0 do
   begin
     ss:= goods_time_list.Strings[i];
     if ss<> '' then
      begin
       if ss[1]= '9' then
        begin
         //发挥作用,检查是攻击的还是恢复的，攻击的减，恢复的加
         
          delete(ss,1,2); //删除句首的定时作用标记

           p:= strtoint2(copy(ss,1,pos(',',ss)-1)); //取得人物id
               //0-4，我方人物，5-9，敌方人物

           if data2.get_game_goods_type_s(ss,goods_type1)= '256' then
            begin
             //增加
              ppp2(true);
            end else begin
                      //减少
                       ppp2(false);
                     end;
         
         //取得时间，秒数，1表示10秒
         tm:= strtoint2(data2.get_game_goods_type_s(ss,goods_n1));
         dec(tm);
         if tm= 0 then //如果为零，删除此物品从定时器列表
          begin
              goods_time_list.Delete(i);
          end else begin
                   //回写
                    m:= 0; //取得时间之前的内容位置
                    for k:= 1 to 10 do
                       m:= fastcharpos(ss,',',m+1);

                   ss:= '0,'+ copy(ss,1,m)+ inttostr(tm)+ ',0'; //价格为零了
                   goods_time_list.Strings[i]:= ss;
                 end;

        end else begin
                   //累计，到9时表示可以发挥作用，每秒增加一次
                   j:= strtoint2(ss[1]);
                   inc(j);
                   delete(ss,1,2);
                   ss:= inttostr(j)+ ',' + ss;

                    goods_time_list.Strings[i]:= ss;
                 end;
      end; //end if
   end; //end for

  if goods_time_list.Count= 0 then
     timer3.Enabled:= false;
end;

function TForm_pop.game_get_xtl_values(p, v, t: integer): integer;
  var t2: Tplayer;
begin
   //根据v值来决定返回我方人物全值，半值，原值
   //参数是：人物id，值，类型（体，灵，血）
    t2:= game_get_role_from_i(p);
          if t2<> nil then
           begin
            if (v= game_m_quan) or (v= game_m_quan_qi) then
              result:= t2.plvalues[t+ 24]
               else if (v= game_m_ban) or (v= game_m_ban_qi) then
                   result:= t2.plvalues[t+ 24] div 2
                    else result:= v;

           end else result:= 0;

end;

function TForm_pop.game_get_xtl_values_guai(p, v, t: integer): integer;
begin
                       //根据v值来决定返回怪物全值，半值，原值
                       //怪物的类型（最后一个参数）恒为1，只取命值
  if p > 4 then
    dec(p,5);
    if (v= game_m_quan) or (v= game_m_quan_qi) then
              result:= net_guai_g[p].ming_gu
               else if (v= game_m_ban) or (v= game_m_ban_qi) then
                   result:= net_guai_g[p].ming_gu div 2
                    else result:= v;
end;

function TForm_pop.game_return_filter(p: integer; type1: integer): Tmtl_rec;
        function get_t_y: integer; //根据id取得原始值
          var t: Tplayer;
         begin
          get_t_y:= 0;
           //p值：0-4，我方人物，5-9，敌方人物
           if p < 5 then
            begin
             t:= game_get_role_from_i(p);
              if t<> nil then
               begin
                 case type1 of
                 1: get_t_y:= t.plvalues[1];
                 2: get_t_y:= t.plvalues[2];
                 3: get_t_y:= t.plvalues[3];
                 4: get_t_y:= t.plvalues[20];
                 5: get_t_y:= t.plvalues[27]; //固定命
                 6: get_t_y:= t.plvalues[25]; //体
                 7: get_t_y:= t.plvalues[26];  //灵
                 end;
               end;
              //我方人物
            end else begin
                       p:= p-5;
                       case type1 of
                       1: get_t_y:= 0;
                       2: get_t_y:= net_guai_g[p].shu;
                       3: get_t_y:= net_guai_g[p].gong;
                       4: get_t_y:= net_guai_g[p].fang;
                       5: get_t_y:= net_guai_g[p].ming_gu;  //命
                       6: get_t_y:= net_guai_g[p].ti_gu;  //体
                       7: get_t_y:= net_guai_g[p].ling_gu;  //灵
                       end;
                     end;
         end;
        function get_t(const s: string): integer;
          var i2: integer;
         begin
          i2:= 0;
           case type1 of
            1:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_y1)); //取得运值
            2:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_s1)); //取得速
            3:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_g1)); //取得攻
            4:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_f1)); //取得防护
            5:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_m1)); //命
            6:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_t1)); // 体
            7:  i2:= strtoint2(data2.get_game_goods_type_s(s,goods_l1)); // 灵

           end;
              //根据是否全满，半满等类型返回合适的值
           if (i2= game_m_quan) or (i2 = game_m_quan_qi) then
                   get_t:= get_t_y
                    else if (i2= game_m_ban) or (i2 = game_m_ban_qi) then
                       get_t:= get_t_y div 2
                        else get_t:= i2;

         end;
var i,j,k: integer;
    ss: string;
begin
     result.m.int:= 0;
     result.t.int:= 0;
     result.l.int:= 0;
             {此函数每次根据type参数，返回一个相应的值
             现改造为一次返回全部的数
             1234，运速攻防
             567，命体灵}

 if not Assigned(goods_time_list) then
    exit;


                //返回 运，速，攻，防，定时过滤器的值
                //p值：0-4，我方人物，5-9，敌方人物
   for i:= 0 to goods_time_list.Count -1 do
      begin
       if i >= goods_time_list.Count then
           exit;
           
       ss:= goods_time_list.strings[i];
       if ss='' then exit;

       if inttostr(p)= data2.get_game_goods_type_s(ss,goods_type1) then
        begin
          delete(ss,1,2); //去除句首的定时标记
          for k := 2 to 7  do
           begin
             type1:= k;
             j:= get_t(ss);
           //有多个定时记录时，取最大的
            case k of
             2: begin
                 if j> abs(result.l.Hi) then  //速
                   begin
                   result.l.Hi:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.l.Hi:= result.l.Hi* -1;
                   end;
             end;
             3: begin
                 if j> abs(result.m.Hi) then  //攻
                   begin
                   result.m.Hi:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.m.Hi:= result.m.Hi* -1;
                   end;
             end;
             4: begin
                 if j> abs(result.t.Hi) then  //防
                   begin
                   result.t.Hi:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.t.Hi:= result.t.Hi* -1;
                   end;
             end;
             5: begin
                 if j> abs(result.m.Lo) then  //命
                   begin
                   result.m.Lo:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.m.Lo:= result.m.Lo* -1;
                   end;
             end;
             6: begin
                 if j> abs(result.t.Lo) then  //体
                   begin
                   result.t.Lo:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.t.Lo:= result.t.Lo* -1;
                   end;
             end;
             7: begin
                 if j> abs(result.l.Lo) then  //灵
                   begin
                   result.l.Lo:= j;
                   if data2.get_game_goods_type_s(ss,goods_type1)<> '256' then
                      result.l.Lo:= result.L.Lo* -1;
                   end;
             end;
            end; //end case

           end;
        end;

      end; //end for

end;

function TForm_pop.get_r_role_all_count_NoDead: integer;  //取得我方全部上场人物数量，不包括已经死亡的
var j: integer;
begin
result:= 0;
      for j:= 0 to Game_role_list.Count-1 do
    begin
      if (game_read_values(j,4)= 1) and
         (game_read_values(j,ord(g_life))> 0) then
           inc(result);  //跳过不被允许上场的人，和已死亡的人物
    end;

  if result> 5 then
   result:= 5;
   
  if result= 0 then
    result:= 1; //免得除零错误
end;

function TForm_pop.is_can_jingyan(p: integer): boolean; //是否可接受经验值，参数是上场人物编号

var t: Tplayer;
begin
result:= false;
     t:= game_get_role_from_i(p);
     if t<> nil then
      begin
        if t.plvalues[ord(g_life)]> 0 then
         result:= true;
      end;


end;

procedure TForm_pop.draw_text_17_m(st1: Tstringlist; flag: integer;
  c: Tcolor);
var aafont: TAAFontEx;
    bmp : TBitmap;
    i: integer; 
begin
   if st1.Count= 0 then
   begin
   G_show_result_b:= false;
    exit;
   end;

    bmp:=TBitmap.Create;
      bmp.PixelFormat:=pf24bit;
           bmp.Width:=g_result_w1;
           bmp.Height:=g_result_h1;
         {
          flag
          1000 无效果
          1001  轮廓
          1002  噪音
          1003  模糊
          1004  渐变
          1005  半透明
          1006  纹理（未用）

         }

      AAFont := TAAFontEx.Create(bmp.Canvas);

      aafont.Effect.LoadFromIni(game_effect_ini,'AT'+ inttostr(flag));
      aafont.Effect.Shadow.Color:= clblack;
      aafont.Effect.Gradual.StartColor:=c;
      aafont.Effect.Gradual.EndColor:= not c;

      try
        with bmp.Canvas do
        begin
          Font.Name := '宋体'; // 设置字体
          Font.Size := 10;
          Font.Color := c;
          Brush.Style := bsClear; // 设置透明绘制
        end;
      //  W := AAFont.TextWidth(S);
      //  H := AAFont.TextHeight(S);
        for i:= 0 to st1.Count- 1 do
          AAFont.TextOut(16, I * 15+ 8, st1.Strings[i]);

        //AAFont.Canvas := Image1.Canvas; // 也可以切换到另一画布
        //AAFont.TextOut(10, 10, S); // 绘制时将使用Image1.Canvas的字体属性
      finally
        AAFont.Free;
      end;



         with image_result1 do
         begin
         LoadFromBitmap(bmp,false,0,0);
         end;

      bmp.Free;
      //画出特效文字

   G_show_result_b:= true;
   g_dangqian_zhuangtai:= G_animation; //游戏处于动画状态
      //画出特效文字


end;

function TForm_pop.game_upgrade(p: integer): integer;
var t: Tplayer;
    r: integer;
begin
      //游戏人物升级，返回值为新的级数，为零表示没有升

   {
   人物最高200级别
   体力 2000，每级升 10点
   灵力 10000，每级升 50点
   生命 5000， 每级升 25点
   经验值，第一次500点升一级，以后经验值乘以等级
   速，智，防，每级加一点

  }
   result:= 0;
     t:= game_get_role_from_i(p);
     if t<> nil then
      begin
        if t.plvalues[19]>= t.plvalues[ord(g_upgrade)] then
         begin
           //减去升级耗用的经验值
           t.plvalues[19]:= t.plvalues[19]- t.plvalues[ord(g_upgrade)];

           //增加级别和相应的属性
           t.plvalues[ord(g_grade)]:= t.plvalues[ord(g_grade)] + 1; //提高等级

             r:= Game_base_random(5) + 8; //获得一个随机数,作为零头奖励
              //体力 2000，每级升 10点，第一集有50点
           t.plvalues[ord(g_gdtl25)]:= t.plvalues[ord(g_gdtl25)] + 9 + Game_base_random(5);  //固定体力
           t.plvalues[ord(g_tili)]:= t.plvalues[ord(g_gdtl25)]; //体力
             if t.plvalues[ord(g_grade)] * 12 > t.plvalues[ord(g_gdtl25)] then
               t.plvalues[ord(g_gdtl25)]:= t.plvalues[ord(g_grade)] * 14 + 60; //修正个别人物等级高数值过低的bug

           //灵力 10000，每级升 50点
            t.plvalues[ord(g_gdll26)]:= t.plvalues[ord(g_gdll26)]+ 40 + Game_base_random(15); //固定灵力
           t.plvalues[ord(g_lingli)]:= t.plvalues[ord(g_gdll26)]; //灵力
             if t.plvalues[ord(g_grade)] * 44 > t.plvalues[ord(g_gdll26)] then
               t.plvalues[ord(g_gdll26)]:= t.plvalues[ord(g_grade)] * 45 + 100; //修正个别人物等级高数值过低的bug

           //生命 5000， 每级升 25点
            t.plvalues[ord(g_gdsmz27)]:= t.plvalues[ord(g_gdsmz27)] + 20 + Game_base_random(8); //固定生命
           t.plvalues[ord(g_life)]:= t.plvalues[ord(g_gdsmz27)];  //生命值
              if t.plvalues[ord(g_grade)] * 23 > t.plvalues[ord(g_gdsmz27)] then
                t.plvalues[ord(g_gdsmz27)]:= t.plvalues[ord(g_grade)] * 25 + 130; //修正个别人物等级高数值过低的bug

           t.plvalues[ord(g_upgrade)]:= t.plvalues[ord(g_grade)] * 500 * r div 10; //下次升级需要的经验值

            t.plvalues[2]:= t.plvalues[2]+ 1;  //速
             t.plvalues[3]:= t.plvalues[3]+ 5; //攻
              t.plvalues[7]:= t.plvalues[7]+ 1;   //智
              t.plvalues[20]:= t.plvalues[20]+ 2; //防

          result:= t.plvalues[ord(g_grade)];
         end;

        if t.plvalues[19]>= t.plvalues[ord(g_upgrade)] then
           result:= game_upgrade(p); //递归调用

      end;

end;

procedure TForm_pop.game_hide_role(n: string);
var i: integer;
begin
            //两个人被单词时，临时隐藏其他人，参数为需要显示的人
    for i:= 1 to Game_role_list.Count-1 do
    begin
      if Tplayer(Game_role_list.Items[i]).pl_old_name = n then
         begin
           //保存原先上场值到临时
           game_write_values(i,29,
            game_read_values(i,4));
            //需要显示的人物，原先不管是否上场，现允许
            game_write_values(i,4,1);
         end else begin
                   //保存原先上场值到临时
                   game_write_values(i,29,
                      game_read_values(i,4));
                    //上场值改为零
                   game_write_values(i,4,0);
                  end;
    end;
end;

procedure TForm_pop.game_unhide_role;
var i: integer;
begin
        //取消临时隐藏

        for i:= 1 to Game_role_list.Count-1 do
    begin
       game_write_values(i,4,
            game_read_values(i,29));
    end;
end;

procedure TForm_pop.FormClose(Sender: TObject; var Action: TCloseAction);
begin

    text_show_array_G[5].xianshi:= false;
    edit1.Visible:= false;
    Timer_daojishi.Enabled:= false;
 
     if g_particle_rec.xian then
      begin
       g_particle_rec.xian:= false;  //停止天气效果
       AsphyreParticles1.Clear;
      end;
      //退出时清理掉物品定时器内的物品

     timer3.Enabled:= false;

     if Assigned(goods_time_list) then
       goods_time_list.Clear;

   //双人背单词，泡泡龙，结束后恢复隐藏的人物
 if (game_pop_type= 5) or (game_pop_type= 6) then
    game_unhide_role;

 Timer4.Enabled:= false; //速度统计定时器停止
  Timer_donghua.Enabled:= false;

  edit1.text:= '';
  AsphyreTimer1.Enabled:= false;
  if game_pop_type= 7 then
    begin
     if Assigned(wuziqi_tread) then
        begin
        wuziqi_tread.Terminate; //五子棋引擎停止
        //wuziqi_tread.WaitFor;
        end;
     {if wuziqi_rec1.cpt_win then
        self.ModalResult:= mrcancel
        else
         self.ModalResult:= mrok;  }
    end;
end;

function TForm_pop.game_fashu__filter(var i: integer): integer;
var j: integer; //等级
    k: integer; //使用次数
    t: Tplayer;
    i2: integer;
begin
        //法术的等级过滤，返回值为等级，无等级的返回10，法术的升级在此过程内
        {
         法术和技能是多个值组合的，不能直接使用，需过滤掉
        }

      t:= game_get_role_from_i(Fgame_my_cu); //取得当前人物的实例


      for i2:= 0 to 63 do   //将法术编号转换为法术组合值
       begin
         if get_L_16(t.pl_fa_array[i2])= i then
          begin
            i:= t.pl_fa_array[i2];
            break;
          end;
       end;
      for i2:= 0 to 23 do   //技能
       begin
         if get_L_16(t.pl_ji_array[i2])= i then
          begin
            i:= t.pl_ji_array[i2];
            break;
          end;
       end;

      if i< 1024 then
       begin
        result:= 10;
        exit;
       end;

      j:= get_H_8(i); //得到法术等级
      k:= get_HL_8(i); //得到使用次数
      
      //检查是否升级
       inc(k);
      if k> 60 then //为了保持和以前的老存档兼容
         k:= 0;


    // t:= game_get_role_from_i(Fgame_my_cu); //取得当前人物的实例


      for i2:= 0 to 63 do   //法术
       begin
         if t.pl_fa_array[i2]= i then
          begin
              case j of
                   1..3: if k= 15 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   4..6: if k= 35 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   7..9: if k= 60 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   end;
                  if j> 10 then
                     j:= 10;
            t.pl_fa_array[i2]:= set_H_8(t.pl_fa_array[i2],j); //写入法术等级，最高10级
            t.pl_fa_array[i2]:= set_HL_8(t.pl_fa_array[i2],k);  //写入使用次数，次高8位
            break;
          end;
       end;

       for i2:= 0 to 23 do   //技能
       begin
         if t.pl_ji_array[i2]= i then
          begin
              case j of
                   1..3: if k= 10 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   4..6: if k= 10 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   7..9: if k= 10 then
                          begin
                           inc(j);
                           k:= 0;
                          end;
                   end;
                  if j> 10 then
                     j:= 10;
            t.pl_ji_array[i2]:= set_H_8(t.pl_ji_array[i2],j); //写入法术等级，最高10级
            t.pl_ji_array[i2]:= set_HL_8(t.pl_ji_array[i2],k);  //写入使用次数，次高8位
            break;
          end;
       end;

    i:= get_L_16(i); //返回低16位值
    result:= j;
end;

procedure TForm_pop.game_wordow_Animate(form: Tform);  //画出出现时的动画窗口
var
  FDesktopCanvas: TCanvas;
  FDesktopHandle: Hwnd;
  FDesktopBitmap: TPicture;
  SRect: TRect;
  aPos1,aPos2,
  N,FLeft,FTop: Integer;
  KLeft,KTop,KRight,KBottom,
  FStep: Double;
begin
  FDesktopHandle := form1.Handle;
  FDesktopBitmap := TPicture.Create;
  FDesktopCanvas := TCanvas.Create;
  FDesktopBitmap.Bitmap.Width := Screen.Width;
  FDesktopBitmap.Bitmap.Height := Screen.Height;

  FLeft := Form.Left;
  FTop  := Form.Top;
  if Form.Position = poScreenCenter then
  begin
    if Form.FormStyle = fsMDIChild then
    begin
      FLeft := (Application.MainForm.ClientWidth - Form.Width) div 2;
      FTop := (Application.MainForm.ClientHeight - Form.Height) div 2;
    end else
    begin
      FLeft := (Screen.Width - Form.Width) div 2;
      FTop := (Screen.Height - Form.Height) div 2;
    end;
    if FLeft < 0 then FLeft := 0;
    if FTop < 0 then FTop := 0;
  end
  else if Form.Position = poDesktopCenter then
  begin
    if Form.FormStyle = fsMDIChild then
    begin
      FLeft := (Application.MainForm.ClientWidth - Form.Width) div 2;
      FTop := (Application.MainForm.ClientHeight - Form.Height) div 2;
    end else
    begin
      FLeft := (Screen.DesktopWidth - Form.Width) div 2;
      FTop := (Screen.DesktopHeight - Form.Height) div 2;
    end;
    if FLeft < 0 then FLeft := 0;
    if FTop < 0 then FTop := 0;
  end;

  FDesktopCanvas.Handle := GetWindowDC(FDesktopHandle);
  SendMessage(FDesktopHandle, WM_PAINT, integer(FDesktopCanvas.Handle), 0);
  SRect := Rect(0, 0, Screen.Width, Screen.Height);
  FDesktopBitmap.Bitmap.Canvas.CopyRect(SRect,FDesktopCanvas,SRect);

  FDesktopCanvas.Brush.Color := clBtnFace;
  FDesktopCanvas.Brush.Style := bsClear;
  if game_pop_type= 1 then
     FDesktopCanvas.Pen.Color := rgb(173,252,127)
     else
       FDesktopCanvas.Pen.Color := rgb(245,128,78);
  FDesktopCanvas.Pen.Width := 2;
  FDesktopCanvas.Pen.Style := psDot;

  N := Form.Width div 32;
  if N<=0 then
    N := 8;

  aPos1 := (Form.Width div 2)+FLeft;
  aPos2 := (Form.Height div 2)+FTop;
  KTop := aPos2;   KLeft := aPos1;
  KRight  := aPos1;  KBottom := aPos2;

  FStep := Form.Height / Form.Width;
  while KLeft>FLeft do
  begin
    KLeft   := KLeft - N;
    KTop    := KTop - FStep*N;
    KRight  := KRight + N;
    KBottom := KBottom + FStep*N;
    if (KLeft<FLeft) or (KTop<FTop+1) then Break;
    Sleep(25);
    FDesktopCanvas.Rectangle(Trunc(KLeft)+2,Trunc(KTop)+2,Trunc(KRight),Trunc(KBottom));
   // BitBlt(FDesktopCanvas.Handle,Trunc(KLeft),Trunc(KTop),
    //  Trunc(KRight-KLeft),Trunc(KBottom-KTop),
    //  FDesktopBitmap.Bitmap.Canvas.Handle,Trunc(KLeft),Trunc(KTop),SRCCOPY);

  end;
  {BitBlt(FDesktopCanvas.Handle,FLeft,FTop,Width,Height,
      FDesktopBitmap.Canvas.Handle,FLeft,FTop,SRCCOPY);}
  ReleaseDC(0, FDesktopCanvas.Handle);
  FDesktopBitmap.Free;
  FDesktopCanvas.Free;


end;

function TForm_pop.lingli_is_ok(const s: string): boolean;
var t: Tplayer;
    L: integer;
begin
  if f_type_g = 4 then
   begin
    result:= true;
    exit; //对于物品，不判断此值
   end;
       //比对当前人物的灵力是否够发挥法术
  t:= game_get_role_from_i(Fgame_my_cu); //取得当前人物的实例
  L:= Form_goods.get_goods_id(s); //取得物品id
   Assert(L > 0,'当前的物品id无效');
   L:= data2.get_game_goods_type(L,goods_L1); //法术类都消耗灵力

     result:= (L <= t.plvalues[ord(g_lingli)]);
end;

procedure TForm_pop.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
    ListBox1.Canvas.FillRect(Rect);
   {case index mod 5 of
   0: begin
       imagelist1.Draw(ListBox1.Canvas,rect.left+1,rect.top,5);

       if get_jb= 1 then
        imagelist1.Draw(ListBox1.Canvas,140,rect.top,13);
      end;
   1: begin
       imagelist1.Draw(ListBox1.Canvas,rect.left+1,rect.top,11);
      end;
   2: begin
       imagelist1.Draw(ListBox1.Canvas,rect.left+1,rect.top,10);
      end;
   3: begin
       imagelist1.Draw(ListBox1.Canvas,rect.left+1,rect.top,12);
      end;
   4: begin
       imagelist1.Draw(ListBox1.Canvas,rect.left+1,rect.top,4);
      end;
   end;  }
     Assert(Index<>-1,'索引低端越位');
     Assert(Index<ListBox1.Items.count,'索引高端越位');
     if fastcharpos(ListBox1.Items[Index],'-',1)= 1 then
        ListBox1.Canvas.Font.Style:= [fsbold]
        else  begin
              ListBox1.Canvas.Font.Style:= [];
              data2.ImageList_sml.Draw(ListBox1.Canvas,rect.left+2,rect.top+3,
                        Game_goods_Index_G[form_goods.get_goods_id(ListBox1.Items[Index])]);
               if odSelected in State then
                ListBox1.Canvas.Font.Color:= clwindow
                else
                  if lingli_is_ok(ListBox1.Items[Index]) then
                      ListBox1.Canvas.Font.Color:= clwindowtext
                     else
                       ListBox1.Canvas.Font.Color:= clred;
              end;

  ListBox1.Canvas.TextOut(Rect.Left+20, Rect.Top+3, ListBox1.Items[Index]);

end;

procedure TForm_pop.CheckBox8MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if CheckBox8.Checked= false then
   begin
     if game_read_values(0,ord(g_30_yanchi)) = 0 then
       if form1.game_check_goods_nmb('时间加速丸',1)=1 then
         begin
          if messagebox(handle,'您需要使用一个时间加速丸来换取20次立即显示功能，是否使用？','询问',mb_yesno or MB_ICONQUESTION)=mryes then
            begin
             form1.game_goods_change_n('时间加速丸',-1);
              game_write_values(0,ord(g_30_yanchi),20);
            end else begin
                       checkbox8.Checked:= true;
                     end;
         end else begin
                   messagebox(handle,'您需要购买“时间加速丸”才能取消延迟显示。','提示',mb_ok);
                   checkbox8.Checked:= true;
                  end;
   end;
end;

procedure TForm_pop.Timer4Timer(Sender: TObject);
var i: integer;
begin
  //每秒10次累计速度，20倍封顶，这样，使得速度的比较误差减少到5%
   for i:= 0 to 9 do
    begin
     if game_p_list[i] >= speed_limt_G then
       exit; //有一个速度大于指定值，退出速度累加
    end;

    //速度累加
     for i:= 0 to 9 do
      begin
       if i < 5 then
        begin  //我方人员速度累加
         inc(game_p_list[i],game_get_role_su(i));
        end else begin //敌方人员速度累加
                  inc(game_p_list[i],game_get_guai_su(i -5)); //参数减去5
                 end;
      end;

     write_label2_11;
end;

procedure TForm_pop.tili_add_100;
var
    i: integer;
begin
 //在背单词时会增加体力，如果体力小于固定体力，则每次增加百分之一
  for i:= 0 to Game_role_list.Count-1 do
    begin
      if game_read_values(i,ord(g_tili)) <
          game_read_values(i,ord(g_gdtl25)) then
          begin
            game_write_values(i,ord(g_tili),
             game_read_values(i,ord(g_tili)) +
              game_read_values(i,ord(g_gdtl25)) div 100 + 1);

              if  game_read_values(i,ord(g_tili)) >
                  game_read_values(i,ord(g_gdtl25)) then
                  game_write_values(i,ord(g_tili),
                   game_read_values(i,ord(g_gdtl25)));
          end;

    end;
end;

procedure TForm_pop.ListBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 if ssleft in shift then
 begin
  if abs(mouse_down_xy.y- y)> 5 then
   begin
  if not ListBox1.Dragging then
    begin
     g_Dragging:= true;
    ListBox1.BeginDrag(false);
    end;
   end;
  exit;
 end else
      g_Dragging:= false;

   ListBox1.Tag:= ListBox1.ItemAtPos(Point(X,Y),True);

     if ListBox1.Tag <> listbox1.ItemIndex then
        begin
        listbox1.ItemIndex:= ListBox1.Tag;
        if listbox1.ItemIndex > -1 then
         if listbox1.Canvas.TextWidth(listbox1.Items[listbox1.Itemindex]) > listbox1.ClientWidth then
          begin
          listbox1.Hint:= listbox1.Items[listbox1.Itemindex];
          listbox1.ShowHint:= true;
          end else begin
                    listbox1.Hint:= '';
                    listbox1.ShowHint:= false;
                   end;
        end;
end;

procedure TForm_pop.ListBox1MeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
   height:= 22;
end;


procedure TForm_pop.game_kptts_init;
var Reg: TRegistry;
   ss: string;
begin

game_is_sooth:= false;
     (*
  Reg := TRegistry.Create;
    with Reg do
     begin
    RootKey := HKEY_LOCAL_MACHINE;
    if KeyExists('SOFTWARE\Classes\CLSID\{385B9F5A-B588-4050-B787-B2CB7960F27C}\InProcServer32') then
      begin
       OpenKeyReadOnly('SOFTWARE\Classes\CLSID\{385B9F5A-B588-4050-B787-B2CB7960F27C}\InProcServer32');
        ss:= readstring('');
        if FileExists(ss) then
         begin
       try
        kp_tts:= TKDVoice.Create(application);
        kp_tts.InitSoundEngine;
        game_is_sooth:= true;
       except
        kp_tts:= nil;
        game_is_sooth:= false;
       end;
         end;
      end;
    closekey;
    Free;
    end; *)
end;

function TForm_pop.game_get_opengl_info: string;
begin

  result:= '';

end;

procedure TForm_pop.add_to_errorword_list(id: integer);
var i: integer;
begin
//添加到列表，首先从指针处往后添加，如果没有空位，则从开头到指针处重新添加一下
   for i:= game_error_word_list_G[1] to high(game_error_word_list_G) do
       if game_error_word_list_G[i]= 0 then
        begin
          game_error_word_list_G[i]:= id;
          exit;
        end;

   for i:=2 to game_error_word_list_G[1] do
      if game_error_word_list_G[i]= 0 then
        begin
          game_error_word_list_G[i]:= id;
          exit;
        end;
end;

procedure TForm_pop.clear_errorword_list;
begin
   fillchar(game_error_word_list_G,sizeof(game_error_word_list_G),0);
    if game_rep >= 0 then
       game_error_word_list_G[0]:= game_rep;//表示错误单词重复的间隔
    game_error_word_list_G[1]:= 2; //指针指向临近的一个地址
end;

function TForm_pop.get_Word_id: integer;
begin
//获取错误的单词
//1。首先检查是否有错误单词并到达间隔次数，如果没有则获取随机数

 if game_error_word_list_G[game_error_word_list_G[1]]= 0 then
  begin
    //如果没有出错的单词需重复，那么取随机数，该函数会判断顺序背诵或者艾宾浩斯
     result:= get_Random_EXX;

  end else begin
             if game_error_word_list_G[0] = 0 then //表示隔几个单词再背
               begin
                 //取值
                 result:= game_error_word_list_G[game_error_word_list_G[1]];
                 game_error_word_list_G[game_error_word_list_G[1]]:= 0;
                  if game_rep >= 0 then
                     game_error_word_list_G[0]:= game_rep; //计数器赋初值
                 inc(game_error_word_list_G[1]); //指针加一
                 if game_error_word_list_G[1] > high(game_error_word_list_G) then
                    game_error_word_list_G[1]:= 2; //如果指针到底，那么返回头

                 if result >= wordlist1.Count then
                    result:= get_Random_EXX;
               end else begin
                          //值减去一  取随机数
                          dec(game_error_word_list_G[0]);
                          result:= get_Random_EXX;
                        end;
           end;
  game_dangqian_word_id:= result; //保留单词编号，用于插入错误列表用
end;

procedure TForm_pop.get_word_fen(out f: T_word_QianHouZhui;
  const s: string);
  function qian1: boolean; //搜索前缀
    var i: integer;
    begin
     qian1:= false;
     for i:= game_word_qianzhui.Count- 1 downto 0 do
       begin
         if fastpos(s,game_word_qianzhui.Strings[i],length(s),length(game_word_qianzhui.Strings[i]),1)> 0 then
          begin
           f.qian_start:= 1;
           f.qian_end:= length(game_word_qianzhui.Strings[i]);
           qian1:= true;
           exit;
          end;
       end;
    end;
  function hou1: boolean; //搜索后缀
    var i: integer;
    begin
     hou1:= false;
     for i:= game_word_houzhui.Count- 1 downto 0 do
       begin
         if Pos(game_word_houzhui.Strings[i],s)=
            (length(s)-length(game_word_houzhui.Strings[i])+ 1) then
          begin
           f.hou_start:= fastpos(s,game_word_houzhui.Strings[i],length(s),length(game_word_houzhui.Strings[i]),1);
           f.hou_end:= length(game_word_houzhui.Strings[i]);
           hou1:= true;
           exit;
          end;
       end;
    end;

begin       //取得单词分色
  {0不分色  game_m_color
                             1 前缀优先，二取一
                             2 后缀优先，二取一
                             3 前缀优先，全部
                             4 后缀优先，全部
                             game_word_qianzhui,game_word_houzhui
                             }

  case game_m_color of
    1: begin
         if not qian1 then
            hou1;
       end;
    2: begin
         if not hou1 then
            qian1;
       end;
    3: begin
        qian1;
        hou1;
       end;
    4: begin
        hou1;
        qian1;
       end;
    end;

end;

procedure TForm_pop.AsphyreDevice1Initialize(Sender: TObject;
  var Success: Boolean);
   var   ss: string;
begin

 if game_app_path_G= '' then
    game_app_path_G:= ExtractFilePath(application.ExeName);
 ss:= game_app_path_G;

  // 装入字体
 ASDb1.FileName:= ss + 'fonts.asdb';
 Success:= AsphyreFonts1.LoadFromASDb(ASDb1);
 
 game_beijing_index_i:= 1; //初始化背景编号为1
 // 装入图像
 if (Success) then
    begin
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\particle.bmp',point(16,16),point(16,16),point(32,32),aqMedium,alMask,true,$FF000000,0);
       if not Success then
        showmessage('载入粒子图像失败。'+ SysErrorMessage(getlasterror));

   {  for i:= 1 to 7 do
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\bg'+ inttostr(i)+'.jpg',point(640,480),point(640,480),point(1024,512),aqMedium,alNone,false,0,0);

      if not Success then
        showmessage('载入背景失败。'+ SysErrorMessage(getlasterror));  }
      //攻击类动画++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\jian.jpg',point(64,64),point(64,64),point(256,256),aqMedium,alMask,true,0,0);
       if not Success then
        showmessage('载入jian失败。'+ SysErrorMessage(getlasterror));
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\dao.jpg',point(64,64),point(64,64),point(256,256),aqMedium,almask,true,0,0);
        if not Success then
        showmessage('载入dao失败。'+ SysErrorMessage(getlasterror));
       //我方  法术单体 恢复++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wohuifu_f_d.jpg',point(128,128),point(128,128),point(512,512),aqMedium,almask,true,$FF000000,0);
        if not Success then
        showmessage('载入wohuifu_f_d.bmp失败。'+ SysErrorMessage(getlasterror));
       //我方法术单体攻击++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wofashugong_D.jpg',point(128,128),point(128,128),point(512,512),aqMedium,almask,true,$FF000000,0);
        if not Success then
        showmessage('载入wofashugong_D.bmp失败。'+ SysErrorMessage(getlasterror));
      //我方法术全体攻击++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wogong_q.jpg',point(256,256),point(256,256),point(512,512),aqMedium,almask,true,0,0);
         if not Success then
        showmessage('载入wogong_q.jpg失败。'+ SysErrorMessage(getlasterror));
      //我方物品单体攻击++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wowugong_d.jpg',point(128,128),point(128,128),point(512,512),aqMedium,almask,true,0,0);
        if not Success then
        showmessage('载入wowugong_d.bmp失败。'+ SysErrorMessage(getlasterror));
      //我方 物品恢复++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wupinhuifu_d.jpg',point(128,128),point(128,128),point(512,512),aqMedium,alMask,true,$FF000000,0);
         if not Success then
        showmessage('载入wupinhuifu_d.bmp失败。'+ SysErrorMessage(getlasterror));
      //我方法术全体恢复++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\wohuifu_q.jpg',point(256,256),point(256,256),point(512,512),aqMedium,almask,true,0,0);
          if not Success then
        showmessage('载入wohuifu_q.jpg失败。'+ SysErrorMessage(getlasterror));
       //怪法术全体攻击++
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\guaigong_q.jpg',point(256,256),point(256,256),point(512,512),aqMedium,almask,true,0,0);
         if not Success then
        showmessage('载入guaigong_q.jpg失败。'+ SysErrorMessage(getlasterror));
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\gong.bmp',point(225,150),point(225,150),point(256,256),aqMedium,alNone,false,0,0);
         if not Success then
        showmessage('载入gong.bmp失败。'+ SysErrorMessage(getlasterror));
      Success:= AsphyreImages1.AddFromFile(ss+ 'img\gong_xiaoguo.bmp',point(38,36),point(39,36),point(256,64),aqMedium,alNone,false,0,0);
         if not Success then
        showmessage('载入gong_xiaoguo.bmp失败。'+ SysErrorMessage(getlasterror));
    end;
   game_init_Success_G:= Success;
end;

procedure TForm_pop.AsphyreTimer1Timer(Sender: TObject);
begin
// 画
  AsphyreDevice1.Render(0, True);

   AsphyreTimer1.Process(1.0);
  // 上演
  AsphyreDevice1.Flip();
end;

function RGBA(Red, Green, Blue, Alpha: Cardinal): tcolor4;
begin
 Result:=cColor1( Red or (Green shl 8) or (Blue shl 16) or (Alpha shl 24));
end;

procedure TForm_pop.AsphyreDevice1Render(Sender: TObject);

begin
  //渲染+++++++++++++++++++++开始

//背景图
   if game_not_bg_black then
   begin
   AsphyreCanvas1.Draw(image_bg_1_1, 0, 0, 0, fxNone);
   AsphyreCanvas1.Draw(image_bg_1_2, 512, 0, 0, fxNone);
   end;
   
//启动动画

   if game_pop_type= 6 then  //显示泡泡龙
        show_bubble_on_scr;

   if game_pop_type= 7 then  //显示五子棋
      begin
        show_wuziqi_on_src;
        exit;
      end;

   if G_dangqian_zhuangtai =G_word then
     begin
     //单词图
     AsphyreCanvas1.DrawEx(image_word,g_danci_weizhi.weizi,Cardinal( 255 or (255 shl 8)
              or (255 shl 16) or (g_danci_weizhi.alpha shl 24)),0, fxBlend);
     //解释图

     
    if (game_pic_check_area = G_words_Pic_y) and (G_mus_at= mus_jieshi1) then //鼠标在上面时颜色
     begin
      if g_is_word_right then
        AsphyreCanvas1.TexMap(image_cn1,pBounds4(g_jieshi_weizhi1.weizi.Left,
                                               g_jieshi_weizhi1.weizi.Top,
                                               image_cn1.VisibleSize.X,
                                               image_cn1.VisibleSize.Y),
                                               G_right_color,tcNull,fxBlend)
      else
      AsphyreCanvas1.TexMap(image_cn1,pBounds4(g_jieshi_weizhi1.weizi.Left,
                                               g_jieshi_weizhi1.weizi.Top,
                                               image_cn1.VisibleSize.X,
                                               image_cn1.VisibleSize.Y),
                                               G_checked_color,tcNull,fxBlend);
     end else
      AsphyreCanvas1.DrawEx(image_cn1, g_jieshi_weizhi1.weizi,Cardinal( 255 or (255 shl 8) or (255 shl 16) or (g_danci_weizhi.alpha shl 24)), 0, fxBlend);

    if (game_pic_check_area = G_words_Pic_y) and (G_mus_at= mus_jieshi2) then
    begin
      if g_is_word_right then
       AsphyreCanvas1.TexMap(image_cn2,pBounds4(g_jieshi_weizhi2.weizi.Left,
                                               g_jieshi_weizhi2.weizi.Top,
                                               image_cn2.VisibleSize.X,
                                               image_cn2.VisibleSize.Y),
                                               G_right_color,tcNull,fxBlend)
      else
      AsphyreCanvas1.TexMap(image_cn2,pBounds4(g_jieshi_weizhi2.weizi.Left,
                                               g_jieshi_weizhi2.weizi.Top,
                                               image_cn2.VisibleSize.X,
                                               image_cn2.VisibleSize.Y),
                                               G_checked_color,tcNull,fxBlend);
   end else
    AsphyreCanvas1.DrawEx(image_cn2, g_jieshi_weizhi2.weizi,Cardinal( 255 or (255 shl 8) or (255 shl 16) or (g_danci_weizhi.alpha shl 24)), 0, fxBlend);

    if (game_pic_check_area = G_words_Pic_y) and (G_mus_at= mus_jieshi3) then
     begin
      if g_is_word_right then
       AsphyreCanvas1.TexMap(image_cn3,pBounds4(g_jieshi_weizhi3.weizi.Left,
                                               g_jieshi_weizhi3.weizi.Top,
                                               image_cn3.VisibleSize.X,
                                               image_cn3.VisibleSize.Y),
                                               G_right_color,tcNull,fxBlend)
      else
      AsphyreCanvas1.TexMap(image_cn3,pBounds4(g_jieshi_weizhi3.weizi.Left,
                                               g_jieshi_weizhi3.weizi.Top,
                                               image_cn3.VisibleSize.X,
                                               image_cn3.VisibleSize.Y),
                                               G_checked_color,tcNull,fxBlend);
    end else
    AsphyreCanvas1.DrawEx(image_cn3, g_jieshi_weizhi3.weizi,Cardinal( 255 or (255 shl 8) or (255 shl 16) or (g_danci_weizhi.alpha shl 24)), 0, fxBlend);
    end;

//怪方提示
    if g_show_text_up then
    AsphyreCanvas1.Draw(image_up, 192, 125, 0, fxBlend);
//我方提示
   if g_show_text_down then
   AsphyreCanvas1.Draw(image_down, 192, 340, 0, fxBlend);

   if game_pop_type= 6 then
       exit; //泡泡龙时不再显示后面的内容


//我方人物图
    if g_role_show1 then
      begin
       if ((game_pic_check_area = G_my_pic_y) and (G_mus_at= mus_role1)) or g_role_jialiang1 then
        AsphyreCanvas1.TexMap(image_role1,pBounds4(G_C_role_left1,
                                               G_C_role_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_role_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_role1, G_C_role_left1, G_C_role_top, 0, fxNone);
      end;
    if g_role_show2 then
      begin
       if ((game_pic_check_area = G_my_pic_y) and (G_mus_at= mus_role2)) or g_role_jialiang2 then
        AsphyreCanvas1.TexMap(image_role2,pBounds4(G_C_role_left2,
                                               G_C_role_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_role_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_role2, G_C_role_left2, G_C_role_top, 0, fxNone);
      end;
    if g_role_show3 then
     begin
      if ((game_pic_check_area = G_my_pic_y) and (G_mus_at= mus_role3)) or g_role_jialiang3 then
        AsphyreCanvas1.TexMap(image_role3,pBounds4(G_C_role_left3,
                                               G_C_role_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_role_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_role3, G_C_role_left3, G_C_role_top, 0, fxNone);
     end;
    if g_role_show4 then
     begin
      if ((game_pic_check_area = G_my_pic_y) and (G_mus_at= mus_role4)) or g_role_jialiang4 then
        AsphyreCanvas1.TexMap(image_role4,pBounds4(G_C_role_left4,
                                               G_C_role_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_role_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_role4, G_C_role_left4, G_C_role_top, 0, fxNone);
     end;
    if g_role_show5 then
     begin
      if ((game_pic_check_area = G_my_pic_y) and (G_mus_at= mus_role5)) or g_role_jialiang5 then
        AsphyreCanvas1.TexMap(image_role5,pBounds4(G_C_role_left5,
                                               G_C_role_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_role_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_role5, G_C_role_left5, G_C_role_top, 0, fxNone);
     end;
//怪物图
   if g_guai_show1 then
     begin
      if ((game_pic_check_area = G_g_pic_y) and (G_mus_at= mus_guai1)) or g_guai_jialiang1 then
        AsphyreCanvas1.TexMap(image_guai1,pBounds4(G_C_role_left1,
                                               G_C_guai_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_guai_color,tcNull,fxBlend)
       else
       AsphyreCanvas1.Draw(image_guai1, G_C_role_left1, G_C_guai_top, 0, fxNone);
     end;
   if g_guai_show2 then
    begin
     if ((game_pic_check_area = G_g_pic_y) and (G_mus_at= mus_guai2))or g_guai_jialiang2 then
        AsphyreCanvas1.TexMap(image_guai2,pBounds4(G_C_role_left2,
                                               G_C_guai_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_guai_color,tcNull,fxBlend)
       else
     AsphyreCanvas1.Draw(image_guai2, G_C_role_left2, G_C_guai_top, 0, fxNone);
    end;
   if g_guai_show3 then
    begin
     if ((game_pic_check_area = G_g_pic_y) and (G_mus_at= mus_guai3))or g_guai_jialiang3 then
        AsphyreCanvas1.TexMap(image_guai3,pBounds4(G_C_role_left3,
                                               G_C_guai_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_guai_color,tcNull,fxBlend)
       else
     AsphyreCanvas1.Draw(image_guai3, G_C_role_left3, G_C_guai_top, 0, fxNone);
    end;
   if g_guai_show4 then
    begin
     if ((game_pic_check_area = G_g_pic_y) and (G_mus_at= mus_guai4))or g_guai_jialiang4 then
        AsphyreCanvas1.TexMap(image_guai4,pBounds4(G_C_role_left4,
                                               G_C_guai_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_guai_color,tcNull,fxBlend)
       else
     AsphyreCanvas1.Draw(image_guai4, G_C_role_left4, G_C_guai_top, 0, fxNone);
    end;
   if g_guai_show5 then
    begin
     if ((game_pic_check_area = G_g_pic_y) and (G_mus_at= mus_guai5))or g_guai_jialiang5 then
        AsphyreCanvas1.TexMap(image_guai5,pBounds4(G_C_role_left5,
                                               G_C_guai_top,
                                               game_bmp_role_width,
                                               game_bmp_role_h),
                                               G_checked_guai_color,tcNull,fxBlend)
       else
     AsphyreCanvas1.Draw(image_guai5, G_C_role_left5, G_C_guai_top, 0, fxNone);
    end;
//攻击动画图
  with g_DanTiFaShuGongJi do //单体法术攻击
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wofashugong_D.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_dantiWuPinGongji do //单体物品攻击
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wowugong_d.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_DanTiFaShuHuiFu do //单体法术--恢复
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wohuifu_f_d.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_DanTiWuPinHuiFu do //单体物品--恢复
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wupinhuifu_d.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_QuanTiFaShuGongji do //全体--法术攻击
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wogong_q.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_Quantifashuhuifu do //全体--法术--恢复
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['wohuifu_q.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_Guai_Fashu do //怪--法术--攻击全体
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['guaigong_q.jpg'],weizhi.Left, weizhi.top, zhen, fxBlendNA);
   end;
   with G_PuTongGongji do //单体-- 普通攻击
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['jian.jpg'],weizhi.Left, weizhi.top, zhen, fxadd);
   end;
   with G_Guai_PuTongGongji do //怪--普通---攻击
   begin
   if xianshi then
      AsphyreCanvas1.Draw(AsphyreImages1.Image['dao.jpg'],weizhi.Left, weizhi.top, zhen, FXadd);
   end;



//胜利失败，结果tu

   if g_show_result_b then
      AsphyreCanvas1.Draw(image_result1, 192,176 , 0, fxblend);

//我方攻击策略窗口
     with g_gong do
      begin
      if xianshi then
       begin
         AsphyreCanvas1.Drawex(AsphyreImages1.Image['gong.bmp'],weizhi.Left, weizhi.top,
         Cardinal( 255 or (255 shl 8) or (255 shl 16) or (g_gong.alpha shl 24)),0, FXblend);

         if g_icon.xianshi then
            AsphyreCanvas1.Drawex(g_icon_image, g_icon.weizhi.left, g_icon.weizhi.top,
             Cardinal( 255 or (255 shl 8) or (255 shl 16) or (g_gong.alpha shl 24)),0, fxBlend);
         if g_gong_xiaoguo.xianshi then //攻术物防逃
            AsphyreCanvas1.Draw(AsphyreImages1.Image['gong_xiaoguo.bmp'],g_gong_xiaoguo.weizhi.Left, g_gong_xiaoguo.weizhi.top, g_gong_xiaoguo.zhen, FXblend);
       end;
      end;

 //值飘动
     with text_show_array_G[0] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
       with text_show_array_G[1] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
       with text_show_array_G[2] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
       with text_show_array_G[3] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
       with text_show_array_G[4] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
       with text_show_array_G[5] do
      begin
      if xianshi then
         AsphyreFonts1[0].TextOut(zhi,left1,top1,$FF808080, peise,xiaoguo);

      end;
   // AsphyreCanvas1.Draw(AsphyreImages1.Image['gunzi.image'], 240, 0, 0, fxBlend);
   if g_particle_rec.xian then
      AsphyreParticles1.Render;
 //渲染结束
end;

procedure TForm_pop.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if not game_musmv_ready then
    exit;
  if game_pop_type= 7 then  //显示五子棋
        exit;

 //G_mus_at:= mus_nil;
 if game_pic_check_area<> G_all_pic_n then
  begin
   //获取鼠标所在的组件
    if game_pic_check_area = G_g_pic_y then   //怪可选
     begin
      if (y> G_C_guai_top) and (y < G_C_guai_top + game_bmp_role_h) then
       begin
       if (x> G_C_role_left1) and (x < G_C_role_left1 + game_bmp_role_width) then
          G_mus_at:= mus_guai1
           else if (x> G_C_role_left2) and (x < G_C_role_left2 + game_bmp_role_width) then
                     G_mus_at:= mus_guai2
                     else if (x> G_C_role_left3) and (x < G_C_role_left3 + game_bmp_role_width) then
                     G_mus_at:= mus_guai3
                     else if (x> G_C_role_left4) and (x < G_C_role_left4 + game_bmp_role_width) then
                     G_mus_at:= mus_guai4
                     else if (x> G_C_role_left5) and (x < G_C_role_left5 + game_bmp_role_width) then
                     G_mus_at:= mus_guai5
                     else G_mus_at:= mus_nil;
       end;
     end;

    if game_pic_check_area = G_my_pic_y then   //我方可选
     begin
      if (y> G_C_role_top) and (y < G_C_role_top + game_bmp_role_h) then
       begin
       if (x> G_C_role_left1) and (x < G_C_role_left1 + game_bmp_role_width)then
          G_mus_at:= mus_role1
          else if (x> G_C_role_left2) and (x < G_C_role_left2 + game_bmp_role_width)then
          G_mus_at:= mus_role2
          else if (x> G_C_role_left3) and (x < G_C_role_left3 + game_bmp_role_width)then
          G_mus_at:= mus_role3
          else if (x> G_C_role_left4) and (x < G_C_role_left4 + game_bmp_role_width)then
          G_mus_at:= mus_role4
          else if (x> G_C_role_left5) and (x < G_C_role_left5 + game_bmp_role_width) then
          G_mus_at:= mus_role5
          else G_mus_at:= mus_nil;
       end;
     end;

    if  game_pic_check_area = G_words_Pic_y then   //单词可选
      begin
        if (x> g_jieshi_weizhi1.weizi.Left) and (x < g_jieshi_weizhi1.weizi.Right)
          and (y> g_jieshi_weizhi1.weizi.Top) and (y < g_jieshi_weizhi1.weizi.Bottom) then
          begin
           if G_mus_at<> mus_jieshi1 then
            begin
             G_mus_at:= mus_jieshi1;
              g_timer_count_5:= 0;
              timer5.Enabled:= true;
            end;
          end else if (x> g_jieshi_weizhi2.weizi.Left) and (x < g_jieshi_weizhi2.weizi.Right)
          and (y> g_jieshi_weizhi2.weizi.Top) and (y < g_jieshi_weizhi2.weizi.Bottom) then
          begin
           if G_mus_at<> mus_jieshi2 then
            begin
              G_mus_at:= mus_jieshi2;
              g_timer_count_5:= 0;
              timer5.Enabled:= true;
            end;
          end else if (x> g_jieshi_weizhi3.weizi.Left) and (x < g_jieshi_weizhi3.weizi.Right)
          and (y> g_jieshi_weizhi3.weizi.Top) and (y < g_jieshi_weizhi3.weizi.Bottom) then
          begin
            if G_mus_at<> mus_jieshi3 then
             begin
              G_mus_at:= mus_jieshi3;
              g_timer_count_5:= 0;
              timer5.Enabled:= true;
             end;
          end else G_mus_at:= mus_nil;
      end;
   end else G_mus_at:= mus_nil;

   //设置hint++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     show_text_hint('');
   if (y> G_C_guai_top) and (y < G_C_guai_top + game_bmp_role_h) then
       begin
       if (x> G_C_role_left1) and (x < G_C_role_left1 + game_bmp_role_width) then
          show_text_hint(g_hint_array_g[5])
           else if (x> G_C_role_left2) and (x < G_C_role_left2 + game_bmp_role_width) then
                     show_text_hint(g_hint_array_g[6])
                     else if (x> G_C_role_left3) and (x < G_C_role_left3 + game_bmp_role_width) then
                     show_text_hint(g_hint_array_g[7])
                     else if (x> G_C_role_left4) and (x < G_C_role_left4 + game_bmp_role_width) then
                     show_text_hint(g_hint_array_g[8])
                     else if (x> G_C_role_left5) and (x < G_C_role_left5 + game_bmp_role_width) then
                     show_text_hint(g_hint_array_g[9]);
       end;

    if (y> G_C_role_top) and (y < G_C_role_top + game_bmp_role_h) then
       begin
       if (x> G_C_role_left1) and (x < G_C_role_left1 + game_bmp_role_width)then
          show_text_hint(g_hint_array_g[0])
          else if (x> G_C_role_left2) and (x < G_C_role_left2 + game_bmp_role_width)then
          show_text_hint(g_hint_array_g[1])
          else if (x> G_C_role_left3) and (x < G_C_role_left3 + game_bmp_role_width)then
          show_text_hint(g_hint_array_g[2])
          else if (x> G_C_role_left4) and (x < G_C_role_left4 + game_bmp_role_width)then
          show_text_hint(g_hint_array_g[3])
          else if (x> G_C_role_left5) and (x < G_C_role_left5 + game_bmp_role_width) then
          show_text_hint(g_hint_array_g[4]);
       end;
   //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    if g_gong.xianshi then
     begin
      if g_gong.time=0 then
      begin
      if (y> 270) and (y < 306) then
      begin
       if (x > 349) and (x< 386)  then
          begin
          g_gong_xiaoguo.weizhi.Left:= 349;
          g_gong_xiaoguo.weizhi.Top:= 270;
          g_gong_xiaoguo.xianshi:= true;
          g_gong_xiaoguo.zhen:= 0;
          show_text_hint('对怪使用武器攻击。快捷键 G');
          end else if (x > 392) and (x< 430) then
          begin
          g_gong_xiaoguo.weizhi.Left:= 392;
          g_gong_xiaoguo.weizhi.Top:= 270;
          g_gong_xiaoguo.xianshi:= true;
          g_gong_xiaoguo.zhen:= 1;
          show_text_hint('处于防护状态，可减轻伤害。快捷键 F');
          end else if (x > 437) and (x< 475) then
          begin
          g_gong_xiaoguo.weizhi.Left:= 436;
          g_gong_xiaoguo.weizhi.Top:= 270;
          g_gong_xiaoguo.xianshi:= true;
          g_gong_xiaoguo.zhen:= 2;
          show_text_hint('选择一个法术，法术能提供更大的攻击效果。快捷键 S');
          end else if (x > 480) and (x< 518) then
          begin
          g_gong_xiaoguo.weizhi.Left:= 481;
          g_gong_xiaoguo.weizhi.Top:= 270;
          g_gong_xiaoguo.xianshi:= true;
          g_gong_xiaoguo.zhen:= 3;
          show_text_hint('使用物品补充生命值，灵力等，或者使用暗器攻击。快捷键 W');
          end else if (x > 521) and (x< 550) then
          begin
          g_gong_xiaoguo.weizhi.Left:= 521;
          g_gong_xiaoguo.weizhi.Top:= 270;
          g_gong_xiaoguo.xianshi:= true;
          g_gong_xiaoguo.zhen:= 4;
          show_text_hint('退出战斗，但逃跑不一定能成功，这和你的速度值有关。快捷键 T');
          end else g_gong_xiaoguo.xianshi:= false;
      end else g_gong_xiaoguo.xianshi:= false;
      end else g_gong_xiaoguo.xianshi:= false;
     end;


end;

function wuziqi_result: integer; //五子棋结果，返回0表示继续，1表示失败，2表示胜利，3表示和棋
var i,j,k,tmp: integer;
    t1,t2: tpoint;
    b: boolean;
    label pp;
begin
  //g_ball_color_me
  result:= 0;
  k:= 0;
  for i:= 0 to 14 do
  begin
   tmp:= 0; //连续棋子的数量
   b:= false;
   for j:= 1 to 14 do
    begin
     if (LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i,j-1]).Bytes[3]) then
        begin
         inc(tmp);
         if not b then
          begin
            b:= true;
            t1.X:= j-1;
            t1.Y:= i;
          end;
         if tmp > k then
           begin
            k:= tmp;
            t2.X:= j;
            t2.Y:= i;
            result:= LongRec(bubble_boll_g_array[i,j]).Bytes[3];
           end;
        end else tmp:= 0;
    end; // for j
    if k >= 4 then
     goto pp;
  end; // for i

  for j:= 0 to 14 do
  begin
   tmp:= 0; //连续棋子的数量
   b:= false;
   for i:= 1 to 14 do
    begin
     if (LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i-1,j]).Bytes[3]) then
        begin
         inc(tmp);
         if not b then
          begin
            b:= true;
            t1.X:= j;
            t1.Y:= i-1;
          end;
         if tmp > k then
           begin
            k:= tmp;
            t2.X:= j;
            t2.Y:= i;
            result:= LongRec(bubble_boll_g_array[i,j]).Bytes[3];
           end;
        end else tmp:= 0;
    end; // for j
    if k >= 4 then
     goto pp;
  end; // for i

  k:= 0;
   //右斜
  for i:= 0 to 10 do
   begin
     for j:= 0 to 10 do
      begin
        if (LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+1,j+1]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+2,j+2]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+3,j+3]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+4,j+4]).Bytes[3]) then
        begin
          t1.X:= j;
          t1.Y:= i;
          t2.X:= j+ 4;
          t2.Y:= i +4;
          k:= 5;
          result:= LongRec(bubble_boll_g_array[i,j]).Bytes[3];
          goto pp;
        end;
      end; // for j
   end;// for i

   //左斜
  for i:= 0 to 10 do
   begin
     for j:= 4 to 14 do
      begin
        if (LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+1,j-1]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+2,j-2]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+3,j-3]).Bytes[3]) and
        (LongRec(bubble_boll_g_array[i,j]).Bytes[3]= LongRec(bubble_boll_g_array[i+4,j-4]).Bytes[3]) then
        begin
          t1.X:= j;
          t1.Y:= i;
          t2.X:= j- 4;
          t2.Y:= i +4;
          k:= 5;
          result:= LongRec(bubble_boll_g_array[i,j]).Bytes[3];
          goto pp;
        end;
      end; // for j
   end;// for i

   pp:
   if k>= 4 then
           begin
            with wuziqi_rec1 do
              begin
              x0:= t1.x * 32 +68;
              y0:= t1.y * 32 +16;
              x1:= t2.x * 32 +68;
              y1:= t2.y * 32 +16;
              xy0:= true;
              end;

             if result= g_ball_color_cpt then
                result:= 1
                else
                 result:= 2; //我方胜利
           end else result:= 0;
end;

procedure wuziqi_shengli;
var i,j: integer;
begin
   form_pop.g_tiankong:=true; //禁止听力显示
   case form_pop.game_pop_count of
   0: begin
        i:= 100;
        j:= 200;
      end;
   1: begin
        i:= 200;
        j:= 400;
      end;
   2: begin
        i:= 400;
        j:= 500;
      end;
   3: begin
        i:= 800;
        j:= 700;
      end;
   4: begin
        i:= 1600;
        j:= 900;
      end;
   else
    i:= 100;
    j:= 100;
   end;
   form1.game_attribute_change(0,19,i); //全体增加经验值
   form1.game_attribute_change(1,0,j); //增加金钱
   form_pop.draw_asw('您获胜！全体加经验'+inttostr(i)+' 加金钱'+inttostr(j),0,0);
   wuziqi_rec1.word_showing:= true;
   form_pop.G_game_delay(3000);
   wuziqi_rec1.cpt_win:= false;
   form_pop.ModalResult:= mrok;
end;

procedure TForm_pop.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 var t: Tpoint;
begin
  if game_pop_type= 7 then  //五子棋
     begin
       if g_dangqian_zhuangtai= g_wuziqi1 then
       begin
       GetCursorPos(T);
       t:= panel1.ScreenToClient(t);
       if (t.X< 52) or (t.X> 531) or (t.Y< 0) or (t.Y>479) then
         exit;
         x:= (t.X-52) div 32;
         y:= t.Y div 32;
       if LongRec(bubble_boll_g_array[y,x]).Bytes[3]= 0 then
         begin
          if (t.Y mod 32 in[8..24]) and ((t.X-52) mod 32 in[8..24]) then
           begin
             g_dangqian_zhuangtai:= g_wuziqi2;
             LongRec(bubble_boll_g_array[y,x]).Bytes[3]:= g_ball_color_me;
             inc(wuziqi_rec1.me_count);
             wuziqi_rec1.me_row:= y;
             wuziqi_rec1.me_col:= X;
             wuziqi_rec1.row:= y;
             wuziqi_rec1.col:= X;
             form1.game_attribute_change(0,19,3); //全体增加经验值3
             show_ad(1); //显示广告，在下十个子之后
             statusbar1.Panels[0].Text:= '全体增加经验值3，电脑思考中……';
             if wuziqi_result=2 then //五子棋结果，返回0表示继续，1表示失败，2表示胜利，3表示和棋
             begin
              wuziqi_shengli; //五子棋获胜
             end
             else begin
                   
                   wuziqi_sendstr('turn '+ inttostr(x)+','+ inttostr(y));
                  end;
           end;
         end;

       end;
        exit;
     end;

  if (not game_musmv_ready) or edit1.Visible then
    exit;

    if g_gong.xianshi then
    begin
     if g_gong_xiaoguo.xianshi then
      begin
      case g_gong_xiaoguo.zhen of
      0: Button1Click(self);
      1: Button2Click(self);
      2: Button3Click(self);
      3: Button4Click(self);
      4: Button5Click(self);
      end;
      end;
    end;

         case game_pic_check_area of
              G_g_pic_y: begin
                          //怪物gl对象可选中时被点击
                          //我方攻击，参数为攻击者，怪物id和攻击方式，0为普通攻击，其他值为法术或者物体
                          if mbRight = Button then
                          begin
                           game_pic_check_area:= G_all_pic_n;
                           //groupbox3.Visible:= true;
                           g_gong.xianshi:= true;
                          end;
                         end;
              G_my_pic_y:begin
                          //我方人员对象图片可选中 时被点击
                          if mbRight = Button then
                          begin
                           game_pic_check_area:= G_all_pic_n;
                           //groupbox3.Visible:= true;
                           g_gong.xianshi:= true;
                          end;
                         end;

              end; //end case

   if game_pic_check_area= G_all_pic_n then
       exit; //退出



               case game_pic_check_area of
                 G_words_Pic_y: begin
                                 case G_mus_at of
                                  mus_jieshi1: check_asw(0,false);
                                  mus_jieshi2: check_asw(1,false);
                                  mus_jieshi3: check_asw(2,false);
                                 end;
                                 if mbRight = Button then //添加单词到错误列表
                                      add_to_errorword_list(game_dangqian_word_id);
                                end;
                 G_g_pic_y: begin
                          //怪物gl对象可选中时被点击
                          //我方攻击，参数为攻击者，怪物id和攻击方式，0为普通攻击，其他值为法术或者物体
                           case G_mus_at of
                            mus_guai1:  My_Attack(Fgame_my_cu,0,F_Attack_type);
                            mus_guai2:  My_Attack(Fgame_my_cu,1,F_Attack_type);
                            mus_guai3:  My_Attack(Fgame_my_cu,2,F_Attack_type);
                            mus_guai4:  My_Attack(Fgame_my_cu,3,F_Attack_type);
                            mus_guai5:  My_Attack(Fgame_my_cu,4,F_Attack_type);
                           end;
                         end;
              G_my_pic_y:begin
                          //我方人员对象图片可选中 时被点击
                          case G_mus_at of
                           mus_role1: My_comeback(Fgame_my_cu,0,F_Attack_type);
                           mus_role2: My_comeback(Fgame_my_cu,1,F_Attack_type);
                           mus_role3: My_comeback(Fgame_my_cu,2,F_Attack_type);
                           mus_role4: My_comeback(Fgame_my_cu,3,F_Attack_type);
                           mus_role5: My_comeback(Fgame_my_cu,4,F_Attack_type);
                          end;
                         end;
              end; //end case


end;

procedure TForm_pop.Timer_donghuaTimer(Sender: TObject);
begin
 {
  if yodao_time> 0 then
    begin
      dec(yodao_time);
      if yodao_time= 10 then
         skp_string(jit_words);
    end; }
  if wuziqi_rec1.word_showing then
   begin
    //五子棋背单词
    if (wuziqi_rec1.word_time<= 0) and (g_dangqian_zhuangtai= g_wuziqi1) then
       wuziqi_rec1.word_showing:= false;

     dec(wuziqi_rec1.word_time);
    exit;
   end;

 if time_list1.Timer_donghua then
 begin
  case g_danci_donghua_id of
   0: go_amt_00(G_danci_donghua_count);
   1: go_amt_01(G_danci_donghua_count);
   2: go_amt_02(G_danci_donghua_count);
   3: go_amt_03(G_danci_donghua_count);
   4: go_amt_04(G_danci_donghua_count);
   5: go_amt_05(G_danci_donghua_count);
   6: go_amt_06(G_danci_donghua_count);
  end;
   G_dangqian_zhuangtai:=G_word; //显示单词画面

   if G_danci_donghua_count = game_amt_length then
   begin
    time_list1.Timer_donghua:= false;
      AsphyreTimer1Timer(self); //重画
    game_musmv_ready:= true;

      if game_bg_music_rc_g.type_word and
      (g_is_tingli_b=false) and (g_tiankong=false) then
      begin
      //显示输入框，并启动倒计时器

       edit1.SetBounds(g_jieshi_weizhi2.weizi.Left + panel1.Left,
                       g_jieshi_weizhi2.weizi.Top + panel1.Top,
                       g_jieshi_weizhi2.weizi.Right- g_jieshi_weizhi2.weizi.Left,
                       g_jieshi_weizhi2.weizi.Bottom - g_jieshi_weizhi2.weizi.Top);

      
        text_show_array_G[5].left1:= g_jieshi_weizhi2.weizi.Right + 9;
        text_show_array_G[5].top1:=  g_jieshi_weizhi2.weizi.Top;
       if timer1.Enabled= false then
        begin
         edit1.Visible:= true;
         create_edit_bmp(game_word_1); //创建底图
         edit1.Repaint;
         edit1.SetFocus;
         Timer_daojishi.Tag:= 600;
         Timer_daojishi.Enabled:= true;
        end;
      end;

     //发出声音
      if checkbox2.Checked then
     begin
     {$IFDEF IBM_SPK}
     jit_spk1.spk:= Jit_words;
      postthreadmessage(jit_spk1.ThreadID,um_ontimer,0,0);
     {$ENDIF}

     {$IFDEF MS_SPK}
       skp_string(Jit_words);
       //  微软speck;
      {$ENDIF}

     end;
   end;
   inc(G_danci_donghua_count);
  end;

  if time_list1.Timer_wo_gongji then
     Timer_wo_gongjiTimer;
  if time_list1.Timer_guai_gongji then
     Timer_guai_gongjiTimer;
  if time_list1.Timer_wo_fashugongji then
     Timer_wo_fashugongjiTimer;
  if time_list1.Timer_guai_fashugongji then
     Timer_guai_fashugongjiTimer;
  if time_list1.Timer_wupin_gongji then
     Timer_wupin_gongjiTimer;
  if time_list1.Timer_wupin_huifu then
     Timer_wupin_huifuTimer;
  if time_list1.Timer_fashu_huifu then
     Timer_fashu_huifuTimer;
  if time_list1.Timer_gong then
     Timer_gongTimer;
  if time_list1.Timer_bubble then
     Timer_bubbleTimer;  //泡泡龙，球动画期间
end;

procedure TForm_pop.g_game_delay(i: integer);
   var t,t2: cardinal;
begin
  t:= GetTickCount;
  t2:= i;
    AsphyreTimer1.Enabled:= false;
    while GetTickCount - t < t2 do
     begin
      AsphyreTimer1Timer(self);
      AsphyreTimer1Process(self);
      application.ProcessMessages;
       sleep(10);
     end;
     AsphyreTimer1.Enabled:= true;
end;

procedure TForm_pop.g_guai_A_next;
begin
 //扣除血点
      // game_guai_Attack_blood(t,g,game_get_Attack_value(z,g2));
        game_guai_Attack_blood;

   un_highlight_my(-1);  //恢复加亮
   un_highlight_guai(-1);
   //重画我方人员
   // draw_game_role(get_pid_from_showId(sid_to_roleId(mtl_game_cmd_dh1.js_sid)));
      draw_game_role(sid_to_roleId(mtl_game_cmd_dh1.js_sid));

    //判断结果
    game_fight_result_adv; //判断结果
end;

procedure TForm_pop.g_wo_A_next;
begin
  //扣除血点
      // game_my_Attack_blood(m,p,game_get_my_Attack_value(d));

      { 由于攻击数值已经算出，所以攻击后的扣血，只需根据预订数组来进行
      }
       game_my_Attack_blood;
   un_highlight_guai(-1);  //恢复加亮
   un_highlight_my(-1);

   //重画我方人员
      draw_game_role(sid_to_roleId(mtl_game_cmd_dh1.fq_sid));

      draw_game_guai(sid_to_roleId(mtl_game_cmd_dh1.js_sid)); //重画怪

    //判断结果
     game_fight_result_adv; //判断结果
end;

procedure TForm_pop.Timer_wo_gongjiTimer;
begin
    //我方攻击动画 定时
       //单体-- 普通攻击 动画 16 帧
        //1。获取攻击者左边坐标，获取被攻击者左边坐标，取得差值
       //2.获取攻击者top和被攻击者top，取得差值

       G_PuTongGongji.zhen:= (game_amt_length- G_PuTongGongji.time) div 4;
       G_PuTongGongji.weizhi.Top:= round(G_C_role_top * (G_PuTongGongji.time / game_amt_length)) + G_C_guai_top;
        if sid_to_roleId(mtl_game_cmd_dh1.fq_sid)= sid_to_roleId(mtl_game_cmd_dh1.js_sid) then  //如果位置相同，直接使用固定坐标
          G_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))
          else begin
                 if sid_to_roleId(mtl_game_cmd_dh1.fq_sid)> sid_to_roleId(mtl_game_cmd_dh1.js_sid) then
                   begin
                    //我方编号大于怪，左边坐标从大向小变化
                    G_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid)) + round(
                    (g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))- g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid))) *
                       (G_PuTongGongji.time / game_amt_length));
                   end else begin  //编号从小向大变化
                            G_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid)) - round(
                    (g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid))- g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))) *
                       (G_PuTongGongji.time / game_amt_length));
                            end;
               end;

      G_PuTongGongji.xianshi:= true;
    if G_PuTongGongji.time= 0 then
       begin
       time_list1.Timer_wo_gongji:= false;
       G_PuTongGongji.xianshi:= false;
       g_wo_A_next;
       end;
     dec(G_PuTongGongji.time);
end;

procedure TForm_pop.Timer_guai_gongjiTimer;
begin
   //怪物攻击动画 定时 16 zhen

       G_Guai_PuTongGongji.zhen:= (game_amt_length- G_Guai_PuTongGongji.time) div 4;

       G_Guai_PuTongGongji.weizhi.Top:= G_C_role_top- round((G_C_role_top- G_C_Guai_top) * (G_Guai_PuTongGongji.time / game_amt_length));

        if sid_to_roleId(mtl_game_cmd_dh1.fq_sid)= sid_to_roleId(mtl_game_cmd_dh1.js_sid) then  //如果位置相同，直接使用固定坐标
          G_Guai_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))
          else begin
                 if sid_to_roleId(mtl_game_cmd_dh1.fq_sid)> sid_to_roleId(mtl_game_cmd_dh1.js_sid) then
                   begin
                    //怪方编号大于我，左边坐标从大向小变化
                    G_Guai_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid)) + round(
                    (g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))- g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid))) *
                       (G_Guai_PuTongGongji.time / game_amt_length));
                   end else begin  //编号从小向大变化
                            G_Guai_PuTongGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid)) - round(
                    (g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid))- g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.fq_sid))) *
                       (G_Guai_PuTongGongji.time / game_amt_length));
                            end;
               end;

      G_Guai_PuTongGongji.xianshi:= true;
   if G_Guai_PuTongGongji.time= 0 then
       begin
       time_list1.Timer_guai_gongji:= false;
       G_Guai_PuTongGongji.xianshi:= false;
       g_guai_A_next;
       end;
     dec(G_Guai_PuTongGongji.time);
end;

procedure TForm_pop.Timer_wo_fashugongjiTimer;
begin
    //我法术攻击 单体、全体 动画定时，Pattern从零开始
          

 if sid_to_roleId(mtl_game_cmd_dh1.js_sid)= -1 then //全体攻击动画 4 帧，用十帧，后面几帧固定不动
  begin
     g_quanTiFaShuGongJi.zhen:= (game_amt_length-g_quanTiFaShuGongJi.time) div 6;
     g_quanTiFaShuGongJi.weizhi.Left:= 160;
     g_quanTiFaShuGongJi.weizhi.top:= 120;
    g_quanTiFaShuGongJi.xianshi:= true;
    if g_quanTiFaShuGongJi.time= 0 then
    begin
    time_list1.Timer_wo_fashugongji:= false;
    g_quanTiFaShuGongJi.xianshi:= false;
    g_wo_A_next;
    end;
      if game_amt_length = g_quanTiFaShuGongJi.time then
    begin
     if gamesave1.tip5= 0 then
        play_sound(4);  //我法术全体攻击的声音
    end;
    dec(g_quanTiFaShuGongJi.time);
  end else begin
               //单体攻击 16 zhen
                g_DanTiFaShuGongJi.zhen:= (game_amt_length- g_DanTiFaShuGongJi.time) div 4;
                g_DanTiFaShuGongJi.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid));  //怪的坐标
                g_DanTiFaShuGongJi.weizhi.top:= G_C_Guai_top;
              g_DanTiFaShuGongJi.xianshi:= true;
             if g_DanTiFaShuGongJi.time= 0 then
                begin
                 time_list1.Timer_wo_fashugongji:= false;
                 g_DanTiFaShuGongJi.xianshi:= false;
                 g_wo_A_next;
                end;
                if game_amt_length = g_DanTiFaShuGongJi.time then
                 begin
                 if gamesave1.tip5= 0 then
                   play_sound(3);  //我法术单体攻击的声音
                 end;
               dec(g_DanTiFaShuGongJi.time);
          end;
end;

procedure TForm_pop.Timer_guai_fashugongjiTimer;
begin
    //怪法术攻击 全体 动画定时 10 帧
                  G_Guai_Fashu.zhen:= (game_amt_length- G_Guai_Fashu.time) div 6;
                  G_Guai_Fashu.weizhi.Left:= 160;
                  G_Guai_Fashu.weizhi.top:= 120;
            G_Guai_Fashu.xianshi:= true;
           if G_Guai_Fashu.time= 0 then
                begin
                 Time_list1.Timer_guai_fashugongji:= false;
                 G_Guai_Fashu.xianshi:= false;
                 g_guai_A_next;
                end;

  if game_amt_length = G_Guai_Fashu.time then
    begin
     if gamesave1.tip5= 0 then
        play_sound(5);  //怪法术攻击的声音
    end;

               dec(G_Guai_Fashu.time);
end;

procedure TForm_pop.Timer_wupin_gongjiTimer;
begin
    //我方物品攻击 动画定时 16 帧

         G_dantiWuPinGongji.zhen:= 15- G_dantiWuPinGongji.time div 4;
         G_dantiWuPinGongji.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid));  //怪
         G_dantiWuPinGongji.weizhi.top:= G_C_Guai_top;

      G_dantiWuPinGongji.xianshi:= true;
    if G_dantiWuPinGongji.time= 0 then
       begin
       time_list1.Timer_wupin_gongji:= false;
       G_dantiWuPinGongji.xianshi:= false;
       g_wo_A_next;
       end;

     if game_amt_length = G_dantiWuPinGongji.time then
    begin
     if gamesave1.tip5= 0 then
        play_sound(2);  //物品攻击后的声音
    end;

     dec(G_dantiWuPinGongji.time);
end;

procedure TForm_pop.Timer_wupin_huifuTimer;
begin
  //我方物品 恢复 动画定时 16 帧
             G_DanTiWuPinHuiFu.zhen:= (game_amt_length- G_DanTiWuPinHuiFu.time) div 4;
             G_DanTiWuPinHuiFu.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid));
             G_DanTiWuPinHuiFu.weizhi.top:= G_C_role_top + game_bmp_role_h -156; //减去图像高
     G_DanTiWuPinHuiFu.xianshi:= true;
   if G_DanTiWuPinHuiFu.time= 0 then
       begin
       time_list1.Timer_wupin_huifu:= false;
       G_DanTiWuPinHuiFu.xianshi:= false;
       G_huifu_next;  //恢复术后续操作
       end;
   if game_amt_length = G_DanTiWuPinHuiFu.time then
    begin
     if gamesave1.tip5= 0 then
        play_sound(0);  //补充物品后的声音
    end;

     dec(G_DanTiWuPinHuiFu.time);
end;

procedure TForm_pop.Timer_fashu_huifuTimer;
begin
    //法术恢复 单体、全体 动画定时

   if sid_to_roleId(mtl_game_cmd_dh1.js_sid)= -1 then //全体法术恢复 10帧
  begin
           G_quanTiFaShuHuiFu.zhen:= (game_amt_length- G_quanTiFaShuHuiFu.time) div 6;
           G_quanTiFaShuHuiFu.weizhi.Left:= 160;
           G_quanTiFaShuHuiFu.weizhi.top:= 120;
    G_quanTiFaShuHuiFu.xianshi:= true;
    if G_quanTiFaShuHuiFu.time<= 0 then
    begin
    time_list1.Timer_fashu_huifu:= false;
    G_quanTiFaShuHuiFu.xianshi:= false;
    G_huifu_next;   //恢复术后续操作
    end;
    if game_amt_length = G_quanTiFaShuHuiFu.time then
    begin
     if gamesave1.tip5= 0 then
        play_sound(8);  //全体法术恢复的声音
    end;
    dec(G_quanTiFaShuHuiFu.time);
  end else begin
               //单体法术恢复 16 帧
                    G_DanTiFaShuHuiFu.zhen:= (game_amt_length- G_DanTiFaShuHuiFu.time) div 4;
                    G_DanTiFaShuHuiFu.weizhi.Left:= g_get_roleAndGuai_left(sid_to_roleId(mtl_game_cmd_dh1.js_sid));
                    G_DanTiFaShuHuiFu.weizhi.top:= G_C_role_top+ game_bmp_role_h -156; //减去图像高;
               G_DanTiFaShuHuiFu.xianshi:= true;
             if G_DanTiFaShuHuiFu.time= 0 then
                begin
                 time_list1.Timer_fashu_huifu:= false;
                 G_DanTiFaShuHuiFu.xianshi:= false;
                 G_huifu_next;
                end;
             if game_amt_length = G_DanTiFaShuHuiFu.time then
                 begin
               if gamesave1.tip5= 0 then
                  play_sound(1);  //单体法术恢复的声音
                 end;
               dec(G_DanTiFaShuHuiFu.time);
          end;
end;


function TForm_pop.g_get_roleAndGuai_left(i: integer): integer;
begin
result:= 0;
    if i> 4 then
       i:= i -5;

    case i of
     0: result:= G_C_role_left1;
     1: result:= G_C_role_left2;
     2: result:= G_C_role_left3;
     3: result:= G_C_role_left4;
     4: result:= G_C_role_left5;
     end;
end;


procedure TForm_pop.G_huifu_next;   //恢复术后续操作
begin
  un_highlight_my(-1);
   draw_game_role(-1); //重画全部
   game_pic_check_area:= G_all_pic_n; //全局禁止选中
   show_text(false,'');


   game_fight_result_adv; //判断结果
end;

procedure TForm_pop.Timer_gongTimer;
var bmp: tbitmap;
    tpl: Tplayer;
begin
    //我方攻击窗口出现的动画
     if GameSave1.tip3=0 then
      begin
    g_gong.weizhi.Left:= g_gong.weizhi.Left- 2;
    g_icon.weizhi.Left:= g_gong.weizhi.Left + 81; //小头像位置
     g_icon.weizhi.top:= g_gong.weizhi.top + 37;
      end else begin
                 g_gong.weizhi.Left:= 340;
                 g_icon.weizhi.Left:= g_gong.weizhi.Left + 81; //小头像位置
                 g_icon.weizhi.top:= g_gong.weizhi.top + 37;
               end;

     if g_gong.time= game_amt_length then
      begin
        bmp:= tbitmap.Create;
        tpl:= game_get_role_from_i(Fgame_my_cu);
        with g_icon_image do
        begin
        data2.ImageList2.GetBitmap(tpl.plvalues[ord(g_Icon_index)]+ 1,bmp);
        LoadFromBitmap(bmp,false,0,0);
        end;
       bmp.Free;
       g_icon.xianshi:= true;
       show_fashuwupin_k(tpl.pl_old_name);
      end;

    dec(g_gong.time);

    if GameSave1.tip4=0 then
       g_gong.alpha:= weizhi_get_alpha(game_amt_length- g_gong.time);

    if g_gong.time= 0 then
     time_list1.Timer_gong:= false;

      g_gong.xianshi:= true;
      g_gong_xiaoguo.xianshi:= false;
  //reshow_su; //如果是“术”，重新显示
end;

procedure TForm_pop.g_miao_shou(g_id,s_id: integer); //从怪物上偷点什么
var b: boolean;
    v: integer;
    k: Tmtl_rec;
    label pp;
begin
    //传入参数为怪物id和法术id
    
    //判断怪类型，如果是会魔法的怪，只偷钱，因为这类怪大多是boss，掉的物品一般是特殊的，不适合多次偷窃
    //其他类型的怪，二分之一的偷钱，二分之一的偷物

   if g_id>= 5 then
     g_id:= g_id -5;

  if net_guai_g[g_id].sid< (g_nil_user_c- 10) then
   begin
     //来自网络的怪，不能偷
    draw_text_17('任务禁止',1000,clblack);
    g_game_delay(500);
    goto pp;
   end;
  
  if loc_guai_g[g_id].fa_wu<= 0 then
    begin
     b:= (Game_base_random(2)= 0);

    end else begin
              b:= true; //偷钱
             end;

    if b then
     v:= loc_guai_g[g_id].qian //钱
      else
       v:= loc_guai_g[g_id].wu_diao; //物

       sleep(10);
       k:= game_get_my_Attack_value(s_id);  //返回的是负数
        {妙手的扣血值为10，升到10级时为20的值，这里返回是负数}
       if Game_base_random(23) <= abs(k.m.Lo) then
        begin
         //偷窃成功
         if Assigned(Game_role_list.Items[0]) then
          begin
           if Tplayer(Game_role_list.Items[0]).plvalues[ord(g_morality)]=0 then
            begin
             draw_text_17('道德值不足',1000,clblue,18);
            end else begin //************************
                     if Game_base_random(5)= 0 then
                       Tplayer(Game_role_list.Items[0]).change_g_morality(-1);
             if b then
             begin
              form1.game_change_money(v);
              draw_text_17('偷到金钱：'+ inttostr(v),1000,clblue,18);
             end else begin
                     if v= 0 then
                    begin
                     draw_text_17('没有物品',1000,clblue,18);
                    end else begin
                             if read_goods_number(v) < $FF then
                                write_goods_number(v,1); //增加物品1
                                draw_text_17('偷到物品：'+ pchar(data2.get_game_goods_type(v,goods_name1)),1000,clblue,18);
                             end;
                   end;

                     end;  //******************

          end;
         
         g_game_delay(600);
        end else begin
                   //偷窃失败
                   draw_text_17('任务失败',1000,clblack);
                  g_game_delay(500);
                 end;
     pp:
   G_show_result_b:= false;  
  un_highlight_guai(-1);  //不加亮
   un_highlight_my(-1);
   draw_game_role(Fgame_my_cu); //重画人员
   game_fight_result_adv; //判断结果
end;

procedure TForm_pop.del_a_word;
begin
 if G_word = g_dangqian_zhuangtai then
  del_word_in_lib
  else messagebox(handle,'当前无显示的单词。','不能删除',mb_ok);
end;

procedure TForm_pop.gong;
begin
  if g_gong.xianshi or groupbox3.Visible then
   begin
    button1click(self);
   end;
end;

procedure TForm_pop.Action1Execute(Sender: TObject);
begin
 gong;
end;

procedure TForm_pop.Action8Execute(Sender: TObject);
begin
  del_a_word;

end;

procedure TForm_pop.Action2Execute(Sender: TObject);
begin
   //防快捷键
  if g_gong.xianshi or groupbox3.Visible then
   begin
    button2click(self);
   end;


end;

procedure TForm_pop.Action3Execute(Sender: TObject); //术快捷键
begin
   if g_gong.xianshi or groupbox3.Visible then
   begin
    g_gong.xianshi:= false;
    button3click(self);
   end;

end;

procedure TForm_pop.Action4Execute(Sender: TObject);//物快捷键
begin
   if g_gong.xianshi or groupbox3.Visible then
   begin
    g_gong.xianshi:= false;
    button4click(self);
   end;
end;

procedure TForm_pop.Action5Execute(Sender: TObject); //逃快捷键
begin
  if g_gong.xianshi or groupbox3.Visible then
   begin
    button5click(self);
   end;
end;

procedure TForm_pop.Action6Execute(Sender: TObject);
begin
 if game_pic_check_area =G_words_Pic_y then
       check_asw(0,false); //答案一快捷键


end;

procedure TForm_pop.Action7Execute(Sender: TObject);
begin
   if game_pic_check_area =G_words_Pic_y then
       check_asw(1,false);
end;

procedure TForm_pop.Action9Execute(Sender: TObject);
begin
   if game_pic_check_area =G_words_Pic_y then
         check_asw(2,false);
end;

procedure TForm_pop.Action10Execute(Sender: TObject);
begin
  leiji_show; //显示累计错误或者正确的信息 快捷键 I
end;

procedure TForm_pop.Action11Execute(Sender: TObject);
begin
   //快捷键 1
   kuaijie_12345(1);
end;

procedure TForm_pop.Action12Execute(Sender: TObject);
begin
  //快捷键 2
  kuaijie_12345(2);
end;

procedure TForm_pop.Action13Execute(Sender: TObject);
begin
  //快捷键 3
  kuaijie_12345(3);
end;

procedure TForm_pop.Action14Execute(Sender: TObject);
begin
 //快捷键 4
 kuaijie_12345(4);
end;

procedure TForm_pop.Action15Execute(Sender: TObject);
begin
   //快捷键 5
   kuaijie_12345(5);
end;

procedure TForm_pop.kuaijie_12345(id: integer);  //快捷键操作
begin
if not game_musmv_ready then
    exit;

   if g_gong.xianshi then
    begin

      case id of
      1: Button1Click(self);
      2: Button2Click(self);
      3: Button3Click(self);
      4: Button4Click(self);
      5: Button5Click(self);
      end;
     exit;
    end;

    if game_pic_check_area= G_all_pic_n then
   exit; //退出

               case game_pic_check_area of
                 G_words_Pic_y: begin
                                 case id of
                                  1: check_asw(0,false);
                                  2: check_asw(1,false);
                                  3: check_asw(2,false);
                                 end;
                                end;
                 G_g_pic_y: begin
                          //怪物gl对象可选中时被点击
                          //我方攻击，参数为攻击者，怪物id和攻击方式，0为普通攻击，其他值为法术或者物体
                           case id of
                            1:  My_Attack(Fgame_my_cu,0,F_Attack_type);
                            2:  My_Attack(Fgame_my_cu,1,F_Attack_type);
                            3:  My_Attack(Fgame_my_cu,2,F_Attack_type);
                            4:  My_Attack(Fgame_my_cu,3,F_Attack_type);
                            5:  My_Attack(Fgame_my_cu,4,F_Attack_type);
                           end;
                         end;
              G_my_pic_y:begin
                          //我方人员对象图片可选中 时被点击
                          case id of
                           1: My_comeback(Fgame_my_cu,0,F_Attack_type);
                           2: My_comeback(Fgame_my_cu,1,F_Attack_type);
                           3: My_comeback(Fgame_my_cu,2,F_Attack_type);
                           4: My_comeback(Fgame_my_cu,3,F_Attack_type);
                           5: My_comeback(Fgame_my_cu,4,F_Attack_type);
                          end;
                         end;
              end; //end case
end;

procedure TForm_pop.AsphyreTimer1Process(Sender: TObject);
begin
    if g_particle_rec.xian then
     begin
      if Random(3)= 0 then
       begin
       with AsphyreParticles1.CreateImage(0, Point2(Random(600), 1), 180, fxBlendNA) do
     begin
      // set random speed
       Patt:= g_particle_rec.xuli;
      Velocity:= Point2((Random(10) - 5) / 20,  (Random(20) / 5));
      // set particle acceleration
       if g_particle_rec.xiaoguo= 0 then //随机飘落
          Accel:= Point2((0.002 + ((Random(10)-3) / 300)), (0.002 + (Random(10) / 300)))
          else if g_particle_rec.xiaoguo= 1 then //固定方向
            Accel:= Point2(0, (0.502 + (Random(10) / 300)));
     end;
      end;
 // move the particles
      AsphyreParticles1.Update();
     end;
end;

procedure draw_grass(b: tbitmap; x, y: integer; angle: double;
  len, minlen: single);
  var x1,y1: integer;
begin
  if len > minlen then
   begin
    x1:= round(cos(angle) * len) + x;
    y1:= round(sin(angle) *len) + y;
    b.Canvas.MoveTo(x,y);
    b.Canvas.LineTo(x1,y1);
    draw_grass(b,(x+x1)div 2,(y1+y)div 2,angle- pi /8,len / 2,minlen);
     if Random(5)= 0 then
      draw_grass(b,x1,y1,angle +pi /6,len / 1.5,minlen)
     else
    draw_grass(b,x1,y1,angle -pi /6,len / 1.5,minlen);
   end;
end;

procedure TForm_pop.draw_random_grass(b: Tbitmap); //随机画草，建议高度 200，建议宽度 400
var i: integer;
begin
   b.Canvas.Pen.Color:= clgreen;
 for i:= 0 to 15 do
  draw_grass(b,(i-2) * (15 + Random(20)),round(b.Height /1.15)+Random(40),-pi/12,100,0.5);

end;
function floattobyte(f: single): byte;
begin
  result:= lo(round(f));
end;
procedure TForm_pop.draw_random_XX(bt: Tbitmap;flag: integer);  //画随机分析图
var x,y,newx,newy,a,b,c,d,e,f,r,y_c1,Y_C2,x_c1,X_C2: single;
   n,i,j: integer;
   m: array[0..6,0..6] of single;
begin
 n:= 100000;
 x:= 0;
 y:= 0;

 x_c1:= 0.5;
      X_C2:= 2;
      y_c1:= 0.25;
      Y_C2:= 1.25;

  //++++++++++++++++++++
    for i:= 0 to 6 do
       for j:= 0 to 6 do
         m[i,j]:= 0;

     if flag= 0 then
        flag:= Random(21)
        else
         flag:= flag -1;

     case flag of
     0: begin
      m[0,0]:= 0.5;
      m[0,1]:= -0.5;
      m[0,2]:= 0.5;
      m[0,3]:= 0.5;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.5;

      m[1,0]:= 0.5;
      m[1,1]:= 0.5;
      m[1,2]:= -0.5;
      m[1,3]:= 0.5;
      m[1,4]:= 0.5;
      m[1,5]:= 0.5;
      m[1,6]:= 0.5;
      x_c1:= 0.55;
      X_C2:= 2.1;  //2
      y_c1:= 0.4;
      Y_C2:= 1.6; //1.25
       end;
      1:begin
      m[0,0]:= 0.25;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.5;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.154;

      m[1,0]:= 0.5;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= 0.5;
      m[1,4]:= -0.25;
      m[1,5]:= 0.5;
      m[1,6]:= 0.307;
      m[2,0]:= -0.25;
      m[2,1]:= 0;
      m[2,2]:= 0;
      m[2,3]:= -0.25;
      m[2,4]:= 0.25;
      m[2,5]:= 1;
      m[2,6]:= 0.078;

      m[3,0]:= 0.5;
      m[3,1]:= 0;
      m[3,2]:= 0;
      m[3,3]:= 0.5;
      m[3,4]:= 0;
      m[3,5]:= 0.75;
      m[3,6]:= 0.307;
      m[4,0]:= 0.5;
      m[4,1]:= 0;
      m[4,2]:= 0;
      m[4,3]:= -0.25;
      m[4,4]:= 0.5;
      m[4,5]:= 1.25;
      m[4,6]:= 0.154;
      x_c1:= 0.5;
      X_C2:= 1.6;  //1.5
      y_c1:= 0;
      Y_C2:= 1.6; //1.25
       end;
      2:begin
      m[0,0]:= 0.787879;
      m[0,1]:= -0.424242;
      m[0,2]:= 0.242424;
      m[0,3]:= 0.859848;
      m[0,4]:= 1.758647;
      m[0,5]:= 1.408065;
      m[0,6]:= 0.9;

      m[1,0]:= -0.121212;
      m[1,1]:= 0.257576;
      m[1,2]:= 0.05303;
      m[1,3]:= 0.05303;
      m[1,4]:= -6.721654;
      m[1,5]:= 1.377236;
      m[1,6]:= 0.05;
      m[2,0]:= 0.181818;
      m[2,1]:= -0.136364;
      m[2,2]:= 0.090909;
      m[2,3]:= 0.181818;
      m[2,4]:= 6.086107;
      m[2,5]:= 1.568035;
      m[2,6]:= 0.05;
      x_c1:= 7;
      X_C2:= 15;  //14.015
      y_c1:= 0;
      Y_C2:= 9.65; //9.56
       end;
      3:begin
      m[0,0]:= 0.255;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.255;
      m[0,4]:= 0.3726;
      m[0,5]:= 0.6714;
      m[0,6]:= 0.2;

      m[1,0]:= 0.255;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= 0.255;
      m[1,4]:= 0.1146;
      m[1,5]:= 0.2232;
      m[1,6]:= 0.2;
      m[2,0]:= 0.255;
      m[2,1]:= 0;
      m[2,2]:= 0;
      m[2,3]:= 0.255;
      m[2,4]:= 0.6306;
      m[2,5]:= 0.2232;
      m[2,6]:= 0.2;
      m[3,0]:= 0.37;
      m[3,1]:= -0.642;
      m[3,2]:= 0.642;
      m[3,3]:= 0.37;
      m[3,4]:= 0.6356;
      m[3,5]:= -0.0061;
      m[3,6]:= 0.4;
      x_c1:= 0;
      X_C2:= 0.9;  //0.846
      y_c1:= 0;
      Y_C2:= 1; //0.9012
       end;
      4:begin
      m[0,0]:= 0.382;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.382;
      m[0,4]:= 0.3072;
      m[0,5]:= 0.619;
      m[0,6]:= 0.2;
      m[1,0]:= 0.382;
      m[1,1]:= 1;
      m[1,2]:= 0;
      m[1,3]:= 0.382;
      m[1,4]:= 0.6033;
      m[1,5]:= 0.4044;
      m[1,6]:= 0.2;
      m[2,0]:= 0.382;
      m[2,1]:= 0;
      m[2,2]:= 0;
      m[2,3]:= 0.382;
      m[2,4]:= 0.0139;
      m[2,5]:= 0.4044;
      m[2,6]:= 0.2;
      m[3,0]:= 0.382;
      m[3,1]:= 0;
      m[3,2]:= 0;
      m[3,3]:= 0.382;
      m[3,4]:= 0.1253;
      m[3,5]:= 0.0595;
      m[3,6]:= 0.2;
      m[4,0]:= 0.382;
      m[4,1]:= 1;
      m[4,2]:= 0;
      m[4,3]:= 0.382;
      m[4,4]:= 0.492;
      m[4,5]:= 0.0595;
      m[4,6]:= 0.2;
      x_c1:= 0;
      X_C2:= 0.95;  //0.942
      y_c1:= 0;
      Y_C2:= 1; //1
       end;
      5:begin
      m[0,0]:= 0.745455;
      m[0,1]:= -0.459091;
      m[0,2]:= 0.406061;
      m[0,3]:= 0.887121;
      m[0,4]:= 1.460279;
      m[0,5]:= 0.691072;
      m[0,6]:= 0.912675;

      m[1,0]:= -0.424242;
      m[1,1]:= -0.065152;
      m[1,2]:= -0.175758;
      m[1,3]:= -0.218182;
      m[1,4]:= 3.809567;
      m[1,5]:= 6.741476;
      m[1,6]:= 0.087325;
      x_c1:= 6.12;
      X_C2:= 12.18;  //14.015
      y_c1:= 0.12;
      Y_C2:= 10.2; //9.56
       end;
      6:begin
      m[0,0]:= 0;
      m[0,1]:= -0.5;
      m[0,2]:= 0.5;
      m[0,3]:= 0;
      m[0,4]:= 0.5;
      m[0,5]:= 0;
      m[0,6]:= 0.333;

      m[1,0]:= 0;
      m[1,1]:= 0.5;
      m[1,2]:= -0.5;
      m[1,3]:= 0;
      m[1,4]:= 0.5;
      m[1,5]:= 0.5;
      m[1,6]:= 0.333;
      m[2,0]:= 0.5;
      m[2,1]:= -3;
      m[2,2]:= 0.2;
      m[2,3]:= 0.5;
      m[2,4]:= 0.25;
      m[2,5]:= 0.5;
      m[2,6]:= 0.8;
      x_c1:= 0;
      X_C2:= 1.5;  //14.015
      y_c1:= 0;
      Y_C2:= 1.5; //9.56
       end;
       7:begin
      m[0,0]:= 0.824074;
      m[0,1]:= 0.281482;
      m[0,2]:= -0.212346;
      m[0,3]:= 0.864198;
      m[0,4]:= -1.882290;
      m[0,5]:= -0.110607;
      m[0,6]:= 0.8;

      m[1,0]:= 0.088272;
      m[1,1]:= 0.520988;
      m[1,2]:= -0.463889;
      m[1,3]:= -0.377778;
      m[1,4]:= 0.785360;
      m[1,5]:= 8.095795;
      m[1,6]:= 0.2;

      x_c1:= 6.2;
      X_C2:= 12.3;  //14.015
      y_c1:= 0.17;
      Y_C2:= 10.3; //9.56
       end;
       8:begin
      m[0,0]:= 0;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.5;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.05;
      m[1,0]:= 0.42;
      m[1,1]:= -0.42;
      m[1,2]:= 0.42;
      m[1,3]:= 0.42;
      m[1,4]:= 0;
      m[1,5]:= 0.2;
      m[1,6]:= 0.4;
      m[2,0]:= 0.42;
      m[2,1]:= 0.42;
      m[2,2]:= -0.42;
      m[2,3]:= 0.42;
      m[2,4]:= 0;
      m[2,5]:= 0.2;
      m[2,6]:= 0.4;
      m[3,0]:= 0.1;
      m[3,1]:= 0;
      m[3,2]:= 0;
      m[3,3]:= 0.4;
      m[3,4]:= 0;
      m[3,5]:= 0.2;
      m[3,6]:= 0.15;

      x_c1:= 0.2388;
      X_C2:= 0.5;  //0.942
      y_c1:= 0;
      Y_C2:= 0.5; //1
       end;
       9:begin
      m[0,0]:= 0;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.5;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.05;
      m[1,0]:= 0.42;
      m[1,1]:= -0.42;
      m[1,2]:= 0.42;
      m[1,3]:= 0.42;
      m[1,4]:= 0;
      m[1,5]:= 0.2;
      m[1,6]:= 0.4;
      m[2,0]:= 0.42;
      m[2,1]:= 0.42;
      m[2,2]:= -0.42;
      m[2,3]:= 0.42;
      m[2,4]:= 0;
      m[2,5]:= 0.2;
      m[2,6]:= 0.4;
      m[3,0]:= 0.1;
      m[3,1]:= 0;
      m[3,2]:= 0;
      m[3,3]:= 0.3;
      m[3,4]:= 0;
      m[3,5]:= 0.6;
      m[3,6]:= 0.15;

      x_c1:= 0.4;
      X_C2:= 0.8;  //0.942
      y_c1:= 0;
      Y_C2:= 0.9; //1
       end;
       10:begin
      m[0,0]:= -0.04;
      m[0,1]:= 0;
      m[0,2]:= -0.19;
      m[0,3]:= -0.47;
      m[0,4]:= -0.12;
      m[0,5]:= 0.3;
      m[0,6]:= 0.25;
      m[1,0]:= 0.65;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= 0.56;
      m[1,4]:= 0.06;
      m[1,5]:= 1.56;
      m[1,6]:= 0.25;
      m[2,0]:= 0.41;
      m[2,1]:= 0.46;
      m[2,2]:= -0.39;
      m[2,3]:= 0.61;
      m[2,4]:= 0.46;
      m[2,5]:= 0.4;
      m[2,6]:= 0.25;
      m[3,0]:= 0.52;
      m[3,1]:= -0.35;
      m[3,2]:= 0.25;
      m[3,3]:= 0.74;
      m[3,4]:= -0.48;
      m[3,5]:= 0.38;
      m[3,6]:= 0.25;

      x_c1:= 2.6;
      X_C2:= 5.1;  //0.942
      y_c1:= 0.4;
      Y_C2:= 4.4; //1
       end;
       11:begin
      m[0,0]:= 0.6;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.6;
      m[0,4]:= 0.18;
      m[0,5]:= 0.36;
      m[0,6]:= 0.25;
      m[1,0]:= 0.6;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= 0.6;
      m[1,4]:= 0.18;
      m[1,5]:= 0.12;
      m[1,6]:= 0.25;
      m[2,0]:= 0.4;
      m[2,1]:= 0.3;
      m[2,2]:= -0.3;
      m[2,3]:= 0.4;
      m[2,4]:= 0.27;
      m[2,5]:= 0.36;
      m[2,6]:= 0.25;
      m[3,0]:= 0.4;
      m[3,1]:= -0.3;
      m[3,2]:= 0.3;
      m[3,3]:= 0.4;
      m[3,4]:= 0.27;
      m[3,5]:= 0.09;
      m[3,6]:= 0.25;

      x_c1:= -0.1;
      X_C2:= 0.75;  //0.942
      y_c1:= 0;
      Y_C2:= 1; //1
       end;
       12:begin
      m[0,0]:= 0;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.25;
      m[0,4]:= 0;
      m[0,5]:= -0.14;
      m[0,6]:= 0.02;
      m[1,0]:= 0.85;
      m[1,1]:= 0.02;
      m[1,2]:= -0.02;
      m[1,3]:= 0.83;
      m[1,4]:= 0;
      m[1,5]:= 1;
      m[1,6]:= 0.84;
      m[2,0]:= 0.09;
      m[2,1]:= -0.28;
      m[2,2]:= 0.3;
      m[2,3]:= 0.11;
      m[2,4]:= 0;
      m[2,5]:= 0.6;
      m[2,6]:= 0.07;
      m[3,0]:= -0.09;
      m[3,1]:= 0.25;
      m[3,2]:= 0.3;
      m[3,3]:= 0.09;
      m[3,4]:= 0;
      m[3,5]:= 0.7;
      m[3,6]:= 0.07;

      x_c1:= 1.6;
      X_C2:= 3;  //0.942
      y_c1:= 0;
      Y_C2:= 5.9; //1
       end;
       13:begin
      m[0,0]:= 0.05;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.6;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.1;
      m[1,0]:= 0.05;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= -0.5;
      m[1,4]:= 0;
      m[1,5]:= 1.0;
      m[1,6]:= 0.1;
      m[2,0]:= 0.46;
      m[2,1]:= 0.32;
      m[2,2]:= -0.386;
      m[2,3]:= 0.383;
      m[2,4]:= 0;
      m[2,5]:= 0.6;
      m[2,6]:= 0.2;
      m[3,0]:= 0.47;
      m[3,1]:= -0.154;
      m[3,2]:= 0.171;
      m[3,3]:= 0.423;
      m[3,4]:= 0;
      m[3,5]:= 1;
      m[3,6]:= 0.2;
      m[4,0]:= 0.43;
      m[4,1]:= 0.275;
      m[4,2]:= -0.26;
      m[4,3]:= 0.476;
      m[4,4]:= 0;
      m[4,5]:= 1;
      m[4,6]:= 0.2;
      m[5,0]:= 0.421;
      m[5,1]:= -0.357;
      m[5,2]:= 0.354;
      m[5,3]:= 0.307;
      m[5,4]:= 0;
      m[5,5]:= 0.7;
      m[5,6]:= 0.2;
      x_c1:= 0.8;
      X_C2:= 1.73;  //0.942
      y_c1:= 0;
      Y_C2:= 1.95; //1
       end;
       14:begin
      m[0,0]:= 0.195;
      m[0,1]:= -0.488;
      m[0,2]:= 0.344;
      m[0,3]:= 0.433;
      m[0,4]:= 0.4431;
      m[0,5]:= 0.2452;
      m[0,6]:= 0.25;
      m[1,0]:= 0.462;
      m[1,1]:= 0.414;
      m[1,2]:= -0.252;
      m[1,3]:= 0.361;
      m[1,4]:= 0.2511;
      m[1,5]:= 0.5692;
      m[1,6]:= 0.25;
      m[2,0]:= -0.058;
      m[2,1]:= -0.07;
      m[2,2]:= 0.453;
      m[2,3]:= -0.111;
      m[2,4]:= 0.5976;
      m[2,5]:= 0.0969;
      m[2,6]:= 0.25;
      m[3,0]:= -0.035;
      m[3,1]:= 0.07;
      m[3,2]:= -0.469;
      m[3,3]:= -0.022;
      m[3,4]:= 0.4884;
      m[3,5]:= 0.5069;
      m[3,6]:= 0.2;
      m[4,0]:= -0.637;
      m[4,1]:= 0;
      m[4,2]:= 0;
      m[4,3]:= 0.501;
      m[4,4]:= 0.8562;
      m[4,5]:= 0.2513;
      m[4,6]:= 0.05;

      x_c1:= 0;
      X_C2:= 1;  //0.942
      y_c1:= 0;
      Y_C2:= 0.88; //1
       end;
       15:begin
      m[0,0]:= 0.05;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.4;
      m[0,4]:= -0.06;
      m[0,5]:= -0.47;
      m[0,6]:= 0.2;
      m[1,0]:= -0.05;
      m[1,1]:= 0;
      m[1,2]:= 0;
      m[1,3]:= -0.4;
      m[1,4]:= -0.06;
      m[1,5]:= -0.47;
      m[1,6]:= 0.2;
      m[2,0]:= 0.03;
      m[2,1]:= -0.14;
      m[2,2]:= 0;
      m[2,3]:= 0.26;
      m[2,4]:= -0.16;
      m[2,5]:= -0.01;
      m[2,6]:= 0.1;
      m[3,0]:= -0.03;
      m[3,1]:= 0.14;
      m[3,2]:= 0;
      m[3,3]:= -0.26;
      m[3,4]:= -0.16;
      m[3,5]:= -0.1;
      m[3,6]:= 0.1;
      m[4,0]:= 0.56;
      m[4,1]:= 0.44;
      m[4,2]:= -0.37;
      m[4,3]:= 0.51;
      m[4,4]:= 0.3;
      m[4,5]:= 0.15;
      m[4,6]:= 0.3;
      m[5,0]:= 0.19;
      m[5,1]:= 0.07;
      m[5,2]:= -0.1;
      m[5,3]:= 0.15;
      m[5,4]:= -0.2;
      m[5,5]:= 0.28;
      m[5,6]:= 0.05;
      m[6,0]:= -0.33;
      m[6,1]:= -0.34;
      m[6,2]:= -0.3;
      m[6,3]:= 0.34;
      m[6,4]:= -0.54;
      m[6,5]:= 0.39;
      m[6,6]:= 0.05;
      x_c1:= 0.95;
      X_C2:= 1.95;  //0.942
      y_c1:= 0.8;
      Y_C2:= 1.65; //1
       end;
       16:begin
      m[0,0]:= 0.387;
      m[0,1]:= 0.43;
      m[0,2]:= 0.43;
      m[0,3]:= -0.387;
      m[0,4]:= 0.256;
      m[0,5]:= 0.522;
      m[0,6]:= 0.333;
      m[1,0]:= 0.441;
      m[1,1]:= -0.091;
      m[1,2]:= -0.009;
      m[1,3]:= -0.322;
      m[1,4]:= 0.4219;
      m[1,5]:= 0.5059;
      m[1,6]:= 0.333;
      m[2,0]:= -0.468;
      m[2,1]:= 0.02;
      m[2,2]:= -0.113;
      m[2,3]:= 0.015;
      m[2,4]:= 0.4;
      m[2,5]:= 0.4;
      m[2,6]:= 0.334;

      x_c1:= 0;
      X_C2:= 0.9;  //0.942
      y_c1:= 0;
      Y_C2:= 0.75; //1
       end;
       17:begin
      m[0,0]:= 0.8;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= -0.8;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.5;
      m[1,0]:= 0.4;
      m[1,1]:= -0.2;
      m[1,2]:= 0.2;
      m[1,3]:= 0.4;
      m[1,4]:= 1.1;
      m[1,5]:= 0;
      m[1,6]:= 0.5;

      x_c1:= 0;
      X_C2:= 1.78;  //0.942
      y_c1:= 0.4445;
      Y_C2:= 1; //1
       end;
       18:begin
      m[0,0]:= 0.5;
      m[0,1]:= 0.25;
      m[0,2]:= 0.25;
      m[0,3]:= -0.5;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.5;
      m[1,0]:= 0.75;
      m[1,1]:= -0.25;
      m[1,2]:= 0.25;
      m[1,3]:= 0.75;
      m[1,4]:= 0.75;
      m[1,5]:= 0;
      m[1,6]:= 0.5;

      x_c1:= 0;
      X_C2:= 2.2211;  //0.942
      y_c1:= 0.46;
      Y_C2:= 2.18; //1
       end;
       19:begin
      m[0,0]:= 0;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.16;
      m[0,4]:= 0;
      m[0,5]:= 0;
      m[0,6]:= 0.01;
      m[1,0]:= 0.85;
      m[1,1]:= 0.04;
      m[1,2]:= -0.04;
      m[1,3]:= 0.85;
      m[1,4]:= 0;
      m[1,5]:= 1.6;
      m[1,6]:= 0.85;
      m[2,0]:= 0.2;
      m[2,1]:= -0.26;
      m[2,2]:= 0.23;
      m[2,3]:= 0.22;
      m[2,4]:= 0;
      m[2,5]:= 1.6;
      m[2,6]:= 0.07;
      m[3,0]:= -0.15;
      m[3,1]:= 0.28;
      m[3,2]:= 0.26;
      m[3,3]:= 0.24;
      m[3,4]:= 0;
      m[3,5]:= 0.44;
      m[3,6]:= 0.07;
      x_c1:= 2.185;
      X_C2:= 4.88;  //0.942
      y_c1:= 0;
      Y_C2:= 10; //1
       end;
       20:begin
      m[0,0]:= 0;
      m[0,1]:= 0;
      m[0,2]:= 0;
      m[0,3]:= 0.25;
      m[0,4]:= 0;
      m[0,5]:= -0.04;
      m[0,6]:= 0.02;
      m[1,0]:= 0.92;
      m[1,1]:= 0.05;
      m[1,2]:= -0.05;
      m[1,3]:= 0.93;
      m[1,4]:= -0.002;
      m[1,5]:= 0.5;
      m[1,6]:= 0.84;
      m[2,0]:= 0.035;
      m[2,1]:= -0.2;
      m[2,2]:= 0.16;
      m[2,3]:= 0.04;
      m[2,4]:= -0.09;
      m[2,5]:= 0.02;
      m[2,6]:= 0.07;
      m[3,0]:= -0.04;
      m[3,1]:= 0.2;
      m[3,2]:= 0.16;
      m[3,3]:= 0.04;
      m[3,4]:= 0.083;
      m[3,5]:= 0.12;
      m[3,6]:= 0.07;
      x_c1:= 1.08;
      X_C2:= 4.4;  //0.942
      y_c1:= 0.18;
      Y_C2:= 5.7; //1
       end;
      end;
  //++++++++++++++++++++
  while n> 0 do
   begin
    r:= Random;
     if r <= m[0,0] then
      begin
       a:= m[0,0];
       b:= m[0,1];
       c:= m[0,2];
       d:= m[0,3];
       e:= m[0,4];
       f:= m[0,5];
      end else if r <=m[0,6] + m[1,6] then
       begin
       a:= m[1,0];
       b:= m[1,1];
       c:= m[1,2];
       d:= m[1,3];
       e:= m[1,4];
       f:= m[1,5];
      end else if r <= m[0,6]+ m[1,6]+ m[2,6] then
       begin
       a:= m[2,0];
       b:= m[2,1];
       c:= m[2,2];
       d:= m[2,3];
       e:= m[2,4];
       f:= m[2,5];
      end else if r <= m[0,6]+ m[1,6]+ m[2,6]+m[3,6] then
       begin
       a:= m[3,0];
       b:= m[3,1];
       c:= m[3,2];
       d:= m[3,3];
       e:= m[3,4];
       f:= m[3,5];
      end else if r <= m[0,6]+ m[1,6]+ m[2,6]+m[3,6]+ m[4,6] then
       begin
       a:= m[4,0];
       b:= m[4,1];
       c:= m[4,2];
       d:= m[4,3];
       e:= m[4,4];
       f:= m[4,5];
      end else if r <= m[0,6]+ m[1,6]+ m[2,6]+m[3,6]+ m[4,6] +m[5,6] then
       begin
       a:= m[5,0];
       b:= m[5,1];
       c:= m[5,2];
       d:= m[5,3];
       e:= m[5,4];
       f:= m[5,5];
      end else begin
       a:= m[6,0];
       b:= m[6,1];
       c:= m[6,2];
       d:= m[6,3];
       e:= m[6,4];
       f:= m[6,5];
      end;

      newx:= a *x + b *y + e;
      newy:= c*x + d* y + f;
      x:= newx;
      y:= newy;


      bt.Canvas.Pixels[round(bt.Width *(X+X_C1)/X_C2),round(bt.Height-bt.Height *(y+Y_C1)/Y_C2)]:=
      rgb(floattobyte(255*X),floattobyte(255 *R),floattobyte(255*Y));

    dec(n);
   end; //end while
  // showmessage(floattostr(min2) + ',' +floattostr(max2) + ','+floattostr(min3) + ','+floattostr(max3));
end;

function TForm_pop.need_wait: boolean;
begin
 result:=  (time_list1.Timer_wo_gongji or time_list1.Timer_wo_fashugongji
     or time_list1.Timer_wupin_gongji or time_list1.Timer_wupin_huifu or time_list1.Timer_fashu_huifu);


end;

procedure TForm_pop.clean_lable2_11;
begin
 label2.Caption:= '';
 label3.Caption:= '';
 label4.Caption:= '';
 label5.Caption:= '';
 label6.Caption:= '';
 label7.Caption:= '';
 label8.Caption:= '';
 label9.Caption:= '';
 label10.Caption:= '';
 label11.Caption:= '';
end;

procedure TForm_pop.write_label2_11;
var g: array[0..9,0..1] of integer;
    i,j,k,k2: integer;
    t: Tplayer;
    function get_09name(L,L2: integer): string;
    begin
     if l2= 0 then
       begin
       get_09name:= '';
       end else begin
     if L > 4 then
      begin
       //敌放编号
       result:= loc_guai_g[l-5].name1;
      end else begin
                t:= game_get_role_from_i(l);
                if t<> nil then
                  get_09name:= t.plname;
               end;
               end;
    end;
begin
   clean_lable2_11;
    //0--4，我方编号，5--9，敌方编号
   for i:= 0 to 9 do
    begin
    g[i,0]:= game_p_list[i];
    g[i,1]:= i;
    end;

    for j:= 0 to 9 do
     begin
    for i:= 1 to 9 do
     if g[i,0] > g[i-1,0] then
        begin
         k:= g[i,0];
         k2:= g[i,1];
         g[i,0]:= g[i-1,0];
         g[i-1,0]:= k;
          g[i,1]:= g[i-1,1];
         g[i-1,1]:= k2;
        end;
     end; //end j

      label11.Caption:= get_09name(g_wo_guai_dangqian,1); //当前人物

     if g_wo_guai_dangqian > 4 then
     label11.Font.Color:= clred
     else
       label11.Font.Color:= clgreen;

     label10.Caption:= get_09name(g[0,1],g[0,0]);
     label9.Caption:= get_09name(g[1,1],g[1,0]);
     label8.Caption:= get_09name(g[2,1],g[2,0]);
     label7.Caption:= get_09name(g[3,1],g[3,0]);
     label6.Caption:= get_09name(g[4,1],g[4,0]);
     label5.Caption:= get_09name(g[5,1],g[5,0]);
     label4.Caption:= get_09name(g[6,1],g[6,0]);
     label3.Caption:= get_09name(g[7,1],g[7,0]);
     label2.Caption:= get_09name(g[8,1],g[8,0]);
   //  label2.Caption:= get_09name(g[9,1],g[9,0]);
end;

procedure TForm_pop.ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

 if button = mbRight then
  begin
   groupbox3.Visible:= false;
   g_gong.xianshi:= true;
  end else begin
            if not g_Dragging then
              if listbox1.ItemIndex > -1 then
                listbox1_click1;
            //结束拖动
            if g_Dragging then
             begin
              ListBox1.EndDrag(true);
              g_Dragging:= false;
             end;
           end;


end;

procedure TForm_pop.ListBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 accept:= true;
end;

procedure TForm_pop.Button6DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
 accept:= true;
end;

procedure TForm_pop.Button6DragDrop(Sender, Source: TObject; X,
  Y: Integer);
  var ss: string;
      t: Tplayer;
begin
  if source<> listbox1 then
     exit;

   if listbox1.Itemindex= -1 then
    exit;

     ss:= listbox1.Items.Strings[listbox1.ItemIndex];
  if (ss= '') or (ss[1]= '-') then
   begin
    (sender as tbutton).Caption:= '快捷-无';
    if listbox1.Items.Count<= 2 then
     if f_type_g = 4 then
      messagebox(handle,'您没有可用的物品（药材），物品可以在野外捡到或者在城镇的店铺内买到。','加油',mb_ok or MB_ICONWARNING)
     else
     messagebox(handle,'您没有学会法术，法术秘籍可以在迷宫找到或者在一些特定人物处获得。','继续冒险',mb_ok or MB_ICONWARNING);
   exit;   //分割线，退出
   end;


  (sender as tbutton).Caption:= data2.get_game_goods_type_s(ss,goods_name1); //获取物品id

  t:= game_get_role_from_i(fgame_my_cu);

   if button6.Caption='快捷-无' then
    fashu_wupin_kuaijie_list.Values[t.pl_old_name+'1']:=''
    else
     fashu_wupin_kuaijie_list.Values[t.pl_old_name+'1']:= button6.Caption;

   if button7.Caption='快捷-无' then
    fashu_wupin_kuaijie_list.Values[t.pl_old_name+'2']:=''
    else
     fashu_wupin_kuaijie_list.Values[t.pl_old_name+'2']:= button7.Caption;
    if button8.Caption='快捷-无' then
    fashu_wupin_kuaijie_list.Values[t.pl_old_name+'3']:=''
    else
     fashu_wupin_kuaijie_list.Values[t.pl_old_name+'3']:= button8.Caption;
    if button9.Caption='快捷-无' then
    fashu_wupin_kuaijie_list.Values[t.pl_old_name+'4']:=''
    else
     fashu_wupin_kuaijie_list.Values[t.pl_old_name+'4']:= button9.Caption;
    if button10.Caption='快捷-无' then
    fashu_wupin_kuaijie_list.Values[t.pl_old_name+'5']:=''
    else
     fashu_wupin_kuaijie_list.Values[t.pl_old_name+'5']:= button10.Caption;
end;

procedure TForm_pop.laod_fashu_wupin_k(const s: string);
begin
 if FileExists(s) then
    fashu_wupin_kuaijie_list.LoadFromFile(s);
end;

procedure TForm_pop.save_fashu_wupin_k(const s: string);
begin
   fashu_wupin_kuaijie_list.SaveToFile(s);
end;

procedure TForm_pop.show_fashuwupin_k(const s: string);
begin
  if fashu_wupin_kuaijie_list.Values[s+'1']= '' then
     button6.Caption:='快捷-无'
     else
       button6.Caption:= fashu_wupin_kuaijie_list.Values[s+'1'];
  if fashu_wupin_kuaijie_list.Values[s+'2']= '' then
     button7.Caption:='快捷-无'
     else
       button7.Caption:= fashu_wupin_kuaijie_list.Values[s+'2'];
  if fashu_wupin_kuaijie_list.Values[s+'3']= '' then
     button8.Caption:='快捷-无'
     else
       button8.Caption:= fashu_wupin_kuaijie_list.Values[s+'3'];
  if fashu_wupin_kuaijie_list.Values[s+'4']= '' then
     button9.Caption:='快捷-无'
     else
       button9.Caption:= fashu_wupin_kuaijie_list.Values[s+'4'];
  if fashu_wupin_kuaijie_list.Values[s+'5']= '' then
     button10.Caption:='快捷-无'
     else
       button10.Caption:= fashu_wupin_kuaijie_list.Values[s+'5'];
end;

procedure TForm_pop.Button6Click(Sender: TObject);
var ss: string;
   id,j: integer;
   procedure b6_end;
   begin
        time_list1.timer_gong:= false;
  groupbox3.Visible:= false;
  g_gong.xianshi:= false;
   end;
begin
   if  (groupbox3.Visible= false ) and (g_gong.xianshi= false) then
     exit;    //都没有显示时快捷键不可用

   if (sender as tbutton).Caption= '快捷-无' then
     exit;

   if need_wait then
    exit;

  ss:= (sender as tbutton).Caption;

  id:= Form_goods.get_goods_id(ss); //获取物品id

   F_Attack_type:= id; //保存当前物品或者法术的id
   f_type_g:= 4;

  ss:= Data2.get_goods_all_s(id);  //取得了物品字符串的内容

   j:= strtoint2(data2.get_game_goods_type_s(ss,goods_type1)); //取得类型


   if j and 2=2 then
    begin
    if read_goods_number(id)> 0 then
    begin
     b6_end;
     procedure_2(ss);
    end  else begin
             messagebox(handle,pchar('物品不足，您已经用完了'+(sender as tbutton).Caption),'物品不足',mb_ok or MB_ICONWARNING);
           end;
    end else if j and 4=4 then
         begin
          if read_goods_number(id)> 0 then
           begin
           b6_end;
          procedure_4(ss);
          end
           else begin
             messagebox(handle,pchar('物品不足，您已经用完了'+(sender as tbutton).Caption),'物品不足',mb_ok or MB_ICONWARNING);
            end;
         end else if j and 128= 128 then
           begin
           f_type_g:= 3;
           if lingli_is_ok(ss) then
            begin
               b6_end;
             procedure_128(ss);
            end else begin  //灵力不够时退出，首先获得法术名称，然后取id，然后取灵力，然后和当前人物比对剩余灵力
                   messagebox(handle,pchar('灵力不够，不能使用此法术。'+ (sender as tbutton).Caption),'灵力不够',mb_ok or MB_ICONWARNING);
                  end;
           end else if j and 256 = 256 then
                       begin
                        if read_goods_number(id)> 0 then
                          begin
                             b6_end;
                           procedure_256(ss);
                          end else begin
                            messagebox(handle,pchar('物品不足，您已经用完了'+(sender as tbutton).Caption),'物品不足',mb_ok or MB_ICONWARNING);
                          end;
                       end;
     
end;

procedure TForm_pop.Action16Execute(Sender: TObject);
begin
  Button6Click(button6);  //物品法术的快捷键
end;

procedure TForm_pop.Action17Execute(Sender: TObject);
begin
  Button6Click(button7);
end;

procedure TForm_pop.Action18Execute(Sender: TObject);
begin
     Button6Click(button8);
end;

procedure TForm_pop.Action19Execute(Sender: TObject);
begin
    Button6Click(button9);
end;

procedure TForm_pop.Action20Execute(Sender: TObject);
begin
    Button6Click(button10);
end;

procedure TForm_pop.show_hint_button;
begin
     button6.Hint:= '物品或者法术的快捷键，可拖动物品或法术到此，快捷键'+ ShortCutToText(Action16.ShortCut);
     button7.Hint:= '物品或者法术的快捷键，可拖动物品或法术到此，快捷键'+ ShortCutToText(Action17.ShortCut);
     button8.Hint:= '物品或者法术的快捷键，可拖动物品或法术到此，快捷键'+ ShortCutToText(Action18.ShortCut);
     button9.Hint:= '物品或者法术的快捷键，可拖动物品或法术到此，快捷键'+ ShortCutToText(Action19.ShortCut);
     button10.Hint:= '物品或者法术的快捷键，可拖动物品或法术到此，快捷键'+ ShortCutToText(Action20.ShortCut);

     button1.Hint:= '攻击怪物。普通物理攻击，快捷键 '+ ShortCutToText(Action1.ShortCut);
     button2.Hint:= '进入防护状态，可减轻伤害，快捷键'+ ShortCutToText(Action2.ShortCut);
     button3.Hint:= '使用法术攻击怪物或者恢复队员，快捷键'+ ShortCutToText(Action3.ShortCut);
     button4.Hint:= '使用恢复类物品补充或者投掷类物品攻击，快捷键'+ ShortCutToText(Action4.ShortCut);
     button5.Hint:= '三十六计，走为上计，快捷键'+ ShortCutToText(Action5.ShortCut);
end;

procedure TForm_pop.ListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  mouse_down_xy.X:= X;
  mouse_down_xy.Y:= Y; //保存鼠标按下时的位置，用来检测拖动
end;

procedure TForm_pop.N7Click(Sender: TObject);
begin
 game_not_bg_black:= not game_not_bg_black;
   if not game_not_bg_black then
  begin
  messagebox(handle,'黑色背景已经临时启用，如需保存此设置，请点击游戏的“系统设置”页面，在那里更改并保存。','注意',mb_ok);
  end else begin
               messagebox(handle,'黑色背景已经临时关闭，如需保存此设置，请点击游戏的“系统设置”页面，在那里更改并保存。','注意',mb_ok);
            end;
end;

procedure TForm_pop.play_sound(i: integer);
begin
   Assert(i<>-1,'索引越位');
    With DXWaveList1.items[i] Do
    Begin
      volume := -1000;
      pan := 0;
      play(false);
    End;
end;

procedure TForm_pop.Button11Click(Sender: TObject);
begin
 popupmenu1.Popup(Button11.ClientOrigin.X,Button11.ClientOrigin.Y+Button11.Height);
end;

procedure TForm_pop.PopupMenu1Popup(Sender: TObject);
begin
  if GameSave1.tip1= 0 then
     n1.Caption:= '关闭单词动画'
     else n1.Caption:= '开启单词动画';

  if GameSave1.tip2= 0 then
     n2.Caption:= '关闭单词透明效果'
     else n2.Caption:= '开启单词透明效果';

  if GameSave1.tip3= 0 then
     n4.Caption:= '关闭策略窗口动画'
     else n4.Caption:= '开启策略窗口动画';
  if GameSave1.tip4= 0 then
     n5.Caption:= '关闭策略窗口透明'
     else n5.Caption:= '开启策略窗口透明';
  if GameSave1.tip5= 0 then
     n9.Caption:= '关闭战斗音效'
     else n9.Caption:= '开启战斗音效';
  if GameSave1.tip6= 0 then
     n10.Caption:= '关闭怪物叫声'
     else n10.Caption:= '开启怪物叫声';

  if not game_not_bg_black then
    n7.Caption:= '关闭黑色背景'
   else
     n7.Caption:= '启用黑色背景';
end;

procedure TForm_pop.N1Click(Sender: TObject);
begin
  GameSave1.tip1:= not GameSave1.tip1;

end;

procedure TForm_pop.N2Click(Sender: TObject);
begin
    GameSave1.tip2:= not GameSave1.tip2;
end;

procedure TForm_pop.N4Click(Sender: TObject);
begin
   GameSave1.tip3:= not GameSave1.tip3;
end;

procedure TForm_pop.N5Click(Sender: TObject);
begin
GameSave1.tip4:= not GameSave1.tip4;
end;

procedure TForm_pop.N9Click(Sender: TObject);
begin
  GameSave1.tip5:= not GameSave1.tip5;
end;

procedure TForm_pop.N10Click(Sender: TObject);
begin
  GameSave1.tip6:= not GameSave1.tip6;
end;

procedure TForm_pop.N12Click(Sender: TObject);
begin
    GameSave1.tip1:= 0;
    GameSave1.tip2:= 0;
    GameSave1.tip3:= 0;
    GameSave1.tip4:= 0;
    GameSave1.tip5:= 0;
    GameSave1.tip6:= 0;
    game_not_bg_black:= true;
end;

procedure TForm_pop.Timer_auto_attackTimer(Sender: TObject);

begin
    //自动攻击怪物，在一秒

  inc(g_auto_attack);
   if g_auto_attack= 10 then
    begin
      Timer_auto_attack.Enabled:= false;
      g_auto_attack:= 0;

      case get_min_guai_f of
      0: G_mus_at:= mus_guai1;
      1: G_mus_at:= mus_guai2;
      2: G_mus_at:= mus_guai3;
      3: G_mus_at:= mus_guai4;
      4: G_mus_at:= mus_guai5;
      end;

      Panel1MouseDown(self,mbLeft,[ssleft],0,0);
    end;
end;

procedure TForm_pop.init_weizi;
begin
 with g_danci_weizhi.weizi do //初始化单词和显示的位置和大小
     begin
     Left:= g_word_show_left;
     Top:= G_C_danci_top;
     Right:= g_word_show_left + game_bmp_width;
     Bottom:= Top+ game_bmp_h1;
     end;
    g_danci_weizhi.alpha:= 255;

    with g_jieshi_weizhi1.weizi do
    begin
     Left:= g_word_show_left;
     Top:= G_C_jieshi1_top;
     Right:= g_word_show_left + game_bmp_width;
     Bottom:= Top + game_bmp_h2;
     end;
     g_jieshi_weizhi1.alpha:= 255;

    with g_jieshi_weizhi2.weizi do
     begin
     Left:= g_word_show_left;
     Top:= G_C_jieshi2_top;
     Right:= g_word_show_left + game_bmp_width;
     Bottom:= top + game_bmp_h2;
     end;
    g_jieshi_weizhi2.alpha:= 255;

    with g_jieshi_weizhi3.weizi do
     begin
     Left:= g_word_show_left;
     Top:= G_C_jieshi3_top;
     Right:= g_word_show_left + game_bmp_width;
     Bottom:= top + game_bmp_h2;
     end;
     g_jieshi_weizhi3.alpha:= 255;

     with image_word do
       begin
       Size:= point(game_bmp_width,64);
       PatternSize:= point(game_bmp_width,game_bmp_h1);
       VisibleSize:= point(game_bmp_width,game_bmp_h1);
       end;

     with image_cn1 do
       begin
       Size:= point(game_bmp_width,32);
       PatternSize:= point(game_bmp_width,game_bmp_h2);
       VisibleSize:= point(game_bmp_width,game_bmp_h2);
       end;
     with image_cn2 do
       begin
       Size:= point(game_bmp_width,32);
       PatternSize:= point(game_bmp_width,game_bmp_h2);
       VisibleSize:= point(game_bmp_width,game_bmp_h2);
       end;
     with image_cn3 do
       begin
      Size:= point(game_bmp_width,32);
      PatternSize:= point(game_bmp_width,game_bmp_h2);
       VisibleSize:= point(game_bmp_width,game_bmp_h2);
       end;


     with image_up do
      begin
      Size:= point(game_bmp_width,32);
      PatternSize:= point(game_bmp_width,32);
       VisibleSize:= point(game_bmp_width,32);
      end;
    with image_down do
      begin
       Size:= point(game_bmp_width,32);
       PatternSize:= point(game_bmp_width,32);
       VisibleSize:= point(game_bmp_width,32);
      end;
      game_intl_pic;
      
end;

procedure TForm_pop.Timer5Timer(Sender: TObject);
begin
  inc(g_timer_count_5); //累计时间，如果累计到
  if G_mus_at= mus_nil then
    begin
    g_is_word_right:= false;
     exit;
    end;

  if g_timer_count_5= 50 then
   begin
     if ((G_mus_at= mus_jieshi1) and (jit_tmp_3=0)) or
        ((G_mus_at= mus_jieshi2) and (jit_tmp_3=1)) or
        ((G_mus_at= mus_jieshi3) and (jit_tmp_3=2))  then
        begin
         if form1.game_check_money(60)=1 then
           begin
            form1.game_change_money(-60);
            show_text(false,'正确，扣了60金钱。');
            g_is_word_right:= true;
             add_to_errorword_list(game_dangqian_word_id); //添加到错误单词表。复习用
           end else show_text(false,'您钱不够。不能显示答案');
        end else begin
                  g_is_word_right:= false;
                  if form1.game_check_money(60)=1 then
                   begin
                    show_text(false,'鼠标下答案不正确。');
                   end else show_text(false,'您钱不够。不能显示答案');
                 end;
   end else if  g_timer_count_5= 1 then
     begin
      show_text(false,'');

     end else if g_timer_count_5= 15 then
               show_text(false,'鼠标答案上停留5秒可显示提示');
end;

function TForm_pop.get_Random_EXX: integer;
 function get_part_postion: integer;   //取得在分段背单词时的单词id
  begin
   {分段背单词数字的第一个位置保存一个进度指针}
   result:= -1;
   if part_size_g= nil then exit;
   if length(part_size_g)= 1 then exit;
    //第一个位置，保存指针
   if part_size_g[0]> 0 then
     begin
      if part_size_g[0]> high(part_size_g) then
         part_size_g[0]:= 1;
      result:= part_size_g[part_size_g[0]];
      inc(part_size_g[0]);
     end;
  end;
 procedure set_part_postion(t: integer);
 var i: integer;
  begin
    if part_size_g= nil then exit;
      if part_size_g[0]= 0 then
      begin
       for i:= 1 to length(part_size_g)-1 do
        begin
          if i=  high(part_size_g) then
                part_size_g[0]:= 1; //检测到最后一个位置时，为1，这会有个小问题，就是如果是中途插入的，会多获取一个单词
          if part_size_g[i]= 0 then
            begin
             part_size_g[i]:= t;
             exit;
            end;
        end;
      end;
  end;
begin
   //如果顺序或者艾宾浩斯，者取值
  result:= -1;
  
   if game_abhs_g then
     result:= get_abhs_value;

   if result= -1 then
    begin
      //检查分段背单词数组
      result:= get_part_postion;
      if result> -1 then
        exit;

     if game_shunxu_g then
      begin
       result:= GameSave1.tip7; //取得顺序值
       inc(GameSave1.tip7);
       if GameSave1.tip7 >= wordlist1.Count then
          GameSave1.tip7:= 0;
      end else begin
                result:= Random(wordlist1.Count);
               end;
      set_part_postion(result); //保存到分段背诵表
    end;
   
end;

procedure TForm_pop.init_tiame_day_abhs;
begin
   //初始化abhs指针
   if game_abhs_g then
    begin
      if stringlist_abhs5.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs5.Strings[0],1,fastcharpos(stringlist_abhs5.Strings[0],',',1)-1),g_time_5) then
            g_time_5:= 0;

      if stringlist_abhs30.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs30.Strings[0],1,fastcharpos(stringlist_abhs30.Strings[0],',',1)-1),g_time_30) then
            g_time_30:= 0;
      if stringlist_abhs240.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs240.Strings[0],1,fastcharpos(stringlist_abhs240.Strings[0],',',1)-1),g_time_240) then
            g_time_240:= 0;
     if stringlist_abhs_d1.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs_d1.Strings[0],1,fastcharpos(stringlist_abhs_d1.Strings[0],',',1)-1),g_day_1) then
            g_day_1:= 0;
     if stringlist_abhs_d2.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs_d2.Strings[0],1,fastcharpos(stringlist_abhs_d2.Strings[0],',',1)-1),g_day_2) then
            g_day_2:= 0;
     if stringlist_abhs_d4.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs_d4.Strings[0],1,fastcharpos(stringlist_abhs_d4.Strings[0],',',1)-1),g_day_4) then
            g_day_4:= 0;
     if stringlist_abhs_d7.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs_d7.Strings[0],1,fastcharpos(stringlist_abhs_d7.Strings[0],',',1)-1),g_day_7) then
            g_day_7:= 0;
     if stringlist_abhs_d15.Count> 0 then
        if not Trystrtoint(copy(stringlist_abhs_d15.strings[0],1,fastcharpos(stringlist_abhs_d15.Strings[0],',',1)-1),g_day_15) then
            g_day_15:= 0;
      
   end;
end;

function TForm_pop.get_abhs_value: integer;
var k: integer;
    ss: string;
    label pp;
begin
   //返回艾宾浩斯值
g_on_abhs:= false;

     result:= -1;
     init_tiame_day_abhs;
   k:= DateTimeToFileDate(now);
    //++++++++++++++++++++++++++++++++++++  g_time_5
   if g_time_5> 0 then
     begin
              if (k - g_time_5 > 300) and Assigned(stringlist_abhs5) and (stringlist_abhs5.Count> 0) then
               begin
                ss:= stringlist_abhs5.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs5.Delete(0);
                stringlist_abhs30.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs5.Count= 0 then
                   g_time_5:= 0;
                 goto pp;
               end;
     end;
  //++++++++++++++++++++++++++++++++++++  g_time_5 end

   //++++++++++++++++++++++++++++++++++++  g_time_30
     if g_time_30> 0 then
     begin
              if (k - g_time_30 > 1500) and Assigned(stringlist_abhs30) and (stringlist_abhs30.Count> 0) then
               begin
                ss:= stringlist_abhs30.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs30.Delete(0);
                stringlist_abhs240.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs30.Count= 0 then
                   g_time_30:= 0;

               goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_time_30 end

     //++++++++++++++++++++++++++++++++++++  g_time_240  改为120分钟
      if g_time_240> 0 then
     begin
              if (k - g_time_240 > 5400) and Assigned(stringlist_abhs240) and (stringlist_abhs240.Count> 0) then
               begin
                ss:= stringlist_abhs240.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs240.Delete(0);
                stringlist_abhs_d1.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs240.Count= 0 then
                   g_time_240:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_time_240 end

       //++++++++++++++++++++++++++++++++++++  g_day_1
       if g_day_1> 0 then
     begin
              if (k - g_day_1 > 72000) and Assigned(stringlist_abhs_d1) and (stringlist_abhs_d1.Count> 0) then
               begin
                ss:= stringlist_abhs_d1.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs_d1.Delete(0);
                stringlist_abhs_d2.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs_d1.Count= 0 then
                   g_day_1:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_day_1 end

       //++++++++++++++++++++++++++++++++++++  g_day_2
        if g_day_2> 0 then
     begin
              if (k - g_day_2 > 86400) and Assigned(stringlist_abhs_d2) and (stringlist_abhs_d2.Count> 0) then
               begin
                ss:= stringlist_abhs_d2.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs_d2.Delete(0);
                stringlist_abhs_d4.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs_d2.Count= 0 then
                   g_day_2:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_day_2 end

       //++++++++++++++++++++++++++++++++++++  g_day_4
       if g_day_4> 0 then
     begin
              if (k - g_day_4 > 172800) and Assigned(stringlist_abhs_d4) and (stringlist_abhs_d4.Count> 0) then
               begin
                ss:= stringlist_abhs_d4.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs_d4.Delete(0);
                stringlist_abhs_d7.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs_d4.Count= 0 then
                   g_day_4:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_day_4 end

       //++++++++++++++++++++++++++++++++++++  g_day_7
         if g_day_7> 0 then
     begin
              if (k - g_day_7 > 259200) and Assigned(stringlist_abhs_d7) and (stringlist_abhs_d7.Count> 0) then
               begin
                ss:= stringlist_abhs_d7.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs_d7.Delete(0);
                stringlist_abhs_d15.Append(inttostr(DateTimeToFileDate(now))+
                           ','+copy(ss,fastcharpos(ss,',',1)+1,5));
                if stringlist_abhs_d7.Count= 0 then
                   g_day_7:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_day_7 end

       //++++++++++++++++++++++++++++++++++++  g_day_15
       if g_day_15> 0 then
     begin
              if (k - g_day_15 > 691200) and Assigned(stringlist_abhs_d15) and (stringlist_abhs_d15.Count> 0) then
               begin
                ss:= stringlist_abhs_d15.Strings[0];
                result:= strtoint2(copy(ss,fastcharpos(ss,',',1)+1,5));
                stringlist_abhs_d15.Delete(0);
                //stringlist_abhs.Append(ss);
                if stringlist_abhs_d15.Count= 0 then
                   g_day_15:= 0;

                goto pp;
               end;
     end;

    //++++++++++++++++++++++++++++++++++++  g_day_15 end

    pp:
     if result >= wordlist1.Count then
          result:= Random(wordlist1.Count)
          else
                g_on_abhs:= true;

  if result= -1 then
     exit;

  if g_abhs_index<> result then
   begin
    g_abhs_index:= result;
    g_abhs_count:= 0;
   end else begin
               inc(g_abhs_count);
             if g_abhs_count>= 2 then
               result:= get_abhs_value;
               
            end;
 
end;

procedure TForm_pop.load_abhs;
var ss: string;
begin

   if (Game_save_path<> '') and (fastcharpos(Game_save_path,'!',1)> 0) then
      ss:= Game_save_path
     else ss:= game_doc_path_G+'save\';

   //if FileExists(ss+ '1'+ g_string_abhs) then    一天内的abhs表不保存
   //  begin
      stringlist_abhs5.Clear; //清除abhs
    //  stringlist_abhs5.LoadFromFile(ss+ '1' + g_string_abhs);
     // end;
    //  if FileExists(ss+ '2'+ g_string_abhs) then
    // begin
       stringlist_abhs30.Clear;
    // stringlist_abhs30.LoadFromFile(ss+ '2'+ g_string_abhs);
   //  end;
     // if FileExists(ss+ '3'+ g_string_abhs) then
   //  begin
      stringlist_abhs240.Clear;
  //  stringlist_abhs240.LoadFromFile(ss+ '3'+ g_string_abhs);
  //  end;
      if FileExists(ss+ '4'+ g_string_abhs) then
     begin
     stringlist_abhs_d1.Clear;
    stringlist_abhs_d1.LoadFromFile(ss+ '4'+ g_string_abhs);
    end;
      if FileExists(ss+ '5'+ g_string_abhs) then
     begin
     stringlist_abhs_d2.Clear;
    stringlist_abhs_d2.LoadFromFile(ss+ '5'+ g_string_abhs);
    end;
      if FileExists(ss+ '6'+ g_string_abhs) then
     begin
     stringlist_abhs_d4.Clear;
    stringlist_abhs_d4.LoadFromFile(ss+ '6'+ g_string_abhs);
    end;
      if FileExists(ss+ '7'+ g_string_abhs) then
     begin
     stringlist_abhs_d7.Clear;
     stringlist_abhs_d7.LoadFromFile(ss+ '7'+ g_string_abhs);
    end;
      if FileExists(ss+ '8'+ g_string_abhs) then
     begin
     stringlist_abhs_d15.Clear;
     stringlist_abhs_d15.LoadFromFile(ss+ '8'+ g_string_abhs);
    end;
end;

procedure TForm_pop.save_abhs;
var ss: string;
begin
   if game_abhs_g then
    begin
     if fastcharpos(Game_save_path,'!',1)> 0 then
     ss:= Game_save_path
     else
     ss:= game_doc_path_G+'save\';

     // if stringlist_abhs5.Count > 0 then               一天内的abhs表不保存
    {  stringlist_abhs5.SaveToFile(ss+ '1'+ g_string_abhs);
     if stringlist_abhs30.Count > 0 then
     stringlist_abhs30.SaveToFile(ss+ '2'+ g_string_abhs);
     if stringlist_abhs240.Count > 0 then
    stringlist_abhs240.SaveToFile(ss+ '3'+ g_string_abhs);  }
    if stringlist_abhs_d1.Count > 0 then
    stringlist_abhs_d1.SaveToFile(ss+ '4'+ g_string_abhs);
    if stringlist_abhs_d2.Count > 0 then
    stringlist_abhs_d2.SaveToFile(ss+ '5'+ g_string_abhs);
    if stringlist_abhs_d4.Count > 0 then
    stringlist_abhs_d4.SaveToFile(ss+ '6'+ g_string_abhs);
    if stringlist_abhs_d7.Count > 0 then
    stringlist_abhs_d7.SaveToFile(ss+ '7'+ g_string_abhs);
    if stringlist_abhs_d15.Count > 0 then
   stringlist_abhs_d15.SaveToFile(ss+ '8'+ g_string_abhs);
    end;
end;

procedure TForm_pop.del_abhs;
var ss: string;
begin

     if fastcharpos(Game_save_path,'!',1)> 0 then
     ss:= Game_save_path
     else
     ss:= game_doc_path_G+'save\';

      stringlist_abhs5.Clear; //清除abhs
      DeleteFile(ss+'1' + g_string_abhs);


       stringlist_abhs30.Clear;
     DeleteFile(ss+'2'+ g_string_abhs);


      stringlist_abhs240.Clear;
    DeleteFile(ss+'3'+ g_string_abhs);


     stringlist_abhs_d1.Clear;
    DeleteFile(ss+'4'+ g_string_abhs);


     stringlist_abhs_d2.Clear;
    DeleteFile(ss+'5'+ g_string_abhs);


     stringlist_abhs_d4.Clear;
    DeleteFile(ss+'6'+ g_string_abhs);


     stringlist_abhs_d7.Clear;
     DeleteFile(ss+'7'+ g_string_abhs);


     stringlist_abhs_d15.Clear;
     DeleteFile(ss+'8'+ g_string_abhs);

     DeleteFile(ss+'1words.ini.abhs');
     DeleteFile(ss+'2words.ini.abhs');
     DeleteFile(ss+'3words.ini.abhs');
     DeleteFile(ss+'4words.ini.abhs');
     DeleteFile(ss+'5words.ini.abhs');
     DeleteFile(ss+'6words.ini.abhs');
     DeleteFile(ss+'7words.ini.abhs');
     DeleteFile(ss+'8words.ini.abhs');

end;

procedure TForm_pop.ComboBox1Enter(Sender: TObject);
begin
  combobox1.Tag:= combobox1.ItemIndex;
end;

procedure TForm_pop.game_up_role; //人物升级
var i,k: integer;
    str1: Tstringlist;
    t: Tplayer;
begin
str1:= Tstringlist.Create;
   for i:= 0 to 4 do
      begin
        k:= game_upgrade(i);
        if k > 0 then
         begin
          t:= game_get_role_from_i(i);
             str1.Append(t.plname + ' 升到：'+ inttostr(k)+' 级');
         end;
      end;

       if str1.Count > 0 then
        begin
         draw_text_17_m(str1,1000,clblack);
         G_game_delay(3000);
        end;
str1.free;
     {
   人物最高200级别
   体力 2000，每级升 10点
   灵力 10000，每级升 50点
   生命 5000， 每级升 25点
   经验值，第一次500点升一级，以后经验值乘以等级
   速，智，防，每级加一点
  }
end;

function TForm_pop.get_error_words: string;
begin
   result:= '第'+inttostr(jit_word_p+1)+'单词：'+ get_word_safe(jit_word_p);
end;

procedure TForm_pop.save_set(const s: string);
begin
  save_check;
 gamesave1.leiji:= gamesave1.leiji + Trunc((now - jit_kssj) *24*60*60);
 save_game_progress(s+ 'default.sav');
end;

procedure TForm_pop.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
  Para.WndParent:=Form1.Handle;
end;

procedure TForm_pop.Action21Execute(Sender: TObject);
begin
   if G_word = g_dangqian_zhuangtai then
    begin
      skp_string(Jit_words);
    end;
end;

function TForm_pop.get_pop_string(c: integer): string;
begin
    // 获取pop字符串
    pk_zhihui_g.game_zt:=1;
    if game_at_net_g then
     set_caoshi_list_value(g_nil_user_c); //初始化超时记录表

    result:= '<table align=center style="font-size:28pt;"><tr><td align=right><font size=3>'+ inttostr(game_pop_count) + '</font></td></tr>';
    dec(game_pop_count);
        jit_num:= 1;
    result:= result+ start_show_word(true) + '</table>';

end;

function TForm_pop.html_asw_string(c: integer): string;
begin
    //获取选择答案后的字符串

    result:= '<table align=center style="font-size:28pt;"><tr><td align=right><font size=3>'+ inttostr(game_pop_count) + '</font></td></tr>' +
             check_asw(c,true) + '</table>';

end;

function TForm_pop.create_net_guai(id: integer): boolean;
var c,d1: integer;
    t: cardinal;
     i: integer;
begin
     //怪物类型，一万以下表示本地怪，一万以上，表明高端是一个sid，负数，表明是一个小队id
    {
     用到一个函数，
     是获取多个怪的怪资料

     Tnet_guai=packed record
      sid: word;       //来自网络的怪，sid
      ming: integer;
      ti:   integer;
      ling: integer;
      shu:  integer;
      gong: integer;
      fang: integer;
      L_fang:word; //临时防护值
    }
    c:= 0;
    if (id > 0) and (id < 10000) then
     begin
       result:= false;
       exit;
     end;

    longrec(d1).Lo:= g_nil_user_c;
    longrec(d1).Hi:= g_nil_user_c;
      for i:= 0 to 4 do
        net_guai_g[i].sid:= g_nil_user_c;

    if id > 10000 then
     begin
       //载入一个怪资料  cmd 等于一，表示获取一个怪资料

        c:= 1;
       longrec(d1).Hi:= longrec(id).Hi;

     end else if id < 0 then
               begin
                 //载入一个小队的怪资料
                c:= 2; // 表示获取一个小队的怪资料
                d1:= abs(id);

               end;
    //发送数据，并等待怪资料返回
     screen.Cursor:= crhourglass;
    send_pak_tt(g_rep_guai_c,c,d1,0,my_s_id_g);

    t:= GetTickCount;
    while (Game_wait_ok1_g= false) and (GetTickCount -t < 10000) do
      begin
        application.ProcessMessages;
        sleep(10);
      end;
      screen.Cursor:= crdefault;
    if Game_wait_ok1_g and (game_wait_integer_g > 0) then
     begin
      //怪创建成功
      result:= true;
     end else  result:= false; //创建来自网络的怪失败
end;

procedure TForm_pop.net_cmd_center(c, d1, d2: integer; sid: word);
var i: integer;
begin
     //联网时，控制权命令接受中心
     //pk_zhihui_g.game_zt: integer;   //0场景状态，1，背单词，2挖矿，3采药，4，打坐，5比赛，6战斗
    if (game_player_head_G.duiwu_dg= 0) or (game_at_net_g= false)
      or (pk_zhihui_g.game_zt= 0) then
       exit;

    {
     data1，为1表示需要重新调度，为零表示获得了控制权
     有控制权时，弹出背单词窗口，如果背的不对，那么失去攻击的机会

     
     sid表示了获得控制权的sid，如果是自己获得了控制权，那么开始相应动作，如果是其他人获得了控制权，那么
     高亮相应人物

    }
   if d1= 1 then
    begin
      //重新调度
      net_cmd_send_center;
      exit;
    end;

   pk_zhihui_g.is_kongzhi:= (sid= my_s_id_g);

   //高亮人物
     i:= sid_to_roleId(sid);  //这里将同时设置倒计时需要的坐标
     if i >= 5 then
       highlight_guai_base(i -5)
      else
        highlight_my_base(i);

   //显示倒计时 队长的倒计时要多几秒，用于网络误差
    if game_player_head_G.duiwu_dg= 100 then
       Timer_daojishi.Tag:= 35
       else
         Timer_daojishi.Tag:= 30;
     Timer_daojishi.Enabled:= true;

   if pk_zhihui_g.is_kongzhi then
    begin
      //显示单词
      start_show_word(false);
    end;
end;

function TForm_pop.sid_to_roleId(sid: integer): integer;
var i: integer;
begin
     // 从sid转换为role或者guai的屏幕id 并同时设定倒计时的位置

result:= 0;



     text_show_array_G[5].peise:= $FF00887C;
      text_show_array_G[5].xiaoguo:= fxNone;


    //0--4，我方编号，5--9，敌方编号
    if sid= my_s_id_g then
     begin
      result:= 0;  //自己总是排在最前面的
      text_show_array_G[5].left1:= g_get_roleAndGuai_left(0) + game_bmp_role_width -9;
      text_show_array_G[5].top1:= g_C_role_top + 8;
      exit;
     end;

     if sid= (g_nil_user_c-11) then
     begin
      result:= -1;  //g_nil_user_c-11,总是转换为 -1
      text_show_array_G[5].left1:= g_get_roleAndGuai_left(0) + game_bmp_role_width -9;
      text_show_array_G[5].top1:= g_C_role_top + 8;
      exit;
     end;

       for i:= 0 to 4 do
        if net_guai_g[i].sid= sid then
         begin
          result:= i+ 5;
          text_show_array_G[5].left1:= g_get_roleAndGuai_left(result)+ game_bmp_role_width -9;
           text_show_array_G[5].top1:= g_C_guai_top+ game_bmp_role_h + 18;
          exit;
         end;

    if not game_at_net_g then
      begin
        result:= sid;
        exit; //如果不是在联网游戏，如果怪的sid没匹配 直接退出
      end;

      for i:= 0 to 3 do
        if game_player_head_G.duiyuan[i] =sid then
           result:= i+ 1;

     text_show_array_G[5].top1:= g_C_role_top + 8;
     text_show_array_G[5].left1:= g_get_roleAndGuai_left(result)+ game_bmp_role_width -9;
end;

procedure TForm_pop.Timer_daojishiTimer(Sender: TObject);
begin
  //倒计时
     text_show_array_G[5].xianshi:= true;
      Timer_daojishi.Tag:= Timer_daojishi.Tag -1;
       text_show_array_G[5].zhi:= inttostr(Timer_daojishi.Tag div 10);

      if time_list1.Timer_show_jit_word= -50 then //负100开始
       begin
         //再次显示英文
        draw_asw(jit_words,0);
        draw_asw('输入英文',3);
        time_list1.Timer_show_jit_alpha:= 0;
       end else if time_list1.Timer_show_jit_word< -50 then
                 begin
                   if time_list1.Timer_show_jit_alpha=1 then
                    begin
                     //-255..0..255  变暗
                     if time_list1.Timer_show_jit_word mod 10 = 0 then
                        draw_asw(game_word_1,0)  //显示中文
                        else if time_list1.Timer_show_jit_word mod 10 = -4 then
                                draw_asw(jit_words,0);

                       // inc(time_list1.Timer_show_jit_alpha);
                    end;

                 end;
      inc(time_list1.Timer_show_jit_word);

 if  Timer_daojishi.Tag<= 0 then
    begin
       text_show_array_G[5].xianshi:= false;   //超时发生，如果是队长，还需做重新分配控制权当事情
       Timer_daojishi.Enabled:= false;

     if not game_at_net_g then
     begin
      //本机，作为背单词失败，超时
       add_to_errorword_list(game_dangqian_word_id);
          edit1.Visible:= false;
         edit1.Text:= '';
       after_check_asw(false);

     end else begin
      pk_zhihui_g.is_kongzhi:= false;
      if pk_zhihui_g.is_zhihui then
        begin
          set_caoshi_list_value(game_player_head_G.kongzhiquan); //当前控制权的人物写入一次超时记录
          //重新调配
          net_cmd_send_center;
        end;
              end;
    end;
end;

function TForm_pop.roleId_to_sid(roleId: integer): integer;
begin
     // 从roleid转换为sid，0-4是我方id，5-9是敌方id

     if roleId in[5..9] then
       begin
       result:=  net_guai_g[roleId- 5].sid;
       exit;
       end;

     if not game_at_net_g then
      begin
        if roleId= -1 then
           result:= g_nil_user_c- 11
           else
            result:= roleid;
        exit; //如果不是在联网游戏，则直接退出
      end;

result:= g_nil_user_c;





    //0--4，我方编号，5--9，敌方编号
    if roleId= 0 then
     begin
      result:= my_s_id_g;  //自己总是排在最前面的
      exit;
     end else if roleId= -1 then
                 begin
                  result:= g_nil_user_c- 11;  //-1固定转换为此值
                  exit;
                 end;


    if roleId in[1..4] then
       result:= game_player_head_G.duiyuan[roleId-1];

end;

procedure TForm_pop.net_cmd_send_center; //联网时，命令发送中心
var sid: word;
begin
      {
       1.取得一个当前轮到的人物
       2。如果是自己，给于控制权，开始动作
       如果是别人，发送控制权指令
       4。如果是怪物（非实际玩家），直接计算出伤害值，然后发送动画指令
          并在动画结束后重新调度
       }

    if (game_player_head_G.duiwu_dg<> 0) and (game_player_head_G.duiwu_dg<> 100) then
       exit;  //既不是队长也不是自由模式，退出


  g_wo_guai_dangqian:=  game_p_list_ex; //得到轮到战斗的人物id，按速度排

      // 0--4，我方人员，5--9，敌方人员

     sid:= roleId_to_sid(g_wo_guai_dangqian); //取得当前的sid

     if sid < g_nil_user_c then
     begin
       {人物获得了控制权}
          net_cmd_center(0, 0, 0, sid); //人获得机会

      Data_net.send_game_kongzhi(0, 0, 0,sid); //发送控制权命令
     end else begin
               // 怪获得机会，直接计算出伤害值，然后发送动画

              end;

  write_label2_11; //排序显示
end;

{联网时动画指令接收}
procedure TForm_pop.net_rec_game_cmd(fq_sid: word;   //发起方sid
                                  js_sid: word;    //接受方（受攻击方）sid
                                  fq_m: integer;
                                  fq_t: integer;   //命体灵，发起方传送的是新值
                                  fq_l: integer;
                                  js_m: integer;   //接受方传送的是差值
                                  js_t: integer;
                                  js_l: integer;
                                  flag: word;    //类型，指名是0无动画，1，物理攻击，2法术攻击，3物品攻击，4物品恢复，5法术恢复，6,防7逃
                                  wu: word);
begin
//定时器停止，开始动画
   Timer_daojishi.Enabled:= false;
   text_show_array_G[5].xianshi:= false;
   //***************************************
        //highlight_my(p); //加亮人物

   //***************************************

 //动画结束后，如果是指挥，那么发出重新调度指令 ?可能要写在别的地方
    if pk_zhihui_g.is_zhihui then
          net_cmd_send_center;
end;

procedure TForm_pop.gong_js(f, j,w: integer;guai: boolean); //我方攻击，计算出攻击参数
var x: Tmtl_rec;
    q,q2,fh: integer;
begin
   {
    计算攻击的伤害值，f表示发起id，J表示被攻击方id
    w表示物品编号
    guai为true，表示是计算怪物的攻击力

    设定攻击方的新值和被攻击方的差值
    动画开始时设定新值，动画结束后设定差值
   }
  // 顺序id转为sid
    mtl_game_cmd_dh1.flag:= 0;
    mtl_game_cmd_dh1.fq_sid:= roleId_to_sid(f);
    mtl_game_cmd_dh1.js_sid:= roleId_to_sid(j);
    // mtl_game_cmd_dh1.flag:= 该值在之前的过程内被设定
    mtl_game_cmd_dh1.wu:= w;   //物品类型

     f_time_role_id:= j;
     

    if guai then
    begin
      if j= -1 then  //如果是群攻，那么获取一个随机id来取得防护值
     fh:= get_r_role_id
     else
      fh:= j;
     x:=game_get_Attack_value(game_guai_xishu_f,w);  //取得怪方攻击力 参数为攻击类型（并设定怪方新值）
     q2:= game_read_values(get_pid_from_showId(fh),ord(g_defend)) * game_read_values(get_pid_from_showId(fh),ord(g_linshifang)); //防护值

    end else begin
              x:= game_get_my_Attack_value(w);  //取得我方攻击力 参数为攻击类型（并设定我方新值）
              if j= -1 then  //如果是群攻，那么获取一个随机id来取得防护值
               fh:= get_min_guai_f
               else
                 fh:= j;
               if fh >= 5 then
                  fh:= fh -5;
              q2:= net_guai_g[fh].fang + net_guai_g[f].L_fang;
              
             end;


              {由于返回的数据为负数，所以，防护值是加上去
              这里，防护只对命值起作用}
               if x.m.Lo<> 0 then
               q:= round((q2 / abs(x.m.Lo) + 1) * 10)
               else q:= 2; //防护系数
            
            game_guai_fanghu_xishu_f:= Game_base_random(q);
            if game_guai_fanghu_xishu_f > 10 then
               x.m.Lo:= x.m.Lo + q2
                else
                 x.m.Lo:= x.m.Lo + (q2 div (5+ Game_base_random(6)));

            if x.m.Lo > 0 then
              x.m.Lo:= 0;
          with mtl_game_cmd_dh1 do  //设定差值
          begin
          js_m:=      x.m.Lo;
          js_t:=      x.t.Lo;
          js_l:=      x.l.Lo;
          js_g:=   x.m.Hi;
          js_f:=   x.t.Hi;
          js_shu:=    x.l.Hi;
          end;


end;

procedure TForm_pop.huifu_js(f, j, w: integer);   //计算恢复值
     procedure add_blood(p2: integer; kk: integer;ll: boolean);      //恢复术内嵌过程
        var t2:Tplayer;
            j2: integer;
        begin
          t2:= game_get_role_from_i(p2);
           if t2= nil then
            exit;
                                  //对于全满和半满的，不管等级，都不打折

                                  j2:= data2.get_game_goods_type(w,goods_m1);

                                  if t2.plvalues[ord(g_life)] <= 0 then
                                   if j2< game_m_ban_qi then
                                     exit;  //命值小于8个9，不能起死回生，退出

                                if (j2= game_m_quan_qi) or (j2=game_m_quan) then
                                   j2:= t2.plvalues[ord(g_gdsmz27)]
                                    else if (j2= game_m_ban_qi) or (j2=game_m_ban) then
                                         j2:= t2.plvalues[ord(g_gdsmz27)] div 2
                                          else j2:= j2 * (kk+10) div 10 + t2.plvalues[ord(g_life)];

                               if j2 > t2.plvalues[ord(g_gdsmz27)] then
                                  j2:= t2.plvalues[ord(g_gdsmz27)];
                                 // 27 生命值 100
                                {修改为在统一的数组内的差值
                               game_show_blood(true,j2- t2.plvalues[ord(g_life)],p2,1);
                                t2.plvalues[ord(g_life)]:= j2;
                                G_game_delay(500); //飘动时间 }
                                mtl_game_cmd_dh1.js_m:=j2- t2.plvalues[ord(g_life)];

                              j2:= data2.get_game_goods_type(w,goods_t1);
                                if (j2= game_m_quan_qi) or (j2=game_m_quan) then
                                   j2:= t2.plvalues[ord(g_gdtl25)]
                                    else if (j2= game_m_ban_qi) or (j2=game_m_ban) then
                                         j2:= t2.plvalues[ord(g_gdtl25)] div 2
                                          else j2:= j2 * (kk+10) div 10 + t2.plvalues[ord(g_tili)];

                               if j2 > t2.plvalues[ord(g_gdtl25)] then
                                  j2:= t2.plvalues[ord(g_gdtl25)];
                                  //增加体力
                                 //飘动，飘动方向，false向下，飘动的值，人物id，类型（1血，二体力，三灵力）
                               { game_show_blood(true,j2-t2.plvalues[ord(g_tili)],p2,2);
                                 t2.plvalues[ord(g_tili)]:= j2;
                                G_game_delay(500); //飘动时间  }
                                   mtl_game_cmd_dh1.js_t:=j2- t2.plvalues[ord(g_tili)];
                                if ll then
                                begin
                                j2:= data2.get_game_goods_type(w,goods_L1);
                                if (j2= game_m_quan_qi) or (j2=game_m_quan) then
                                   j2:= t2.plvalues[ord(g_gdll26)]
                                    else if (j2= game_m_ban_qi) or (j2=game_m_ban) then
                                         j2:= t2.plvalues[ord(g_gdll26)] div 2
                                          else j2:= j2 * (kk+10) div 10 + t2.plvalues[ord(g_lingli)];
                               if j2 > t2.plvalues[ord(g_gdll26)] then
                                  j2:= t2.plvalues[ord(g_gdll26)];
                                 // 26 灵力 0
                              { game_show_blood(true,j2-t2.plvalues[ord(g_lingli)],p2,3);
                                t2.plvalues[ord(g_lingli)]:= j2; }
                                mtl_game_cmd_dh1.js_l:=j2- t2.plvalues[ord(g_lingli)];
                                end; //恢复灵力

        end;
var i,k,k2: integer;
    label pp;
begin
   //参数为恢复发起者，恢复接受者，恢复类型，这过程仅限于我方发起的恢复，怪的恢复不在这里
   //判断是物品恢复还是法术恢复，扣除物品数量，扣除法术消耗的灵力
   //p等于-1，表示全体恢复

   {恢复术的计算过程
   恢复术的动画过程}
    mtl_game_cmd_dh1.flag:= 0;
   mtl_game_cmd_dh1.fq_sid:= roleId_to_sid(f);
    mtl_game_cmd_dh1.js_sid:= roleId_to_sid(j);
    // mtl_game_cmd_dh1.flag:= 该值在之前的过程内被设定
    mtl_game_cmd_dh1.wu:= w;   //物品类型

    //在物品定时器内使用的变量，0-4，我方人物，5-9，敌方人物
        f_time_role_id:= j;
        if j >= 5 then
           j:= j -5;

      with mtl_game_cmd_dh1 do
      begin
      fq_m:= game_read_values(get_pid_from_showId(f),ord(g_life));
      fq_t:= game_read_values(get_pid_from_showId(f),ord(g_tili));
      fq_l:= game_read_values(get_pid_from_showId(f),ord(g_lingli));
      js_g:= 0;
      js_f:= 0;
      js_shu:= 0;
      end;

               k:= game_fashu__filter(w); //取得等级，并处理编号类型
             i:= data2.get_game_goods_type(w,goods_type1); //取得类型
               if i and 128= 128 then
                begin
                //法术恢复，扣除恢复发起者灵力
                 //扣除灵力
              //   if f=j then //如果是同一个人，则扣除双倍灵力，因为会恢复一部分
               //   mtl_game_cmd_dh1.fq_l:= mtl_game_cmd_dh1.fq_l- data2.get_game_goods_type(w,goods_L1) *2
               //  else
                 mtl_game_cmd_dh1.fq_l:= mtl_game_cmd_dh1.fq_l- data2.get_game_goods_type(w,goods_L1);



                 //增加受益者相应的值，包括命，体
                 if j= -1 then
                  begin
                     //***********************************************************
                    {for i2:= 0 to 4 do
                       add_blood(i2,k,false); 全体回复的，做一个统一值}
                       k2:= data2.get_game_goods_type(w,goods_m1);
                                if (k2= game_m_quan_qi) or (k2=game_m_quan) then
                                   mtl_game_cmd_dh1.js_m:= 32767   //全满
                                    else if (k2= game_m_ban_qi) or (k2=game_m_ban) then
                                        mtl_game_cmd_dh1.js_m:= 32766 //半满
                                          else mtl_game_cmd_dh1.js_m:= k2 * (k+10) div 10;
                              k2:= data2.get_game_goods_type(w,goods_t1);
                                if (k2= game_m_quan_qi) or (k2=game_m_quan) then
                                    mtl_game_cmd_dh1.js_t:= 32767
                                    else if (k2= game_m_ban_qi) or (k2=game_m_ban) then
                                         mtl_game_cmd_dh1.js_t:= 32766
                                          else mtl_game_cmd_dh1.js_t:= k2 * (k+10) div 10;
                                mtl_game_cmd_dh1.js_l:= 0; //灵力增加等于零
                    //************************************************************
                  end else add_blood(j,k,false);
                end else if (i and 2= 2) or (i and 256= 256) then
                          begin

                            //扣除物品数量，且物品都是单体恢复
                            if read_goods_number(w)> 0 then
                                write_goods_number(w,-1)
                                else
                                  goto pp;

                            //攻击类物品，除返回直接攻击值外，还要定时

                                if game_read_values(get_pid_from_showId(j),ord(g_life)) <= 0 then
                                   if data2.get_game_goods_type(w,goods_m1)< game_m_ban_qi then
                                     goto pp;  //物品命值小于8个9，不能起死回生，退出
                                  { 下面这些值在定时器过滤器内获得
                               t.plvalues[1]:=t.plvalues[1]+ data2.get_game_goods_type(d,goods_y1);  //幸运值
                               t.plvalues[2]:=t.plvalues[2]+ data2.get_game_goods_type(d,goods_s1);   //2。速度
                               t.plvalues[3]:=t.plvalues[3]+ data2.get_game_goods_type(d,goods_g1);  // 3。攻击力
                               t.plvalues[7]:=t.plvalues[7]+ data2.get_game_goods_type(d,goods_z1);   //7。智力
                               t.plvalues[20]:=t.plvalues[20]+ data2.get_game_goods_type(d,goods_f1);  // 20。防护值
                                                                 }

                               add_blood(j,0,true); //增加体，灵，命第二个参数为零，表示没有附加的等级
                               pp: time_list1.Timer_wupin_huifu:= true;
                           if data2.get_game_goods_type(w,goods_n1)<>0 then
                              begin
                                //安插定时器
                                game_add_to_goods_time_list(w);
                              end;
                          end;


end;

procedure TForm_pop.huifu_donghua;  //恢复时动画
var t2: Tplayer;
    fq1,js1,i: integer;
     function can_show(i88: integer): boolean;
      begin
       result:= true;
        t2:= game_get_role_from_i(i88); //取得接受者实例，并增加命体灵
               if t2<> nil then
                begin
                 if (js1= -1) and (t2.plvalues[ord(g_life)]<= 0) then
                    result:= false;
                 end else result:= false;
      end;
      procedure add_mtl(i88: integer);
      var m: smallint;
      begin
       t2:= game_get_role_from_i(i88); //取得接受者实例，并增加命体灵
               if t2<> nil then
                begin
                 if (js1= -1) and (t2.plvalues[ord(g_life)]<= 0) then
                    exit;

                 if  mtl_game_cmd_dh1.js_m = 32767 then
                     m:= t2.plvalues[ord(g_gdsmz27)]
                     else if mtl_game_cmd_dh1.js_m = 32766 then
                        m:= t2.plvalues[ord(g_gdsmz27)] div 2
                        else m:= mtl_game_cmd_dh1.js_m;
                 t2.plvalues[ord(g_life)]:= t2.plvalues[ord(g_life)] +m;
                  if t2.plvalues[ord(g_life)] > t2.plvalues[ord(g_gdsmz27)] then
                     t2.plvalues[ord(g_life)]:= t2.plvalues[ord(g_gdsmz27)];

                 if  mtl_game_cmd_dh1.js_t = 32767 then
                     m:= t2.plvalues[ord(g_gdtl25)]
                     else if mtl_game_cmd_dh1.js_t = 32766 then
                        m:= t2.plvalues[ord(g_gdtl25)] div 2
                        else m:= mtl_game_cmd_dh1.js_t;
                 t2.plvalues[ord(g_tili)]:= t2.plvalues[ord(g_tili)] +m;
                    if t2.plvalues[ord(g_tili)] > t2.plvalues[ord(g_gdtl25)] then
                     t2.plvalues[ord(g_tili)]:= t2.plvalues[ord(g_gdtl25)];

                 if  mtl_game_cmd_dh1.js_l = 32767 then
                     m:= t2.plvalues[ord(g_gdll26)]
                     else if mtl_game_cmd_dh1.js_l = 32766 then
                        m:= t2.plvalues[ord(g_gdll26)] div 2
                        else m:= mtl_game_cmd_dh1.js_l;
                 t2.plvalues[ord(g_lingli)]:= t2.plvalues[ord(g_lingli)] +m;
                    if t2.plvalues[ord(g_lingli)] > t2.plvalues[ord(g_gdll26)] then
                     t2.plvalues[ord(g_lingli)]:= t2.plvalues[ord(g_gdll26)];
                end;
      end;
begin
     {恢复的情况，包括
     1。单机时，我方人物恢复
     2。单机时，怪恢复
     3。联网时，我方人物恢复
     4。联网时，怪恢复
      怪物总是有sid，我方人物在不联网时没有sid
     }
     
     game_pic_check_area:= G_all_Pic_n;
    G_DanTiWuPinHuiFu.time:= Game_amt_length;
    G_DanTifashuHuiFu.time:= Game_amt_length;
    G_quanTiFaShuHuiFu.time:= Game_amt_length;
    
    fq1:= sid_to_roleId(mtl_game_cmd_dh1.fq_sid);
    js1:= sid_to_roleId(mtl_game_cmd_dh1.js_sid);

         if fq1>= 5 then
          highlight_guai(fq1-5)
          else
            highlight_my(fq1); //加亮人物

         if js1>= 5 then
          highlight_guai(js1-5)
          else  if js1= -1 then
                begin
                     highlight_my(js1);
                end else
                 highlight_my(js1); //加亮人物



   //   动画激活
   if js1=-1 then
    time_list1.Timer_fashu_huifu:= true
   else
   time_list1.Timer_wupin_huifu:= true;

    if js1= -1 then
     begin
      for i:= 0 to 4 do
        if can_show(i) then
           game_show_blood(true,mtl_game_cmd_dh1.js_m,i,1);
     end else
       game_show_blood(true,mtl_game_cmd_dh1.js_m,js1,1);
    G_game_delay(500); //飘动时间
      //增加体力
   //飘动，飘动方向，false向下，飘动的值，人物id，类型（1血，二体力，三灵力）
  if js1= -1 then
     begin
      for i:= 0 to 4 do
        if can_show(i) then
        game_show_blood(true,mtl_game_cmd_dh1.js_t,i,1);
     end else
  game_show_blood(true,mtl_game_cmd_dh1.js_t,js1,2);
    G_game_delay(500); //飘动时间
  // 26 灵力 0
    if js1= -1 then
     begin
      for i:= 0 to 4 do
        if can_show(i) then
        game_show_blood(true,mtl_game_cmd_dh1.js_l,i,1);
     end else
   game_show_blood(true,mtl_game_cmd_dh1.js_l,js1,3);

   //修改值
  if fq1>= 5 then
   begin
    //大于等于5的，表示怪
    fq1:= fq1-5;
    net_guai_g[fq1].ming:= mtl_game_cmd_dh1.fq_m;
    net_guai_g[fq1].ti:= mtl_game_cmd_dh1.fq_t;
    net_guai_g[fq1].ling:= mtl_game_cmd_dh1.fq_l;

   end else begin
               t2:= game_get_role_from_i(fq1); //取得发起者实例，并增加命体灵
               if t2<> nil then
                begin
                 t2.plvalues[ord(g_life)]:= mtl_game_cmd_dh1.fq_m;
                 t2.plvalues[ord(g_tili)]:= mtl_game_cmd_dh1.fq_t;
                 t2.plvalues[ord(g_lingli)]:= mtl_game_cmd_dh1.fq_l;
                end;
            end;

   if js1>= 5 then
   begin
    //大于等于5的，表示怪
    net_guai_g[js1-5].ming:= net_guai_g[js1-5].ming + mtl_game_cmd_dh1.js_m;
    net_guai_g[js1-5].ti:= net_guai_g[js1-5].ti     + mtl_game_cmd_dh1.js_t;
    net_guai_g[js1-5].ling:= net_guai_g[js1-5].ling + mtl_game_cmd_dh1.js_l;

   end else begin
               if js1=-1 then
                begin
                for i:= 0 to 4 do
                   add_mtl(i);
                end else add_mtl(js1);

            end;

  draw_game_role(-1); //重画
end;

function TForm_pop.game_get_role_from_sid(i: integer): Tplayer;
var j: integer;
begin

result:= nil;
  for j:= 0 to Game_role_list.Count-1 do
    begin
     if Assigned(Game_role_list.Items[j]) then
      if Tplayer(Game_role_list.Items[j]).plvalues[34]= i then
       begin
        result:= Tplayer(Game_role_list.Items[j]);
        exit;
       end;
    end;

end;

function TForm_pop.get_comp_word: boolean;
    var ss: string;
     begin
     result:= false;

     case jit_tmp_3 of
      0: ss:= game_word_1;
      1: ss:= game_word_2;
      2: ss:= game_word_3;
     end;

      if (comparetext(trim(edit1.Text),trim(jit_words))=0) or (comparetext(trim(edit1.Text),trim(ss))=0) then
         begin
          if (edit1.Text<>'') and (edit1.Text[1]=' ') then
             add_to_errorword_list(game_dangqian_word_id); //作为生词，添加到错误列表
         result:= true;
         end else begin
                if length(edit1.Text) >= 20 then
                  begin
                    if ByteType(edit1.Text,1)= mbLeadByte then
                      begin
                        //如果是中文
                        exit;
                       { if (pos(edit1.Text,ss)> 0) or (pos(edit1.Text,jit_words)> 0) then
                           result:= true; }
                      end else if (pos(edit1.Text,ss)> 0) or (pos(edit1.Text,jit_words)> 0) then
                           result:= true;
                  end;
              end;
end;

procedure TForm_pop.Edit1Change(Sender: TObject);
    
begin
   {1。如果等于单词或者等于正确答案的，那么胜利，并退出
   2。否则，比较是否匹配部分答案
   3。
   }

   if game_bg_music_rc_g.type_char_spk and (edit1.Text<> '') then
     begin
       form1.game_spk_string(edit1.Text[length(edit1.Text)]);
     end;

     if edit1.Visible and get_comp_word then
        begin
         edit1.Visible:= false;
         text_show_array_G[5].xianshi:= false;
         Timer_daojishi.Enabled:= false;
         if game_bg_music_rc_g.type_char_spk then
            form1.game_spk_string(edit1.Text);
            
         edit1.Text:= '';
         draw_asw(game_word_1,2);
         after_check_asw(true);
        end else begin
                    if game_bg_music_rc_g.type_word_flash then
                     begin
                      time_list1.Timer_show_jit_word:= -100;
                      time_list1.Timer_show_jit_alpha:=1;
                       draw_asw('5秒后可再次显示单词',3);
                     end else begin
                                time_list1.Timer_show_jit_word:= -80;
                                time_list1.Timer_show_jit_alpha:=0;
                                 draw_asw(game_word_1,0); //显示中文
                                 draw_asw('3秒后可再次显示单词',3);
                              end;
                 

                 end;
end;

procedure TForm_pop.ActionList1Execute(Action: TBasicAction;
  var Handled: Boolean);
  var c: string;
begin
    c:= lowercase(ShortCutToText((action as Taction).ShortCut));
    if edit1.Visible and (length(c)=1) then
     begin
       edit1.SelText:= c[1];
       Handled:= true;
     end else begin
                //如果是填空模式，且快捷键值等于正确答案的首字母，那么确认此值
                 if g_tiankong then
                  begin
                   if (game_word_1<> '') and (upcase(game_word_1[1])=upcase(c[1])) then
                    begin
                     Handled:= true;
                     Action6Execute(self);
                    end;
                   if (game_word_2<> '') and (upcase(game_word_2[1])=upcase(c[1])) then
                    begin
                     Handled:= true;
                     Action7Execute(self);
                    end;
                   if (game_word_3<> '') and (upcase(game_word_3[1])=upcase(c[1])) then
                    begin
                     Handled:= true;
                     Action9Execute(self);
                    end;
                  end;
              end;
end;

procedure TForm_pop.HandleCTLColorEdit(var Msg: TWMCTLCOLOREDIT);
begin
    if Msg.ChildWnd = Edit1.Handle then
    begin
     SetBkMode(Msg.ChildDC, TRANSPARENT);
     Msg.Result := integer(Edit1.Brush.Handle);    //强制转换
    end;
end;

procedure TForm_pop.create_edit_bmp(s: string);
begin
       //给edit 贴个地图
         //edit 底图 edit1.Brush.Bitmap:=

{ if Assigned(game_edit1_bmp) then
      game_edit1_bmp.Free;
   //  begin

        game_edit1_bmp:= Tbitmap.Create;
        game_edit1_bmp.Width:= edit1.ClientWidth;
        game_edit1_bmp.Height:= edit1.ClientHeight;
        game_edit1_bmp.Canvas.Font.Color:= clsilver;
        game_edit1_bmp.Canvas.Font.Name:= '宋体';
        game_edit1_bmp.Canvas.Font.Size:= 10;
   //  end;

     game_edit1_bmp.Canvas.FillRect(rect(0,0,game_edit1_bmp.width,game_edit1_bmp.Height));

        game_edit1_bmp.Canvas.TextOut(48,6,s);

     edit1.Brush.Bitmap:= game_edit1_bmp;  }

end;

procedure TForm_pop.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    edit1.Repaint;
end;

procedure TForm_pop.set_Action_az;
var st: Tshortcut;
    i: integer;
    b: boolean;
begin
    Action_az1.ShortCut:= 0;
    Action_az2.ShortCut:= 0;
    Action_az3.ShortCut:= 0;

    if g_tiankong then
     begin

       if game_word_1<> '' then
        begin
         st:= TextToShortCut(upcase(game_word_1[1]));
         b:= false;
          for i:= 0 to ActionList1.ActionCount -1 do
              if TAction(ActionList1.Actions[i]).ShortCut= st then
                 b:= true;
          if not b then
             Action_az1.ShortCut:= st;
        end;
       if game_word_2<> '' then
          begin
         st:= TextToShortCut(upcase(game_word_2[1]));
         b:= false;
          for i:= 0 to ActionList1.ActionCount -1 do
              if TAction(ActionList1.Actions[i]).ShortCut= st then
                 b:= true;
          if not b then
             Action_az2.ShortCut:= st;
        end;
       if game_word_3<> '' then
          begin
         st:= TextToShortCut(upcase(game_word_3[1]));
         b:= false;
          for i:= 0 to ActionList1.ActionCount -1 do
              if TAction(ActionList1.Actions[i]).ShortCut= st then
                 b:= true;
          if not b then
             Action_az3.ShortCut:= st;
        end;
     end;
end;

procedure TForm_pop.Action_az1Execute(Sender: TObject);
begin
  //动态快捷键 空的过程
end;

procedure TForm_pop.Action_az2Execute(Sender: TObject);
begin
    ////动态快捷键 空的过程
end;

procedure TForm_pop.Action_az3Execute(Sender: TObject);
begin
   ////动态快捷键 空的过程
end;

procedure bubble_path_to_xy;   //根据角度和路径长度计算出新的坐标点
var hd: single;  //弧度
begin
   hd:= 90- abs(bubble_data1.arrow_Angle); //先算出角度

   if bubble_data1.start_X<= 0 then
    begin
     //球碰到了左边墙壁
      hd:= 90- hd; //算出法线后的角度
      hd:= hd * pi /180; //获得弧度
      bubble_data1.boll_top:= round(cos(hd) * bubble_data1.boll_path_length);
      bubble_data1.boll_top:= bubble_data1.start_Y- bubble_data1.boll_top;

       bubble_data1.boll_left:= round(sin(hd) * bubble_data1.boll_path_length);
       bubble_data1.boll_left:= bubble_data1.start_X + bubble_data1.boll_left;

    end else if bubble_data1.start_X>= 640 then
              begin
                //球碰到了右边墙壁
                hd:= 90- hd; //算出法线后的角度
                hd:= hd * pi /180; //获得弧度
                 bubble_data1.boll_top:= round(cos(hd) * bubble_data1.boll_path_length);
                 bubble_data1.boll_top:= bubble_data1.start_Y- bubble_data1.boll_top;

                  bubble_data1.boll_left:= round(sin(hd) * bubble_data1.boll_path_length);
                  bubble_data1.boll_left:= bubble_data1.start_X - bubble_data1.boll_left;

              end else begin
                         //原始原点
                        
                        hd:= hd * pi /180; //获得弧度

                         bubble_data1.boll_top:= round(sin(hd) * bubble_data1.boll_path_length);
                         bubble_data1.boll_top:= bubble_data1.start_Y- bubble_data1.boll_top;

                          bubble_data1.boll_left:= round(cos(hd) * bubble_data1.boll_path_length);
                          if bubble_data1.arrow_Angle < 0 then
                             bubble_data1.boll_left:= bubble_data1.start_X - bubble_data1.boll_left
                             else
                              bubble_data1.boll_left:= bubble_data1.start_X + bubble_data1.boll_left;
                       end;

  dec(bubble_data1.boll_top,16); //减去16是因为这个点是球心
   dec(bubble_data1.boll_left,16);

end;

procedure ball_at_left_right(L: integer=16);  //球是否运行到边缘检测  g_boll_21_cn
//var x: integer;
begin

  // x:= (bubble_data1.boll_left+ L) div g_boll_w_cn; //重算x值，不考虑奇偶行
   if (bubble_data1.boll_left<= L) or (bubble_data1.boll_left>=(640-L*2)) then
     begin
       //重设原点和长度
       if (bubble_data1.start_X<> 0) and (bubble_data1.start_X<> 640) then
        begin
       bubble_data1.start_Y:= bubble_data1.boll_top; //指针原点
       

       if (bubble_data1.boll_left<= L) then
       bubble_data1.start_X:= 0
       else  begin
              bubble_data1.start_X:= 640;
             // l:= l* 2;
             end;
       if l<= 0 then
         bubble_data1.start_Y:= bubble_data1.start_Y + 16;
      //球位置移动到箭头
       bubble_data1.boll_path_length:= L; //轨迹长度
        end;
     end;
end;

procedure TForm_pop.show_bubble_on_scr;  //显示泡泡龙到屏幕
var r: Trect;
    i,j: integer;
begin
  {位置信息：包括颜色球索引，为零的不显示，宽和高}
  {bubble_boll_g_array,0..3byte，3表示颜色球索引，1表示宽，2表示高，0表示是否处于同色统计内}
  for i:= 0 to g_boll_14_cn do
    for j:= 0 to g_boll_21_cn do
     begin
      if LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0 then
        begin
          r.Left:= j * g_boll_w_cn + ((i mod 2) * g_boll_w_cn div 2);
          r.Top:= i * g_boll_h_cn;
          r.Right:= r.Left + LongRec(bubble_boll_g_array[i,j]).Bytes[1];
          r.Bottom:=r.Top + LongRec(bubble_boll_g_array[i,j]).Bytes[2];
          AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'], r,$FFFFFFFF, LongRec(bubble_boll_g_array[i,j]).Bytes[3]-1, fxBlendNA);
        end;
     end;

  AsphyreCanvas1.Draw(image_bubble, 256,416, 0, fxBlend); //画出泡泡发射台
  //画出发射台上的泡泡
    AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'], rect(271,433,303,465)
    ,$FFFFFFFF,bubble_data1.next_color, fxBlendNA); //此处color没有减去一

   //画出横线
   AsphyreCanvas1.Line(0,390,640,390,$FF1E90DF,$FF1E90DF,fxNone);
    if (g_dangqian_zhuangtai= g_bubble)  and (bubble_data1.dot_line_count<= 0) then
     begin
       //画出瞄准线
       bubble_data1.start_X:= 336;
       bubble_data1.start_Y:= 432; //指针原点
       bubble_data1.boll_path_length:= 22;
       while true do
        begin
          
          bubble_path_to_xy;

          i:= (bubble_data1.boll_top+ g_boll_h_cn div 2) div g_boll_h_cn;
             if i mod 2=0 then
                j:= (bubble_data1.boll_left+ g_boll_w_cn div 2) div g_boll_w_cn
                else
                 j:= bubble_data1.boll_left div g_boll_w_cn; //奇数行
         if boll_can_stk(i,j,bubble_data1.boll_left mod g_boll_w_cn)
           or (bubble_data1.boll_path_length> 640) then
            break; //可停靠时中断

           ball_at_left_right(0); //检测是否运行到边缘，球
          inc(bubble_data1.boll_left,16);
          inc(bubble_data1.boll_top,16);
         AsphyreCanvas1.PutPixel(bubble_data1.boll_left,bubble_data1.boll_top,$FFFFFFFF,fxnone);
         inc(bubble_data1.boll_path_length,2);
        end;
     end;

   //画出运行中的泡泡
  if bubble_data1.boll_show then
   begin
      with r do
       begin
       Left:= bubble_data1.boll_left;
       Top:= bubble_data1.boll_top;
       Right:= Left + 32;
       Bottom:=Top + 32;
       end;
    AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'], r,$FFFFFFFF, bubble_data1.boll_color -1, fxBlendNA);

   end;

  //画出指针
  AsphyreCanvas1.DrawRot(imgae_arrow,336,432,bubble_data1.arrow_Angle * pi /180,1,$FFFFFFFF, 0, fxBlendNA);

 {image_bubble) then
     image_bubble.Free;
  if assigned(imgae_arrow}
end;

procedure TForm_pop.Action22Execute(Sender: TObject);
begin
   //left
  if g_dangqian_zhuangtai= g_bubble then
   begin
    show_text(false,'');
    if bubble_data1.arrow_Angle > -70 then
       bubble_data1.arrow_Angle:= bubble_data1.arrow_Angle-7;
   end;
end;

procedure TForm_pop.Action23Execute(Sender: TObject);
begin
    //right
   if g_dangqian_zhuangtai= g_bubble then
   begin
      show_text(false,'');
     if bubble_data1.arrow_Angle < 70 then
       bubble_data1.arrow_Angle:= bubble_data1.arrow_Angle+7;
   end;
end;


procedure TForm_pop.Action24Execute(Sender: TObject);
begin
   //up 发球

  if g_dangqian_zhuangtai= g_bubble then
   begin
     if bubble_data1.dot_line_count> 0 then
       dec(bubble_data1.dot_line_count);
     g_dangqian_zhuangtai:= g_boll_move; //进入球运行状态
     if gamesave1.tip5= 0 then
       play_sound(1);

     dec(bubble_data1.sycs); //剩余发球数量减去一
     bubble_data1.boll_color:= bubble_data1.next_color+1; //next color是以零为最小数的，所以需要加一
     bubble_data1.next_color:= Random(7); //待发射球换新
     bubble_data1.start_X:= 336;
     bubble_data1.start_Y:= 432; //指针原点
      //球位置移动到箭头
       bubble_data1.boll_path_length:= 48; //轨迹长度
       //计算球坐标
       bubble_path_to_xy;
     bubble_data1.zt:= 0; //状态，0表示球移动，1表示球消失
     bubble_data1.boll_show:= true;
     time_list1.Timer_bubble:= true;
   end;
end;

procedure TForm_pop.Timer_bubbleTimer;  //泡泡龙，球动画
         procedure boll_xuankong(y,x: integer);
          begin   //检测悬空球
           if LongRec(bubble_boll_g_array[y,x]).Bytes[0]= 3 then
              exit
              else LongRec(bubble_boll_g_array[y,x]).Bytes[0]:= 3;
           if y= 0 then  //判断顶行
             begin
               if x= 0 then
                begin
                 if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]>0 then
                    boll_xuankong(y,x+1);
                 if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]>0 then
                    boll_xuankong(y+1,x);
                end else if x= g_boll_21_cn then
                           begin
                            if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]>0 then
                               boll_xuankong(y,x-1);
                            if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]>0 then
                               boll_xuankong(y+1,x-1);
                           end else begin
                                     if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]>0  then
                                        boll_xuankong(y,x+1);
                                     if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]>0  then
                                        boll_xuankong(y,x-1);
                                     if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]>0  then
                                        boll_xuankong(y+1,x);
                                     if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]>0 then
                                        boll_xuankong(y+1,x-1);
                                    end;
             end else begin //*********************************判断中间行的球
                        if x= 0 then
                         begin
                           if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]>0 then
                              boll_xuankong(y-1,x);  //上行同一列
                           if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]>0 then
                              boll_xuankong(y+1,x);  //下同
                           if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]>0 then
                              boll_xuankong(y,x+1);   //向右
                           if y mod 2=1 then
                            begin //奇数行，多判断两个
                             if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]>0 then
                              boll_xuankong(y-1,x+1);  //上行向右
                             if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]>0 then
                              boll_xuankong(y+1,x+1);  //下右
                            end;
                         end else if x= g_boll_21_cn then  //右边的球
                               begin
                                  if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]>0 then
                                     boll_xuankong(y,x-1);   //向前
                                  if y mod 2=0 then
                                  begin                //偶数行
                                  if LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3]>0 then
                                     boll_xuankong(y-1,x-1);  //上小
                                  if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]>0 then
                                     boll_xuankong(y+1,x-1);  //下小
                                  end else
                                    begin //奇数行，
                                    if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]>0 then
                                     boll_xuankong(y-1,x+1);  //上行向右
                                    if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]>0 then
                                     boll_xuankong(y+1,x+1);  //下右
                                    if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]>0 then
                                     boll_xuankong(y-1,x);  //上同
                                    if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]>0 then
                                     boll_xuankong(y+1,x);  //下同
                                    end;
                               end else begin  //中间的球
                                          if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]>0 then
                                             boll_xuankong(y-1,x);  //上行同一列
                                          if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]>0 then
                                             boll_xuankong(y+1,x);  //下同
                                          if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]>0 then
                                             boll_xuankong(y,x+1);   //向右
                                           if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]>0 then
                                             boll_xuankong(y,x-1);   //向左
                                            if y mod 2= 0 then
                                             begin
                                             if LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3]>0 then
                                             boll_xuankong(y-1,x-1);  //上小
                                            if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]>0 then
                                             boll_xuankong(y+1,x-1);  //下小
                                             end else begin
                                            if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]>0 then
                                             boll_xuankong(y-1,x+1);  //上行大
                                            if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]>0 then
                                             boll_xuankong(y+1,x+1);  //下大
                                                      end;
                                        end;
                      end;

          end; //procedure
         procedure boll_to_grid;
          var x,y: integer;
          begin
             //对齐到网格，并检测是否可以停靠，是否需要转向
             //如果球的边缘大于4点 and 小于26，为无效位置

            y:= (bubble_data1.boll_top+ g_boll_h_cn div 2) div g_boll_h_cn;
             if y mod 2=0 then
                x:= (bubble_data1.boll_left+ g_boll_w_cn div 2) div g_boll_w_cn
                else
                 x:= bubble_data1.boll_left div g_boll_w_cn; //奇数行

            if boll_can_stk(y,x,bubble_data1.boll_left mod g_boll_w_cn) then
              begin
               bubble_data1.boll_show:= false;
               longrec(bubble_boll_g_array[y,x]).Bytes[3]:= bubble_data1.boll_color;
               LongRec(bubble_boll_g_array[y,x]).Bytes[1]:= 32;
               LongRec(bubble_boll_g_array[y,x]).Bytes[2]:= 32;
               bubble_data1.last_y:= y;
               bubble_data1.last_x:= x;
               if y= g_boll_14_cn then
                begin  //游戏结束*******************************************************************
                 show_text(true,'游戏结束！');
                 if gamesave1.tip5= 0 then
                     play_sound(15);

                 g_dangqian_zhuangtai:= g_end;
                 inc(bubble_data1.sycs); //使用次数加一，用于阻止出现背单词
                 G_game_delay(2000);
                 self.ModalResult:= mrcancel;
                end else
                     bubble_data1.zt:= 1; //进入是否消失检测

              end else begin
                         //球是否运行到边缘检测  g_boll_21_cn
                         ball_at_left_right;
                       end;
          end; //end procedure
          procedure mark_boll(y,x,flag: integer); //检测连续球，并做标记
           begin
             if LongRec(bubble_boll_g_array[bubble_data1.last_y,bubble_data1.last_x]).Bytes[3]= 0 then
                exit; //最后消失的球不再了，退出
            //检测上下左右6个位置
            if LongRec(bubble_boll_g_array[y,x]).Bytes[0]= flag then
              exit
              else
                LongRec(bubble_boll_g_array[y,x]).Bytes[0]:= flag;
            if y= 0 then  //判断顶行，由于最下面一行有球就算输，所以最下面一行不会有球
             begin
               if x= 0 then
                begin
                 if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                    mark_boll(y,x+1,flag);
                 if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                    mark_boll(y+1,x,flag);
                end else if x= g_boll_21_cn then
                           begin
                            if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                               mark_boll(y,x-1,flag);
                            if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                               mark_boll(y+1,x-1,flag);
                           end else begin
                                     if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                        mark_boll(y,x+1,flag);
                                     if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                        mark_boll(y,x-1,flag);
                                     if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                        mark_boll(y+1,x,flag);
                                     if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                        mark_boll(y+1,x-1,flag);
                                    end;
             end else begin //*********************************判断中间行的球
                        if x= 0 then
                         begin
                           if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                              mark_boll(y-1,x,flag);  //上行同一列
                           if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                              mark_boll(y+1,x,flag);  //下同
                           if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                              mark_boll(y,x+1,flag);   //向右
                           if y mod 2=1 then
                            begin //奇数行，多判断两个
                             if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                              mark_boll(y-1,x+1,flag);  //上行向右
                             if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                              mark_boll(y+1,x+1,flag);  //下右
                            end;
                         end else if x= g_boll_21_cn then  //右边的球
                               begin
                                  if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y,x-1,flag);   //向前
                                  if y mod 2=0 then
                                  begin                //偶数行
                                  if LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y-1,x-1,flag);  //上小
                                  if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y+1,x-1,flag);  //下小
                                  end else
                                    begin //奇数行，
                                    if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y-1,x+1,flag);  //上行向右
                                    if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y+1,x+1,flag);  //下右
                                    if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y-1,x,flag);  //上同
                                    if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                     mark_boll(y+1,x,flag);  //下同
                                    end;
                               end else begin  //中间的球
                                          if LongRec(bubble_boll_g_array[y-1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y-1,x,flag);  //上行同一列
                                          if LongRec(bubble_boll_g_array[y+1,x]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y+1,x,flag);  //下同
                                          if LongRec(bubble_boll_g_array[y,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y,x+1,flag);   //向右
                                           if LongRec(bubble_boll_g_array[y,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y,x-1,flag);   //向左
                                            if y mod 2= 0 then
                                             begin
                                             if LongRec(bubble_boll_g_array[y-1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y-1,x-1,flag);  //上小
                                            if LongRec(bubble_boll_g_array[y+1,x-1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y+1,x-1,flag);  //下小
                                             end else begin
                                            if LongRec(bubble_boll_g_array[y-1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y-1,x+1,flag);  //上行大
                                            if LongRec(bubble_boll_g_array[y+1,x+1]).Bytes[3]= LongRec(bubble_boll_g_array[y,x]).Bytes[3] then
                                             mark_boll(y+1,x+1,flag);  //下大
                                                      end;
                                        end;
                      end;
           end; //procedure
          function boll_clear: boolean;  //检测是否有击中的球
           var i,j,k: integer;
           begin
             //如果有球被击中，进入消失状态
             result:= false; //如果已经有球正处于变小状态，则为true
             for i:= 0 to g_boll_14_cn do
              begin
                for j:= 0 to g_boll_21_cn do
                    if LongRec(bubble_boll_g_array[i,j]).Bytes[0]=1 then
                      begin
                        result:= true;
                        if LongRec(bubble_boll_g_array[i,j]).Bytes[1]> 0 then
                          begin
                           LongRec(bubble_boll_g_array[i,j]).Bytes[1]:= LongRec(bubble_boll_g_array[i,j]).Bytes[1]-1;
                           LongRec(bubble_boll_g_array[i,j]).Bytes[2]:= LongRec(bubble_boll_g_array[i,j]).Bytes[2]-1;
                          end else begin
                                    LongRec(bubble_boll_g_array[i,j]).Bytes[3]:= 0; //颜色取消
                                    LongRec(bubble_boll_g_array[i,j]).Bytes[0]:= 0;
                                    end;
                      end;
              end; //i

              if result= false then
               begin
                  k:= 0;
                 for i:= 0 to g_boll_14_cn do
                   for j:= 0 to g_boll_21_cn do
                        if LongRec(bubble_boll_g_array[i,j]).Bytes[3]>0 then
                             inc(k);
                 game_pop_count:= k; //剩下的球的数量
                 if k= 0 then
                  begin
                   //游戏胜利 *********************************************************
                     if gamesave1.tip5= 0 then
                     play_sound(14);

                   if Random(2)= 0 then
                    begin
                    k:= Random(9009)+ 2000;
                    show_text(true,'胜利！！奖励金钱 '+inttostr(k));
                    form1.game_attribute_change(1,0,k);
                    end else begin
                            k:= Random(4009)+ 500;
                            show_text(true,'胜利！全体加经验值 '+inttostr(k));
                            form1.game_attribute_change(0,19,k);
                         end;
                    g_dangqian_zhuangtai:= g_end;
                    inc(bubble_data1.sycs); //次数加一，用于阻止进入背单词界面
                    //给予奖励

                   result:= true;
                   G_game_delay(3000);
                   self.ModalResult:= mrok;
                   exit;
                  end;
                 //如果没有正在消失中的球，那么检测是否有球可供变小消失
                 //首先根据最后一个添加的球来递归检测是否3个互联，如果此球颜色为零，那么扫描是否有悬空的球
                 mark_boll(bubble_data1.last_y,bubble_data1.last_x,2); //预标记球
                 //统计预标记数量，并清除预标记
                 k:= 0;
                 for i:= 0 to g_boll_14_cn do
                   for j:= 0 to g_boll_21_cn do
                        if LongRec(bubble_boll_g_array[i,j]).Bytes[0]=2 then
                           begin
                             inc(k);
                             LongRec(bubble_boll_g_array[i,j]).Bytes[0]:= 0; //正在消失中的球的标记
                           end;

                 //如果大于等于3，则正式标记一下，否则，检测是否有悬空的球
                 if k>= 3 then
                  begin
                  if gamesave1.tip5= 0 then
                     play_sound(4);
                   mark_boll(bubble_data1.last_y,bubble_data1.last_x,1); //正式标记需变小的球
                   //加经验值，随机奖励***********************************************************

                   case Random(12) of
                   0: begin
                        inc(bubble_data1.sycs);
                        show_text(false,'奖励发泡泡机会一次');
                      end;
                   1: begin
                       form1.game_attribute_change(1,0,30); //全体增加经验值5
                       show_text(false,'增加金钱30');
                      end;
                   2: begin
                       inc(bubble_data1.sycs,2);
                        show_text(false,'奖励发泡泡机会2次');
                      end;
                   3: begin
                       inc(bubble_data1.sycs,k);
                        show_text(false,'奖励发泡泡机会'+inttostr(k)+'次');
                      end;
                   4: begin
                       inc(bubble_data1.sycs,3);
                        show_text(false,'奖励发泡泡机会3次');
                      end;
                   5: begin
                       inc(bubble_data1.dot_line_count,2);
                        show_text(false,'扣掉瞄准线 2次');
                      end;
                   6: begin
                       inc(bubble_data1.dot_line_count,3);
                        show_text(false,'扣掉瞄准线 3次');
                      end;
                   7: begin
                       inc(bubble_data1.dot_line_count,1);
                        show_text(false,'扣掉瞄准线 1次');
                      end;
                   8: begin
                       form1.game_attribute_change(0,19,-50); //全体增加经验值5
                      show_text(false,'倒扣经验值50');
                      end;
                    else
                      form1.game_attribute_change(0,19,30); //全体增加经验值5
                      show_text(false,'全体增加经验值30');
                    end;
                   
                   result:= true;
                  end else begin
                             //检测是否有悬空球，只在最后一个球消失时才做此检测
                             k:= 0;
                             if LongRec(bubble_boll_g_array[bubble_data1.last_y,bubble_data1.last_x]).Bytes[3]= 0 then
                                begin
                                  for i:= 0 to g_boll_21_cn do
                                     if LongRec(bubble_boll_g_array[0,i]).Bytes[3]> 0 then
                                        boll_xuankong(0,i); //将相连的球标记为 3

                                  for i:= 0 to g_boll_14_cn do
                                      for j:= 0 to g_boll_21_cn do
                                         if LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0 then
                                          if  LongRec(bubble_boll_g_array[i,j]).Bytes[0]= 3 then
                                              LongRec(bubble_boll_g_array[i,j]).Bytes[0]:= 0
                                              else begin
                                                   inc(k);
                                                   LongRec(bubble_boll_g_array[i,j]).Bytes[0]:= 1; //孤立的球标记为消失
                                                   result:= true;
                                                   end;
                                 if result then
                                  begin
                                    if (gamesave1.tip5= 0) then
                                        play_sound(4); //播放声音
                                    form1.game_attribute_change(0,19,k* k); //悬空球消失，全体增加经验值5
                                    show_text(false,'全体增加经验值'+ inttostr(k*k));
                                  end;
                                end;
                           end;
               end;
           end;
begin
    //计算并修正球的轨迹
    //当遇到可停靠位置时，计算并让球消失，重新调度
    if g_dangqian_zhuangtai<> g_boll_move then
      begin
       time_list1.Timer_bubble:= false;
       exit;
      end;

    if bubble_data1.zt= 0 then
     begin
      //状态，0表示球移动
      inc(bubble_data1.boll_path_length,4);
       bubble_path_to_xy; //计算球坐标

      //把网格对齐检测，并检测是否可以停靠，如果停靠，那么设置检测是否可以消失
       boll_to_grid;
     end else if bubble_data1.zt= 1 then  //消失检测标志
                begin
                  //状态，1表示检测球是否可消失
                    if boll_clear= false then
                     begin  //没有击中的球可供消失
                     time_list1.Timer_bubble:= false;
                     if bubble_data1.sycs > 0 then
                        g_dangqian_zhuangtai:= g_bubble //重新调度为发球
                        else
                        start_show_word(false);  //重新调度为背单词
                     end;
                end;


  
end;

procedure TForm_pop.Action25Execute(Sender: TObject);
begin
   game_bg_music_rc_g.type_word:= not game_bg_music_rc_g.type_word;
   if edit1.Visible then
      start_show_word(false);
end;

procedure TForm_pop.wuziqi_msg(var Msg: TMessage);  //五子棋引擎来的消息
var x,y,i: integer;
    b: boolean;
begin
 if msg.LParam <> 999 then
    exit;

   case msg.WParam of
   0: begin
       //引擎不存在
        messagebox(handle,'下棋引擎不存在。','错误',mb_ok);
        close;
       end;
   1: begin
       //管道创建失败
        messagebox(handle,'与下棋引擎通讯的管道创建失败。','错误',mb_ok);
        close;
       end;
   2: begin//创建引擎失败
        messagebox(handle,'创建下棋引擎失败。','错误',mb_ok);
        close;
      end;
   3: begin//有数据可以读取了
      // if wuziqi_flag= 2 then
      // begin
       //EnterCriticalSection(wuziqi_CriticalSection);
       //wuziqi_flag:= 3; //数据读取中
         // wuziqi_receive
         
         statusbar1.Panels[0].Text:= wuziqi_receive;
         if not (wuziqi_receive[0] in['0'..'9']) then
           begin
                  b:= false;
                  while true do
                   begin
                   for i:= 1 to wuziqi_char_count_cn do
                    if wuziqi_receive[i-1]=#0 then
                     break
                     else
                       wuziqi_receive[i-1]:= wuziqi_receive[i];
                    if b then
                      break;
                    if wuziqi_receive[0]= #10 then
                       b:= true;
                   end;
                 if wuziqi_receive[0]= #0 then
                    exit;

           end;

             if not (wuziqi_receive[0]in['0'..'9']) then
                    exit;
                    
             b:= false;
             x:= 0;
             y:= 0;
             for i:= 0 to wuziqi_char_count_cn do
              begin
                if not (wuziqi_receive[i] in['0'..'9']) then
                   b:= true
                   else
                if b then
                  y:= y * 10 + strtoint(wuziqi_receive[i])
                  else
                   x:= x * 10 + strtoint(wuziqi_receive[i]);
              end;
             LongRec(bubble_boll_g_array[y,x]).Bytes[3]:= g_ball_color_cpt;
             if wuziqi_result=1 then //五子棋结果，返回0表示继续，1表示失败，2表示胜利，3表示和棋
             begin
              g_tiankong:=true; //禁止听力显示
               draw_asw('您输了。',0,0);
               wuziqi_rec1.word_showing:= true;
              G_game_delay(2000);
              wuziqi_rec1.cpt_win:= true;
               postmessage(handle,wuziqi_msg_c,4,999);
             end
             else begin
                     g_dangqian_zhuangtai:= g_wuziqi1;
                   if wuziqi_rec1.me_count > 4 then
                    begin
                     wuziqi_rec1.word_time:= 128;
                     //刷新单词
                     show_a_word_on_wzq;
                     wuziqi_rec1.word_showing:= true;
                    end;

                  end;
             inc(wuziqi_rec1.cpt_count);
             wuziqi_rec1.cpt_row:= y;
             wuziqi_rec1.cpt_col:= X;
             wuziqi_rec1.row:= y;
             wuziqi_rec1.col:= X;
      // wuziqi_flag:= 4; //数据读取完毕
      // LeaveCriticalSection(wuziqi_CriticalSection);
      // end;
      end;
    4: begin
        self.ModalResult:= mrcancel;
       end;
   end;
end;

procedure TForm_pop.wuziqi_sendstr(s: string); //发送五子棋命令
var i: integer;
begin
    s:= s + #13#10;
    EnterCriticalSection(wuziqi_CriticalSection);
               wuziqi_flag:= 5; //待发送数据写入中
                 fillchar(wuziqi_send, sizeof(wuziqi_send), #0);
                 i:= length(s);
                 move(pchar(s)^,wuziqi_send,i);
                 byte(wuziqi_send[wuziqi_char_count_cn]):= lo(i);
               //wuziqi_send

               wuziqi_flag:= 6; //待发送数据写入完毕
    LeaveCriticalSection(wuziqi_CriticalSection);
end;
procedure quad_wuziqi(tp: Tpoint;L: integer; C: dword);
var C4: Tcolor4;
    T4: Tpoint4;
begin
    //画出矩形
   T4[0].x:= tp.X- L;
   T4[0].y:= tp.y- L;
    T4[1].x:= tp.X+ L;
   T4[1].y:= tp.y- L;
    T4[2].x:= tp.X+ L;
   T4[2].y:= tp.y+ L;
    T4[3].x:= tp.X- L;
   T4[3].y:= tp.y+ L;

   C4[0]:= C;
   C4[1]:= C;
   C4[2]:= C;
   C4[3]:= C;
   Form_pop.AsphyreCanvas1.Quad(T4,C4,fxnone);
end;

procedure quad_wuziqi2(tp: Tpoint;L: integer; C: dword);
begin
    //画出十字

   Form_pop.AsphyreCanvas1.Line(tp.x-L,tp.y,tp.x+L,tp.y,c,c,fxnone);
   Form_pop.AsphyreCanvas1.Line(tp.x,tp.y-L,tp.x,tp.y+L,c,c,fxnone);
end;

procedure TForm_pop.show_wuziqi_on_src; //显示五子棋到屏幕
 const w=32;
var r: Trect;
    i,j: integer;
    t: tpoint;
begin
  {位置信息：包括颜色球索引，为零的不显示，宽和高}
  {bubble_boll_g_array,0..3byte，3表示颜色球索引，1表示宽，2表示高，0表示是否处于同色统计内}
  for i:= 0 to 14 do
    for j:= 0 to 14 do
     begin
      if LongRec(bubble_boll_g_array[i,j]).Bytes[3]> 0 then
        begin
          r.Left:= j * w + w+ 20;
          r.Top:= i * w;
          r.Right:= r.Left + 32;
          r.Bottom:=r.Top + 32;
          AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'], r,$FFFFFFFF, LongRec(bubble_boll_g_array[i,j]).Bytes[3]-1, fxBlend);
          //如果该子是最后下的子，那么画十字上去
          if (i= wuziqi_rec1.row) and (j= wuziqi_rec1.col) then
             begin
             t.X:= r.Left+16;
             t.Y:= r.Top+16;
             quad_wuziqi2(t,5, $FF1E90DF);
             end;
        end;
     end;


       //画出右边的两个棋子
    AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'],576,90 ,$FFFFFFFF, 0, fxBlend);
    AsphyreCanvas1.DrawEx(AsphyreImages1.Image['bubble.png'],576,314,$FFFFFFFF, 2, fxBlend);
     //画出步数
     AsphyreFonts1[0].TextOut(inttostr(wuziqi_rec1.cpt_count),576,154,$FFD08080, $FFD08080,fxBlend);
     AsphyreFonts1[0].TextOut(inttostr(wuziqi_rec1.me_count),576,376,$FFD08080, $FFD08080,fxBlend);
     if wuziqi_rec1.xy0 then
       form_pop.AsphyreCanvas1.Line(wuziqi_rec1.x0
                                   ,wuziqi_rec1.y0,wuziqi_rec1.x1,wuziqi_rec1.y1,$FFFFFFFF,$FFFFFFFF, fxnone);

     if wuziqi_rec1.word_showing then  //显示单词
       begin
       r.Left:= wuziqi_rec1.cpt_col * w + 52;
       r.Top:= wuziqi_rec1.cpt_row * w;
       r.Right:= r.Left + game_bmp_width;
       r.Bottom:=r.Top + game_bmp_h1;
       AsphyreCanvas1.DrawEx(image_word,r,$AAFFFFFF,0, fxBlend);
       end;

     //画出可下子点的小矩形，该过程位于最后
    if g_dangqian_zhuangtai= g_wuziqi1 then
     begin
       //鼠标位置转换为矩阵，如果该点没有棋子，那么画一个矩形上去
       GetCursorPos(T);
       t:= panel1.ScreenToClient(t);
       if (t.X< 52) or (t.X> 531) or (t.Y< 0) or (t.Y>479) then
         exit;
       if LongRec(bubble_boll_g_array[t.Y div w,(t.X-52) div w]).Bytes[3]= 0 then
         begin
          if (t.Y mod w in[8..24]) and ((t.X-52) mod w in[8..24]) then
           begin
             t.Y:= t.Y div w * w+16;
             t.X:=(t.X-52) div w * w+ 68;
             quad_wuziqi(t,8, $FFFFFFFF);
           end;
         end;

     end;

   
end;

procedure TForm_pop.show_a_word_on_wzq;
var ss,ss2: string;
    i: integer;
begin
    //在五子棋时显示一个单词
  ss:= get_word_safe(get_Word_id); //取得单词编号，如果有错误重复选项，则会取回错误单词编号
  ss2:= copy(ss,1,pos('=',ss)-1);

     if (ss2<> '') and (checkbox2.checked) then
        skp_string(ss2);
    if Assigned(form_chinese) and G_can_chinese_tts then
       begin
        ss2:= copy(ss,pos('=',ss)+1,255);
        if length(ss2)> 8 then
         begin
           i:= pos(' ',ss2);
           if i= 0 then
              i:= pos('，',ss2);
           if i> 0 then
             ss2:= copy(ss2,1,i-1);
         end;
        if ss2<> '' then
           form_chinese.cn_string:=ss2;
       end;
    g_tiankong:=true; //禁止听力显示
    ss:= StringReplace(ss,'=',' ',[]);
    draw_asw(ss,0,0);
end;

procedure TForm_pop.show_ad(add_i: integer);  //刷新广告
begin
{  if (Game_ad_count_G.X<> 1) or (Game_ad_count_G.Y < 10)then
   begin
    inc(jit_num);
     if jit_num mod 15 = 0 then
      begin
       if game_bg_music_rc_g.show_ad_web then
        form1.game_page(0)
        else begin
               //在本窗口顶部显示广告
              // WebBrowser1.Navigate('http://www.finer2.com/wordgame/jiqiao'+inttostr(Random(20)+1)+'.htm');
             end;
      end;
   end;
       }
end;

procedure TForm_pop.create_top_ad; //创建一个网页广告小窗口
 const h= 100;
begin
 {  self.Height:= self.Height + h;
   checkbox2.Top:= checkbox2.Top + h;
   checkbox3.Top:= checkbox3.Top + h;
   checkbox8.Top:= checkbox8.Top + h;
   button11.Top:= button11.Top + h;
   label1.Top:= label1.Top + h;
   combobox1.Top:= combobox1.Top + h;
   panel1.Top:= panel1.Top+ h;
   groupbox3.Top:= groupbox3.Top + h;
    
    label3.Top:= label2.Top + h;
    label4.Top:= label2.Top + h;
    label5.Top:= label2.Top + h;
    label6.Top:= label2.Top + h;
    label7.Top:= label2.Top + h;
    label8.Top:= label2.Top + h;
    label9.Top:= label2.Top + h;
    label10.Top:= label2.Top + h;
    label11.Top:= label2.Top + h;
    label2.Top:= label2.Top + h;
    WebBrowser1:= TWebBrowser.Create(application);
    WebBrowser1.ParentWindow:= self.Handle;
    WebBrowser1.Left:= 0;
    WebBrowser1.Top:= 0;
    WebBrowser1.Height:= h;
    WebBrowser1.Width:= 700;

    WebBrowser1.Navigate('http://www.finer2.com/wordgame/game.htm');   }
end;

procedure TForm_pop.SpVoice1EndStream(Sender: TObject;
  StreamNumber: Integer; StreamPosition: OleVariant);
begin
   postmessage(form_chinese.handle,msg_langdu_huancong,1022,0);
end;

procedure TForm_pop.N15Click(Sender: TObject);
begin
    del_a_word;
end;

procedure TForm_pop.N17Click(Sender: TObject);
begin
      //插入新单词
      edit2.Text:= '';
      edit3.Text:= '';
   groupbox1.Caption:= '添加新单词';
    groupbox1.Visible:= true;
end;

procedure TForm_pop.N16Click(Sender: TObject);
begin
     //修改当前单词
   if G_word = g_dangqian_zhuangtai then
  begin
     edit2.Text:= Jit_words;
     edit3.Text:= game_word_1;
    groupbox1.Caption:= '编辑单词';
    groupbox1.Visible:= true;
  end
  else messagebox(handle,'当前无显示的单词。','不能编辑',mb_ok);
end;

procedure TForm_pop.Button13Click(Sender: TObject);
begin
 groupbox1.Visible:= false;
end;

procedure TForm_pop.Button14Click(Sender: TObject);
begin
 button14.Tag:= 1;
    if game_pop_type=3 then
    begin
    // game_fight_result:= 2;  调试时自动为2
     game_fight_result_adv; //判断结果
    end else self.ModalResult:= mrok;

end;

procedure TForm_pop.Button12Click(Sender: TObject);
begin
     //确定单词添加修改
     if (edit2.Text= '') or (edit3.Text= '') then
        begin
          messagebox(handle,'请填写单词和中文解释。','添加',mb_ok);
          exit;
        end;
screen.Cursor:= crhourglass;
    if groupbox1.Caption= '添加新单词' then
     begin
      if messagebox(handle,'确定添加当前单词？','添加',mb_yesno) = mryes then
                 begin
                  if wordlist1.Values[edit2.Text]<>'' then
                   if messagebox(handle,'该单词已经存在，是否覆盖？','覆盖',mb_yesno) = mryes then
                       wordlist1.Values[edit2.Text]:= edit3.Text;
                 end;

     end else begin
                if messagebox(handle,'确定编辑当前单词？','编辑',mb_yesno) = mryes then
                 begin
                   wordlist1.Values[edit2.Text]:= edit3.Text;
                 end;
              end;
screen.Cursor:= crdefault;
end;

procedure TForm_pop.N14Click(Sender: TObject);
begin
    //编辑当前词库
    ShellExecute(handle,'open',pchar(game_app_path_G+'lib\'+ combobox1.Text),nil,nil,sw_shownormal);
end;

function TForm_pop.get_word_safe(i: integer): string;
begin
   if (i>= wordlist1.Count) or (i<0) then
    result:= wordlist1.Strings[Random(wordlist1.Count)]
   else
    result:= wordlist1.Strings[i];
end;

end.
