unit Unit_goods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus;
 const
  game_zb_star= 16; //在人物属性列表内的装备起始位置，改动装备列表时需修改此值

type
  TForm_goods = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    ListBox2: TListBox;
    ListBox3: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ListBox4: TListBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ListBox5: TListBox;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ListBox6: TListBox;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    ListBox7: TListBox;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    ListBox8: TListBox;
    ListBox9: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    Button16: TButton;
    Button17: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    TabSheet8: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ListBox7Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ListBox2DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox2MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ListBox7DblClick(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure ListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListBox3DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox3MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ListBox3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure CreateParams(var Para:TCreateParams);override;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TabSheet8Show(Sender: TObject);
  private
    { Private declarations }
    FMonoBitmap: Tbitmap;
    procedure game_role_list_p; //人物列表
    procedure game_role_goods_show(n: string); //人物装备显示
    procedure game_show_goods_all; //显示全部物品

    procedure set_game_wp(add: boolean; t: integer); //添加或者卸载装备，后一个参数是装备号，1表示帽子
    procedure add_zb(tt: Tlistbox; id: integer); //增加装备
    procedure lost_zb(tt: Tlistbox); //丢弃装备
    procedure unload_zb(id: integer); //卸载装备
    procedure game_zb_Refresh; //刷新当前人物的装备和物品列表
    function get_zb_id_listbox4: integer; //返回当前装备的穿戴号，无效返回零
    function is_man_woman(i2: integer): boolean; //判断是否可以穿，是否符合男女式样
    procedure eat_food(id: integer); //消费一个可食用物品
    function is_can_add_listbox3: boolean; //是否够等级携带武器
    function get_dengji: integer; //获取当前人物的等级
  public
    { Public declarations }
    function get_goods_id(const s: string): integer; //获取物品编号
    procedure set_align_at(box: tlistbox); //设置数量对齐
    procedure draw22(Canvas: TCanvas; X, Y,w,h, i: Integer); //画一个缩小的图

  end;

var
  Form_goods: TForm_goods;

implementation
  uses unit_player,unit1, Unit_data,unit_pop,FastStrings,unit_pic,unit_dwjh,unit_net;
{$R *.dfm}

{ TForm_goods }

procedure TForm_goods.game_role_goods_show(n: string);  //人物装备属性显示
var i,j: integer;
    str1: Tstringlist;
begin
str1:= Tstringlist.Create;

 for i:= 0 to Game_role_list.Count-1 do
    begin
     if Assigned(game_role_list.Items[i]) then
       if Tplayer(game_role_list.Items[i]).get_name_and_touxian = n then
          begin
           checkbox1.Checked:= (game_read_values(i,ord(g_hide))= 0); //是否隐藏，0表示隐藏
           checkbox1.Visible:= (listbox1.ItemIndex > 0); //主角不允许设置隐藏
           listbox2.Items.Clear;
           listbox2.Items.Append('属性');
           if n='无名' then
           listbox2.Items.Append('姓名：'+ n + '（想改名吗，来“易名轩”吧。）')
           else
           listbox2.Items.Append('姓名：'+ n);
            if game_read_values(i,12)= 0 then
               listbox2.Items.Append('性别：女')
               else
                listbox2.Items.Append('性别：男');  //12。性别
           listbox2.Items.Append('等级：'+ inttostr(game_read_values(i,28)));

           listbox2.Items.Append(format('生命值：%d/%d', [game_read_values(i,8),
                                                          game_read_values(i,27)])); //8。生命值
           listbox2.Items.Append(format('体力：%d/%d', [game_read_values(i,5),
                                                          game_read_values(i,25)]));  //5。体力
           listbox2.Items.Append(format('灵力：%d/%d', [game_read_values(i,6),
                                                          game_read_values(i,26)]));   //6。灵力
           listbox2.Items.Append('速度：'+ inttostr(game_read_values(i,2))); //2。速度
           listbox2.Items.Append('攻击：'+ inttostr(game_read_values(i,3))); //3。攻击力
           listbox2.Items.Append('防护：'+ inttostr(game_read_values(i,20)));   //20。防护值
           listbox2.Items.Append('智力：'+ inttostr(game_read_values(i,7)));  //7。智力
           listbox2.Items.Append('幸运：'+ inttostr(game_read_values(i,1)));
           listbox2.Items.Append('经验值：'+ inttostr(game_read_values(i,19)));  //19。经验值
           listbox2.Items.Append('下次升级：'+ inttostr(game_read_values(i,24)));
           listbox2.Items.Append('金币：'+ inttostr(game_read_values(i,0)));   //0。金钱         0 号记录

            listbox2.Items.Append('');
            listbox2.Items.Append('装备');
               for j:= zb_td1 to zb_yg1 do
                begin
                  case j of
                   zb_td1: listbox2.Items.Append('头戴：'+ Data2.get_game_goods_type_a(Tplayer(game_role_list.Items[i]).pl_accouter1[j]));
                   zb_sc1: listbox2.Items.Append('身穿：'+ Data2.get_game_goods_type_a(Tplayer(game_role_list.Items[i]).pl_accouter1[j]));
                   zb_pf1: listbox2.Items.Append('披风：'+ Data2.get_game_goods_type_a(Tplayer(game_role_list.Items[i]).pl_accouter1[j]));
                   zb_jc1: listbox2.Items.Append('脚穿：'+ Data2.get_game_goods_type_a(Tplayer(game_role_list.Items[i]).pl_accouter1[j]));
                   zb_hw1: listbox2.Items.Append('护腕：'+ Data2.get_game_goods_type_a(Tplayer(game_role_list.Items[i]).pl_accouter1[j]));
                   zb_jz1: listbox2.Items.Append('戒指：'+ Data2.get_game_goods_type_a(Tplayer(game_role_list.Items[i]).pl_accouter1[j]));
                   zb_xl1: listbox2.Items.Append('项链：'+ Data2.get_game_goods_type_a(Tplayer(game_role_list.Items[i]).pl_accouter1[j]));
                   zb_wq1: listbox2.Items.Append('武器：'+ Data2.get_game_goods_type_a(Tplayer(game_role_list.Items[i]).pl_accouter1[j]));
                   zb_yg1: listbox2.Items.Append('腰挂：'+ Data2.get_game_goods_type_a(Tplayer(game_role_list.Items[i]).pl_accouter1[j]));
                  end;
                end;
            game_show_goods_all; //显示全部物品
            //显示技能和仙术
               str1.Clear;
               listbox8.items.Clear;
             Tplayer(game_role_list.Items[i]).get_pl_ji_p(str1);
               listbox8.items.text:= str1.Text;
               str1.Clear;
               listbox9.items.Clear;
             Tplayer(game_role_list.Items[i]).get_pl_fa_p(str1);
               listbox9.items.text:= str1.Text;
            break;
          end;
    end;
 str1.Free;
end;

procedure TForm_goods.game_role_list_P;  //游戏人物列表
var i: integer;
begin
 if game_role_list.Count=0 then
  begin
   messagebox(handle,'游戏没有开始，请先开始游戏或者载入进度。','游戏没开始',mb_ok);
   exit;
  end;

  listbox1.Items.Clear;
   for i:= 0 to Game_role_list.Count-1 do
    begin
     if Assigned(game_role_list.Items[i]) then
      listbox1.Items.add(Tplayer(game_role_list.Items[i]).get_name_and_touxian);
    end;

end;

procedure TForm_goods.FormShow(Sender: TObject);
begin
   game_role_list_P;  //游戏人物列表
   if listbox1.Items.Count> 0 then
      game_role_goods_show(listbox1.Items.Strings[0]);  //人物装备属性显示

   if listbox1.ItemIndex= -1 then
      listbox1.ItemIndex:= 0;

   checkbox1.Enabled:= not Game_is_only_show_G; //仅显示指定人物时，该控件间被禁用。

    TabSheet8.TabVisible:= game_at_net_g; //联网界面
     button16.Visible:= not game_at_net_g;
     
    if Assigned(form_dwjh) then
      if game_at_net_g and form_dwjh.Showing then
          form_dwjh.Close;
end;

procedure TForm_goods.game_show_goods_all; //显示全部物品
var i,i88: integer;
    ss,ss2: string;
    procedure add_to_listbox(i2: integer;l2: Tlistbox);
     begin
      l2.Items.Append(game_add_shuliang_string(ss2,read_goods_number(i2)));
     end;
begin
listbox3.Items.Clear;
listbox4.Items.Clear;
listbox5.Items.Clear;
listbox6.Items.Clear;
listbox7.Items.Clear;
label1.Caption:= '名称  数量  详细介绍';
label2.Caption:=label1.Caption;
label3.Caption:=label1.Caption;
label4.Caption:=label1.Caption;
label5.Caption:=label1.Caption;

  for i:= 1 to 1023 do
   begin
    if read_goods_number(i) <> 0 then
     begin
      ss:= Data2.game_memini1.ReadString('GOODS',inttostr(i),'');  //取得字符串
      if (ss<> '') and (length(ss) > 10) then
       begin
       ss2:= ss;
       Data2.get_game_goods_type_a_base(ss2);//获取类型描述
       i88:= strtoint(Data2.get_game_goods_type_s(ss,goods_type1));
        if i88 and 16= 16 then
          add_to_listbox(i,listbox3)
            else if i88 and 1= 1 then
                                 add_to_listbox(i,listbox4)
            else if i88 and 2= 2 then
                                 add_to_listbox(i,listbox5)
            else if i88 and 8= 8 then
                                 add_to_listbox(i,listbox6)
            else if (i88 and 64= 64) or (i88 and 4= 4) or (i88 and 256= 256) then
                   begin
                   //取描述和名称
                    ss2:=  data2.get_game_goods_type_s(ss,goods_name1) + ',' +
                           data2.get_game_goods_type_s(ss,goods_ms1);
                                 add_to_listbox(i,listbox7);
                   end
            else if strtoint(Data2.get_game_goods_type_s(ss,goods_type1)) and 128= 128 then
                                begin
                                 ss2:= data2.get_game_goods_type_s(ss,goods_name1) + ','+
                                       data2.get_game_goods_type_s(ss,goods_ms1);
                                 add_to_listbox(i,listbox7);
                                end;
       end; //end if ss
     end;  //end if Game_goods_G[i]
   end; //end for

   listbox2.ItemIndex:= 0;  //定位到物品项首
   set_align_at(listbox3);  //数量对齐显示
   set_align_at(listbox4);
   set_align_at(listbox5);
   set_align_at(listbox6);
   set_align_at(listbox7);
end;

procedure TForm_goods.ListBox1Click(Sender: TObject);
begin
 if listbox1.Tag= 0 then
 if listbox1.ItemIndex<> -1 then
     game_zb_Refresh;
end;

procedure TForm_goods.Button2Click(Sender: TObject);
begin
  //卸载武器
   unload_zb(zb_wq1);
end;

procedure TForm_goods.Button3Click(Sender: TObject);
begin
 //丢弃武器
  lost_zb(listbox3);
end;

function TForm_goods.get_goods_id(const s: string): integer;
var i: integer;
    ss,ss2: string;
begin
result:= 0;
 if s<> '' then
 begin
   i:= fastcharpos(s,',',1);
  if i > 0 then
     ss:= copy(s,1,i-1)
     else
      ss:= s;

 for i:= 1 to 1023 do
  begin
    if read_goods_number(i) = 0 then
      Continue; //跳过我方不存在的物品

      ss2:= Data2.game_memini1.ReadString('GOODS',inttostr(i),'');
    if ss= Data2.get_game_goods_type_s(ss2,goods_name1) then
     begin
      result:= i;
      exit;
     end;
  end; //end i

     for i:= 1 to 1023 do
      begin
    if read_goods_number(i) > 0 then
      Continue; //跳过已经存在的物品

      ss2:= Data2.game_memini1.ReadString('GOODS',inttostr(i),'');
       if length(ss2)< 10 then
         continue; //特短的字符串跳过
    if ss= Data2.get_game_goods_type_s(ss2,goods_name1) then
     begin
      result:= i;
      exit;
     end;
    end; //end i

 end;
end;

procedure TForm_goods.Button1Click(Sender: TObject);
begin
  //装备武器,穿戴号 8
    if is_can_add_listbox3 then
       add_zb(listbox3,zb_wq1)
       else messagebox(handle,'不能装备此武器。等级不够或者男女不匹配。','错误',mb_ok);
end;

procedure TForm_goods.set_game_wp(add: boolean; t: integer);
var  pl: Tplayer;
begin
  //添加或者卸载装备，后一个参数是装备号，1表示帽子
  {1: '头戴：'+ game_role_list.Items[i]).pl_accouter1[j]));
  2: '身穿：'+ game_role_list.Items[i]).pl_accouter1[j]));
  3: '披风：'+ game_role_list.Items[i]).pl_accouter1[j]));
  4: '脚穿：'+ game_role_list.Items[i]).pl_accouter1[j]));
  5: '护腕：'+ game_role_list.Items[i]).pl_accouter1[j]));
  6: '戒指：'+ game_role_list.Items[i]).pl_accouter1[j]));
  7: '项链：'+ game_role_list.Items[i]).pl_accouter1[j]));
  8: '武器：'+ game_role_list.Items[i]).pl_accouter1[j]));
  9: '腰挂：'+ game_role_list.Items[i]).pl_accouter1[j])); }
  pl:= Tplayer(game_role_list.Items[listbox1.ItemIndex]);
   if pl= nil then
     exit;
   

 if add then
  begin
    pl.plvalues[1]:=pl.plvalues[1]+ data2.get_game_goods_type(pl.pl_accouter1[t],goods_y1);  //幸运值
    pl.plvalues[2]:=pl.plvalues[2]+ data2.get_game_goods_type(pl.pl_accouter1[t],goods_s1);   //2。速度
    pl.plvalues[3]:=pl.plvalues[3]+ data2.get_game_goods_type(pl.pl_accouter1[t],goods_g1);  // 3。攻击力
    pl.plvalues[7]:=pl.plvalues[7]+ data2.get_game_goods_type(pl.pl_accouter1[t],goods_z1);   //7。智力
    pl.plvalues[20]:=pl.plvalues[20]+ data2.get_game_goods_type(pl.pl_accouter1[t],goods_f1);  // 20。防护值
    pl.plvalues[25]:=pl.plvalues[25]+ data2.get_game_goods_type(pl.pl_accouter1[t],goods_t1);   //25  固定体力 50
    pl.plvalues[26]:=pl.plvalues[26]+ data2.get_game_goods_type(pl.pl_accouter1[t],goods_L1);  // 26 固定灵力 0
    pl.plvalues[27]:=pl.plvalues[27]+ data2.get_game_goods_type(pl.pl_accouter1[t],goods_m1);  // 27 固定生命值 100
  end else begin
       if pl.pl_accouter1[t]= 0 then
          exit;
    pl.plvalues[1]:=  pl.plvalues[1]- data2.get_game_goods_type(pl.pl_accouter1[t],goods_y1);  //幸运值
    pl.plvalues[2]:=  pl.plvalues[2]- data2.get_game_goods_type(pl.pl_accouter1[t],goods_s1);   //2。速度
    pl.plvalues[3]:=  pl.plvalues[3]- data2.get_game_goods_type(pl.pl_accouter1[t],goods_g1);  // 3。攻击力
    pl.plvalues[7]:=  pl.plvalues[7]- data2.get_game_goods_type(pl.pl_accouter1[t],goods_z1);   //7。智力
    pl.plvalues[20]:= pl.plvalues[20]- data2.get_game_goods_type(pl.pl_accouter1[t],goods_f1);  // 20。防护值
    pl.plvalues[25]:= pl.plvalues[25]- data2.get_game_goods_type(pl.pl_accouter1[t],goods_t1);   //25  固定体力 50
    pl.plvalues[26]:= pl.plvalues[26]- data2.get_game_goods_type(pl.pl_accouter1[t],goods_L1);  // 26 固定灵力 0
    pl.plvalues[27]:= pl.plvalues[27]- data2.get_game_goods_type(pl.pl_accouter1[t],goods_m1);  // 27 固定生命值 100
              if pl.plvalues[5] > pl.plvalues[25] then
                 pl.plvalues[5]:= pl.plvalues[25];
              if  pl.plvalues[6] > pl.plvalues[26] then
                 pl.plvalues[6]:= pl.plvalues[26];
              if pl.plvalues[8] > pl.plvalues[27] then
                 pl.plvalues[8]:= pl.plvalues[27];
           end;
