unit Unit2;

interface

uses
  Classes,SysUtils,windows,URLMon,unit_data,System.Zip;

type
  Tkill = class(TThread)
  private
    { Private declarations }
    ss_1,ss_2,ss_3: string;
    procedure unzip;
  protected
    procedure Execute; override;
  end;
 var kill1: Tkill;
implementation
   uses unit1;
{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure kill.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ kill }
function need_update_times: boolean; //是否间隔了5天，需要重新下载
var str1: Tstringlist;
    d1: tdatetime;
     b: boolean;
begin
result:= true;
 b:= false;

 str1:= Tstringlist.Create;
 if FileExists(game_doc_path_G +'save\update.dat') then
  begin
    str1.loadfromfile(game_doc_path_G +'save\update.dat');
    if TryStrToDate(str1.values['date'],d1) then
      begin
        if date- d1 > 5 then
          begin
           result:= true;
           b:= true;
          end else result:= false;
      end else b:= true;

  end else b:= true;

  if b then
   begin
    str1.values['date']:= datetostr(date);
    str1.SaveToFile(game_doc_path_G +'save\update.dat');
   end;
  str1.Free;
end;

procedure Tkill.Execute;
var
     //h: HWND;
     str1: Tstringlist;
     j: integer;
     b: boolean;
     ss: string;
     label pp;
begin
  { Place thread code here }
  FreeOnTerminate:=true;//
   //h:= form1.Handle;
   b:= false;

   j:= 0;
   //开始下载一个自动更新文件，间隔5天检测一次

   if (Game_update_url_G<> '') and (Game_update_file_G<> '') and need_update_times then
   begin
     ss_2:= game_doc_path_G +'tmp';
    if not DirectoryExists(ss_2) then
       mkdir(ss_2);

    ss_3:= ss_2 +'\';

    pp:
    ss_1 := Game_update_url_G+ Game_update_file_G; //合成完整路径
     ss_2:= game_doc_path_G +'tmp\' + Game_update_file_G;
     inc(j);

    if FileExists(ss_2) or (UrlDownloadToFile(nil, Pchar(ss_1), Pchar(ss_2), 0, nil)= 0) then
     begin
       b:= true;
      Synchronize(unzip); //解压缩文件
      if FileExists(ss_3+ 'read.txt') then
       begin
         str1:= Tstringlist.Create;
         str1.LoadFromFile(ss_3+ 'read.txt');
         Game_update_file_G:= str1[0];
         ss:=  str1.Values['msg'];
             {
          for i:= 1 to str1.Count - 1 do
           begin
            if FileExists(ss_3 + str1[i]) then
            begin
            if ExtractFileExt(str1[i])= '.exe' then
             begin
              movefile(pchar(game_app_path_G + str1[i]),pchar(ss_3 + str1[i]+'2'));
              b:= true;
             end;
              copyfile(pchar(ss_3 + str1[i]),pchar(game_app_path_G + str1[i]),false);

            end; //end if file
           end;
                }
          str1.Clear;
          if FileExists(game_doc_path_G +'dat\set.txt') then
            str1.LoadFromFile(game_doc_path_G +'dat\set.txt')
            else
              str1.LoadFromFile(game_app_path_G +'dat\set.txt');  //保存新的更新名称
          str1.Values['update_file']:= Game_update_file_G;
          str1.Values['app_path']:= game_app_path_G;   //保存游戏路径
          str1.SaveToFile(game_doc_path_G +'dat\set.txt');
         str1.Free;
       end;

       if j>= 10 then
         exit;

     if FileExists(game_app_path_G +'tmp\' + Game_update_file_G) then
        DeleteFile(pchar(game_app_path_G +'tmp\' + Game_update_file_G))
        else goto pp;

     end;

    
   end; //end if (game
   //下载结束

     //固定查找是否有exe文件，固定读取read.ext里的msg内容
      if b then
        Form1.shell_exe(ss);
        
      {
    if b then
     begin
      if messagebox(0,'主程序已经更新了，是否自动存盘并重启游戏？','询问',mb_yesnocancel or MB_ICONWARNING)= idyes then
       begin
        Form1.game_save(1);
        Form1.shell_exe; //再次执行，并带读盘参数
          TerminateProcess(GetCurrentProcess, 1);
       end;
     end;
           
   if DebugHook = 0 then
    begin
   While SendMessageTimeout(h, $0000, 0, 0, SMTO_NORMAL, 20000, Res)<>0 do
     begin
       sleep(1000);
     end;

    Form1.game_save(1);
    case messagebox(0,'程序意外失去响应，本场景已经自动存盘，点是结束程序并自动读盘。点否直接退出程序，然后你可以手工读盘。','程序失去响应',mb_yesnocancel or MB_ICONWARNING) of
       idyes: Form1.shell_exe; //再次执行，并带读盘参数
       idcancel: begin
                  kill1:= Tkill.Create(false); //再次创建监视线程
                  exit;
                 end;
       end;
    TerminateProcess(GetCurrentProcess, 1);
    end;

        }
end;

procedure Tkill.unzip;
begin
     TZipFile.ExtractZipFile(ss_2, ss_3);

end;

end.
 