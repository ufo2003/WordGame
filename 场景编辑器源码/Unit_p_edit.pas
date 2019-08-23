unit Unit_p_edit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TForm_P_edit = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_P_edit: TForm_P_edit;

implementation
    uses unit1;
{$R *.dfm}

procedure TForm_P_edit.FormShow(Sender: TObject);
var i: integer;
begin
 stringgrid1.Cells[0,0]:= '类型';
  stringgrid1.Cells[1,0]:= '值';

  stringgrid1.Cells[0,1]:= '姓名';
         //属性，64个
  stringgrid1.Cells[0,2]:= '金钱';
  stringgrid1.Cells[0,3]:= '幸运值';
  stringgrid1.Cells[0,4]:= '速度';
  stringgrid1.Cells[0,5]:= '攻击力';
  stringgrid1.Cells[0,6]:= '是否上场';
  stringgrid1.Cells[0,7]:= '体力';
  stringgrid1.Cells[0,8]:= '灵力';
  stringgrid1.Cells[0,9]:= '智力';
  stringgrid1.Cells[0,10]:= '生命值';
  stringgrid1.Cells[0,11]:= '道德值';
  stringgrid1.Cells[0,12]:= '威望值';
  stringgrid1.Cells[0,13]:= '性格';
  stringgrid1.Cells[0,14]:= '性别';
  stringgrid1.Cells[0,15]:= '贪婪';
  stringgrid1.Cells[0,16]:= '主角对其的爱情值';
  stringgrid1.Cells[0,17]:= '对主角的爱情值';
  stringgrid1.Cells[0,18]:= '对主角信任度';
  stringgrid1.Cells[0,19]:= '主角对其信任度';
  stringgrid1.Cells[0,20]:= '辅助记录';
  stringgrid1.Cells[0,21]:= '经验值';
  stringgrid1.Cells[0,22]:= '防护值';
  stringgrid1.Cells[0,23]:= '外表';
  stringgrid1.Cells[0,24]:= '谈话前后文编号';
  stringgrid1.Cells[0,25]:= '谈话游标';
  stringgrid1.Cells[0,26]:= '下次升级';
  stringgrid1.Cells[0,27]:= '固定体力';
  stringgrid1.Cells[0,28]:= '固定灵力';
  stringgrid1.Cells[0,29]:= '固定生命值';
  stringgrid1.Cells[0,30]:= '当前等级';
  stringgrid1.Cells[0,31]:= '临时隐藏';
    stringgrid1.Cells[0,32]:= '系统保留';
    stringgrid1.Cells[0,33]:= '系统保留';
    stringgrid1.Cells[0,34]:= '头像序号';
   for i:= 35 to 65 do
      stringgrid1.Cells[0,i]:= '属性' + inttostr(i-1);

        //装备，10个
  stringgrid1.Cells[0,66]:= '装备（未用）';
    stringgrid1.Cells[0,67]:= '头戴';
    stringgrid1.Cells[0,68]:= '身穿';
    stringgrid1.Cells[0,69]:= '披风';
    stringgrid1.Cells[0,70]:= '脚穿';
    stringgrid1.Cells[0,71]:= '护腕';
    stringgrid1.Cells[0,72]:= '戒指';
    stringgrid1.Cells[0,73]:= '项链';
    stringgrid1.Cells[0,74]:= '武器';
    stringgrid1.Cells[0,75]:= '腰挂';

     //技能，24个
             for i:= 76 to 99 do
      stringgrid1.Cells[0,i]:= '技能组合编号' + inttostr(i-75);


      //法术，64个
       for i:= 100 to 163 do
      stringgrid1.Cells[0,i]:= '法术组合编号' + inttostr(i-99);

end;

procedure TForm_P_edit.Button1Click(Sender: TObject);
var i: integer;
begin
    try
      for i:= 2 to StringGrid1.rowCount- 1 do
        strtoint(StringGrid1.Cells[1,i]);
    except
      raise Exception.Create('错误，值必须是数字。');
    end;



   for i:= 1 to StringGrid1.rowCount- 1 do
    form1.SynEditor1.lines.Strings[i]:= StringGrid1.Cells[1,i];

  file_is_change:= true;
  
    self.ModalResult:= mrok;
end;

procedure TForm_P_edit.Button2Click(Sender: TObject);
begin
    self.Close;
end;

end.
