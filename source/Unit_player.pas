unit Unit_player;

interface
 uses classes,sysutils;

type
  //人物属性
 {
0。金钱         0 号记录
1。幸运值
2。速度
3。攻击力
4。是否上场--同时上场的只能5个，主角占了一个，上场等于1
5。体力
6。灵力
7。智力
8。生命值
9。道德值
10。威望值
11。性格

12。性别
13。贪婪
14。主角对其的爱情值
15。对主角的爱情值
16。对主角信任度
17。主角对其信任度
18。辅助记录
19。经验值
20。防护值
21.。外表
22。谈话前后文编号
23。谈话游标，为了快速查找对话用
24  下次升级
25  固定体力 50
26 固定灵力 0
27 固定生命值 100
28当前等级
29临时隐藏，双人背单词时用，隐藏其他人
30,关闭单词延迟显示的次数
31,临时防护系数
32,图标序号
33，头衔
}
   Tgame_one_value=(g_money,g_luck,g_speed,g_attack,g_hide,g_tili,g_lingli,g_intellect,
                   g_life,g_morality,g_weiwang,g_character,g_sex,g_cupidity,g_love,g_loveme,
                   g_believeMe,g_believe,g_fuzu,g_experience{经验},g_defend,g_face,g_talk22,
                   g_talkid23,g_upgrade,g_gdtl25,g_gdll26,g_gdsmz27,g_grade,
                   g_tmp_hide,g_30_yanchi,g_linshifang,g_icon_index,g_touxian);
 pplayer= ^Tplayer;
 Tplayer = class(TPersistent)
  private
   Fname: string;
   Fvalues: array[0..63] of integer;
   Fpl_accouter1: array[0..9] of integer; //装备，十个，0号记录暂时未用
   Fpl_ji_array: array[0..23] of integer;   //技能列表
   Fpl_fa_array: array[0..63] of integer; //法术列表
    FtalkChar1: char;
    FtalkChar4: char;
    FtalkChar5: char;
    FtalkChar2: char;
    FtalkChar3: char;
    Foldname: string;
    procedure setFname(const Value: string);
    function get_values(Index: Integer): integer; //属性
    procedure set_values(Index: Integer; const Value: integer);
    procedure setFtalkChar(const Value: char);
    procedure setFtalkChar2(const Value: char);
    procedure setFtalkChar3(const Value: char);
    procedure setFtalkChar4(const Value: char);
    procedure setFtalkChar5(const Value: char);
    procedure setFoldname(const Value: string);
    function get_pl_accouter1(Index: Integer): integer;
    function get_pl_fa_array(Index: Integer): integer;
    function get_pl_ji_array(Index: Integer): integer;
    procedure set_pl_accouter1(Index: Integer; const Value: integer);
    procedure set_pl_fa_array(Index: Integer; const Value: integer);
    procedure set_pl_ji_array(Index: Integer; const Value: integer);
  protected

  public
   constructor Create(const FileName: string); overload;
   property plname: string read Fname write setFname;
   property plvalues[Index: Integer]: integer read get_values write set_values; //读取游戏属性
   property pl_accouter1[Index: Integer]: integer read get_pl_accouter1 write set_pl_accouter1; //装备，十个，0号记录暂时未用  array[0..9] of
   property pl_ji_array[Index: Integer]: integer read get_pl_ji_array write set_pl_ji_array;   //技能列表  array[0..23] of
   property pl_fa_array[Index: Integer]: integer read get_pl_fa_array write set_pl_fa_array; //法术列表 array[0..63] of
   property PlTalkChar1: char read FtalkChar1 write setFtalkChar;
   property PlTalkChar2: char read FtalkChar2 write setFtalkChar2;
   property PlTalkChar3: char read FtalkChar3 write setFtalkChar3;
   property PlTalkChar4: char read FtalkChar4 write setFtalkChar4;
   property PlTalkChar5: char read FtalkChar5 write setFtalkChar5;
   procedure get_pl_ji_p(st1: Tstringlist); //获取技能列表
   procedure get_pl_fa_p(st1: Tstringlist); //获取法术列表
   procedure saveupp(const filename: string); //保存人物文件
   property pl_old_name: string read Foldname write setFoldname;  //原始名称
   procedure add_fa(id: integer);   //添加法术
   procedure add_ji(id: integer); //添加技能
   procedure change_g_morality(i: integer); //加减道德值
   function get_name_and_touxian: string;
  end;

implementation
   uses unit_data,unit_net;
{ Tplayer }

