unit Unit_reg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,System.Hash;

type
  TForm_reg = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Label14: TLabel;
    Edit12: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    procedure Button3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function id_bucunzai: boolean; //判断id是否存在
  public
    { Public declarations }
  end;

var
  Form_reg: TForm_reg;

implementation
     uses unit_net,unit_glb,unit_data;
{$R *.dfm}

procedure TForm_reg.Button3Click(Sender: TObject);
begin
 if trim(edit1.Text) = '' then
    begin
      messagebox(handle,'用户Id不能为空。','错误',mb_ok);
     edit1.SetFocus;
     exit;
    end;

button3.Enabled:= false;

   id_bucunzai;

 button3.Enabled:= true;
end;

procedure TForm_reg.Edit1Change(Sender: TObject);
begin
  label1.Caption:= '*用户ID：';
end;

function TForm_reg.id_bucunzai: boolean;
var t: cardinal;
    ss: string;
    i: integer;
begin
result:= false;
   if Data_net.g_start_udpserver2(Game_server_addr_g) then
   begin
    Game_wait_ok1_g:= false;
    game_wait_integer_g:= 0;
     t:= GetTickCount;
     //发送查询数据，然后等待查询结果
      ss:= '    '+ edit1.Text;
      i:= byte_to_integer(g_player_isreg_c,false);
      move(i,Pointer(ss)^,4);
      screen.Cursor:= crhourglass;
      sleep(100);
      g_send_msg_str(ss); //向服务器发送
    while (Game_wait_ok1_g= false) and (GetTickCount -t < 10000) do
      begin
        application.ProcessMessages;
        sleep(100);
      end;
       screen.Cursor:= crdefault;

       if Game_wait_ok1_g then
        begin
         if game_wait_integer_g= 1 then
          begin
           label1.Font.Color:= clgreen;
           label1.Caption:= 'ID可用';
           result:= true;
          end else if game_wait_integer_g= 2 then
                    begin
                    label1.Font.Color:= clred;
                    label1.Caption:= 'ID已被注册';
                   end else if game_wait_integer_g= 3 then
                       begin
                         label1.Font.Color:= clred;
                         label1.Caption:= '服务器禁止注册';
                       end;
        end else begin
                   messagebox(handle,'通讯超时，查询失败。','错误',mb_ok);
                 end;
   end else begin
              messagebox(handle,'连接服务器出错。','错误',mb_ok);
            end;
end;

procedure TForm_reg.Button2Click(Sender: TObject);
begin
 close;
end;

procedure TForm_reg.Button1Click(Sender: TObject);
var ss: string;
    i: integer;
    t: cardinal;
begin
   if trim(edit1.Text)= '' then
    begin
     messagebox(handle,'用户Id不能为空。','错误',mb_ok);
     edit1.SetFocus;
     exit;
    end;

    if edit3.Text= '' then
    begin
     messagebox(handle,'密码不能为空。','错误',mb_ok);
     edit3.SetFocus;
     exit;
    end;
    if edit3.Text<> edit4.Text then
    begin
     messagebox(handle,'两次输入的密码不一致。','错误',mb_ok);
     edit4.SetFocus;
     exit;
    end;
    if (edit5.Text<> '') and (edit6.Text= '') then
    begin
     messagebox(handle,'您填写了密码问题，则密码答案不能为空。','错误',mb_ok);
     edit6.SetFocus;
     exit;
    end;

    if edit8.Text= '' then
       edit8.Text:= '0'; //年龄为零

    if id_bucunzai then
     begin
      ss:= '    '+ edit1.Text+'|' + edit2.Text;
      i:= byte_to_integer(g_player_reg_c,false);
      move(i,Pointer(ss)^,4); //写入头信息
      ss:= ss + '|' + THashMD5.GetHashString(edit3.text) +'|' + combobox1.Text;
      ss:= ss + '|' + edit5.Text +'|' + edit6.Text + '|' +edit7.Text;
      ss:= ss + '|' + edit8.Text +'|' + edit9.Text + '|' +edit10.Text;
      ss:= ss + '|' + edit11.Text +'|' + edit12.Text + '|' +edit13.Text;
      ss:= ss + '|' + edit14.Text +'|' + edit15.Text + '|' +edit16.Text;

      if (edit5.Text= '') and (edit6.Text= '') and (edit7.Text= '') and (edit9.Text= '') and
         (edit10.Text= '') and (edit11.Text= '') and (edit12.Text= '') and (edit13.Text= '') and
         (edit14.Text= '') and (edit15.Text= '') and (edit16.Text= '') then
         ss:= ss + '|无'
         else
          ss:= ss + '|有'; //有，表示有写选填信息

          button1.Enabled:= false;
          screen.Cursor:= crhourglass;
         sleep(100);
          Game_wait_ok1_g:= false;
           game_wait_integer_g:= 0;
           
         g_send_msg_str(ss); //向服务器发送注册信息
         t:= GetTickCount;
         while (Game_wait_ok1_g= false) and (GetTickCount -t < 15000) do
          begin
           application.ProcessMessages;
           sleep(100);
          end;  //等待回复信号
          screen.Cursor:= crdefault;

       if Game_wait_ok1_g then
        begin
         //注册信息，data1=1，注册成功，2注册失败有同名存在，3注册失败，其他原因
         case game_wait_integer_g of
         1: begin
             messagebox(handle,'注册成功。','成功',mb_ok);
             self.ModalResult:= mrok;
            end;
         2: messagebox(handle,'有同名用户存在，注册失败。','错误',mb_ok);
         3: messagebox(handle,'服务器禁止注册，注册失败。','错误',mb_ok);
         4: messagebox(handle,'注册失败，其他原因，请联系服务器网管。','错误',mb_ok);
         end;
        end else begin
                   messagebox(handle,'通讯超时，注册失败。','错误',mb_ok);
                 end;
       button1.Enabled:= true;
     end else messagebox(handle,'注册失败。','错误',mb_ok);
end;

procedure TForm_reg.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if key= #13 then
      key:= #0
      else begin
            if key in['|','''','"'] then
              begin
                messagebox(handle,'信息内不能含有 | " '' 这些符号。','错误',mb_ok);
                key:= #0;
              end;
           end;
end;

procedure TForm_reg.FormCreate(Sender: TObject);
begin
   SetWindowLong(Edit8.Handle, GWL_STYLE, GetWindowLong(Edit8.Handle, GWL_STYLE) or ES_NUMBER);
end;

end.