end;

procedure TForm_goods.add_zb(tt: Tlistbox; id: integer);  //增加装备
var pl: Tplayer;
    i: integer;
begin
  //装备武器
   if listbox1.ItemIndex<> -1 then
    begin
      if tt.ItemIndex < 0 then
         tt.ItemIndex:= 0;

     i:= get_goods_id(tt.Items[tt.ItemIndex]);
      if i> 0 then
       begin
         pl:= Tplayer(game_role_list.Items[listbox1.ItemIndex]);

            write_goods_number(i,-1);

          if pl.pl_accouter1[id] > 0 then
            begin
             write_goods_number(pl.pl_accouter1[id],1);
              set_game_wp(false,id); //去掉现有装备带来的属性增加值
            end;
          pl.pl_accouter1[id]:= i;
          //写入装备带来的属性改变
           set_game_wp(true,id); //增加装备带来的属性
         game_zb_Refresh;
       end;
    end;

end;

procedure TForm_goods.lost_zb(tt: Tlistbox);  //丢弃装备
var i2: integer;
begin
  if tt.ItemIndex<> -1 then
    begin
     i2:= get_goods_id(tt.Items[tt.ItemIndex]);
      if messagebox(handle,pchar(format('该物品共有%d件，是否全部丢弃？丢弃后不可恢复。',[read_goods_number(i2)])),'询问', mb_yesno or MB_ICONQUESTION)= mryes then
       begin
        write_goods_number(i2,0); //置零，丢弃数据
        game_zb_Refresh; //刷新
       end;
    end else showmessage('请选择要丢弃的物品。');
