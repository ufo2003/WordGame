unit Unit_trade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids;

type
  TForm_trade = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    StringGrid2: TStringGrid;
    Label2: TLabel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    arow_g_grid: integer;
    price_zk1: integer; //店家卖出折扣
    price_zk2: integer; //店家收购折扣
    sg_type: integer;
    procedure game_show_trade;
    procedure add_to_stringgrid1(tt1,tt2: integer; s1: Tstringgrid);

    function get_zksg_str(zk: boolean): string; //获取折扣或者收购的商店招牌语
    function get_zksg_pri(zk: boolean; const s: string): string; //获取折扣或者收购的价格
    procedure show_money(s1: Tstringgrid); //显示金钱
    function get_stringgrid_money(s: Tstringgrid): integer;
  public
    { Public declarations }
    game_trade_id,game_flag: integer;
    procedure CreateParams(var Para:TCreateParams);override;
  end;

var
  Form_trade: TForm_trade;

implementation

uses Unit_data,Unit_player,unit1, Unit_goods;

{$R *.dfm}

procedure TForm_trade.FormShow(Sender: TObject);
begin
 if game_trade_id= 0 then
    game_trade_id:= 1;

 stringgrid1.Cells[0,0]:='编号';
 stringgrid1.Cells[1,0]:='名称';
 stringgrid1.Cells[2,0]:='描述';
 stringgrid1.Cells[3,0]:='已有数量';
 stringgrid1.Cells[4,0]:='购买数量';
  stringgrid2.Cells[0,0]:='编号';
  stringgrid2.Cells[1,0]:='名称';
  stringgrid2.Cells[2,0]:='描述';
  stringgrid2.Cells[3,0]:='已有数量';
  stringgrid2.Cells[4,0]:='出售数量';

  stringgrid1.Col:= 4;
  stringgrid1.Row:= 1;
   stringgrid2.Col:= 4;
  stringgrid2.Row:= 1;

   case game_trade_id of
    1..3: begin
           self.Caption:= '武器店';
           sg_type:= 16;
          end;
    4..6: begin
           self.Caption:= '装备防具店';
           sg_type:= 1;
          end;
    7..9 :begin
           self.Caption:= '药材铺子';
           sg_type:= 2;
          end;
    10..12:begin
            self.Caption:= '副食杂货铺';
            sg_type:= 64;
           end;
    else
      self.Caption:= '专卖店';
      sg_type:= 64; //商品类型同杂货铺
    end;
    
   if game_flag= 0 then
      PageControl1.ActivePage:= TabSheet1
       else
         PageControl1.ActivePage:= TabSheet2;

  game_show_trade;
  show_money(stringgrid1);
  TabSheet2Show(self);
end;

procedure TForm_trade.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   {with TStringGrid(Sender) do begin
    if (ACol = 4) and (gdFocused in State) then
      Options := Options + [goEditing]
    else Options := Options - [goEditing];
    end; }

  if acol= 1 then
   begin
   TStringGrid(Sender).Canvas.FillRect(Rect);
   TStringGrid(Sender).Canvas.TextRect(Rect, Rect.Left + 20, Rect.Top + 2,
               TStringGrid(Sender).Cells[ACol, ARow]);

    data2.ImageList_sml.Draw(TStringGrid(Sender).Canvas,rect.left+2,rect.top+3,
                        Game_goods_Index_G[form_goods.get_goods_id(TStringGrid(Sender).Cells[ACol, ARow])]);

   end;

if (Arow= arow_g_grid) then
  with (sender as tStringgrid).Canvas do
  begin
      brush.Color:=$00F0F0;
      DrawFocusRect(Rect);
  end;



end;

procedure TForm_trade.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin

  arow_g_grid:= ARow;

 if acol<> 4 then
   begin
    if TStringGrid(Sender).Row<> arow_g_grid then
      TStringGrid(Sender).Row:= arow_g_grid;
    CanSelect:= false;
   end;



  (sender as tStringgrid).Repaint;
end;

