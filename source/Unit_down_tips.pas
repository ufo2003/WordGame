unit Unit_down_tips;

interface

uses
  Classes,SysUtils;

type
  down_tips = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation
   uses unit_data,URLMon,windows,unit1;
{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure down_tips.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ down_tips }

procedure down_tips.Execute;
var str1,str2: Tstringlist;
    i: integer;
    ss,ss_file,ss_down: string;
begin
  { Place thread code here
  先检测文件是否存在
  如果不存在，那么下载
  如果存在，那么追加
  }

  str1:= Tstringlist.Create;
  ss_file:= game_doc_path_G +'save/read.dat';
  ss_down:= game_doc_path_G +'save/read.dwn';
  if FileExists(ss_file) then
      str1.LoadFromFile(ss_file);

     ss:= 'http://www.finer2.com/NetBook_re.asp?page='+ inttostr(str1.Count div 10);

     if UrlDownloadToFile(nil, Pchar(ss), Pchar(ss_down), 0, nil)= 0 then
        begin
           sleep(600);
           str2:= Tstringlist.Create;
            str2.LoadFromFile(ss_down);
            if str2.Count > 0 then
             begin
              for i:=str2.Count-1 downto 0 do //清理头尾 需要 if then 优化开启
                  if (str2.Strings[i]= '') or (str2.Strings[i][1]='<') then
                     str2.Delete(i);

              ss_down:= str2.Text;
               ss_down:= StringReplace(ss_down, #13#10, '', [rfReplaceAll]);
               ss_down:= StringReplace(ss_down, '<::>', #13#10, [rfReplaceAll]);
                 str2.Text:= ss_down;
                 if str2.Count > 0 then
                 begin
                  for i:= str2.Count-1 downto str1.Count mod 10 do
                      str1.Append(str2.Strings[i]); //拷贝多下载的进入

                      str1.SaveToFile(ss_file);
                 end;
             end;
           str2.Free;
        end;

  if str1.Count > 0 then
    begin
        //添加到阅读文件内
      game_read_stringlist.AddStrings(str1);
    end;
  str1.Free;
end;

end.