end;

procedure TForm_goods.unload_zb(id: integer); //卸载装备
var pl: Tplayer;
begin
   if listbox1.ItemIndex<> -1 then
    begin
      pl:= Tplayer(game_role_list.Items[listbox1.ItemIndex]);
       if pl.pl_accouter1[id] > 0 then
          write_goods_number(pl.pl_accouter1[id],1);
        set_game_wp(false,id);
      pl.pl_accouter1[id]:= 0;
     game_zb_Refresh;
    end;

end;

procedure TForm_goods.Button5Click(Sender: TObject);
begin
  //脱去所穿装备
  if listbox2.ItemIndex <= game_zb_star then
    showmessage('请在左边列表内选择需要脱离的装备。')
    else begin
          unload_zb(listbox2.ItemIndex - game_zb_star);
           game_zb_Refresh;
         end;
end;

procedure TForm_goods.game_zb_Refresh;  //装备，物品刷新
begin

  if (listbox1.ItemIndex> 0) and game_at_net_g then
  begin
   pagecontrol1.Enabled:= false;
   button17.Enabled:= false;
  end else begin
        pagecontrol1.Enabled:= true;
        button17.Enabled:= true;
        game_role_goods_show(listbox1.Items[listbox1.ItemIndex]);
       end;

end;

