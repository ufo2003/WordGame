unit unit_save;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_save = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1MeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
    function check_password(const s: string): boolean;
  public
   addr: string;
   cunpan: string; //最后存盘地址
    procedure CreateParams(var Para:TCreateParams);override;
    function get_app_data_path: string;
    { Public declarations }
  end;

var
  Form_save: TForm_save;

implementation
    uses unit1,unit_data,SHFolder,shellapi,md5;
{$R *.dfm}

procedure TForm_save.FormShow(Sender: TObject);
var vSearchRec: TSearchRec;
  vPathName,ss: string;
  j,K: Integer;
  px: array of integer;
begin
   listbox1.Items.Clear;
    setlength(px,1024); //开辟一个内存

   vPathName := game_doc_path_G+'save\*.*';   //先搜索文档路径
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      listbox1.Items.Add(vSearchRec.Name);
       px[listbox1.Count-1]:= vSearchRec.Time;
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

   vPathName := game_app_path_G+'save\*.*';   //再搜索程序目录
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      listbox1.Items.Add(vSearchRec.Name);
       px[listbox1.Count-1]:= vSearchRec.Time;
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

  vPathName := get_app_data_path + '\背单词游戏存盘数据\*.*';  //再次搜索app路径
  K := FindFirst(vPathName, faDirectory, vSearchRec);
  while K = 0 do
  begin
    if (vSearchRec.Attr and faDirectory <> 0) and (Pos(vSearchRec.Name, '..') = 0) then
    begin
      listbox1.Items.Add(vSearchRec.Name);
      px[listbox1.Count-1]:= vSearchRec.Time;
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);

  screen.Cursor:= crhourglass;
   listbox1.Items.BeginUpdate;
    for j:= 1 to listbox1.Count-1 do
     begin
       for k:= j to listbox1.Count-1 do
         begin
           if px[k] > px[j-1] then
             begin
                ss:= listbox1.Items.Strings[k];
                listbox1.Items.Strings[k]:= listbox1.Items.Strings[j-1];
                listbox1.Items.Strings[j-1]:= ss;
                px[k]:= px[k] xor px[j-1];   //交换值
                px[j-1]:= px[k] xor px[j-1];
                px[k]:= px[k] xor px[j-1];
             end;
         end;
     end;

   for k:= 0 to 49 do
  listbox1.Items.Append('');

  listbox1.Items.endUpdate;
 screen.Cursor:= crdefault;

end;

procedure TForm_save.Button3Click(Sender: TObject);
begin
self.Close;
end;

