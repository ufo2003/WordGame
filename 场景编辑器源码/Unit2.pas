unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
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
    Label12: TLabel;
    Label13: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label14: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
    is_write_name: boolean; //是否修改名称，用于区别读值或者读值及修改行号
  public
    { Public declarations }
    show_type_i: integer;
    procedure show_ss(ss: string);
    procedure show_ss2(ss: string);
  end;

var
  Form2: TForm2;

implementation
   uses unit1;
{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
self.ModalResult:= mrcancel;
end;

procedure TForm2.Button1Click(Sender: TObject);
var ss: string;
begin
 if edit1.Text= '' then
  begin
    showmessage('名称不能为空');
    exit;
  end;

 if edit2.Text= '' then
  edit2.Text:= '1'
   else
    begin
     try
       strtoint(edit2.text);
     except
       showmessage('必须是数字');
       exit;
     end;
    end;
    if edit3.Text= '' then
  edit3.Text:= '1'
   else
    begin
     try
       strtoint(edit3.text);
     except
       showmessage('必须是数字');
       exit;
     end;
    end;
    if edit4.Text= '' then
  edit4.Text:= '1'
   else
    begin
     try
       strtoint(edit4.text);
     except
       showmessage('必须是数字');
       exit;
     end;
    end;
    if edit5.Text= '' then
  edit5.Text:= '1'
   else
    begin
     try
       strtoint(edit5.text);
     except
       showmessage('必须是数字');
       exit;
     end;
    end;
    if edit6.Text= '' then
  edit6.Text:= '1'
   else
    begin
     try
       strtoint(edit6.text);
     except
       showmessage('必须是数字');
       exit;
     end;
    end;
    if edit7.Text= '' then
  edit7.Text:= '1'
   else
    begin
     try
       strtoint(edit7.text);
     except
       showmessage('必须是数字');
       exit;
     end;
    end;
    if edit8.Text= '' then
  edit8.Text:= '1'
   else
    begin
     try
       strtoint(edit8.text);
     except
       showmessage('必须是数字');
       exit;
     end;
    end;
    if edit9.Text= '' then
  edit9.Text:= '1'
   else
    begin
     try
       strtoint(edit9.text);
     except
       showmessage('必须是数字');
       exit;
     end;
    end;
    if edit10.Text= '' then
  edit10.Text:= '1'
   else
    begin
     try
       strtoint(edit10.text);
     except
       showmessage('必须是数字');
       exit;
     end;
    end;
    if edit11.Text= '' then
  edit11.Text:= '1'
   else
    begin
     try
       strtoint(edit11.text);
     except
       showmessage('必须是数字');
       exit;
     end;
    end;
    if edit12.Text= '' then
  edit12.Text:= '1'
   else
    begin
     try
       strtoint(edit12.text);
     except
       showmessage('必须是数字');
       exit;
     end;
    end;

 ss:= edit1.Text+ ','+ edit2.Text+ ','+edit3.Text+ ','+edit4.Text+ ','+edit5.Text+ ','+
 edit6.Text+ ','+edit7.Text+ ','+edit8.Text+ ','+edit9.Text+ ','+edit10.Text+ ','+
 edit11.Text+ ','+edit12.Text+ ','+edit13.Text;

 form1.write_ss(ss);
 form1.SynEditor1Change(sender);
end;

procedure TForm2.show_ss(ss: string);
begin
  if ss= '' then
   exit;

   if pos('=',ss)>0 then
    delete(ss,1,pos('=',ss));

   edit1.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
    edit2.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit3.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit4.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit5.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit6.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit7.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit8.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit9.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit10.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit11.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit12.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit13.Text:=ss;

   //根据类型再次修改label标签

end;

procedure TForm2.Button3Click(Sender: TObject);
begin
 is_write_name:= false;
 form1.read_ss_up;
end;

procedure TForm2.show_ss2(ss: string);
begin
  if ss= '' then
   exit;

   if pos('=',ss)>0 then
    delete(ss,1,pos('=',ss));
    if copy(ss,1,pos(',',ss)-1)<> '' then
     label14.Caption := copy(ss,1,pos(',',ss)-1);

      if is_write_name then
            edit1.Text:= copy(ss,1,pos(',',ss)-1);

   delete(ss,1,pos(',',ss));
    edit2.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit3.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit4.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit5.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit6.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit7.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit8.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit9.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit10.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit11.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));
   edit12.Text:= copy(ss,1,pos(',',ss)-1);
   delete(ss,1,pos(',',ss));

   if is_write_name then
      edit13.Text:= ss;

end;