procedure TForm_goods.Button6Click(Sender: TObject);
begin
 lost_zb(listbox4);  //丢弃装备
end;

procedure TForm_goods.Button4Click(Sender: TObject);
var i: integer;
begin
 //穿戴装备，判断男女

    i:= get_zb_id_listbox4;

    if i> 0 then
     add_zb(listbox4,i)
     else
      messagebox(handle,'不能穿戴，男女款式不匹配或者等级不够。','错误',mb_ok);

end;

function TForm_goods.get_zb_id_listbox4: integer;
var i,j: integer;
begin
result:= 0;
 if listbox4.ItemIndex< 0 then
    listbox4.ItemIndex:= 0;

  i:= get_goods_id(listbox4.Items[listbox4.ItemIndex]);
   if i<> 0  then
    begin
      j:= data2.get_game_goods_type(i,goods_n1);
        if j mod 100 < 5 then
         begin
          if data2.get_game_goods_type(i,goods_y1) > get_dengji then
             exit;  //等级不够，退出
         end;
      if is_man_woman(j) then
        result:= j mod 100;
    end;
end;
                    {返回当前装备是否符合所选人物的性别}
function TForm_goods.is_man_woman(i2: integer): boolean;
   function is_w: boolean; 
    var pl: Tplayer;
    begin  //是否女性
      pl:= Tplayer(game_role_list.Items[listbox1.ItemIndex]);
       result:= (pl.plvalues[12]= 0);
    end;