procedure TForm_trade.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
 if (sender as tStringgrid).Col <> 4 then
  key:= #0
   else
    begin
     if not(key in['0'..'9',#8]) then
      begin
       key:= #0;
      end;
    end;
end;

procedure TForm_trade.game_show_trade;   //显示店铺内物品
var str1: Tstringlist;
    i,t2,t3: integer;
begin

  for i:= 1 to stringgrid1.RowCount- 1 do
      stringgrid1.Rows[i].Clear;

   str1:= Tstringlist.Create;
    Data2.Load_file_upp(ExtractFilePath(application.ExeName)+'layer'+
                        inttostr(game_trade_id)+'.upp',str1);

    if str1.Count> 0 then
     begin
      if str1.Values['id']= 'layer'+ inttostr(game_trade_id) then
       begin
        t2:= strtoint(str1.Values['begin']);
        t3:= strtoint(str1.Values['end']);
        add_to_stringgrid1(t2,t3,stringgrid1);   //添加到字符串列表
         for i:= 2 to 9 do
          begin  //添加更多区间
            if str1.Values['begin'+ inttostr(i)]<> '' then
               begin
               t2:= strtoint(str1.Values['begin'+ inttostr(i)]);
            if str1.Values['end'+ inttostr(i)]<> '' then
                begin
                 t3:= strtoint(str1.Values['end'+ inttostr(i)]);
                  add_to_stringgrid1(t2,t3,stringgrid1);
                end;
               end;
          end; //end for i
       end else showmessage('不是有效的店铺定义文件。载入店铺出错。');
     end else showmessage('需要店铺定义文件。载入店铺失败。');
   str1.Free;
   label3.Caption:= get_zksg_str(true);
end;

procedure TForm_trade.add_to_stringgrid1(tt1, tt2: integer; s1: Tstringgrid);
     function get_row_id: integer;
      var j: integer;
      begin
       result:= 1;
        for j:= 1 to s1.RowCount- 1 do
           if s1.Cells[0,j]= '' then
             begin
             result:= j;
             exit;
             end else begin
                     if j= s1.RowCount- 1 then
                        begin
                        s1.RowCount:= j+ 2;
                        result:= j+ 1;
                        end;
                   end;
      end;
var i,i2: integer;
    ss,ss2: string;
begin
  for i:= tt1 to tt2 do
    begin
      i2:= get_row_id; //获取空的行号
      ss:= data2.game_memini1.ReadString('GOODS',inttostr(i),'');
      s1.Cells[0,i2]:= inttostr(i);
      s1.Cells[1,i2]:= Data2.get_game_goods_type_s(ss,goods_name1);
      ss2:= Data2.get_game_goods_type_a(i);
      delete(ss2,1,pos(',',ss2));
          ss2:= '价格：'+get_zksg_pri((s1= stringgrid1),Data2.get_game_goods_type_s(ss,goods_j1)) +' '+ ss2;
      s1.Cells[2,i2]:= ss2{+ ' '+
                                Data2.get_game_goods_type_s(ss,goods_ms1)};
      s1.Cells[3,i2]:= inttostr(read_goods_number(i));

    end; //end for i
end;

function TForm_trade.get_zksg_str(zk: boolean): string;
 var ss: string;
     str1: Tstringlist;
begin
result:= '';
   ss:= ExtractFilePath(application.ExeName);
    if zk then
     ss:= ss+ 'dat/zk'+ inttostr(price_zk1)
     else
       ss:= ss+ 'dat/sg'+ inttostr(price_zk2);

     str1:= Tstringlist.Create;
       str1.LoadFromFile(ss);
        if str1.Count > 0 then
         begin
           result:= str1.Strings[Game_base_random(str1.Count)];
         end;
     str1.Free;
end;

function TForm_trade.get_zksg_pri(zk: boolean; const s: string): string;
var p2: integer;
begin
  p2:= strtoint(s);
   if zk then
    p2:= p2 * price_zk1 div 10
     else
       p2:= p2 * price_zk2 div 10;

   result:= inttostr(p2);
end;

procedure TForm_trade.show_money(s1: Tstringgrid);
begin

  if s1= stringgrid1 then
   label1.Caption:= format('共有%d金币，预计购物需%d金钱',
               [game_read_values(0,0),get_stringgrid_money(s1)])
    else
     label2.Caption:= format('现有%d金币，预计卖出后可得%d金钱',
               [game_read_values(0,0),get_stringgrid_money(s1)]);
end;

function TForm_trade.get_stringgrid_money(s: Tstringgrid): integer;
     function get_price(ss: string): integer;
      begin
        result:= strtoint(copy(ss,7,pos(' ',ss)-7));
      end;
var i: integer;
begin

result:= 0;

  for i:= 1 to s.RowCount-1 do
   begin
     if (s.Cells[4,i]<> '') and (s.Cells[0,i]<> '') then
      result:= result + get_price(s.Cells[2,i]) * strtoint(s.Cells[4,i]);
   end;
end;

procedure TForm_trade.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   show_money(sender as Tstringgrid);
end;

procedure TForm_trade.Button1Click(Sender: TObject);
begin
  if stringgrid1.Cells[4,stringgrid1.Row]='' then
     stringgrid1.Cells[4,stringgrid1.Row]:= '1'
     else
      begin
        stringgrid1.Cells[4,stringgrid1.Row]:= inttostr(strtoint(stringgrid1.Cells[4,stringgrid1.Row])+1);
      end;
  show_money(stringgrid1);
end;

procedure TForm_trade.Button2Click(Sender: TObject);
begin
 if stringgrid1.Cells[4,stringgrid1.Row]<>'' then
    if stringgrid1.Cells[4,stringgrid1.Row]= '0' then
     stringgrid1.Cells[4,stringgrid1.Row]:= ''
     else
      begin
        stringgrid1.Cells[4,stringgrid1.Row]:= inttostr(strtoint(stringgrid1.Cells[4,stringgrid1.Row])-1);
      end;
  show_money(stringgrid1);
end;

procedure TForm_trade.Button3Click(Sender: TObject);
var i,i2: integer;
begin
 if get_stringgrid_money(stringgrid1) > game_read_values(0,0) then
   begin
     showmessage('金额不足，请减少购物数量。');
     exit;
   end;

 i2:= 0;
 for i:= 1 to stringgrid1.RowCount-1 do
    if (stringgrid1.Cells[0,i]<> '') and (stringgrid1.Cells[4,i]<> '') then
     begin
     if strtoint(stringgrid1.Cells[4,i])+ strtoint(stringgrid1.Cells[3,i]) > 255 then
      begin
       showmessage('单款自有数量和新购数量总和不能超过255个。');
        stringgrid1.Row:= i;
       exit;
      end;
     inc(i2,strtoint(stringgrid1.Cells[4,i]));
     end;

  if i2= 0 then
   begin
    showmessage('请在上面表格的最后一列输入您需要的购买数量。');
     exit;
   end;

   //购物操作
   for i:=  1 to stringgrid1.RowCount-1 do
    begin
      if (stringgrid1.Cells[0,i]<> '') and (stringgrid1.Cells[4,i]<> '') then
       begin
        write_goods_number(strtoint(stringgrid1.Cells[0,i]),strtoint(stringgrid1.Cells[4,i]));
       end;
    end; //end for

    //扣去金钱
     game_write_values(0,0,
                              game_read_values(0,0) -
                              get_stringgrid_money(stringgrid1));

   if pos('买一送一',label3.Caption)> 0 then
    begin
     if i2= 1 then
       messagebox(handle,'本店今天买一送一，您买了一件商品，就送您一句吉言：“祝您游戏玩的愉快。”','买一送一',mb_ok or MB_ICONINFORMATION)
        else
          messagebox(handle,'本店今天买一送一，您买了一些商品，送您一句祝福：“祝您早日学有所成！”','买一送一',mb_ok or MB_ICONINFORMATION);
    end else messagebox(handle,'谢谢购买，欢迎再次光临。','谢谢',mb_ok or MB_ICONINFORMATION);

  self.Close;
end;
     {收购}
procedure TForm_trade.TabSheet2Show(Sender: TObject);
 var i: integer;
begin
price_zk2:= Game_base_random(4)+ 3;
 screen.Cursor:= crhourglass;
  for i:= 1 to stringgrid2.RowCount - 1 do
       stringgrid2.Rows[i].Clear;

  show_money(stringgrid2);
  label4.Caption:= get_zksg_str(false);
   //显示全部的可销售商品 8=冶炼物品
    for i:= 1 to 1023 do
     begin
      if read_goods_number(i) > 0 then
       begin
        if (Data2.get_game_goods_type(i,goods_type1) and sg_type= sg_type) or
           (Data2.get_game_goods_type(i,goods_type1) and 8= 8) then
          add_to_stringgrid1(i,i,stringgrid2);
       end;
     end; //for i

 screen.Cursor:= crdefault;
end;

procedure TForm_trade.Button5Click(Sender: TObject);
begin
if stringgrid2.Cells[4,stringgrid2.Row]='' then
     stringgrid2.Cells[4,stringgrid2.Row]:= '1'
     else
      begin
        if stringgrid2.Cells[3,stringgrid2.Row]<> stringgrid2.Cells[4,stringgrid2.Row] then
          stringgrid2.Cells[4,stringgrid2.Row]:= inttostr(strtoint(stringgrid2.Cells[4,stringgrid2.Row])+1);
      end;
  show_money(stringgrid2);

end;

procedure TForm_trade.Button6Click(Sender: TObject);
begin
 if stringgrid2.Cells[4,stringgrid2.Row]<>'' then
    if stringgrid2.Cells[4,stringgrid2.Row]= '0' then
     stringgrid2.Cells[4,stringgrid2.Row]:= ''
     else
      begin
        stringgrid2.Cells[4,stringgrid2.Row]:= inttostr(strtoint(stringgrid2.Cells[4,stringgrid2.Row])-1);
      end;
  show_money(stringgrid2);
end;

procedure TForm_trade.Button4Click(Sender: TObject);
var i,i2: integer;
begin
 i2:= 0;
 for i:= 1 to stringgrid2.RowCount-1 do
    if (stringgrid2.Cells[0,i]<> '') and (stringgrid2.Cells[4,i]<> '') then
     begin
     if strtoint(stringgrid2.Cells[4,i]) > strtoint(stringgrid2.Cells[3,i]) then
      begin
       showmessage('卖出数量不能大于持有数量。');
        stringgrid2.Row:= i;
       exit;
      end;
     inc(i2,strtoint(stringgrid2.Cells[4,i]));
     end;

  if i2= 0 then
   begin
    showmessage('请在上面表格的最后一列输入您需要卖出的数量。');
     exit;
   end;

   for i:=  1 to stringgrid2.RowCount-1 do
    begin
      if (stringgrid2.Cells[0,i]<> '') and (stringgrid2.Cells[4,i]<> '') then
       begin
        write_goods_number(strtoint(stringgrid2.Cells[0,i]), strtoint(stringgrid2.Cells[4,i]) * -1);
       end;
    end; //end for

    //加上金钱
     game_write_values(0,0,
                              game_read_values(0,0) +
                              get_stringgrid_money(stringgrid2));

    messagebox(handle,pchar(format('交易成功，您得到了金钱：%d',
    [get_stringgrid_money(stringgrid2)])),'交易成功。',mb_ok or MB_ICONINFORMATION);
      self.Close;
end;

procedure TForm_trade.TabSheet1Show(Sender: TObject);
begin
price_zk1:= Game_base_random(6)+ 7;
game_show_trade;
  show_money(stringgrid1);
end;

procedure TForm_trade.FormCreate(Sender: TObject);
begin
game_trade_id:= 1;
end;

procedure TForm_trade.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
  Para.WndParent:=Form1.Handle;

end;

end.
