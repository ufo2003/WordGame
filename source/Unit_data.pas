unit Unit_data;

interface

uses
  SysUtils, Classes,IniFiles, ImgList, Controls,windows,Unit_net,unit_player,unit_glb,
  ShellCtrls,System.Zip, System.ImageList,System.Hash,VCLUnZip,VCLZip;


//function QueryPerformanceCounter(var lpPerformanceCount: int64): BOOLean; stdcall;
const
  game_const_star_war= $0400 + 31671;
  game_const_script_after= $0400 + 31672;
 zb_td1= 1;
 zb_sc1= 2;
 zb_pf1= 3;
 zb_jc1= 4;
 zb_hw1= 5;
 zb_jz1= 6;
 zb_xl1= 7;
 zb_wq1= 8;
 zb_yg1= 9;
   game_m_quan_qi= 999999999; //起死回生，全满
   game_m_ban_qi = 99999999;  //起死回生，半满
   game_m_quan   = 9999999;  //不回生，全满
   game_m_ban    = 999999;   //不回生，半满

 Download_try_count= 7;  //下载不成功尝试次数
 refresh_time_C= 600000;  //刷新网络用户信息间隔时间
 banben_const= '1'; //客户端版本号
 
type
    Tbg_music_rc=packed record
     bg_img: boolean;   //背景图启用，值为 1，表示启用
     bg_tm: integer;    //背景图透明度
     bg_music: boolean;    //背景音乐启用
     bg_yl: integer;     //背景音乐音量
     bg_lrc: boolean;    // ;背景歌词启用
     mg_pop: boolean;    // ;迷宫弹出式背单词窗口启用
     pop_img: boolean;   // ;网页式背单词窗口背景图启用
     pop_img_tm: integer; //;网页式背单词窗口背景图透明度
     bg_img_radm: boolean;  //   ;背景图随机显示
     bg_music_radm: boolean; //   ;背景音乐随机播放
     bg_img_index: integer;    //背景图像序号
     bg_music_index: integer; //背景音乐序号
     bg_music_base: boolean; //开启重低音----改为回音效果
     lrc_dir: string[255];
     sch_enable: boolean;   // ;图片搜索开启
     sch_MAX: integer;      //  ;图片搜索次数最大值，一2048
     sch_count1: integer;     //图片搜索计数
     sch_key: string[64];  // ;图片搜索关键字
     sch_pic: string[255];  //  ;图片搜索
     gum_path: string[255];     // ;gum下载地址
     gum_only: boolean;   //仅搜索gum下载文件夹，适合在线版本
     sch_img_sty: integer; //搜索下载的图片显示方式
     sch_img_height: integer; //图片高度
     not_tiankong: boolean;    // ;禁止填空式选择
     type_word: boolean; //;启用键盘输入背单词
     type_word_flash: boolean;  //单词闪烁
      type_char_spk: boolean;   //字母发音
      temp_mg_pop: boolean; //临时迷宫弹出变量
      desktop_word: boolean; //是否启用桌面背单词
      show_ad_web: boolean; //广告显示在web内
      yodao_sound: boolean;  //是否启用有道网易单词朗读
      number_count: integer; //本局已背单词数，不保存
      down_readfile: boolean; //下载在线阅读内容
      en_type_name: string[32];
      cn_type_name: string[32];
      baidu_vol: integer;
      baidu_sex: integer;
      baidu_spd: integer; //语速，0-9 默认5
      baidu_pit: integer; //音调
     end;

  //名称,类型，防，体，灵，速，命，攻，智，运，耐久，价格；描述
  Tgame_goods_type=(goods_name1,goods_type1,goods_f1,goods_t1,goods_L1,goods_s1,
                    goods_m1,goods_g1,goods_z1,goods_y1,goods_n1,goods_j1,goods_ms1);
  Tgame_s_type=(G_nil,G_action,G_description,G_chat);

  TData2 = class(TDataModule)
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList_sml: TImageList;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  //  procedure IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
  //    ABinding: TIdSocketHandle);
    procedure ShellChangeNotifier1Change;
  private
    { Private declarations }

    function read_game_scene(source,dest: Tstringlist):boolean;//解析场景
    function explain_scene_html(const s: string): string; //对场景内的html文件进行解释
    procedure explain_scene_html_base(var s: string);
    procedure Load_file_ini(const n: string; st1: Tstringlist);
    function get_checkout: integer; //获取物品校验码
    procedure chat_if_then(st1: Tstringlist); //对话内的if then 过滤
    function get_bg_img_filename(s: string): string; //取得自定义背景图片名
     
  public
    { Public declarations }
    game_memini1: TMemIniFile;  //物品列表
    game_memini_event: TMemIniFile; //事件列表
    procedure load_scene(id: string; St1: Tstringlist);//载入场景文件
    procedure Load_file_upp(const n: string; st1: Tstringlist); //载入人物，怪物文件
    procedure save_file_upp(const n: string; st1: Tstringlist); //保存人物，怪物文件
    procedure save_file_event(const n: string);
    procedure load_goods_file; //载入物品描述文件
    function get_game_goods_type(i: integer; tp: Tgame_goods_type): integer; //获取一个指定序号的物品属性
    function get_game_goods_type_s(const s: string; tp: Tgame_goods_type): string; //从字符窜内拆分属性
    function rep_game_goods_type_s(const s: string; tp: Tgame_goods_type; sub: string): string; //替换指定的内容
    function get_game_goods_type_a(i: integer): string; //返回值非零的全部属性
    procedure get_game_goods_type_a_base(var ss: string);
    function get_game_fa(i2: integer): string; //获得指定法术名称
    function get_game_ji(i2: integer): string; //获得指定技能名称
    procedure load_event_file(n: string); //载入事件文件,带默认值的
    procedure Load_file_event(const n: string; st1: Tstringlist); //载入事件文件 base
    function get_goods_all_s(i: integer): string; //根据物品编号来读取物品的完整字符串
    

    procedure game_save_goods; //保存物品
    procedure game_load_goods;

    procedure game_show_task_complete(t: tstrings); //显示已完成的任务
    procedure game_show_task_uncomplete(t: tstrings); //显示没有完成的任务
    procedure game_addto_complete(s: string); //添加一个数据到已完成的，同时删除从未完成
    procedure game_addto_uncomplete(s: string); //添加一个数据到未完成的
    procedure game_load_task_file; //载入任务列表
    procedure game_save_task_file; //保存任务列表
    function game_get_task_s(id: string): string; //取得task描述内的一个内容
    procedure clean_if_then(var s: string); //对字符串内的if then进行预判断，返回最终字符串
    procedure function_re_string(var s: string);
    function function_re_string2(s: string): string; //对string 类型函数进行处理
    procedure out_save(s: string; outfilename: string); //导出单个存档，参数为文件夹路径,导出为的文件名
    procedure in_save(s: string; saveDir: string); //导入单个存档，参数为存档文件名，要导入的游戏存档目录名
  end;

// function QueryPerformanceCounter; external 'kernel32.dll' name 'QueryPerformanceCounter';
 function ExecuteRoutine(AObj: TObject; AName: string;
    Params: array of const): integer;

 function Game_base_random(i: integer): integer;

 function get_L_16(i: integer): integer;  //得到法术编号
 function get_H_8(i: integer): integer; //得到法术等级
 function get_HL_8(i: integer): integer; //得到使用次数，次高8位
 function set_L_16(i,v: integer): integer;  //写入法术编号，返回值为合成后的值
 function set_H_8(i,v: integer): integer; //写入法术等级，最高10级 ，返回值为合成后的值
          {1-3级，20次升一级，4-6级，20次升一级，6-9级，60次升一级}
 function set_HL_8(i,v: integer): integer; //写入使用次数，次高8位，，返回值为合成后的值
 function game_add_shuliang_string(const s: string;k: integer): string;//在名称前插入数量
 function strtoint2(const s: string): integer;
 function game_get_touxian(i: integer): string;
 function read_goods_number(id: integer): integer; //读取数量
 function write_goods_number(id: integer; nmb: integer): boolean; //写入数量
 function game_add_goods_from_net(p: pointer; c: integer): integer; //添加游戏物品数据
 function get_list_str(t: Tstringlist; i: integer): string; //对tliststring进行检查
 function get_down_img_url: string; //合成下载名
 function get_second: int64;  //返回1899年以来的秒数

var
  Data2: TData2;
  game_player_head_G: Tplayer_head; //自己的联网头数据
  Game_goods_G2: array[0..1023] of byte;          //物品
  game_app_path_G: string; //程序路径
  game_doc_path_g: string; //我的文档文件夹
  Game_goods_net_G: array[0..1023] of word; //来自网络的物品
  Game_goods_Index_G: array[0..1023] of word;   //物品图标索引
  Game_chat_name_G,Game_g_name_G: string; //当前对话的人姓名，返回的物品名
  Game_save_path: string; //游戏的保存路径
  Game_chat_index_G,Game_chat_id_G: integer; //快速索引，当前对话到第几句了
  Game_not_save: boolean;
  Game_scene_author: string;  //场景作者
  Game_task_comp1,Game_task_uncomp1,game_message_txt: Tstringlist;
  Game_scene_type_G: integer; //全局场景属性变量 1,普通，2迷宫，4不清除临时表，8不允许结束对话，……
  Game_is_only_show_G: boolean; //是否仅显示指定人物，该变量会影响到goods窗口的checkbox
  Game_script_scene_after,Game_script_scene_G: string; //载入场景后运行此代码
  Game_is_reload: boolean; //重复载入时是否忽略加载前后的脚本执行
  Game_can_talk_G: boolean;
  Game_guai_list_G,Game_touxian_list_G: Tstringlist;
  Game_scene_id_string: string; //在取场景id为字符串的函数内使用
  Game_inttostr_string_G: string;
  Game_datetime_G,Game_pstringw: string; //时间日期内使用,文件id
  Game_time_exe_array_G: array[0..511] of word; //定时执行函数允许的数量
  Game_cannot_runOff: boolean; //禁止逃跑
  Game_migong_xishu: integer; //迷宫内怪物攻击力系数
  Game_not_gohome_G: boolean; //是否允许回城
  Game_ad_count_G: tpoint;
  game_shunxu_g,game_abhs_g: boolean;
  Game_wakuan_zhengque_shu: integer; //每局挖矿正确的数量
  Game_at_net_G: boolean; //游戏处于联网状态
  Game_loading: boolean; //正在载入过程中
  Game_pchar_string_G: string; //用于pchar的返回值
  Game_app_img_path_G,Game_app_img_url_G: string; //游戏图片路径，游戏图片下载路径
  Game_error_count_G: integer; //下载错误次数，如果此值大于100，表示禁止了图片
  Game_update_url_G,Game_update_file_G: string;
  Game_show_error_image_G: boolean; //是否显示错误图片，否，显示等待图片
  Game_net_hide_g: boolean; //禁止网络功能
  Game_server_addr_g: string; //服务器ip地址
  Game_wait_ok1_g: boolean; //等待的一个来自服务器的ok信号
  game_wait_integer_g: integer; //等待到的数据
  Game_wait_ok2_g: boolean; //等待的一个来自服务器的ok信号
  game_wait_integer2_g: integer; //等待到的数据
  game_auto_temp_g: integer; //当write——temp时自动设置进入临时表不清空
  game_debug_handle_g: thandle; //游戏脚本调试
  game_exit_cmd_str_g: string;   //退出后的命令
  game_chat_cache_g: string; //聊天缓存
  game_reload_chat_g: boolean; //是否仅载入聊天记录
  game_NoRevealTrans_g: boolean; //禁止场景切换的转场效果
  game_page_from_net_g: boolean; //来自网络的页面切换
  game_bg_music_rc_g: Tbg_music_rc; //背景图片，音乐选项
  bg_img_filelist_g,bg_music_filelist_g: Tstringlist;
  game_html_pop_str_g: string; //html模式的pop窗口后续命令 36
  temp_pic_file_g: string; //临时下载的图片文件
  ugm_down_count_g: integer; //累计的下载失败的次数
  not_show_img_tip_g: boolean;   //不显示下载图片时的提示内容
  re_show_img_tmp_g: string; //重载时的缓存
  temp_sch_key_g: string; //临时搜索关键字