begin
 {
  i2 > 300,男女均可
  i2> 100 < 200 男
  i2 > 200 < 300 女
 }
  if i2 > 300 then
   result:= true
   else if i2 > 200 then
       result:= is_w
        else result:= not is_w;
end;

procedure TForm_goods.Button9Click(Sender: TObject);
begin
  lost_zb(listbox5);  //丢弃药品食品
end;

procedure TForm_goods.Button12Click(Sender: TObject);
begin
   lost_zb(listbox6);
end;

procedure TForm_goods.Button15Click(Sender: TObject);
begin
 lost_zb(listbox7);
end;

procedure TForm_goods.Button7Click(Sender: TObject);
var i: integer;
begin
  //消耗物品
  if listbox5.ItemIndex < 0 then
   begin
    showmessage('请选择一个物品。');
    exit;
   end;
  i:= get_goods_id(listbox5.Items[listbox5.ItemIndex]);
      if i> 0 then
       begin
        if read_goods_number(i) > 0 then
           write_goods_number(i,-1);
         eat_food(i);
         game_zb_Refresh;
       end;
end;

procedure TForm_goods.eat_food(id: integer);
var  pl: Tplayer;
begin
  pl:= Tplayer(game_role_list.Items[listbox1.ItemIndex]);
   if pl= nil then
     exit;


    pl.plvalues[1]:=  pl.plvalues[1]+ data2.get_game_goods_type(id,goods_y1);  //幸运值
    pl.plvalues[2]:=  pl.plvalues[2]+ data2.get_game_goods_type(id,goods_s1);   //2。速度
    pl.plvalues[3]:=  pl.plvalues[3]+ data2.get_game_goods_type(id,goods_g1);  // 3。攻击力
    pl.plvalues[7]:=  pl.plvalues[7]+ data2.get_game_goods_type(id,goods_z1);   //7。智力
    pl.plvalues[20]:= pl.plvalues[20]+ data2.get_game_goods_type(id,goods_f1);  // 20。防护值
    pl.plvalues[5]:= pl.plvalues[5]+ data2.get_game_goods_type(id,goods_t1);   //25  体力 50
    pl.plvalues[6]:= pl.plvalues[6]+ data2.get_game_goods_type(id,goods_L1);  // 26 灵力 0
    pl.plvalues[8]:= pl.plvalues[8]+ data2.get_game_goods_type(id,goods_m1);  // 27 生命值 100
              if pl.plvalues[5] > pl.plvalues[25] then
                 pl.plvalues[5]:= pl.plvalues[25];
              if  pl.plvalues[6] > pl.plvalues[26] then
                 pl.plvalues[6]:= pl.plvalues[26];
              if pl.plvalues[8] > pl.plvalues[27] then
                 pl.plvalues[8]:= pl.plvalues[27];

end;

function TForm_goods.is_can_add_listbox3: boolean;   //判断是否可以带此武器，男女，等级
var i,i2,j: integer;
begin
result:= false;
   if listbox3.ItemIndex = -1 then
     exit;

 if listbox3.ItemIndex< 0 then
    listbox3.ItemIndex:= 0;

  i:= get_goods_id(listbox3.Items[listbox3.ItemIndex]);
   if i<> 0  then
    begin
      i2:= data2.get_game_goods_type(i,goods_n1); //获取男女式
      j:= data2.get_game_goods_type(i,goods_y1); //获取武器需要的最低等级
       if  is_man_woman(i2) and (get_dengji >= j) then
        result:= true
        else
         result:= false;
    end;

end;

function TForm_goods.get_dengji: integer;
var pl: Tplayer;
begin  //获得当前等级
      pl:= Tplayer(game_role_list.Items[listbox1.ItemIndex]);
       result:= pl.plvalues[28];

end;

procedure TForm_goods.ListBox7Click(Sender: TObject);
var i: integer;
begin
    //按钮状态
   if listbox7.ItemIndex<> -1 then
    begin
      i:= get_goods_id(listbox7.Items.Strings[listbox7.ItemIndex]);
      if i= 0 then
       exit;
       i:= data2.get_game_goods_type(i,goods_type1);
     if i = 128 then
             begin
              //可学习的技能
              button14.Enabled:= true;
              button13.Enabled:= false;
             end else begin
                        //可使用的物品
                        button14.Enabled:= false;
                        button13.Enabled:= true;
                      end;
    end;
end;

procedure TForm_goods.Button14Click(Sender: TObject);
var ss: string;
    pl: Tplayer;
    id2,i,j: integer;