procedure Tplayer.add_fa(id: integer); //添加法术
var i: integer;
begin
  for i:= 0 to 63 do
   if pl_fa_array[i]= 0 then
    begin
      pl_fa_array[i]:= set_H_8(id,1);
      exit;
    end else begin
              if get_L_16(pl_fa_array[i])= id then
                exit; //如果已经学过了，退出
             end;

end;

procedure Tplayer.add_ji(id: integer); //添加技能
var i: integer;
begin
  for i:= 0 to 23 do
   if pl_ji_array[i]= 0 then
    begin
      pl_ji_array[i]:= set_H_8(id,1);
      exit;
    end else begin
              if get_L_16(pl_ji_array[i])= id then
                exit; //如果已经学过了，退出
             end;

end;

procedure Tplayer.change_g_morality(i: integer);
begin
    Fvalues[ord(g_morality)]:= Fvalues[ord(g_morality)] + i;
end;

constructor Tplayer.Create(const FileName: string);
var str1: Tstringlist;
    i: integer;
    ss: string;
begin
 inherited Create;

 if FileName= 'net' then
  begin
   pl_old_name:= '无名';
  end else begin
  str1:= Tstringlist.Create;
  Data2.Load_file_upp(filename,str1);
   if str1.Count> 0 then
    begin
     if str1.Strings[0] <> ExtractFileName(filename) then
       begin
         exit;
       end else str1.Delete(0);
    end else exit;

    for i:= 0 to str1.Count-1 do
     begin
      case i of
       0: ss:= str1.Strings[0];      //姓名
       1..64: plvalues[i-1]:= strtoint(str1.Strings[i]);  //属性
       65..74: pl_accouter1[i-65]:= strtoint(str1.Strings[i]);    //装备
       75..98: pl_ji_array[i-75]:= strtoint(str1.Strings[i]);       //技能
       99..162: pl_fa_array[i-99]:= strtoint(str1.Strings[i]);       //法术
        //如果修改了这里的结束值 162，那么在保存人物属性事件内也需相应修改
       end;
     end;
  str1.Free;

  //检查姓名内是否有包含老的用户名
    i:= pos('<!!!',ss);
   if i> 0 then
    begin
     plname:= copy(ss,1,i-1);
     pl_old_name:= copy(ss,i+ 4, length(ss)-i-3); //取得原始用户名，用于聊天语句匹配
    end
   else begin
         plname:= ss;
          pl_old_name:= ss; //保存原始用户名
        end;
          end; //end net
end;
          
function Tplayer.get_name_and_touxian: string; //取得名称和头像的合成
begin
  if plvalues[ord(g_touxian)] > 0 then
   result:= plname+ '('+ game_get_touxian(plvalues[ord(g_touxian)] -1) +')'
   else
    result:= plname;
end;
           {获取法术列表}
function Tplayer.get_pl_accouter1(Index: Integer): integer;
begin
    if (index < 0) or (index > 9) then
   result:= 0
   else
     result:= fpl_accouter1[index];
end;

function Tplayer.get_pl_fa_array(Index: Integer): integer;
begin
      if (index < 0) or (index > 63) then
   result:= 0
   else
     result:= fpl_fa_array[index];
end;

procedure Tplayer.get_pl_fa_p(st1: Tstringlist);
var i,j,k: integer;
   // game_fa_begin_c,game_fa_end_c: integer;
   // str1: Tstringlist;
begin
{ str1:= Tstringlist.Create;
  Data2.Load_file_upp(data2.game_app_path+ 'dat\const.upp',str1);
  game_fa_begin_c:= strtoint(str1.Values['game_fa_begin_c']);
  game_fa_end_c:=  strtoint(str1.Values['game_fa_end_c']);  }
  for i:= 0 to 63 do
   if pl_fa_array[i] > 0 then
    begin
      j:= get_L_16(pl_fa_array[i]);  //得到法术编号
       k:= get_H_8(pl_fa_array[i]); //得到法术等级
      st1.Append(Data2.get_game_fa(j)+' 等级'+ inttostr(k));
    end;
  //str1.Free;
end;
            
function Tplayer.get_pl_ji_array(Index: Integer): integer;
begin
  if (index < 0) or (index > 23) then
   result:= 0
   else
     result:= fpl_ji_array[index];
end;
          {获取技能列表}
procedure Tplayer.get_pl_ji_p(st1: Tstringlist);
var i,j,k: integer;
     //game_ji_begin_c,game_ji_end_c: integer;
     //str1: Tstringlist;