//  yodao_udp_g,yodao_tcp_g,yodao_udp_host: string;
  read_text_index_g: integer;
  part_size_g: array of integer; //每局循环背诵的单词数
  game_guid: string;
  ZipHeader1: TZipHeader;
implementation
   uses unit1,unit_downhttp,forms,Unit_mp3_yodao,unit_show,unit_pop;
{$R *.dfm}

function get_second: int64;

var SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  //返回1899年以来的秒数 )，hourof(now)，minuteof(now) ，secondof(now)
  result:= trunc(now) * 86400;

  result:= result+ SystemTime.wHour * 3600+ SystemTime.wMinute * 60 + SystemTime.wSecond;

end;

function get_list_str(t: Tstringlist; i: integer): string; //对tliststring进行检查
begin
  
  if (t.Count= 0) or (i<0) or (i>= t.Count) then
   begin
    result:= '1';
   end else
     result:= t.Strings[i];

end;

function game_add_goods_from_net(p: pointer; c: integer): integer; //添加游戏物品数据
var i: integer;
begin
   for i:= 1 to 1012 do
    begin
     case (i-1) mod 4 of
     0: begin
     WordRec(Game_goods_net_G[i]).Hi:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[0] xor 135;
     WordRec(Game_goods_net_G[i]).lo:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[0] xor 211;
      end;
      1: begin
     WordRec(Game_goods_net_G[i]).Hi:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[1] xor 135;
     WordRec(Game_goods_net_G[i]).lo:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[1] xor 211;
         end;
     2: begin
     WordRec(Game_goods_net_G[i]).Hi:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[2] xor 135;
     WordRec(Game_goods_net_G[i]).lo:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[2] xor 211;
         end;
     3: begin
     WordRec(Game_goods_net_G[i]).Hi:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[3] xor 135;
     WordRec(Game_goods_net_G[i]).lo:= longrec(Tgame_wupin(p^).wupin[(i-1) div 4]).bytes[3] xor 211;
        end;
      end;
    end;
   result:= 1;
end;

function read_goods_number(id: integer): integer; //读取数量
var b1,b2: byte;
begin
 if (id> 1023) or (id < 1) then
    result:= 0
    else begin
  if Game_at_net_G then
   begin
   b1:= WordRec(Game_goods_net_G[id]).Hi xor 135;
   b2:= WordRec(Game_goods_net_G[id]).lo xor 211;
    if b1 < b2 then
       result:= b1
       else result:= b2;
   end else result:= Game_goods_G2[id];

         end;
end;

function write_goods_number(id: integer; nmb: integer): boolean; //写入数量
var b1,b2: byte;
begin
 if (id> 1023) or (id < 1) then
    result:= false
    else begin
  if Game_at_net_G then
   begin
   b1:= WordRec(Game_goods_net_G[id]).Hi xor 135;
   b2:= WordRec(Game_goods_net_G[id]).lo xor 211;
    if b1 > b2 then
        b1:= b2
         else b2:= b1; //使得这两个变量等值，这是为防止被其他工具修改，b2的值用来记录原值

    if nmb<> 0 then
      nmb:= nmb + b1;

    if nmb> 255 then
       b1:= 255
       else if nmb < 0 then
             b1:= 0
              else b1:= nmb;
      WordRec(Game_goods_net_G[id]).Hi:= b1 xor 135;
      WordRec(Game_goods_net_G[id]).lo:= b1 xor 211;

      //向服务器发送物品数量修改信息，data1表示物品id，和物品原来数量,data2表示新的数量

      my_send_cmd_pak_g.hander:= byte_to_integer(g_change_wupin_C,false); //设置头信息
        id:= id shl 16 + b2;
      my_send_cmd_pak_g.pak.data1:= id;
      my_send_cmd_pak_g.pak.data2:= b1;  //新数量
      my_send_cmd_pak_g.pak.s_id:= my_s_id_G;
      g_send_msg_cmd(@my_send_cmd_pak_g,sizeof(my_send_cmd_pak_g));
    result:= true;
   end else begin
              if nmb= 0 then
                 Game_goods_G2[id]:= 0 //如果参数为零，清空数量
                else
                 nmb:= nmb + Game_goods_G2[id];
              if nmb > 255 then
                 Game_goods_G2[id]:= 255
                 else if nmb < 0 then
                       Game_goods_G2[id]:= 0
                        else
                         Game_goods_G2[id]:= nmb;

             result:= true;
            end;

         end;

end;

function game_get_touxian(i: integer): string;  //取得头衔
begin
  if (i >= Game_touxian_list_G.Count) or (i < 0) then
    result:= ''
    else
     result:= Game_touxian_list_G.Strings[i];
end;

function strtoint2(const s: string): integer;
begin
  if not TryStrToInt(s,result) then
     result:= 0;
end;
function game_add_shuliang_string(const s: string;k: integer): string;
begin
         result:= s;
         insert('数量：'+ inttostr(k)+ ',',result,fastcharpos(s,',',1)+1);
end;
function get_L_16(i: integer): integer;  //得到法术编号
asm
shl eax, 16
shr eax, 16
end;

function get_H_8(i: integer): integer; //得到法术等级
asm
shr eax, 24

end;

function get_HL_8(i: integer): integer; //得到使用次数，次高8位
asm
shr eax, 16
xor ah,ah
end;

function set_L_16(i,v: integer): integer;  //写入法术编号
asm
mov ax,dx
end;

function set_H_8(i,v: integer): integer; //写入法术等级
asm
mov cx,ax  //备份
shr eax,16
mov ah,dl
shl eax,16
mov ax,cx

end;

function set_HL_8(i,v: integer): integer; //写入使用次数，次高8位
asm
mov cx,ax  //备份
shr eax,16
mov al,dl
shl eax,16
mov ax,cx
end;

function Game_base_random(i: integer): integer;  //随机函数
var int1:int64;
     i32: dword;
begin
    if i= 0 then i:= 1;
 //利用玩家操作的时间间隔之间的微观上的随机性来获取随机数
  QueryperformanceCounter(int1);
    i32:= Int64Rec(int1).lo;
    i32:= i32 shl 16;
    i32:= i32 shr 16;
   result:= integer(i32 mod i);
   result:= (result + Random(i)) mod i;