begin

   //学习该技能
   if listbox7.ItemIndex<> -1 then
    begin
     ss:= listbox7.Items.Strings[listbox7.ItemIndex];
     i:= get_goods_id(ss);
     if data2.get_game_goods_type(i,goods_type1)= 128 then
             begin
              //可学习的技能
               //灵速命都为零的，表示技能
                if  listbox1.Itemindex= -1 then
                 begin
                   messagebox(handle,'请选择一个要学习的人物。','需要指定学习人',mb_ok or MB_ICONWARNING);
                   exit;
                 end;

                if messagebox(handle,pchar('是否让：'+ listbox1.Items.Strings[listbox1.Itemindex]+
                    '学习：'+ data2.get_game_goods_type_s(ss,goods_name1)),'询问',mb_yesno or MB_ICONQUESTION)=mrno then
                     exit;

                pl:= Tplayer(game_role_list.Items[listbox1.ItemIndex]);
                  if pl= nil then
                     exit; //无效的人物名
               id2:= get_goods_id(data2.get_game_goods_type_s(ss,goods_name1));
               if id2= 0 then
                 exit; //无效的物品或法术名

                 //判断男女是否合适
                 j:= data2.get_game_goods_type(id2,goods_f1);
                 if (j<> 3) and (pl.plvalues[12]<> j) then
                    begin
                     if j= 1 then
                      messagebox(handle,'该秘籍只适合男性人物学习。','性别不一致',mb_ok or MB_ICONWARNING)
                     else
                     messagebox(handle,'该秘籍只适合女性人物学习。','性别不一致',mb_ok or MB_ICONWARNING);
                     exit;
                    end;
                 //判断等级是否合适
                   j:= data2.get_game_goods_type(id2,goods_n1);
                   if j > pl.plvalues[28] then
                    begin
                      messagebox(handle,pchar('所选人物等级太低，还不能学此秘籍。要求的最低等级是：'+ inttostr(j)+'级'),
                      '等级太低',mb_ok or MB_ICONWARNING);
                     exit;
                    end;
               if (data2.get_game_goods_type(id2,goods_j1)= 3) then
                  begin
                   //技能
                   pl.add_ji(id2);
                  end else begin
                             //法术
                             pl.add_fa(id2);
                           end;

                write_goods_number(i,-1); //减去一
                game_zb_Refresh; //刷新 //学成后丢弃此秘籍
             end;
    end else messagebox(handle,'请选择一个秘籍或物品。','请选择',mb_ok or MB_ICONWARNING);
end;

procedure TForm_goods.Button13Click(Sender: TObject);
var str1: Tstringlist;
    ss,ss2: string;
begin
    //特殊物品的使用
   {
    else
      messagebox(handle,'此物不能在这里使用。','错误',mb_ok or MB_ICONWARNING);
     end;   }

     if listbox7.ItemIndex= -1 then
      begin
       messagebox(handle,'请选择一个秘籍或物品。','请选择',mb_ok or MB_ICONWARNING);
       exit;
      end;

      

     str1:= Tstringlist.Create;

     data2.Load_file_upp(game_app_path_g + 'dat\special.upp',str1);
      ss:=data2.get_game_goods_type_s(listbox7.Items.Strings[listbox7.ItemIndex],goods_name1);
       if ss= '时间加速丸' then
         form_pop.CheckBox8.Checked:= false;  //打开时间加速

      if ss<> '' then
       begin
        ss2:= ss;
        ss:= str1.Values[ss]; //取得特殊物品的用法
        if ss<> '' then
         begin
         form1.game_goods_change_n(ss2,-1); //物品减去一
         ss:= FastAnsiReplace(ss, '$P$', inttostr(listbox1.ItemIndex+ 1), [rfReplaceAll]);
         Data2.function_re_string(ss); //对string 关键字的内容进行取值
         self.Close;
         form1.Game_action_exe_S_adv(ss); //执行脚本
         // game_zb_Refresh; //刷新
         end else begin
                   messagebox(handle,'该物品不能在这里使用。','错误',mb_ok);
                  end;
       end; 
     str1.Free;

 //2,50,立即显示单词解释，关闭3秒延迟20次
//3,100,回城卷，立即离开野外回到最近的城镇。
//4,600,小礼品，可以送给MM

//8,120,小礼品，浦江产的水晶摆件，做工精细，可以送给MM。
//12,1000,小礼品，可以送给MM  极品缅甸玉胸针

//6,11,小礼品，美眉喜欢的东西。
//13,999,黄金做的小猪，极富收藏价值。现在金价看涨，增值潜力巨大。
//14,20000,稀世珍品，名琴赠知音哦。
end;

procedure TForm_goods.CheckBox1Click(Sender: TObject);
var pl: Tplayer;
begin
   if  listbox1.Itemindex= -1 then
      listbox1.Itemindex:= 0;

  pl:= Tplayer(game_role_list.Items[listbox1.ItemIndex]);
     if pl= nil then
        exit; //无效的人物名

     if checkbox1.Checked then
       pl.plvalues[ord(g_hide)]:= 0
        else
           pl.plvalues[ord(g_hide)]:= 1;
end;