begin
 { str1:= Tstringlist.Create;
  Data2.Load_file_upp(data2.game_app_path+ 'dat\const.upp',str1);
  game_ji_begin_c:= strtoint(str1.Values['game_ji_begin_c']);
  game_ji_end_c:=  strtoint(str1.Values['game_ji_end_c']); }
  for i:= 0 to 23 do
   if pl_ji_array[i] > 0 then
     begin
      j:= get_L_16(pl_ji_array[i]);  //得到编号
       k:= get_H_8(pl_ji_array[i]); //得到等级
      st1.Append(Data2.get_game_ji(j)+' 等级'+ inttostr(k));
     end;
  // str1.Free;
end;

function Tplayer.get_values(Index: Integer): integer;
begin
   if (index < 0) or (index > 63) then
   result:= 1
   else
     result:= Fvalues[index];
end;

procedure Tplayer.saveupp(const filename: string);
var str1: Tstringlist;
    i: integer;
begin
   //创建人物数据表
   str1:= Tstringlist.Create;
    str1.Append(ExtractFileName(filename));
     for i:= 0 to 162 do
     begin
      case i of
       0: str1.Append(plname + '<!!!' +pl_old_name);     //姓名
       1..64: str1.Append(inttostr(plvalues[i-1])); //属性
       65..74: str1.Append(inttostr(pl_accouter1[i-65]));    //装备
       75..98: str1.Append(inttostr(pl_ji_array[i-75]));       //技能
       99..162: str1.Append(inttostr(pl_fa_array[i-99]));       //法术
       end;
     end;

   data2.save_file_upp(filename,str1); //保存upp文件
   str1.Free;
end;

procedure Tplayer.setFname(const Value: string);
begin
  if length(value) > 24 then
   fname:= copy(value,1,24)
   else
    Fname := Value;
end;

procedure Tplayer.setFoldname(const Value: string);
begin
  Foldname := Value;
end;

procedure Tplayer.setFtalkChar(const Value: char);
begin
  FtalkChar1 := Value;
end;

procedure Tplayer.setFtalkChar2(const Value: char);
begin
  FtalkChar2 := Value;
end;

procedure Tplayer.setFtalkChar3(const Value: char);
begin
  FtalkChar3 := Value;
end;

procedure Tplayer.setFtalkChar4(const Value: char);
begin
  FtalkChar4 := Value;
end;

procedure Tplayer.setFtalkChar5(const Value: char);
begin
  FtalkChar5 := Value;
end;

procedure Tplayer.set_pl_accouter1(Index: Integer; const Value: integer);
begin
   if (index > 9) or (index < 0) then
    exit;

    if Game_at_net_G then //联网时，发送自己的改动信息到服务器
     if (fpl_accouter1[index]<> value) and (Fvalues[34]= my_s_id_g) then
        data_net.send_player_Fvalues(index+64,fpl_accouter1[index],value);
      //) and (Fvalues[34]= my_s_id_g)
  if (Game_at_net_G=false) or (Fvalues[34]= my_s_id_g) then
     Fpl_accouter1[index]:= value;
end;

procedure Tplayer.set_pl_fa_array(Index: Integer; const Value: integer);
begin
    if (index > 63) or (index < 0) then
    exit;

    if Game_at_net_G then //联网时，发送改动信息到服务器
     if (fpl_fa_array[index]<> value) and (Fvalues[34]= my_s_id_g) then
      data_net.send_player_Fvalues(index+98,Fpl_fa_array[index],value);
  //
  if (Game_at_net_G=false) or (Fvalues[34]= my_s_id_g) then
  Fpl_fa_array[index]:= value;
end;

procedure Tplayer.set_pl_ji_array(Index: Integer; const Value: integer);
begin
    if (index > 23) or (index < 0) then
    exit;

    if Game_at_net_G then //联网时，发送改动信息到服务器
     if (Fpl_ji_array[index]<> value) and (Fvalues[34]= my_s_id_g) then
      data_net.send_player_Fvalues(index+74,Fpl_ji_array[index],value);
  //
  if (Game_at_net_G=false) or (Fvalues[34]= my_s_id_g) then
  Fpl_ji_array[index]:= value;
end;

procedure Tplayer.set_values(Index: Integer; const Value: integer);
begin
  if (index > 63) or (index < 0) then
    exit;

    if Game_at_net_G then //联网时，发送改动信息到服务器
     if (Fvalues[index]<> value) and (Fvalues[34]= my_s_id_g) then
      data_net.send_player_Fvalues(index,Fvalues[index],value);
 //
  if (Game_at_net_G=false) or (Fvalues[34]= my_s_id_g) then
  Fvalues[index]:= value;
end;

end.
