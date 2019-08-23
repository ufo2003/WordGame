unit Unit_tihuan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_tihuan = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    Button3: TButton;
    Button2: TButton;
    Button4: TButton;
    CheckBox2: TCheckBox;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    dangqian: integer;
    stop: boolean;
    xuyao_queren: boolean;
    tmp_tihuan: string;
    is_temp_tihuan: boolean;
    procedure tihuan(id: integer);
  public
    { Public declarations }
  end;

var
  Form_tihuan: TForm_tihuan;

implementation
   uses unit1;
{$R *.dfm}

procedure TForm_tihuan.Button1Click(Sender: TObject);

begin
     if (memo1.Text= '') or (memo2.Text= '') then
        exit;

     dangqian:= strtoint(edit1.Text);
     button1.Enabled:= false;
     tihuan(dangqian);
end;

procedure TForm_tihuan.tihuan(id: integer);
var i,j,k: integer;
    ss,ss2: string;
    c,t,src: string;
    label pp;
begin
    if (file_open_type= 1) and (file_save_path<> '') then
      ss2:= file_save_path
     else
       ss2:= data_path+ 'scene';

     screen.Cursor:= crhourglass;
      stop:= false;

     for i:= id to strtoint(edit2.Text) do
      begin
        //打开文件 查找 替换 保存
        ss:= ss2 +'\' + inttostr(i) +'.ugm';

        if not FileExists(ss) then
         begin
         inc(dangqian);
         Continue;
         end;

         if stop then break;

        form1.open_file_scene(ss);
        label5.Caption:= inttostr(i);
        dangqian:= i;
         application.ProcessMessages;


         if is_temp_tihuan and (tmp_tihuan<> '') then
                 memo1.Text:= tmp_tihuan;
         c:= memo1.Text;
         t:= memo2.Text;
         src:= form1.SynEditor1.Text;

         pp:
          if strpos(pchar(src),pchar(c))<> nil then
           begin
             if checkbox1.Checked and (xuyao_queren=false) then
              begin
                button2.Enabled:= true;
                screen.Cursor:= crdefault;
                exit;
              end;
              if checkbox2.Checked then
                 button4.Click;
                 
            form1.SynEditor1.Text:= StringReplace(src,c,t,[]);
            form1.save_ugm(ss);
            xuyao_queren:= false;
            button2.Enabled:= false;
              if is_temp_tihuan and (tmp_tihuan<> '') then
                 memo1.Text:= tmp_tihuan;

            is_temp_tihuan:= false;
             application.ProcessMessages;
           end else begin
                      if memo1.Lines.Count>= 2 then
                        begin  //分段匹配查找
                         j:= pos(memo1.Lines.Strings[0],src);
                         k:= pos(memo1.Lines.Strings[1],src);
                         if (j> 0) and (k > j) then
                          begin
                            is_temp_tihuan:= true;
                            tmp_tihuan:= c;
                            c:= copy(src,j,k-j)+memo1.Lines.Strings[1];
                             memo1.Text:= c;
                             goto pp;
                          end;
                        end;
                    end;
        //inc(dangqian);
      end;

      screen.Cursor:= crdefault;
      button1.Enabled:= true;
end;

procedure TForm_tihuan.Button3Click(Sender: TObject);
begin
    button1.Enabled:= true;
    stop:= true;
end;

procedure TForm_tihuan.Button2Click(Sender: TObject);
begin

   if dangqian= 0 then
     begin
       button1.Click;
     end else begin
                xuyao_queren:= true;
                tihuan(dangqian);
              end;
end;

procedure TForm_tihuan.Button4Click(Sender: TObject);
var c,t,c1,t1: string;
    i,c1_i,c2_i: integer;
    b: boolean;
begin

    c:= memo1.Text;
    t:= memo2.Text;
     c1_i:= 0;
      c2_i:= 0;
      b:= false;
      c1:= '';

    for i:= 1 to length(c) do
     begin
      if c[i]=')' then
        break
        else if c[i] in['0'..'9'] then
                c1_i:= c1_i * 10 + strtoint(c[i]);  //id
     end; //for i

    for i:= 1 to length(c) do
     begin
      if c[i]=',' then
       begin
        c2_i:= strtoint(c[i+1]);
        break;
       end; //数量
     end; //for i

     for i:= 1 to length(c) do
     begin
      if b and (c[i]='''') then
       begin

        break;
       end else if c[i]=''''then begin
                                 b:= true;

                                end else if b then
                                 begin
                                   c1:= c1 + c[i];
                                 end;

     end; //for i



  t1:= copy(t,1,pos('(',t));
     delete(t,1,pos('(',t));
  t1:= t1+ copy(t,1,pos('(',t));
     delete(t,1,pos('(',t));

     t1:= t1 + inttostr(c1_i)+ ','+inttostr(c2_i)+ ',''' + c1 +'''';

     delete(t,1,pos(')',t)-1);

     t1:= t1 +t;

     memo2.Text:= t1;

end;

procedure TForm_tihuan.Button5Click(Sender: TObject);
var i: integer;
    ss,ss2: string;
    str1: Tstringlist;
begin
    if messagebox(handle,'现在开始重新做场景编号和名称的对应表，是否继续？','开始',mb_yesno)= mrno then
        exit;

    if (file_open_type= 1) and (file_save_path<> '') then
      ss2:= file_save_path
     else
       ss2:= data_path+ 'scene';

     screen.Cursor:= crhourglass;
        stop:= false;
        button5.Enabled:= false;
        form1.map_name_changed:= false;
        form1.map_name.Clear;
          str1:= Tstringlist.Create;

     for i:= strtoint(edit1.Text) to strtoint(edit2.Text) do
      begin
        //打开文件 查找 替换 保存
        ss:= ss2 +'\' + inttostr(i) +'.ugm';

        if not FileExists(ss) then
         Continue;


         if stop then break;

        form1.open_file_scene(ss,str1);
        label5.Caption:= inttostr(i);
           application.ProcessMessages;

         ss:= str1.Values['名称'];
         if form1.map_name.Values[ss]= '' then
            form1.map_name.Append(ss+'='+str1.Values['id']);

      end;

      form1.map_name.SaveToFile(extractfilepath(application.ExeName)+'highlighters\map_name.txt');
      screen.Cursor:= crdefault;
      button5.Enabled:= true;
        str1.Free;

        
end;

end.