procedure TForm_goods.ListBox2DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
ListBox2.Canvas.FillRect(Rect);

     
     ListBox2.Canvas.Font.Size:= 12;
      if Index in[0,16] then
        begin
        ListBox2.Canvas.Font.Style:= [fsbold];
        //ListBox1.Canvas.Font.Color:= clgreen;

        ListBox2.Canvas.TextOut(Rect.Left+20, Rect.Top, ListBox2.Items[Index]);
        end else begin
                  ListBox2.Canvas.Font.Style:= [];
                   ListBox2.Canvas.TextOut(Rect.Left+20, Rect.Top+ 3, ListBox2.Items[Index]);
                 end;

 case index of
   2: begin //性别
       Draw22(ListBox2.Canvas,rect.left+90,rect.top,18,18,Tplayer(Game_role_list.Items[listbox1.ItemIndex]).plvalues[ord(g_Icon_index)]+ 1);
      { if form1.game_sex_from_id(ListBox1.ItemIndex + 1)=1 then
          data2.imagelist1.Draw(ListBox2.Canvas,rect.left+90,rect.top+3,10) //男
          else
             data2.imagelist1.Draw(ListBox2.Canvas,rect.left+90,rect.top+3,9); }
      end;
   3: begin //等级
       data2.imagelist1.Draw(ListBox2.Canvas,rect.left+1,rect.top,7);
      end;
   4: begin  //生命值
       with ListBox2.Canvas do
        begin
       Pen.Width:= 5;
       Pen.Color:= clred;
       MoveTo(rect.left+ 250,rect.top+9);
       LineTo(rect.left+ 330,rect.top+9);
       Pen.Color:= clgreen;
       MoveTo(rect.left+ 250,rect.top+9);
       LineTo(rect.left+ 250 + round(form1.game_get_blood_l(ListBox1.ItemIndex + 1) /
                        form1.game_get_blood_h(ListBox1.ItemIndex + 1) * 80),rect.top+9);
        end;
      end;
   5: begin  //体力值
       with ListBox2.Canvas do
        begin
       Pen.Mode:=pmCopy;
       Pen.Width:= 5;
       Pen.Color:= clred;
       MoveTo(rect.left+ 250,rect.top+9);
       LineTo(rect.left+ 330,rect.top+9);
       Pen.Color:= clblue;
       if form1.game_get_ti_l(ListBox1.ItemIndex + 1)= 0 then
            exit; //为零，不画
       MoveTo(rect.left+ 250,rect.top+9);
       LineTo(rect.left+ 250 + round(form1.game_get_ti_l(ListBox1.ItemIndex + 1) /
                        form1.game_get_ti_h(ListBox1.ItemIndex + 1) * 80),rect.top+9);
        end;
      end;
   6: begin      //灵力值
       if form1.game_get_ling_h(ListBox1.ItemIndex + 1)= 0 then
          exit; //没有灵力时不画出来

       with ListBox2.Canvas do
        begin
       Pen.Mode:=pmCopy;
       Pen.Width:= 5;
       Pen.Color:= clred;
       MoveTo(rect.left+ 250,rect.top+9);
       LineTo(rect.left+ 330,rect.top+9);
         if form1.game_get_ling_l(ListBox1.ItemIndex + 1)= 0 then
            exit; //为零，不画

       Pen.Color:= clpurple;
       MoveTo(rect.left+ 250,rect.top+9);
       LineTo(rect.left+ 250 + round(form1.game_get_ling_l(ListBox1.ItemIndex + 1) /
                        form1.game_get_ling_h(ListBox1.ItemIndex + 1) * 80),rect.top+9);
        end;
      end;
   14: begin  //金钱
       data2.imagelist1.Draw(ListBox2.Canvas,rect.left+1,rect.top,5);
      end;
   end;
end;

procedure TForm_goods.ListBox2MeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  Height:= 19
end;

procedure TForm_goods.ListBox7DblClick(Sender: TObject);
begin
  if button14.Enabled then
     button14click(sender)
    else if button13.Enabled then
            button13click(sender);
end;

procedure TForm_goods.Button16Click(Sender: TObject);
begin
  if game_at_net_g then
    exit;
    
  if listbox1.Items.Count=1 then
   messagebox(handle,'您的队伍内没有朋友可以替您保管钱物。','提示',mb_ok)
   else
     messagebox(handle,'用鼠标把转出人名拖动到转入人名上即可。','提示',mb_ok or MB_ICONINFORMATION);
end;

procedure TForm_goods.ListBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 if game_at_net_g then
    accept:= false
    else
     accept:= (Sender=Source);
end;

procedure TForm_goods.ListBox1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
  var m,i: integer;
begin
  if game_at_net_g then
    exit;
    
    i:= ListBox1.ItemAtPos(Point(x,y),false);
  if i > -1 then
   begin
    if TryStrToInt(inputbox('请输入要转移的金额  ','金额  ',''),m) then
      begin
       if m> 0 then
        begin
        form1.game_move_money(ListBox1.ItemIndex+ 1,i+ 1,m);
        game_zb_Refresh;
        end;
      end;
   end;
end;

procedure TForm_goods.set_align_at(box: tlistbox);
var i,j,k,i2: integer;
    ss: string;
begin
 //设置数量对齐
 j:= 0;
  for i:= 0 to box.Items.Count -1 do
   begin
     k:= fastcharpos(box.Items[i],',',1);
     if k > j then
        j:= k;
   end;

   for i:= 0 to box.Items.Count -1 do
     begin
      ss:= box.Items[i];
      k:= fastcharpos(ss,',',1);
       if k= 0 then
         Continue;

      if (ss[k+ 1]<> ' ') and (k < j) then
       begin
        for i2:= k to j-1 do
           insert(' ',ss,k+1);

        box.Items[i]:= ss;
       end;
     end;
end;

procedure TForm_goods.ListBox3DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  Tlistbox(control).Canvas.FillRect(Rect);

  Tlistbox(control).Canvas.TextOut(Rect.Left+20, Rect.Top+ 3, Tlistbox(control).Items[Index]);
  data2.ImageList_sml.Draw(Tlistbox(control).Canvas,rect.left+2,rect.top+3,
                        Game_goods_Index_G[form_goods.get_goods_id(Tlistbox(control).Items[Index])]);

end;

procedure TForm_goods.ListBox3MeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
   Height:= 21;