procedure TForm_save.Button1Click(Sender: TObject);
    function get_date_str: string;
     var s: string;
     begin
       s:= datetimetostr(now);
       s:= StringReplace(s,' ','',[rfReplaceAll]);
       s:=StringReplace(s,'-','',[rfReplaceAll]);
       s:=StringReplace(s,':','',[rfReplaceAll]);
       s:=StringReplace(s,'/','',[rfReplaceAll]);
       s:=StringReplace(s,'\','',[rfReplaceAll]);
       result:= s;
     end;
var ss,ss2,gsfNmae: string;
    str1: Tstringlist;
begin
     if game_debug_handle_g<> 0 then
     begin
      messagebox(handle,'调试时不能存盘。','提示',mb_ok);
     exit;
     end;
   if (Game_scene_type_G and 2 = 2) and (Sender= button1) then  //在迷宫
    begin
      messagebox(handle,'迷宫内不能存盘，需要退出迷宫或者使用游戏道具存储卡存盘。','提示',mb_ok);
     exit;
     end;

    if game_role_list.Count=0 then
  begin
   if (sender<> form1) and (sender<>button7) then
    begin
       messagebox(handle,'游戏没有开始，请先开始游戏或者载入进度。','游戏没开始',mb_ok);
     exit;
    end;
  end;
    if game_at_net_g then
     begin
      messagebox(handle,'联网游戏不用存盘','提示',mb_ok);
     exit;
     end;

   //保存
     if checkbox1.Checked then
     begin
      if edit1.Text= '' then
       begin
        messagebox(handle,'您选择了加密存档，但您没有输入密码。请在右下角的密码框内输入密码。','输入密码',mb_ok);
        screen.Cursor:= crdefault;
        exit;
       end;
      if edit1.Text<> edit2.Text then
       begin
        messagebox(handle,'您前后两次输入的密码不同，密码和再次重复的密码必须相同。','不相同的密码',mb_ok);
        screen.Cursor:= crdefault;
        exit;
       end;
     end;
     
     addr:= form1.groupbox5.Caption;
   if sender<> form1 then
   begin
   if listbox1.ItemIndex = -1 then
    ss:= ''
     else
      ss:= listbox1.Items.Strings[listbox1.ItemIndex];
   end else
           ss:= '';

   if (ss<> '') and (sender<>button7) then
    begin
     if messagebox(handle,pchar('是否覆盖档案：'+ ss+' ？'),'询问',mb_yesno or MB_ICONQUESTION)= mryes then
      begin
       if not check_password(ExtractFilePath(application.ExeName) + 'save\'+ ss+'\role.dat') then
        exit;

       ss2:= addr + get_date_str; //获得新档案名
         if checkbox1.Checked then
             begin
              if pos('!',ss2)= 0 then
                 ss2:= ss2+'!'+ form1.game_get_newname_at_id(1); //加入一个保密标记
             end;
       //改名
       renamefile(game_doc_path_g + 'save\'+ ss,
                   game_doc_path_g + 'save\'+ ss2);
       ss:= ss2;
      end;
    end else ss:= addr + get_date_str;


     if sender=button7 then
     begin
       if opendialog1.Execute then
        begin
        gsfNmae:= opendialog1.FileName;  //导入存档时
         ss:= ExtractFileName(gsfNmae);
         ss:= copy(ss,1,pos('.',ss)-1);
         ss2:= ss; //保存一个名称备用
        end
         else exit;
     end;

screen.Cursor:= crhourglass;

        ss:= game_doc_path_g + 'save\'+ ss;

    if checkbox1.Checked then
     begin
     if pos('!',ss)= 0 then
       ss:= ss+'!'+form1.game_get_newname_at_id(1); //加入一个保密标记
     end;

    if not DirectoryExists(ss) then
          CreateDir(ss); //创建存档文件


    if not DirectoryExists(ss) then
     begin
      //如果不成功，再在app目录下创建一下
      if sender=button7 then
       ss:= get_app_data_path + '\背单词游戏存盘数据\'+ ss2
       else
         ss:= get_app_data_path + '\背单词游戏存盘数据\'+ addr + get_date_str;

       if not ForceDirectories(ss) then
        showmessage('创建文件夹失败：'+ ss+ SysErrorMessage(getlasterror));
     end;

    if not DirectoryExists(ss) then
     begin
       messagebox(handle,'创建存盘目录失败。如果是在 win7 下，您可以以管理员身份运行游戏，或者对游戏安装目录内的save文件夹单独授予权限，或者不把游戏安装在系统盘，可以安装在D盘，E盘等。','失败',mb_ok or MB_ICONERROR);
     end else begin  //******************************************
               cunpan:= ExtractFilePath(ss +'\');
               if sender=button7 then
                begin
                 data2.in_save(gsfNmae,ss);
                  //刷新
                  FormShow(Sender);
                 screen.Cursor:= crdefault;
                 exit; //导入存单，导入后退出
                end else
                     form1.game_save_doc(cunpan);
               if checkbox1.Checked then
                   begin
                     str1:= Tstringlist.Create;
                      str1.Append(StrMD5(edit1.text));
                     str1.SaveToFile(ss+'\role.dat');
                     str1.Free;
                     edit1.Text:= '';
                     edit2.Text:= '';
                   end;
                Game_not_save:= false;
                if sender<> form1 then
                 Button1.Enabled:= false;
              end;  //*********************************************
 if sender<> form1 then
  Button1.Enabled:= true;

screen.Cursor:= crdefault;

  if sender<> form1 then
  self.Close;

end;

procedure TForm_save.Button2Click(Sender: TObject); //读取
var ss,ss2: string;
begin
   if game_at_net_g then
     begin
      messagebox(handle,'联网游戏不能读盘','提示',mb_ok);
     exit;
     end;

   if sender<> form1 then
    begin
   if Game_not_save then
  begin
    case messagebox(handle,'游戏没有存盘，当前进度会丢失，是否读取以前的进度？','提示',mb_yesnocancel or MB_ICONQUESTION) of
    //mryes: game_save(0);
    mrno: exit;
    mrcancel: exit;
    end;
  end;

   if listbox1.ItemIndex = -1 then
    ss:= ''
     else
      ss:= listbox1.Items.Strings[listbox1.ItemIndex];

   if ss= '' then
     begin
      messagebox(handle,'请选择一个有效的存盘进度。','选择进度',mb_ok);
      exit;
     end;


    ss2:= game_doc_path_g+ 'save\'+ ss;
    if not check_password(ss2+ '\role.dat') then
    begin
     exit;
    end;
     end else ss2:=  cunpan; //自动读盘


     if not DirectoryExists(ss2) then
       ss2:= ExtractFilePath(application.ExeName)+ 'save\'+ ss;

       //再次检查文件夹是否存在
     if not DirectoryExists(ss2) then
       ss2:= get_app_data_path + '\背单词游戏存盘数据\'+ ss;


     if not DirectoryExists(ss2) then
     begin
       messagebox(handle,'读取进度出错，可能存盘进度被意外删除。','出错',mb_ok);
       exit;
     end;
Button2.Enabled:= false;
screen.Cursor:= crhourglass;
     if sender=button8 then
      begin
       //读取以导出存档
       savedialog1.FileName:= ss+'.gsf';
       if savedialog1.Execute then
          data2.out_save(ss2,savedialog1.FileName);
      end else
          form1.game_load_doc(ExtractFilePath(ss2 +'\'));  //读取存档
Button2.Enabled:= true;
screen.Cursor:= crdefault;

   self.Close;
   
end;

procedure TForm_save.ListBox1DblClick(Sender: TObject);
begin
if listbox1.ItemIndex= -1 then
 exit;

 if button1.Enabled= false then
    button2click(sender)
    else begin
          if listbox1.Items.Strings[listbox1.ItemIndex]= '' then
            begin
             if Game_scene_type_G and 2 = 2 then
             messagebox(handle,'迷宫内不能存盘。但是您可以点击“使用存储卡”来存盘。','不能存盘',mb_ok)
             else begin
             if messagebox(handle,'是否存盘？','询问',mb_yesno or MB_ICONQUESTION)= mryes then
                button1click(sender);
                  end;
            end else begin
                      if messagebox(handle,'要读取进度吗？','询问',mb_yesno or MB_ICONQUESTION)= mryes then
                         button2click(sender);
                     end;
         end;
end;

procedure TForm_save.Button4Click(Sender: TObject);
begin
  if game_debug_handle_g<> 0 then
     begin
      messagebox(handle,'调试时不能存盘。','提示',mb_ok);
     exit;
     end;
  if game_role_list.Count=0 then
  begin
   messagebox(handle,'游戏没有开始，请先开始游戏或者载入进度。','游戏没开始',mb_ok);
   exit;
  end;
  
    if game_at_net_g then
     begin
      messagebox(handle,'联网游戏不用存盘','提示',mb_ok);
     exit;
     end;

  if form1.game_check_goods_nmb('存储卡',1)= 1 then
    begin
     button1click(sender);
     form1.game_goods_change_n('存储卡',-1); //减去存储卡
    end else messagebox(handle,'存储卡数量不足，该卡可以在游戏里面的杂货店买到。','数量不够',mb_ok or MB_ICONWARNING);
end;

procedure TForm_save.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
ListBox1.Canvas.FillRect(Rect);

     ListBox1.Canvas.Font.Style:= [fsbold];
    ListBox1.Canvas.Font.Size:= 16;

      if ListBox1.Items[Index] = '' then
        begin
        ListBox1.Canvas.Font.Color:= clgreen;
        ListBox1.Canvas.TextOut(Rect.Left+2, Rect.Top, '空');
        end else begin
                     if pos('!',ListBox1.Items[Index])> 0 then
                      begin
                        ListBox1.Canvas.Font.Color:= clred;
                        ListBox1.Canvas.TextOut(Rect.Left+2, Rect.Top, '密');
                      end else begin
                                 ListBox1.Canvas.Font.Color:= clblue;
                                 ListBox1.Canvas.TextOut(Rect.Left+2, Rect.Top, '存');
                               end;
                       end;

    ListBox1.Canvas.Font.Size:= 12;
    ListBox1.Canvas.Font.Style:= [];
    ListBox1.Canvas.Font.Color:= clwindowtext;
  ListBox1.Canvas.TextOut(Rect.Left+26, Rect.Top+ 3, ListBox1.Items[Index]);
end;

procedure TForm_save.ListBox1MeasureItem(Control: TWinControl;
  Index: Integer; var Height: Integer);
begin
 Height:= 26;
end;

function TForm_save.get_app_data_path: string;
var InternetCacheFolder: Array[0..MAX_PATH] of Char;
begin
   SHGetFolderPath(0,CSIDL_APPDATA,0,0,InternetCacheFolder);
   Result:= InternetCacheFolder;
end;

procedure TForm_save.Button5Click(Sender: TObject);
var SHOP:TSHFILEOPSTRUCT;
   ss: string;
begin
 if listbox1.ItemIndex= -1 then
   begin
     messagebox(handle,'请选择一个存档','删除',mb_ok);
     exit;
   end;

 if listbox1.Items[listbox1.Itemindex]= '' then
   begin
     messagebox(handle,'请选择一个存档','删除',mb_ok);
     exit;
   end;
   ss:= ExtractFilePath(application.ExeName) + 'save\'+ listbox1.Items.Strings[listbox1.ItemIndex];
   if not check_password(ss+'\role.dat') then
    begin
     messagebox(handle,'删除失败','删除',mb_ok);
     exit;
    end;
  if messagebox(handle,'确定删除当前存档？','删除',mb_yesno)= mryes then
   begin

     FillChar(SHOP,Sizeof(SHOP),0);
 SHOP.Wnd:=0;
 SHOP.pFrom :=pchar(ss+#0#0);
 SHOP.wFunc :=FO_DELETE  ;
 //SHOP.fFlags:=FOF_NOCONFIRMATION; //如果你不行要提示的话就加上这句。
 SHFileOperation(SHOP);
  FormShow(self);
   end;
end;

procedure TForm_save.CheckBox1Click(Sender: TObject);
begin
  edit1.Enabled:= checkbox1.Checked;
  edit2.Enabled:= checkbox1.Checked;
end;

function TForm_save.check_password(const s: string): boolean;
var str1: Tstringlist;
begin
   if FileExists(s) then
    begin
     str1:= Tstringlist.Create;
      str1.LoadFromFile(s);
      if str1.Count= 0 then
       result:= true
       else
        begin
         if edit1.Text= '' then
          begin
           checkbox1.Checked:= true;
           result:= false;
           messagebox(handle,'该档案被加密，请输入密码。','输入密码',mb_ok);
          end else begin
                    if CompareStr( str1.Strings[0],StrMD5(edit1.text))<> 0 then
                     begin
                       result:= false;
                       messagebox(handle,'密码错误。','密码错误',mb_ok);
                     end  else
                         result:= true;
                   end;
        end;
     str1.Free;
    end else result:= true;
end;

procedure TForm_save.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
  Para.WndParent:=Form1.Handle;

end;

procedure TForm_save.Button6Click(Sender: TObject);
begin
  if messagebox(handle,'是否打开游戏的存档文件夹？','文件夹',mb_yesno)=mryes then
    begin
      if DirectoryExists(get_app_data_path + '\背单词游戏存盘数据') then
         begin
          ShellExecute(0,
             'open',pchar(get_app_data_path + '\背单词游戏存盘数据'),nil,nil,sw_shownormal);

         end else  ShellExecute(0,
             'open',pchar(ExtractFilePath(application.ExeName) + 'save'),nil,nil,sw_shownormal);
    end;
end;

procedure TForm_save.Button7Click(Sender: TObject);
begin
  Button1Click(Sender); //导入存单
end;

procedure TForm_save.Button8Click(Sender: TObject);
begin
  Button2Click(button8);   //导出存单
  
end;

end.
