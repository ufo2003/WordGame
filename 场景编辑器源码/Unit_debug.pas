unit Unit_debug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;
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
type
  TForm_debug = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    RichEdit1: TRichEdit;
    Button2: TButton;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button3: TButton;
    Label3: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Button4: TButton;
    Button5: TButton;
    Label5: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label6: TLabel;
    Button6: TButton;
    Button7: TButton;
    Label7: TLabel;
    Edit7: TEdit;
    Button8: TButton;
    GroupBox6: TGroupBox;
    Label8: TLabel;
    Edit8: TEdit;
    Label9: TLabel;
    Edit9: TEdit;
    Label10: TLabel;
    Edit10: TEdit;
    Button9: TButton;
    Button10: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure msg_html_C(var msg1: TWMCopyData); message WM_COPYDATA;
   // procedure msg_func_C(var msg: TWMCopyData); message WM_COPYDATA;
   // procedure msg_event_c1(var msg: TMessage); message event_c1;  //返回了查询消息
  //  procedure msg_event_c2(var msg: TMessage); message event_c2;  //返回了设置
   // procedure msg_res_c1(var msg: TMessage); message res_c1;
    //procedure msg_res_c2(var msg: TMessage); message res_c2;
   // procedure msg_goods_c1(var msg: TMessage); message goods_c1;
   // procedure msg_goods_c2(var msg: TMessage); message goods_c2;
    procedure msg_page_c1(var msg: TMessage); message page_c1;
    //procedure msg_page_c2(var msg: TMessage); message page_c2;
    procedure msg_stop_c(var msg: TMessage); message stop_c;
  public
    { Public declarations }
    debug_handle: thandle;
    procedure CreateParams(var Para:TCreateParams);override;
  end;

var
  Form_debug: TForm_debug;

implementation
      uses unit1,unit_sijian;
{$R *.dfm}

procedure TForm_debug.Button2Click(Sender: TObject);
begin
 if messagebox(handle,'是否结束调试？','询问',mb_yesno)= mryes then
    close;
end;

procedure TForm_debug.msg_html_C(var msg1: TWMCopyData);
var ss: string;
begin
  if msg1.From=debug_handle then
    with msg1.CopyDataStruct^ do
    begin
      setlength(ss, cbData);
      move(pchar(lpData)^, pointer(ss)^, cbData);
      if dwData= html_C then
       richedit1.Lines.Append(ss)
      else if dwData= func_C then
             memo1.lines.Append(ss);
      msg1.result := 1;
    end;

end;

procedure TForm_debug.msg_page_c1(var msg: TMessage);
begin
  if msg.LParam= 1800 then
     debug_handle:= msg.WParam
     else begin
           edit7.Text:= inttostr(msg.WParam);
           richedit1.Lines.Clear;
           memo1.Lines.Clear;
          end;
end;


procedure TForm_debug.msg_stop_c(var msg: TMessage);
begin
   close; //结束
end;

procedure TForm_debug.Button1Click(Sender: TObject);
var i: integer;
begin
   //查看页面值
    i:= sendmessage(debug_handle,event_c1,strtoint(edit1.text),0);
   if i<0 then
    edit2.Text:='游戏没有开始或者处于联网状态'
    else
     edit2.Text:= inttostr(i);
end;

procedure TForm_debug.Button4Click(Sender: TObject);
var i: integer;
begin
   //查看页面值
    i:= sendmessage(debug_handle,res_c1,strtoint(edit3.text),0);
   if i<0 then
    edit4.Text:='游戏没有开始或者处于联网状态'
    else
     edit4.Text:= inttostr(i);

end;

procedure TForm_debug.Button6Click(Sender: TObject);
var i: integer;
begin
   //查看页面值
    i:= sendmessage(debug_handle,goods_c1,strtoint(edit5.text),0);
   if i<0 then
    edit6.Text:='游戏没有开始或者处于联网状态'
    else
     edit6.Text:= inttostr(i);

end;

procedure TForm_debug.Button3Click(Sender: TObject);
var i: integer;
begin
   //修改值
    i:= sendmessage(debug_handle,event_c2,strtoint(edit1.text),strtoint(edit2.text));
   if i<0 then
    edit2.Text:='游戏没有开始或者处于联网状态';

end;

procedure TForm_debug.Button5Click(Sender: TObject);
var i: integer;
begin
   //修改值
    i:= sendmessage(debug_handle,res_c2,strtoint(edit3.text),strtoint(edit4.text));
   if i<0 then
    edit4.Text:='游戏没有开始或者处于联网状态';

end;

procedure TForm_debug.Button7Click(Sender: TObject);
var i: integer;
begin
   //修改值
    i:= sendmessage(debug_handle,goods_c2,strtoint(edit5.text),strtoint(edit6.text));
   if i<0 then
    edit6.Text:='游戏没有开始或者处于联网状态';

end;

procedure TForm_debug.Button8Click(Sender: TObject);
var i: integer;
begin
   //修改值
    i:= sendmessage(debug_handle,page_c2,strtoint(edit7.text),0);
   if i<0 then
    edit7.Text:='游戏没有开始或者处于联网状态';

end;

procedure TForm_debug.Button9Click(Sender: TObject);
var i: integer;
begin
   //查看人物值
    i:= sendmessage(debug_handle,player_c1,strtoint(edit8.text),strtoint(edit9.text));
   if i<0 then
    edit10.Text:='游戏没有开始或者处于联网状态'
    else
     edit10.Text:= inttostr(i);

end;

procedure TForm_debug.Button10Click(Sender: TObject);
var i: integer;
begin
   //人物修改值
    longrec(i).Lo:= strtoint(edit8.text);  //人物序列id，
    longrec(i).Hi:= strtoint(edit9.text);  //人物值编号

    i:= sendmessage(debug_handle,player_c2,i,strtoint(edit10.text));
   if i<0 then
    edit10.Text:='游戏没有开始或者处于联网状态';

end;

procedure TForm_debug.Edit1Change(Sender: TObject);
begin
 (sender as tedit).Hint:= (sender as tedit).Text +'：'+ form_shijian.Memo1.Lines.Values[(sender as tedit).Text];
end;

procedure TForm_debug.Memo1Click(Sender: TObject);
var ss,ss2: string;
   i,j: integer;
begin
   ss:= Memo1.Lines[SendMessage(Memo1.Handle,EM_LINEFROMCHAR,Memo1.SelStart,0)];
   j:= pos('(',ss);
   if j> 0 then
   begin
   ss2:= '';
   for i:= j+ 1 to length(ss) do
       if ss[i] in['0'..'9'] then
          ss2:= ss2+ ss[i]
          else
           break;

     if length(ss2)= 4 then
      if strtoint(ss2) < 5000 then
       edit1.Text:= ss2
       else
        edit3.Text:= ss2;
        
   end;
end;

procedure TForm_debug.CreateParams(var Para: TCreateParams);
begin
  inherited  CreateParams(Para);
   Para.WndParent:=GetDesktopWindow;

end;

procedure TForm_debug.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   sendmessage(debug_handle,stop_c,88,0); //发送中断消息
   form1.Button11.Enabled:= true;
end;

end.