end;

procedure TForm_goods.ListBox3MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 TListBox(Sender).Tag:= TListBox(Sender).ItemAtPos(Point(X,Y),True);


        if TListBox(Sender).Tag > -1 then
         if TListBox(Sender).Canvas.TextWidth(TListBox(Sender).Items[TListBox(Sender).Tag]) > TListBox(Sender).ClientWidth-18 then
          begin
          TListBox(Sender).Hint:= TListBox(Sender).Items[TListBox(Sender).tag];
          TListBox(Sender).ShowHint:= true;
          end else begin
                    TListBox(Sender).Hint:= '';
                    TListBox(Sender).ShowHint:= false;
                   end;

end;

procedure TForm_goods.ListBox1DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  Tlistbox(control).Canvas.FillRect(Rect);
   Tlistbox(control).Canvas.CopyMode:=cmSrcCopy;
  Tlistbox(control).Canvas.TextOut(Rect.Left+26, Rect.Top+ 1, Tlistbox(control).Items[Index]);
  draw22(Tlistbox(control).Canvas,Rect.Left,Rect.Top+ 1,24,24,game_read_values(Index,ord(g_Icon_index))+ 1);

end;

procedure TForm_goods.ListBox1MeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
  Height:= 26;
end;

procedure TForm_goods.draw22(Canvas: TCanvas; X, Y,w,h, i: Integer); //画一个缩小的图
var
  R,r2: TRect;
begin
   r.Left:= x;
   r.top:= y;
   r.Right:= x+ w;
   r.Bottom:= y+ h;
   r2.Left:= 0;
   r2.Top:= 0;
   r2.Right:= 48;
   r2.Bottom:= 48;
      if FMonoBitmap = nil then
      begin
        FMonoBitmap := TBitmap.Create;
        with FMonoBitmap do
        begin
          Canvas.CopyMode:=cmSrcCopy;
          Width := 48;
          Height := 48;
        end;
      end;
      { Store masked version of image temporarily in FBitmap }
      FMonoBitmap.Canvas.Brush.Color := clWhite;
      FMonoBitmap.Canvas.FillRect(Rect(0, 0, 48, 48));
      data2.ImageList2.Draw(FMonoBitmap.Canvas,0,0,i);
      Canvas.CopyRect(r,FMonoBitmap.Canvas,r2);

end;

procedure TForm_goods.FormDestroy(Sender: TObject);
begin
  if FMonoBitmap <> nil then
     FMonoBitmap.Free;

end;

procedure TForm_goods.Button17Click(Sender: TObject);
begin
 if listbox1.ItemIndex<> 0 then
   begin
    messagebox(handle,'只能修改主角的头像，请重新选择人物。','确认',mb_ok);
   end else  popupmenu1.Popup(button17.ClientOrigin.X,button17.ClientOrigin.Y+button17.Height);

end;

procedure TForm_goods.N3Click(Sender: TObject);
begin
  messagebox(handle,'请按键盘上的prt screen键，或者用qq的ctrl + alt + A 快捷键拷屏，然后再这里选择“从剪贴板获取头像即可”。','确认',mb_ok);
end;

procedure TForm_goods.N1Click(Sender: TObject);
begin
 if form1.game_sex_from_id(1)=1 then
    form_pic.game_sex:= true
    else
     form_pic.game_sex:= false;

  form_pic.game_cmd:= 1; //从图片载入
  form_pic.ShowModal;
  listbox1.Invalidate;
   listbox2.Invalidate;
end;

procedure TForm_goods.N2Click(Sender: TObject);
begin
   if form1.game_sex_from_id(1)=1 then
    form_pic.game_sex:= true
    else
     form_pic.game_sex:= false;

  form_pic.game_cmd:= 2; //从剪贴板载入
  form_pic.ShowModal;
    listbox1.Invalidate;
   listbox2.Invalidate;
end;

procedure TForm_goods.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
  Para.WndParent:=Form1.Handle;

end;
procedure TForm_goods.FormCreate(Sender: TObject);
begin
    Form_goods.DoubleBuffered:= true;
    listbox2.DoubleBuffered:= true;
    listbox3.DoubleBuffered:= true;
    listbox4.DoubleBuffered:= true;
    listbox5.DoubleBuffered:= true;
    listbox6.DoubleBuffered:= true;
    listbox7.DoubleBuffered:= true;
    listbox8.DoubleBuffered:= true;
    listbox9.DoubleBuffered:= true;


end;

procedure TForm_goods.ListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  listbox1.Tag:= 1;
end;

procedure TForm_goods.ListBox1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  listbox1.Tag:= 0;
end;

procedure TForm_goods.TabSheet8Show(Sender: TObject);
begin
   if not Assigned(Form_dwjh) then
       Form_dwjh:= TForm_dwjh.Create(application);

     Form_dwjh.show_tp:= 0;
       Form_dwjh.show_data_sid:= my_s_id_G;
       Form_dwjh.show_data_xiaodui:=0;
       Form_dwjh.show_data_zhuzhi:=0;
       Form_dwjh.show_data_guojia:=0;
     //Form_dwjh.Parent:= TabSheet8;
    // Form_dwjh.Align:= alclient;
         Form_dwjh.PageControl1.Parent:= TabSheet8;

   //  Form_dwjh.Show;
end;

end.