procedure TForm2.Button4Click(Sender: TObject);
begin
 is_write_name:= false;
  form1.read_ss_down;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  if show_type_i= 3 then
   begin
    label2.Caption:= '类型';
      edit2.Hint:= '物品，法术的类型';
    label3.Caption:= '防';
      edit3.Hint:= '该物品带来的防护值增加，通常在装备上';
    label4.Caption:= '体';
      edit4.Hint:= '该物品带来的体力值增加，通常在装备上';
    label5.Caption:= '灵';
      edit5.Hint:= '该物品带来的灵力值增加，通常在装备上';
    label6.Caption:= '速';
      edit6.Hint:= '该物品带来的速度值增加，通常在装备上';
    label7.Caption:= '命';
      edit7.Hint:= '消耗该物品产生的生命值补充';
    label8.Caption:= '攻';
      edit8.Hint:= '该物品带来的攻击力增加，通常在武器上';
    label9.Caption:= '智';
      edit9.Hint:= '该物品带来的智力增加';
    label10.Caption:= '运';
      edit10.Hint:= '该物品带来的运增加，通常在武器上';
    label11.Caption:= '标志';
      edit11.Hint:= '附加属性，不同类型的物品作用不同';
    label12.Caption:= '价格';
      edit12.Hint:= '买入价';
   end else if show_type_i= 2 then
       begin
       //攻击，防护值，血值，所会魔法，经验值，掉落物品，掉落金钱，掉落物品数，掉落物概率，速度
        label2.Caption:= '攻击';
          edit2.Hint:= '怪物的攻击力';
    label3.Caption:= '防';
      edit3.Hint:= '怪物的防护值';
    label4.Caption:= '血';
      edit4.Hint:= '怪物的血值';
    label5.Caption:= '魔法';
      edit5.Hint:= '怪物所会的魔法，会一定概率使出';
    label6.Caption:= '经验';
      edit6.Hint:= '打败该怪所获得的经验值';
    label7.Caption:= '掉物';
      edit7.Hint:= '该怪被打败后掉出的物品编号';
    label8.Caption:= '掉钱';
      edit8.Hint:= '该怪被打败后掉出的金钱';
    label9.Caption:= '掉物数';
      edit9.Hint:= '该怪被打败后掉出指定物品的数量';
    label10.Caption:= '概率';
      edit10.Hint:= '该怪被打败后掉出指定物品的概率（X分之一），概率为1，总是掉物品';
    label11.Caption:= '速度';
      edit11.Hint:= '该怪的速度，速度越高，轮到攻击的次数越多';
    label12.Caption:= '头像编号，49默认怪物，59默认人物';
      edit12.Hint:= '头像编号';
       end;

if show_type_i= 3 then //物品
    begin
      if edit2.Text<> '' then
       begin
         case strtoint(edit2.Text) of
           1,9,16,24: begin
                     label11.Caption:= '男女';
                     edit11.Hint:= '10X，男式；20X，女式；30X，通用。'+ #10#13+
                     'X值从1..9，表示穿戴类型';
                      if (strtoint(edit2.Text)=16) or (strtoint(edit2.Text)=24) then
                       begin
                        label10.Caption:= '等级';
                        edit10.Hint:= '持有此武器所需的最低等级。'
                       end;
                    end;
           4: begin
               label11.Caption:= '时长';
                edit11.Hint:= '作用时长，0表示一次有效，1为10秒，2为20秒，以此类推';
              end;
           128: begin
                 label11.Caption:= '等级';
                edit11.Hint:= '需要达到此等级才能学习此技术。';
                  label3.Caption:= '男女';
                edit3.Hint:= '3表示男女可学，1，男可学，0女可学';
                  label10.Caption:= '单全';
                label10.Hint:= '1=单体，为0，表示全体';
                edit10.Hint:= '1表示单体恢复或攻击，为0，表示全体';
                  label12.Caption:= '攻或回';
                edit12.Hint:= '0表示恢复术，1表示攻击术';
                end;
           256:begin
               label11.Caption:= '时长';
                edit11.Hint:= '作用时长，0表示一次有效，1为10秒，2为20秒，以此类推';
              end;
         end; //end case
       end;
    end;

end;

procedure TForm2.Button7Click(Sender: TObject);
begin
 button1click(sender);
 form1.SynEditor1Change(sender);
 self.ModalResult:= mrok;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
 is_write_name:= true;
  form1.read_ss_up_2;


end;

procedure TForm2.Button6Click(Sender: TObject);
begin
 is_write_name:= true;
 form1.read_ss_down_2;
end;

end.