end;
function ExecuteRoutine(AObj: TObject; AName: string;
    Params: array of const): integer;
  const
    RecSize = SizeOf(TVarRec); // 循环处理参数列表时递增的字节数
  var
    PFunc: Pointer;
    ParCount: integer;
  begin
    if not Assigned(AObj) then
      raise Exception.Create ('对象参数错误！');
    PFunc := AObj.MethodAddress(AName); // 获取方法地址
    if not Assigned(PFunc) then
      raise Exception.CreateFmt('在 %s 内的函数: %s 不存在。', [AObj.ClassName,
        AName]);

      ParCount := High(Params) + 1;
    asm
      PUSH        ESI                 // 保存 ESI，我们待会儿要用到它

      MOV         ESI, Params         // ESI 指向参数表首址
      CMP         ParCount, 1         // 判断参数个数
      JB          @NoParam
      JE          @OneParam
      CMP         ParCount, 2
      JE          @TwoParams

    @ManyParams: // 超过两个参数
      CLD                             // 清空方向标志
      MOV         ECX, ParCount
      SUB         ECX, 2              // 循环 ParCount - 2 次
      MOV         EDX, RecSize        // EDX 依次指向每个参数的首址，每次递增 8 Bytes
      ADD         EDX, RecSize        // 跳过前两个参数
    @ParamLoop:
      MOV         EAX, [ESI][EDX]     // 用基址变址寻址方式取得一个参数
      PUSH        EAX                 // 参数进栈
      ADD         EDX, RecSize        // EDX 指向下一个参数首址
      LOOP        @ParamLoop

    @TwoParams: // 两个参数
      MOV         ECX, [ESI] + RecSize

    @OneParam: // 一个参数
      MOV         EDX, [ESI]

    @NoParam:
      MOV         EAX, AObj           // 传入实例地址（即，隐藏参数 Self）
      CALL        PFunc               // 调用方法
      MOV         Result, EAX         // 返回值放入 Result

      POP         ESI                 // 记得还原
    end;
  end;
{ TData2 }
function char_not_in_az(a: char): boolean;
  begin
    result:= not (a in['a'..'z','A'..'Z','0'..'9','_','\','"']);
  end;

procedure TData2.Load_file_ini(const n: string; st1: Tstringlist);
                     {载入物品描述ini文件}
var
  //  ss: string;
    i: integer;
begin

       st1.Clear;
       load_file_upp(n,st1);
     // st1.LoadFromFile(n);

                   {  ss:= st1.Strings[st1.count-1];
                     st1.Delete(st1.count-1);
                     st1.Append('Code=fuchengrong@hotmail.com');
                     delete(ss,1,5);
                      if Comparetext( ss,THashMD5.GetHashString(st1.text))<> 0 then
                       begin
                         st1.clear;
                         st1.Append('游戏物品文件数字水印无效。');
                       end else begin
                                  st1.Delete(st1.count-1);
                                end;  }


 for i:= st1.Count-1 downto 0 do
    if fastpos(st1.Strings[i],';;',length(st1.Strings[i]),2,1)> 0 then
       st1.Delete(i); //忽略双分号的注释行

end;
            {载入人物，怪物，等}
procedure TData2.Load_file_upp(const n: string; st1: Tstringlist);
var
    stream1: TStream;
    ss: string;
    i: integer;
    zip: TVCLUnZip;
begin
  st1.Clear;

  if not FileExists(n) then
    exit;

    ss:= 'uA-G3P@2wQ@3N';
    for i:= 1 to 12 do
     if i mod 2 = 1 then
        delete(ss,i div 2+1,1);
     ss:= copy(ss,1,4);
   // vclzip1.ZipName:= opendialog1.FileName;
   ss:= ss+ '@'+ inttostr(3);
    //vclzip1.Password:= 'AGP2@3%N';
    zip:= TVCLUnZip.create(nil);

      zip.Password:= ss + '%N';
     stream1:= TMemoryStream.Create;
     zip.ZipName:= n;
      //vclzip1.UnZipToStream(stream1,ExtractFileName(n));

        zip.UnZipToStreamByIndex(stream1,0);
      // vclzip1.UnZip;
       stream1.Position:= 0;
       st1.LoadFromStream(stream1);
       zip.free;
   stream1.Free;

   if Comparetext( ExtractFileExt(n),'.usp')<> 0  then  //物品文件不在这里清理分号
     begin
      if not Game_loading then
       begin
                 ss:= st1.Strings[st1.count-1];
                      if ss<> '' then
                       begin
                            delete(ss,1,16);
                            if (game_pstringw<>'') and (ss<> game_pstringw) then
                             begin
                               st1.Clear;
                               messagebox(form1.Handle,'错误，upp文件被意外修改，重新安装游戏可以修正此问题。','error',mb_ok);

                             end;
                       end;
      end;
   for i:= st1.Count-1 downto 0 do
    if fastpos(st1.Strings[i],';;',length(st1.Strings[i]),2,1)> 0 then
       st1.Delete(i); //忽略双分号的注释行
    end;

end;
      {载入物品描述表，用哈希ini}
procedure TData2.load_goods_file;
var str1: Tstringlist;
begin
 if not Assigned(game_memini1) then
    begin
    game_memini1:= TMemIniFile.Create('');

   str1:= Tstringlist.Create;
     Load_file_ini(game_app_path_G +'goods.usp',str1);
     assert(str1.Count>1,'无效的物品文件');
     game_memini1.SetStrings(str1);
   str1.Free;
    end;
end;

procedure TData2.load_scene(id: string; St1: Tstringlist);
var str1: Tstringlist;
    stream1: TStream;
    ss: string;
    ss_addr: string;
    k,m: integer;
    zip2: TVCLUnZip;
    label pp;
     function FileExists_ugm: boolean;
      var t: dword;
      begin
      result:= false;
       {如果不限制仅搜索ugm下载路径,那么先搜索默认路径}
       if not game_bg_music_rc_g.gum_only then
        begin
          ss_addr:= game_app_path_G+'scene\'+ id;
          if FileExists(ss_addr) then
            begin
              result:= true;
              exit;
            end;
        end;
        {默认路径不存在需要的文件,并且ugm下载路径不为空 那么,继续搜索一下ugm路径}
        if game_bg_music_rc_g.gum_path<> '' then
         begin
           ss_addr:= game_doc_path_G+'down_ugm\'+ id;
           if FileExists(ss_addr) then
            begin
              result:= true;
              //并开始下载下一个文件
              inc(m);
              if not FileExists(game_doc_path_G+'down_ugm\'+inttostr(m)+'.ugm') then
                 down_http.Create(game_bg_music_rc_g.gum_path+ inttostr(m)+'.ugm',
                                        game_doc_path_G+'down_ugm\'+ inttostr(m)+'.ugm',false);
            end else begin
                       //如果不存在,那么尝试下载,如果下载超时次数过多,放弃
                       if ugm_down_count_g > 9 then
                        begin
                          m:= 1; //下载失败次数过多
                          exit;
                        end;
                       down_http.Create(game_bg_music_rc_g.gum_path+ id,
                                        ss_addr,false);
                       //等待下载结果
                       t:= GetTickCount;
                       form1.Edit1.Text:= '正在下载场景……';
                       form1.Edit1.Visible:= true;
                        while GetTickCount -t < 15000 do
                          begin
                            if FileExists(ss_addr) then
                             begin
                              result:= true;
                              form1.Edit1.Visible:= false;
                              exit;
                             end;
                            application.ProcessMessages;
                            sleep(100);
                          end;

                       //下载超时
                       form1.Edit1.Visible:= false;
                       inc(ugm_down_count_g);
                       m:= 3;
                     end;
         end else m:= 2; //表示文件不存在,且下载url也不存在


      end;
begin
m:= strtoint2(id); //保存一个数字用于下载文件
id:= id + '.ugm';
k:= 0;

  if FileExists_ugm then
   begin
    str1:= Tstringlist.Create;
    //vclzip1.Password:= 'APP2433N';

        pp:
         str1.Clear;
         stream1:= TMemoryStream.Create;
         zip2:= TVCLUnZip.Create(nil);
         zip2.Password:= 'APP2433N';
         zip2.ZipName:= ss_addr;
         zip2.UnZipToStreamByIndex(stream1,0);
         stream1.Position:= 0;

       str1.LoadFromStream(stream1);

          zip2.free;
          stream1.Free;

       if str1.Count= 0 then
        begin
         inc(k);
         if k<= 5 then
         begin
         sleep(100);
         goto pp;
         end;
          St1.Add('空的场景文件。<a href="game_goto_home(0)" title="">回城</a>');
          stream1.Free;
          str1.Free;
         exit;
        end;

       ss:= trim(str1.Strings[0]) + '.ugm'; //获取第一行字符串
       delete(ss,1,3);
        if CompareText(ss,id)<> 0 then
           begin
             str1.Clear;
             St1.Add('游戏场景ID不匹配。<a href="game_goto_home(0)" title="">回城</a>');
           end else begin

                     ss:= str1.Strings[str1.count-1];
                     str1.Delete(str1.count-1);
                     {str1.Append('Code=ufo2003a@gmail.com');

                     delete(ss,1,5);
                      if CompareStr( ss,THashMD5.GetHashString(str1.text))<> 0 then
                       begin
                         str1.Clear;
                         St1.Add('游戏场景文件无效。<a href="game_goto_home(0)" title="">回城</a>');
                       end else begin
                                  str1.Delete(str1.count-1);

                                end;   }
                       if str1.count>0 then
                         ss:= str1.Strings[str1.count-1]
                         else
                          ss:= '';


                           if ss<> '' then
                              delete(ss,1,16);

                            if (game_pstringw<>'') and (ss<> game_pstringw) then
                             begin
                               str1.Clear;
                                St1.Add('游戏场景CRC校验失败，重新安装游戏可以修正此问题。如果是vista或者win7，win10等操作系统，建议把游戏安装在非系统盘比如D盘试试。<a href="game_goto_home(0)" title="">回城</a>');
                             end;
                    end;


     //stream1.Free;


      if str1.Count > 0 then
       begin // 解析文件
        if not read_game_scene(str1,st1) then
          st1.Add('场景文件解析失败。可能文件已经被破坏。<a href="game_goto_home(0)" title="">回城</a>');
       end;

     str1.Free;
   end else begin
              //文件不存在 下载
               {m= 2; //表示文件不存在,且下载url也不存在
                       m:= 3;  //下载超时
                       m:= 1; //下载失败次数过多}

              st1.Clear;
              st1.Add('<html><body>');
               case m of
               1: st1.Add('多次下载场景失败,将不会再次尝试下载了。请检查网络是否通畅，或者上游戏主页留言反映问题。');
               2: st1.Add('该场景不存在，且不存在可供自动下载的网址信息。');
               3: st1.Add('下载游戏场景超时，已累计超时'+ inttostr(ugm_down_count_g)+'次。');
                else
                 st1.Add('该场景不存在，是否立即下载？');
               end;
              st1.Add('<p>');
              st1.Add('下载<p>');
              st1.Add('<a href="http://www.finer2.com/wordgame/" title="上游戏的主页看看是否有新的可以下载了" target="_blank">上主页查看新版本</a><p>');
              st1.Add('<a href="game_page(-1)" title="">返回前页</a><p>');
              st1.Add('<a href="game_goto_home(0)" title="">回城</a><p>');
              st1.Add('</body></html>');

            end;
end;

procedure TData2.out_save(s: string; outfilename: string);
var str1: Tstringlist;

begin
   str1:= tstringlist.Create;
    str1.Add(s);
    str1.SaveToFile(s+'\out.txt'); //保存有out。txt 如果使用百度语音，那么清空保存的guid 然后删除此文件
   str1.Free;


  screen.Cursor:= crhourglass;
    TZipFile.ZipDirectoryContents(outfilename, s+ '\'); //指定目录全部压缩
    {   zip1:= tvclzip.Create(nil);
       with zip1 do
       begin
         RootDir:= extractfilepath(outfilename);
         ZipName:= outfilename;
         FilesList.Clear;
         FilesList.Add(s+ '\*.*');
         Recurse := True;
         RelativePaths := false;
         //RecreateDirs:=true;
         Zip;
       end;
         zip1.Free; }
  screen.Cursor:= crdefault;
end;

function get_down_img_url: string;
var url,ky: string;
     function URIEncode(const S: string): string;
       var
       I: Integer;
       begin
        result:= '';
         for I := 1 to Length(S) do
           Result := Result + '%' + IntToHex(Ord(S[I]), 2);
       end;
begin
  if (game_bg_music_rc_g.sch_pic<> '') and ((game_bg_music_rc_g.sch_key<> '') or (temp_sch_key_g<>'')) then
   begin
     url:= game_bg_music_rc_g.sch_pic;
     if game_bg_music_rc_g.sch_count1 >= game_bg_music_rc_g.sch_MAX then
        game_bg_music_rc_g.sch_count1:= 0; //搜索页面计数归零

    url:=  StringReplace(url,':number',inttostr(game_bg_music_rc_g.sch_count1),[rfReplaceAll]);
     if temp_sch_key_g<>'' then
        ky:= temp_sch_key_g
        else ky:= game_bg_music_rc_g.sch_key;

    result:=  StringReplace(url,':name',URIEncode(UTF8Encode(ky)),[rfReplaceAll]);

    inc(game_bg_music_rc_g.sch_count1); //累计下载次数
   end else result:= '';
end;

function get_down_img_filename: string;
var ii: integer;
label pp;
begin

    result:= '';
    if Game_scene_type_G and 256= 256 then
       exit;
       
    if temp_sch_key_g= '' then  //如果有临时指定文件，那么每次都重新下载，并先加载缓存
      begin
    if temp_pic_file_g= '' then
       goto pp;
     if not FileExists(temp_pic_file_g) then
         goto pp;
      end else begin  // if temp
                 temp_pic_file_g:= game_app_path_G+ 'img/wait.gif';
               end;
   if  Game_is_reload then //重新载入时忽略
    begin
      result:= re_show_img_tmp_g;
      exit;
    end;
             result:= '<img id="img_shc" ';
              if temp_sch_key_g= '' then
                 ii:= game_bg_music_rc_g.sch_img_height
                 else
                  ii:= 44;
             if ii> 0 then
              result:= result+ 'height='+inttostr(ii);



             result:= result+ ' src="file:///'+ temp_pic_file_g +'" style="float:right;">';
             if not not_show_img_tip_g then
              begin
               result:= result+ '图片来自关键字搜索：<b>';

                if temp_sch_key_g= '' then
                result:= result + game_bg_music_rc_g.sch_key
                else
                  result:= result + '页面指定：'+temp_sch_key_g;

                  result:= result+ '</b> 第'+ inttostr(game_bg_music_rc_g.sch_count1) +'幅 您可以'
                              + '<a href="game_show_set(2)" title="更改喜欢的图片搜索关键字和显示方式">更改关键字</a>&nbsp;<a href="game_set_var(1,1);game_infobox(''提示已取消，将在切换页面后消失'')"'+
                                ' title="不再显示本行文字">取消提示</a>&nbsp;<a href="game_question(''确定要关闭图片显示？您以后也可以在系统设置内恢复显示。'');game_set_var(2,0);game_infobox(''图片已关闭，将在切换页面后消失'')" title="本局游戏内不再显示图片">关闭图片</a><p>';
              end;
             re_show_img_tmp_g:= result; //保存一个副本
      pp:
     
          down_http.Create(get_down_img_url,'',(temp_sch_key_g<>''));
end;

function CrossFixFileName(const FileName: String): String;
const
  PrevChar = '\';
  NewChar = '/';

var
  I: Integer;
begin
  Result := FileName;

  for I := 1 to Length(Result) do
    if Result[I] = PrevChar then
      Result[I] := NewChar;
end;

function StringToHex(str: ansistring): string;
var
   i : integer;
   s : string;
begin
   for i:=1 to length(str) do begin
       s := s + InttoHex(Integer(str[i]),2);
   end;
   Result:=s;
end;
function create_img_file(const s: string): string; //创建一个图片文件并返回文件名
begin
    //jpg用大写，以区别图片生成里面的小写来实现不同功能
   result:= Game_app_img_path_G+ THashMD5.GetHashString(s).Substring(8,16) +'.JPG';
   if not FileExists(result) then
    begin
     //OutputDebugString(pchar(ss));

      form1.game_pic_from_text(nil,s,result);

      //strem1.Free;
    end;

end;

function TData2.read_game_scene(source, dest: Tstringlist): boolean;
var i,k,j: integer;
    s_type: Tgame_s_type; //场景内的资源类型
     b,b2,b3: boolean;
     ss,s_functions,tmp_ss,kuan: string;
     label pp;
begin
result:= false;
Game_cannot_runOff:= false;

                {
           属性=2 迷宫 4=不清除临时表
           8=禁止结束对话 16=载入前动作 32=载入后动作
           64=回城点 128=退出页面时动作
           256=禁止显示搜索的图片
     }

    form1.GroupBox5.Caption:= source.Values['名称'];
    Game_scene_author:= source.Values['作者'];  //保存场景作者名称
    temp_sch_key_g:= source.Values['TempKey']; //临时key
    b2:= source.Values['ID']<>'10000';  //首页，忽略载入前后的执行

        if (game_exit_cmd_str_g <> '') and b2 and (Game_is_reload=false) then
           begin
            if (game_at_net_g=false) or (game_player_head_G.duiwu_dg<>1) then
                form1.Game_action_exe_S_adv(game_exit_cmd_str_g); //执行上次的退出后函数
            game_exit_cmd_str_g:= '';
           end;

     if source.Values['属性'] = '' then
        Game_scene_type_G:= 1
        else
         Game_scene_type_G:= strtoint2(source.Values['属性']);  //保存属性

     if (Game_scene_type_G and 4<> 4) and (game_auto_temp_g<> 2) then
        form1.temp_event_clean; //清空临时表
        
        game_auto_temp_g:= 0;

     if Game_scene_type_G and 64= 64 then
        Form1.game_write_home_id; //保存回城点

     if Game_scene_type_G and 16= 16 then
       begin
         //16 载入场景前执行动作 32为载入场景后
         if not Game_is_reload then //Game_is_reload值为真，不执行脚本
           begin
        s_functions:= source.Values['载入前'];
        if (s_functions <> '') and b2 then
          if (game_at_net_g=false) or (game_player_head_G.duiwu_dg<>1) then  //不是网络，不是跟随
             form1.Game_action_exe_S_adv(s_functions); //执行函数和语句，可带if then
           end;
       end;

    if Game_scene_type_G and 128= 128 then
       begin
         //128 是退出后执行的
         if not Game_is_reload then //Game_is_reload值为真，不执行脚本
           begin
             game_exit_cmd_str_g:= source.Values['退出后'];
           end;
       end;
  b:= false;
  b3:= true; //没有添加过在线用户
  //b_action:= false;
 // b_chat:= false;
  s_type:= G_nil;
  k:= 0; //用来标记{}是否配对

 for i:= 1 to source.Count-1 do
  begin
   if source.Strings[i]= '' then
    Continue;
   if fastpos(source.Strings[i],';;',10,2,1)> 0 then
     Continue; //忽略双分号的注释行

   if fastcharpos(source.Strings[i],'{',1)> 0 then
       begin
        if trim(source.Strings[i])= '{' then //{需独占一行
         begin
          if k= 0 then
           begin
           b:= true;
           inc(k);
           Continue;
           end;
            inc(k);
         end;
       end;

   if not b then
   begin
   if pos('动作=',source.Strings[i])> 0 then
     s_type:= G_action;
    if pos('描述=',source.Strings[i])> 0 then
     s_type:= G_description;
    if pos('对话资源=',source.Strings[i])> 0 then
     s_type:= G_chat;
    
   end else begin
             ss:= source.Strings[i];
             if fastcharpos(ss,'}',1)> 0 then
              begin
               if trim(ss)= '}' then
                 begin
                  dec(k);
                  if k= 0 then
                   begin
                    b:= false;
                    Continue;
                   end;
                 end;
              end;

              case s_type of
               G_action: begin
                           //动作
                           Game_action_list.Append(ss);
                         end;
               G_description: begin
                              //场景
                              if not game_reload_chat_g then
                              begin
                            dest.Append(source.Strings[i]);
                               if b3 then
                                begin
                                 if game_NoRevealTrans_g then
                                  begin  //去掉转场行
                                   if FastPos(source.Strings[i],'revealTrans',
                                      length(source.Strings[i]),11,1)> 0 then
                                     dest.Delete(dest.Count-1); //删除最后一行的转场效果
                                  end;
                                     if FastPosNoCase(source.Strings[i],'</head',
                                                 length(source.Strings[i]),6,1)> 0 then
                                          begin
                                            if (FastPosNoCase(source.Strings[i],'<body',length(source.Strings[i]),5,1)= 0)
                                                 and (FastPosNoCase(source.Strings[i+1],'<body',length(source.Strings[i]),5,1)= 0) then
                                                   begin
                                                   dest.Append('<body>'); //没有body的加入body
                                                    goto pp;
                                                   end;
                                          end;
                                 if FastPosNoCase(source.Strings[i],'<body',
                                   length(source.Strings[i]),5,1)> 0 then
                                  begin
                                     pp:
                                     if game_bg_music_rc_g.bg_img then //自定义背景
                                        dest.Strings[dest.Count-1]:= get_bg_img_filename('')
                                        else if game_bg_music_rc_g.sch_enable then
                                             begin
                                               //如果搜索图片功能开启，且也设在了 搜索图片，作为背景
                                               if (game_bg_music_rc_g.sch_img_sty= 2) and
                                                   (temp_pic_file_g<> '') then
                                                    dest.Strings[dest.Count-1]:= get_bg_img_filename(temp_pic_file_g);
                                             end;
                                     if game_bg_music_rc_g.sch_enable and
                                        (game_bg_music_rc_g.sch_img_sty= 0) then
                                      begin
                                        //搜索图片，作为页首
                                           dest.Append(get_down_img_filename);
                                      end;
                                     if game_at_net_g then
                                     dest.Append('<table><tr><td id=cell_net1></td></tr><tr><td><a href="game_reshow_online(0)" title="点击此按钮可重新获取在线玩家数据">刷新在线玩家</a></td></tr></table>');
                                     //添加聊天显示代码
                                        dest.Append('<div id=layer_chat1 style="position:absolute; top:60%; left:10px; width:90%; height:160px; background-color:FFFFFF; overflow:auto; z-index:64;display:none;">'+
                                        '<table width=70% cellpadding=4 cellspacing=0 rules=none><tr><td id=cell_chat1></td><td valign=top><a href="game_chat_cleans2(0)">关闭</a></td></tr></table></div>');
                                    b3:= false;
                                  end;
                                end else begin // end b3

                                         end; 
                              end; //end if not
                          end;
               G_chat: begin
                          //聊天
                       Game_chat_list.Append(ss);
                       end;
               end; //end case
             result:= true;
            end;

  end; //end for

               //动作的 if then 处理+++++++++++++++++++++++
               chat_if_then(Game_action_list);

               //++++++++++++++++++++++++++++++++++++++++++++++++

           //对话的if then 处理++++++++++++++++++++++++++++++++++++

              chat_if_then(Game_chat_list);
                //聊天语句替换为真实路径，以显示图片
                
                for i:= 0 to Game_chat_list.Count -1 do
             begin
              if fastpos(Game_chat_list.Strings[i],'$apppath$',
                         length(Game_chat_list.Strings[i]),9,1)> 0 then
                 Game_chat_list.Strings[i]:= CrossFixFileName(stringReplace(Game_chat_list.Strings[i],
                                                               '$apppath$','file:///'+game_app_path_G,[rfReplaceAll]));
               Game_chat_list.Strings[i]:=function_re_string2(Game_chat_list.Strings[i]); //对含有返回字符串的函数进行返回值读取
             end; //end for

                Game_can_talk_G:= (Game_chat_list.Count > 0);
                
           //++++++++++++++++++++++++++++++++++++++++++++++++++++++++

          //对资源的进一步解析 ++++++++++++++++++++++++++++++++++++++++++++++++
               if not game_reload_chat_g then  //如果不是仅仅载入对话
                 begin
            dest.Text:= explain_scene_html(dest.getText);  //处理 if then 等等

            for i:= 0 to dest.Count -1 do    //替换为真实路径，以显示图片
             begin
                //不支持自定义协议，于是把这个改为url，然后用临时文件代替
              //if fastpos(dest.Strings[i],'charset=gb2312',length(dest.Strings[i]),14,1)> 0 then
               //  dest.Strings[i]:=stringReplace(dest.Strings[i],'charset=gb2312','charset=ISO-8859-1',[rfReplaceAll]);
               tmp_ss:= dest.Strings[i];
              if fastpos(tmp_ss,'gpic://',length(tmp_ss),7,1)> 0 then
               begin
                  k:= fastpos(tmp_ss,'gpic://',length(tmp_ss),7,1);
                  j:= pos('.bmp',tmp_ss);
                  ss:= copy(tmp_ss,k+7,j+3);

                  kuan:= copy(ss,1,pos(',',ss)-1);  //设置img标签宽度属性
                  // ss:= StringToHex(ss);

                   if tmp_ss[j+4]=')' then
                    begin
                     kuan:= 'background-size:'+kuan+'px;';
                     insert(kuan,tmp_ss,pos(';',tmp_ss)+1);
                    end else begin
                              kuan:= 'width="'+kuan+'"';
                              insert(kuan,tmp_ss,j+5);
                             end;


                    //创建文件并返回路径

                 tmp_ss:= copy(tmp_ss,1,k-1)+ 'file:///'+ create_img_file(ss)+
                                   copy(tmp_ss,j+4,512);
                 //stringReplace(dest.Strings[i],'gpic://','http://127.0.0.1:8081/a?p='+ ss+'&v=a.bmp',[rfReplaceAll]);
               end;

                 //替换为实际的文件名
              if fastpos(tmp_ss,'$apppath$',length(tmp_ss),9,1)> 0 then
                 tmp_ss:=CrossFixFileName(stringReplace(tmp_ss,'$apppath$','file:///'+game_app_path_G,[rfReplaceAll]));

                dest.Strings[i]:=CrossFixFileName(stringReplace(tmp_ss,'file://f','f',[rfReplaceAll]));
             end; //end for
                  if game_bg_music_rc_g.sch_enable and
                  (game_bg_music_rc_g.sch_img_sty= 1) then
                  dest.Insert(dest.Count-2,get_down_img_filename); //搜索图片，作为页脚
                     {
                  if (Game_is_reload=false) and (Game_scene_type_G and 2=2) and ((Game_ad_count_G.X<> 1) or (Game_ad_count_G.Y < 10))
                  then
                  begin
                                           //显示迷宫内的广告 filter:Alpha(Opacity=55);
                  dest.insert(dest.Count-2,'<p>&nbsp;<p>&nbsp;<hr><table style="width:100%; height:240; z-index:5;"><tr><td id=ad_tabletd1>'+
                  '<iframe id=ad_layer1 align=center src="http://www.finer2.com/wordgame/jiqiao'+inttostr(Random(20)+1)+'.htm" width=900 height=240 framespacing=0 frameborder=0></iframe></td></tr></table>');
                  Game_ad_count_G.Y:= Game_ad_count_G.Y+ 1;
                  end;
                        }
                  dest.Insert(dest.Count-2,'<p>&nbsp;<p>&nbsp;<p>&nbsp;<p>&nbsp;<p>&nbsp;'); //插入空行
                 end; // end if not
       //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

       
        //载入场景后执行动作 32为载入场景后
     if Game_scene_type_G and 32= 32 then
       begin
        if Game_is_reload or (form1.game_read_temp(form1.pscene_id)= 1) then //忽略脚本，有标记的迷宫也不打
        begin
         Game_is_reload:= false; //设为false，此值需每次设置
        end else begin
                  Game_script_scene_after := source.Values['载入后'];
                  if (Game_script_scene_after <> '') and b2 then
                    if Game_script_scene_after[1]= 'D' then
                      begin
                      Game_script_scene_G:= Game_script_scene_after;
                      postmessage(form1.Handle,game_const_script_after,31,0);
                       end else
                           postmessage(form1.Handle,game_const_script_after,29,0);
                 end;
       end;
       

         Game_is_reload:= false; //设为false，此值需每次设置 //忽略脚本

   if game_debug_handle_g<> 0 then  //发送调试信息
    begin
      for i:= 0 to Game_action_list.Count-1 do
         Form1.debug_send_func_str(Game_action_list[i],html_C);
      for i:= 0 to dest.Count-1 do
         Form1.debug_send_func_str(dest[i],html_C);
      for i:= 0 to Game_chat_list.Count-1 do
         Form1.debug_send_func_str(Game_chat_list[i],html_C);
    end;
                               
end;

procedure TData2.DataModuleDestroy(Sender: TObject);
begin
 if Assigned(game_memini1) then
    game_memini1.Free;
 if Assigned(game_memini_event) then
    game_memini_event.Free;

 if Assigned(Game_task_uncomp1) then
    Game_task_uncomp1.Free;

 if Assigned(Game_task_comp1) then
    Game_task_comp1.Free;

 if Assigned(game_message_txt) then
    game_message_txt.Free;
 if Assigned(bg_music_filelist_g) then
    bg_music_filelist_g.Free;
 if Assigned(bg_img_filelist_g) then
    bg_img_filelist_g.Free;

Game_guai_list_G.Free;

end;
       
function TData2.get_game_goods_type(i: integer;  //获取物品名称列表
  tp: Tgame_goods_type): integer;
  var ss: string;
      j: Tgame_goods_type;
      k: integer;
begin
  ss:= game_memini1.ReadString('GOODS',inttostr(i),'');
result:= 0;
 if length(ss) < 10 then
    exit;

   for j:= goods_name1 to high(Tgame_goods_type) do
    begin
      //如果是名称和描述，那么返回字符串
      k:= pos(',',ss);
      if (j= tp) and (j=goods_name1) then
       begin
        Game_g_name_G:= copy(ss,1,k-1);
        result:= integer(pchar(Game_g_name_G));
        exit;
       end;
       if (j=tp) and (j= high(Tgame_goods_type)) then
        begin
          Game_g_name_G:= ss;
          result:= integer(pchar(Game_g_name_G));
         exit;
        end;
        //返回integer类型
         if j= tp then
           begin
           result:= strtoint2(copy(ss,1,k-1));
           exit;
           end;
       delete(ss,1,k);
    end;
end;
                   {获取物品属性，不包括描述}
function TData2.get_game_goods_type_a(i: integer): string;
var ss: string;
begin
result:= '';
 if i= 0 then
  exit;

  ss:= game_memini1.ReadString('GOODS',inttostr(i),'');
   get_game_goods_type_a_base(ss);
  result:= ss;
end;

procedure TData2.get_game_goods_type_a_base(var ss: string);
var i,j: integer;
    ss2: string;
begin
  ss2:= get_game_goods_type_s(ss,goods_ms1);//取得描述
  i:= fastcharpos(ss,',',1);
   if i > 0 then
      delete(ss,i,fastcharpos(ss,',',i+1)-i); //删除类型和前面的名称

   
  j:= 3;
  i:= fastcharpos(ss,',',1);
   while i > 0 do
    begin

      if (ss[i+ 1]= '0') or (j >10) then
        begin
         if j> 9 then
            delete(ss,i,200)
          else begin
        delete(ss,i,2);
        dec(i,2);
               end;
        end else begin
                 inc(i);

                 
               case j of
               3:insert('防+',ss,i);
               4:insert('体+',ss,i);
               5: insert('灵+',ss,i);
               6: insert('速+',ss,i);
               7: insert('命+',ss,i);
               8: insert('攻+',ss,i);
               9: insert('智+',ss,i);
              // 10: insert('运 +',ss,i);
               end;
             end;
      i:= fastcharpos(ss,',',i+1);
      inc(j);
    end;

    ss:= StringReplace(ss,'999999999','回生全满',[rfReplaceAll]);
    ss:= StringReplace(ss,'99999999','回生半满',[rfReplaceAll]);
    ss:= StringReplace(ss,'9999999','全满',[rfReplaceAll]);
    ss:= StringReplace(ss,'999999','半满',[rfReplaceAll]);
   // delete(ss,1,fastcharpos(ss,',',1)-1);  //删除前面的名称
  ss:= ss + ','+ ss2;
end;
                {获取字符串类型的物品参数}
function TData2.get_game_goods_type_s(const s: string;
  tp: Tgame_goods_type): string;
 var  ss: string;
      j: Tgame_goods_type;
      k: integer;
begin
 ss:= s;
result:= '';
   for j:= goods_name1 to high(Tgame_goods_type) do
    begin
      k:= pos(',',ss);
      if (j= tp) and (j=goods_name1) then
       begin
        ss:= copy(ss,1,k-1);
        result:= ss;
        exit;
       end;
       if (j=tp) and (j= high(Tgame_goods_type)) then
        begin
          result:= ss;
         exit;
        end;

         if j= tp then
           begin
           result:=copy(ss,1,k-1);
           exit;
           end;
       delete(ss,1,k);
    end;

end;
                 {获取法术描述}
function TData2.get_game_fa(i2: integer): string;
var ss: string;
begin
  ss:= game_memini1.ReadString('GOODS',inttostr(i2),'');
  if ss<>'' then
   result:= format('%s, %s',[get_game_goods_type_s(ss,goods_name1),
                                get_game_goods_type_s(ss,goods_ms1)]);
end;
                   {获取技能描述}
function TData2.get_game_ji(i2: integer): string;
var ss: string;
begin
  ss:= game_memini1.ReadString('GOODS',inttostr(i2),'');
  if ss<>'' then
   result:= format('%s, %s',[get_game_goods_type_s(ss,goods_name1),
                                get_game_goods_type_s(ss,goods_ms1)]);

end;

procedure TData2.load_event_file(n: string); {载入事件文件，公开}
var str1: Tstringlist;
begin
   if not Assigned(game_memini_event) then
    begin
    game_memini_event:= TMemIniFile.Create('');
    end;

   str1:= Tstringlist.Create;
    if n<> '' then
     Load_file_event(n,str1)
     else begin
           str1.Add('[EVENTS]');
           str1.Add('');
           str1.Add('[FOODS]');
           str1.Add('');
          end;
     game_memini_event.SetStrings(str1);
   str1.Free;
    

end;
                 {载入事件文件，base}
procedure TData2.Load_file_event(const n: string; st1: Tstringlist);
var
    stream1: TStream;
    zip2: TVCLUnZip;
begin

   if not FileExists(n) then
    exit;
    zip2:= TVCLUnZip.Create(nil);
   zip2.Password:= 'E1v2e#n%T';

     stream1:= TMemoryStream.Create;
     zip2.ZipName:= n;
      //vclzip1.UnZipToStream(stream1,ExtractFileName(n));

       zip2.UnZipToStreamByIndex(stream1,0);
      // vclzip1.UnZip;
       st1.Clear;
       stream1.Position:= 0;
       st1.LoadFromStream(stream1);
       zip2.free;
   stream1.Free;

end;
              {保存事件文件 公开}
procedure TData2.save_file_event(const n: string);
var
    stream1: TStream;
    st1: Tstringlist;
    vclzip1: TVCLZip;
begin
  if n= '' then
   exit;

 if Assigned(game_memini_event) then
    begin
      vclzip1:= TVCLZip.Create(nil);
      vclzip1.Password:= 'E1v2e#n%T';
     stream1:= TMemoryStream.Create;
     vclzip1.ZipName:= n;
     // vclzip1.UnZipToStream(stream1,ExtractFileName(n));
      st1:= Tstringlist.Create;
       game_memini_event.GetStrings(st1);
        stream1.Position:= 0;
       st1.SaveToStream(stream1);
        stream1.Position:= 0;
       vclzip1.ZipFromStream(stream1,ExtractFileName(n));

       st1.Free;
       stream1.Free;
       vclzip1.Free;
    end;
end;

function TData2.get_goods_all_s(i: integer): string;
begin
   result:= game_memini1.ReadString('GOODS',inttostr(i),'');
end;

procedure TData2.in_save(s: string; saveDir: string);
begin
 //导入存档文件
   //savedir检查看后面是否有杠
screen.Cursor:= crhourglass;
     TZipFile.ExtractZipFile(s, saveDir+'\');
 {  vclunzip1.ZipName:= s;
   vclunzip1.DestDir:= saveDir;
   //VCLUnZip1.RecreateDirs := True;//是否创建子目录
   VCLUnZip1.DoAll := True;
   VCLUnZip1.OverwriteMode := always;
    VCLUnZip1.UnZip;   }

  screen.Cursor:= crdefault;
end;

procedure TData2.save_file_upp(const n: string; st1: Tstringlist);   //保存人物，怪物文件
var
    stream1: TStream;
    i: integer;
    ss: string;
    vclzip1: tvclzip;
begin
  if not Assigned(st1) then
     exit;
  if st1.Count= 0 then
    exit;

  if n= '' then
   exit;

      ss:= 'uA-G3P@2wQ@3N';
    for i:= 1 to 12 do
     if i mod 2 = 1 then
        delete(ss,i div 2+1,1);
     ss:= copy(ss,1,4);

   ss:= ss+ '@'+ inttostr(3);
     vclzip1:= tvclzip.Create(nil);
    vclzip1.Password:= ss + '%N';

     stream1:= TMemoryStream.Create;
     vclzip1.ZipName:= n;
     // vclzip1.UnZipToStream(stream1,ExtractFileName(n));
        stream1.Position:= 0;
       st1.SaveToStream(stream1);
        stream1.Position:= 0;
       vclzip1.ZipFromStream(stream1,ExtractFileName(n));

       stream1.Free;
        vclzip1.Free;


end;

procedure TData2.game_load_goods;
var iFileHandle:integer;
    i: integer;
begin

 iFileHandle:=Fileopen(Game_save_path + 'wp.upp',0);
  if iFileHandle= 0 then
    exit;

for i:= 0 to 1023 do
   Game_goods_G2[i]:= 0;

 try
  FileSeek(iFileHandle,0,0);
  for i:= 0 to 1023 do
    Fileread(iFileHandle,Game_goods_G2[i],1);
 finally
  FileClose(iFileHandle);
 end;

  if Game_goods_G2[0]<> get_checkout then
   begin
    for i:= 0 to 1023 do
     Game_goods_G2[i]:= 0; //如果校验码不对，那么数量全部清空
   end;
end;

procedure TData2.game_save_goods; //保存物品
var iFileHandle:integer;
   i: integer;
begin
  //加校验码
   Game_goods_G2[0]:= get_checkout; //取得校验码

 iFileHandle:=FileCreate(Game_save_path + 'wp.upp');
  if iFileHandle= 0 then
    exit;

 try
  for i:= 0 to 1023 do
     FileWrite(iFileHandle,Game_goods_G2[i],1);
 finally
  FileClose(iFileHandle);
 end;

      
end;

function TData2.get_checkout: integer;  //计算物品校验码
var i: integer;
    fak,sum: integer;
begin
   fak := 1023;
   sum:= 0;

   for i:= 1 to 1023 do //第一个位置保存校验码
    begin
    if (fak mod 2) = 0 then
      sum := sum + Game_goods_G2[i]
    else
      sum := sum + Game_goods_G2[i]* 3 ;

      dec(fak);
    end;

     result:= 10-(sum mod 10);

    if result = 10 then
       result:= 0;

end;

function TData2.explain_scene_html(const s: string): string;
var i,i_start,i_len,j: integer;
    in_code: boolean; //进入代码内
    ss: string;
begin
      //对场景内的html文件进行解释
in_code:= false;
// i_len:= 0;
 i_start:= 0;
 result:= '';
 i:= 0;
 j:= length(s);
  while i< j do
   begin
    inc(i);
    if in_code then
     begin
       //进入需解释的代码块
      if (s[i]= ':') and (s[i+1]= '>') then
       begin
         i_len:= i- i_start; //代码长
         //setlength(ss,i_len);
         //Move(s[I_start],ss[1],I_len); move是按字节算，ss是双字节，所以有问题
         ss:= s.Substring(I_start-1,i_len); //substring 从零开始
          explain_scene_html_base(ss); //处理
          result:= result + ss;   //合并

         in_code:= false;
         inc(i);
       end;
     end else begin //需解释的代码外
               if (s[i]= '<') and (s[i+1]= ':') then
                  begin
                   in_code:= true;
                   i_start:= i+ 2;  //保存起始序号
                   inc(i);
                  end else result:= result+ s[i];

              end;
   end; //end i

  function_re_string(result);  //再对返回字符串类型的函数进行处理
end;

procedure TData2.explain_scene_html_base(var s: string);
 var b: boolean;
    ss: string;
    I_else: integer;
    p_pos,i: integer;
begin
 if FastPos(s,'if',length(s),2,1)> 0 then
   begin
     if FastPos(s,'then',length(s),4,9)> 0 then
        begin
         clean_if_then(s);  //如果是if then 判断的，那么调用判断清理函数，然后退出，否则，简单模式，继续运行下面的代码
        // function_re_string(s);  //再对返回字符串类型的函数进行处理
         exit;
        end;
   end;

  p_pos:= -1;
  ss:= '';
  if s[1]= 'D' then
  begin
   ss:= Game_action_list.Values[copy(s,1,5)];
    if ss= '' then
     exit;
     form1.Game_action_exe_S_adv(ss);
     b:= true;
  end else begin
   for i:= 1 to length(s) do
    begin
      //获取函数，以括号配对为准
      if s[i]= '(' then
       begin
        if p_pos= -1 then
           P_pos:= 1
             else
               inc(P_pos);
       end else if s[i]= ')' then
                   dec(P_pos);

      if p_pos= 0 then //表示括号全部配对完毕，当前i指向右括号
       begin
        ss:=  trim(copy(s,1,i)); //取得函数，函数必须是右括号结尾
         break;
       end;
    end; //end for
            if ss= '' then
              exit;
              b:= form1.Game_action_exe_A(ss)<> 0;  //执行函数
            end;

   I_else:= FastPos(s,'else',length(s),4,1);

   if b then
    begin
     //取得else前面或者全部的内容
     if I_else> 0 then
        delete(s,I_else,length(s)- I_else+ 1);

     delete(s,1,length(ss)); //删除前面的函数
    end else begin
              //取得else后面的内容，如果else不存在，
               if I_else= 0 then
                 s:= ''
                 else
                   delete(s,1,I_else+ 3);
             end;

end;

procedure TData2.game_show_task_complete(t: tstrings);
var str1: Tstringlist;
    i: integer;
begin
     //显示已完成的任务
    if not Assigned(Game_task_comp1) then
       exit;

    str1:= Tstringlist.Create;

       Load_file_upp(game_app_path_G+'dat\task.upp',str1); //载入对照文件

        for i:= 0 to Game_task_comp1.Count-1 do
         begin
          t.Append(str1.Values[Game_task_comp1.Strings[i]]);
         end;
    str1.Free;

end;

procedure TData2.game_show_task_uncomplete(t: tstrings);
var str1: Tstringlist;
    i: integer;
begin
                   //显示没有完成的任务
    if not Assigned(Game_task_uncomp1) then
       exit;

    str1:= Tstringlist.Create;

       Load_file_upp(game_app_path_G+'dat\task.upp',str1); //载入对照文件
    //  Load_file_upp(game_app_path+'dat\task_uncomp.upp',str2); //载入数据文件
        for i:= 0 to Game_task_uncomp1.Count-1 do
         begin
          t.Append(str1.Values[Game_task_uncomp1.Strings[i]]);
         end;
    str1.Free;



end;

procedure TData2.game_addto_complete(s: string);
begin
   if not Assigned(Game_task_comp1) then
       Game_task_comp1:= Tstringlist.Create;

      Game_task_comp1.Append(s);  //添加任务到完成列表

      if Game_task_uncomp1.IndexOf(s)> -1 then
         Game_task_uncomp1.Delete(Game_task_uncomp1.IndexOf(s));  //从未完成列表删除
end;

procedure TData2.game_addto_uncomplete(s: string);
begin
    if not Assigned(Game_task_uncomp1) then
       Game_task_uncomp1:= Tstringlist.Create;

      Game_task_uncomp1.Append(s);  //添加任务到未完成列表
end;

procedure TData2.game_load_task_file;
begin
   if not Assigned(Game_task_uncomp1) then
       Game_task_uncomp1:= Tstringlist.Create;

   if not Assigned(Game_task_comp1) then
       Game_task_comp1:= Tstringlist.Create;
   if not Assigned(game_message_txt) then
       game_message_txt:= Tstringlist.Create;

   if FileExists(Game_save_path+'task_uncomp.upp') then
   Load_file_upp(Game_save_path+'task_uncomp.upp',Game_task_uncomp1);  //载入任务列表

   if FileExists(Game_save_path+'task_comp.upp') then
    Load_file_upp(Game_save_path+'task_comp.upp',Game_task_comp1);
game_message_txt.Clear;
   if FileExists(Game_save_path+'message.upp') then
    Load_file_upp(Game_save_path+'message.upp',game_message_txt);  //载入消息列表
end;

procedure TData2.game_save_task_file;
begin
   if Assigned(Game_task_uncomp1) then
   save_file_upp(Game_save_path+'task_uncomp.upp',Game_task_uncomp1); //保存任务列表

   if Assigned(Game_task_comp1) then
    save_file_upp(Game_save_path+'task_comp.upp',Game_task_comp1);

    if Assigned(game_message_txt) then
    save_file_upp(Game_save_path+'message.upp',game_message_txt);

end;

function TData2.game_get_task_s(id: string): string; //取得task描述内的一个内容
var str1: Tstringlist;

begin


    str1:= Tstringlist.Create;

       Load_file_upp(game_app_path_G+'dat\task.upp',str1); //载入对照文件
      result:= str1.Values[id]; //取得结果
    str1.Free;

end;

procedure TData2.chat_if_then(st1: Tstringlist); //对话内的if then 过滤
     function kuohao(j88: integer; const s: string): integer;
      var j2: integer;
      begin
       kuohao:= 0;   //取得最右边的括号位置
       for j2:= length(s) downto j88 do
           if s[j2]= ')' then
             begin
              kuohao:= j2;
              exit;
             end;
      end;
      function find_then(const s: string): integer;
        var j3: integer;
      begin
        find_then:= -1;
        for j3:= 3 to length(s)- 3 do
         begin
           if (UpCase(s[j3])='T') and (UpCase(s[j3+1])='H')and (UpCase(s[j3+2])='E')
                and (UpCase(s[j3+3])='N') then
                            begin
                             find_then:= j3;
                             exit;
                            end;

         end;

        end;
     function is_if(const s: string; ex: boolean= true): integer;
       var j: integer;
      begin
       is_if:= -1;
        for j:= 1 to length(s)-2 do
          if s[j]= ' ' then
           Continue
            else if UpCase(s[j])='I' then
                   begin
                    if char_not_in_az(s[j+2]) and (UpCase(s[j+ 1])='F') then
                      begin
                       if ex then
                        begin
                        if form1.game_functions_m(copy(s,j+3,find_then(s)-j-3))<> 0 then
                           is_if:= 1
                            else
                              is_if:= 0;
                        end else is_if:= 0; //不需执行
                       exit;
                      end;
                   end else begin
                              //is_if:= -1; // -1 表示该字符串内不含if句式
                              exit;
                            end;
      end;
     function find_else(i2: integer): integer;
       var j3,j4: integer;
      begin
        j4:= 0;
        find_else:= -1;
        for j3:= i2+1 to st1.Count- 1 do
         begin
           if is_if(st1.Strings[j3],false)<> -1 then
              inc(j4) //发现if 标记位加一
              else if (UpperCase(trim(st1.Strings[j3]))= 'END') or (UpperCase(trim(st1.Strings[j3]))= 'END;') then
                 begin
                  if j4= 0 then
                    exit
                  else
                    dec(j4) //发现end 标记位减去一
                 end else if UpperCase(trim(st1.Strings[j3]))= 'ELSE' then
                         begin
                           if j4= 0 then //其余的if end匹配，那么这个else行号返回
                            begin
                             find_else:= j3;
                             exit;
                            end;
                         end;
         end;
      end;
      function find_end(i2: integer): integer;
        var j3,j4: integer;
      begin
        j4:= 1;
        find_end:= -1;
        for j3:= i2+1 to st1.Count- 1 do
         begin
           if is_if(st1.Strings[j3],false)<> -1 then
              inc(j4) //发现if 标记位加一
              else if (UpperCase(trim(st1.Strings[j3]))= 'END') or (UpperCase(trim(st1.Strings[j3]))= 'END;') then
                         begin
                           dec(j4); //发现end 标记位减去一
                           if j4= 0 then //其余的if end匹配，那么这个else行号返回
                            begin
                             find_end:= j3;
                             exit;
                            end;
                         end;
         end;

        end;

var i,k,L,k2: integer;
begin
  for i:= 0 to st1.Count -1 do
   begin
     case is_if(st1.Strings[i]) of
    // -1:
     0: begin
         //找到if 并且条件为false 那么丢弃then 到else或者end的内容
         k:= find_else(i);
         k2:= find_end(i);

         if k<> -1 then
              st1.Delete(k2); //如果else行存在，那么先删除end行，否则，end行会在下面被删除
              
         if k= -1 then
           k:= k2; //如果else不存在，那么就到end为止

           

          for L:= k downto i do
             st1.Delete(L); //删除else前面或者end前的内容

          break;
        end;
     1: begin
         //找到if并且条件为真，那么就丢弃else 后面的内容
          k:= find_else(i);
          k2:= find_end(i); //保存end的位置
          if k > 0 then
           begin
            for L:= k2 downto k do
                st1.Delete(L);  //如果存在else 删除else后面的内容
           end else st1.Delete(k2); //删除end行
           st1.Delete(i); //删除本行
           break;
        end;
      end; //end case
   end; //end for

  // st1.SaveToFile('e:\s.txt');
   
   for i:= 0 to  st1.Count -1 do
    begin
     //再次查找，如果发现if语句，则递归调用
      if is_if(st1.Strings[i]) <> -1 then
       begin
         chat_if_then(st1);
         break;
       end;
    end;
  
end;

procedure TData2.clean_if_then(var s: string);
var k,k2,k88: integer;

     function kuohao(j88: integer): integer;
      var j2,j89: integer;
      begin
       kuohao:= 0;   //取得最右边的括号位置
       j89:= 0;
       for j2:= j88 to length(s) do
           if s[j2]= '(' then
             begin
              inc(j89)
             end else if s[j2]= ')'then
                       begin
                        dec(j89);
                         if j89= 0 then
                          begin
                            kuohao:= j2;
                            exit;
                          end;
                       end;
      end;
     function find_then(i2: integer): integer;
        var j3: integer;
      begin
        find_then:= -1;
        for j3:= i2 to length(s)- 3 do
         begin
           if (s[j3]='t') and (s[j3+1]='h')and (s[j3+2]='e')
                and (s[j3+3]='n') then
                            begin
                             find_then:= j3;
                             exit;
                            end;

         end;

        end;
     function is_if(j90: integer): integer;
       var j,j66: integer;
      begin
        is_if:= -1; // -1 表示该字符串内不含if句式
        j66:= 0;
        for j:= j90 to length(s)-2 do
         begin
          if (s[j]= '(') or (s[j]= '{') then  //在括号内部不搜索
             inc(j66)
              else if (s[j]= ')') or (s[j]= '}') then
                     dec(j66);
           if (j66=0) and (s[j]='i') then
                   begin
                    if char_not_in_az(s[j+2]) and (s[j+ 1]='f') then
                      begin
                        k88:= j;
                        //当进入if then 时，必须临时开启pop功能
                        game_bg_music_rc_g.temp_mg_pop:= game_bg_music_rc_g.mg_pop;
                        game_bg_music_rc_g.mg_pop:= true;
                        if form1.game_functions_m(copy(s,j+3,find_then(j)-j-3))<> 0 then
                           is_if:= 1
                            else
                              is_if:= 0;
                       game_bg_music_rc_g.mg_pop:= game_bg_music_rc_g.temp_mg_pop;
                       exit;
                      end;
                   end;
         end;
      end;
     function find_else(i2: integer): integer;
       var j3,j4: integer;
      begin
        j4:= 0;
        find_else:= -1;
        for j3:= i2 to length(s)-4 do
         begin
           if (s[j3]='i') and (s[j3+1]='f')and char_not_in_az(s[j3+2]) then
              inc(j4) //发现if 标记位加一
              else if char_not_in_az(s[j3-1])and(s[j3]='e') and (s[j3+1]='n')and (s[j3+2]='d') then
               begin
                 dec(j4); //发现end 标记位减去一
                 if j4=0 then
                    exit;
                end  else if (s[j3]='e') and (s[j3+1]='l')and (s[j3+2]='s')and
                           (s[j3+3]='e')and char_not_in_az(s[j3+4]) then
                         begin
                           if j4= 1 then //其余的if end匹配，那么这个else行号返回
                            begin
                             find_else:= j3;
                             exit;
                            end;
                         end;
         end;
      end;
      function up_one(i2: integer): integer;
       begin
        if i2< 1 then
         result:= 1
         else
          result:= i2;
       end;
      function find_end(i2: integer): integer;
        var j3,j4: integer;
      begin
        j4:= 1;
        find_end:= -1;
        for j3:= i2 to length(s)- 2 do
         begin
           if(s[j3]='i') and
             (s[j3+1]='f') and char_not_in_az(s[j3+2]) then
              inc(j4) //发现if 标记位加一
              else if char_not_in_az(s[up_one(j3-1)]) and (s[j3]='e') and
                     (s[j3+1]='n')and (s[j3+2]='d') then
                         begin
                           dec(j4); //发现end 标记位减去一
                           if j4= 1 then //其余的if end匹配，那么这个else行号返回
                            begin
                             find_end:= j3;
                             exit;
                            end;
                         end;
         end;

        end;

begin
k88:= 0;
     case is_if(1) of
    // -1:
     0: begin
         //找到if 并且条件为false 那么丢弃then 到else或者end的内容
         k:= find_else(k88);
         k2:= find_end(k88);
         if k<> -1 then
            delete(s,k2,3); //如果存在else，那么预先删除end
            
         if k= -1 then
           k:= k2-1; //如果else不存在，那么就到end为止
                     //减去一是因为end比else少一位

            delete(s,k88,k-k88+4); //删除else前面或者end前的内容

            s:= trim(s);  //清除两头的空格
           clean_if_then(s); //再次查找，如果发现if语句，则递归调用
           
        end;
     1: begin
         //找到if并且条件为真，那么就丢弃else 后面的内容
          k:= find_else(k88);
          k2:= find_end(k88);
          if k > 0 then
           begin
            delete(s,k,k2+3-k);  //如果存在else 删除else后面的内容
           end else delete(s,k2,3);

          delete(s,k88,find_then(k88)+4 -k88); //删除if
           s:= trim(s);  //清除两头的空格
           clean_if_then(s); //再次查找，如果发现if语句，则递归调用
        end;
      end; //end case

end;

procedure TData2.function_re_string(var s: string); //对需要字符串的函数进行返回值替换
var k,k_end: integer;
    i,t,k2: integer;
    ss: string;
begin
   t:= 0;
       k:= FastPos(s,'game_',length(s),5,1);  //看看是否有需要运行的函数
   k2:= k;
   while k > 4 do
    begin
     inc(t);
     if t> 900 then
       exit;  //防止死循环


     if (s[k-4]='r') and (s[k-3]='u') and (s[k-2]='n') and (s[k-1]=' ') then
      begin
      k_end:= 0; //括号配对
      for i:= k to length(s) do
         if s[i]= '(' then
            inc(k_end)
             else if s[i]= ')' then
                  begin
                   dec(k_end);
                   if k_end= 0 then
                      begin
                       k_end:= i;
                       break;
                      end;
                  end;
      if k_end > k then
       begin
              ss:= copy(s,k,k_end- k+1);
              form1.Game_action_exe_A(ss);
              delete(s,k-4,k_end-k+5);
              k2:= k-5;
              if s<> '' then
                if s[length(s)]= ';' then
                   delete(s,length(s),1);
       end;
       end else if (s[k-4]='i') and (s[k-3]='n') and (s[k-2]='g') and (s[k-1]=' ') then
             begin
     k_end:= 0; //括号配对
      for i:= k to length(s) do
         if s[i]= '(' then
            inc(k_end)
             else if s[i]= ')' then
                  begin
                   dec(k_end);
                   if k_end= 0 then
                      begin
                       k_end:= i;
                       break;
                      end;
                  end;
      if k_end > k then
       begin
       // if k_end= length(s) then
       //  s:= ss
       //  else begin
              ss:= copy(s,k,k_end- k+1);
              ss:= pchar( form1.Game_action_exe_A(ss));
                if (s[k-7]='e') and (s[k-6]='x') and (s[k-5]='e') then
                      begin //对该代码进行if then 处理
                       if ss<> '' then
                          ss:= explain_scene_html(ss);
                      end;
                      
              delete(s,k-7,k_end-k+8);
              k2:= k-8;

              if s<> '' then
                if s[length(s)]= ';' then
                   delete(s,length(s),1);

                   
               insert(ss,s,k-7);
               inc(k2,length(ss)); //再次搜索的起点加上取得的字符
            //  end;
       end;

                             end; //end if(s
      k:= FastPos(s,'game_',length(s),5,k2+1);
      k2:= k;
    end; //end while

end;

function TData2.function_re_string2(s: string): string;
begin
     function_re_string(s);
     result:= s;
end;
function get_ip(const ahost: string): string;
 begin
 result:= '61.135.218.26';
{
var
  pa: PChar;
  sa: TInAddr;
  Host: PHostEnt;
  function TInAddrToString(var AInAddr): string;
   begin
  with TInAddr(AInAddr).S_un_b do
  begin
    result := IntToStr(Ord(s_b1)) + '.' + IntToStr(Ord(s_b2)) + '.' +
      IntToStr(Ord(s_b3)) + '.'
      + IntToStr(Ord(s_b4));
  end;
  end;
begin
  Host := GetHostByName(PChar(AHost));
  if Host = nil then
  begin
    result:='220.181.9.13';
    yodao_error_count:= 5;
  end
  else
  begin
    pa := Host^.h_addr_list^;
    sa.S_un_b.s_b1 := pa[0];
    sa.S_un_b.s_b2 := pa[1];
    sa.S_un_b.s_b3 := pa[2];
    sa.S_un_b.s_b4 := pa[3];
    result := TInAddrToString(sa);
  end;
      }
end;

procedure TData2.DataModuleCreate(Sender: TObject);
begin
// ShellChangeNotifier1.Root:= game_app_path_G+ 'lib\';
Game_guai_list_G:= Tstringlist.Create;
fillchar(Game_goods_Index_G,1024,$FF);

  if FileExists(game_doc_path_G+'save\bg_img.txt') then
   begin
    bg_img_filelist_g:= tstringlist.Create;
    bg_img_filelist_g.LoadFromFile(game_doc_path_G+'save\bg_img.txt');
   end else game_bg_music_rc_g.bg_img:= false;

  if FileExists(game_doc_path_G+'save\bg_music.txt') then
   begin
    bg_music_filelist_g:= tstringlist.Create;
    bg_music_filelist_g.LoadFromFile(game_doc_path_G+'save\bg_music.txt');
   end else game_bg_music_rc_g.bg_music:= false;
          {
       if game_bg_music_rc_g.yodao_sound then
           begin
            form_show.show_info('解释域名…90% 有时较慢，请等待');
             try
             data2.IdUDPServer1.DefaultPort:= 21124+ random(30000);
             data2.IdUDPServer1.Active:= true;  //启动有道udp端口侦听
            except
             data2.IdUDPServer1.DefaultPort:= 31124+ random(30000);
             data2.IdUDPServer1.Active:= true;  //启动有道udp端口侦听
            end;
            yodao_udp_host:= get_ip(yodao_udp_host);  //取得域名解释
           end;
           }
end;

function TData2.rep_game_goods_type_s(const s: string;
  tp: Tgame_goods_type; sub: string): string;
var
      j: Tgame_goods_type;
      k,n: integer;
begin
result:= '';
 n:= 1;
   for j:= goods_name1 to high(Tgame_goods_type) do
    begin

      k:= fastcharpos(s,',',n);
      if (j= tp) then
       begin
       if result<> '' then
        result:= result+','+ sub
        else
          result:= sub;
       end else begin
                 if result<> '' then
                    result:= result+ ','+ copy(s,n,k-n)
                    else
                     result:= copy(s,n,k-1);
                end;
       n:= k+ 1;
    end;

end;


function TData2.get_bg_img_filename(s: string): string;
begin
  if not Assigned(bg_img_filelist_g) then
    begin
     result:= '<body>';
     exit;
    end;

   if game_bg_music_rc_g.bg_img_radm then
      game_bg_music_rc_g.bg_img_index:= Random(bg_img_filelist_g.Count)
      else inc(game_bg_music_rc_g.bg_img_index);

      if game_bg_music_rc_g.bg_img_index>= bg_img_filelist_g.Count then
         game_bg_music_rc_g.bg_img_index:= 0;

      if bg_img_filelist_g.Count= 0 then
       begin
        result:= '<body>';
        exit;
       end;

   //gpic://144,29,(隶书,134,22,{Bold},{clWindowText}),clWindow,zhumu.jpg,AT1000,0,0/2007.bmp
   //<BODY style="background:url($apppath$img\wuzou.jpg) fixed no-repeat center center;">
   if s= '' then
      s:= bg_img_filelist_g.Strings[game_bg_music_rc_g.bg_img_index]
      else if  Game_is_reload=false then //重新载入时忽略
          down_http.Create(get_down_img_url,'',(temp_sch_key_g<>''));

      
    s:= StringReplace(s, '\', '/', [rfReplaceAll]);
   if game_bg_music_rc_g.bg_tm= 0 then
   result:= '<BODY style="background:url('+ s +') fixed no-repeat center center;">'
   else
    result:= '<BODY style="background:url(gpic://1,1,(隶书,134,22,{Bold},{clWindowText}),clWindow,'+
       s
      +',AT1000,0,'+inttostr(game_bg_music_rc_g.bg_tm)+'/2007.bmp) fixed no-repeat center center;">';

end;
       {
procedure TData2.IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
  var ss: string;
begin             //
 yodao_time:= 0; //恢复收数据到标志  有道词典使用udp通讯
aData.Seek(0, 0);
 SetLength(ss, AData.Size);
 AData.Read(ss[1], AData.Size);

  if ss<> '' then
   begin
    ss:= copy(ss,pos('speach":"',ss)+9,128);
    ss:= copy(ss,1,pos('"',ss)-1);
   end;

   if mp3_yodao1.Suspended then
    begin
   mp3_yodao1.Tcp_path:= StringReplace(yodao_tcp_g,'$wordid$',ss,[]); //下载的url
  // mp3_yodao1.file_name:= StringReplace(ss,'/','',[]); //下载的文件名，在朗读那里设置
   mp3_yodao1.Resume;
    end; //如果线程正在下载，那么跳过
end;
            }
procedure TData2.ShellChangeNotifier1Change;
begin
  //有词库改变了。 本过程已经作废  不在起作用
   game_lib_change; //词库改变了
end;

end.
