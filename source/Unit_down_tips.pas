unit Unit_down_tips;

interface

uses
  Classes,SysUtils,System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent;

type
  down_tips = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;
  var
   down_tip1: down_tips;
implementation
   uses unit_data,windows,unit1;
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
var     ss: string;
    nethttpclient1: Tnethttpclient;
begin
  { Place thread code here
  先检测文件是否存在
  如果不存在，那么下载
  如果存在，那么追加
  }


    nethttpclient1:= Tnethttpclient.Create(nil);

     ss:= 'http://download.abcd666.cn/readtext/get_text.php';
     repeat
      //如果允许下载，那么下载阅读材料，每次下载一条，不然从文件加载阅读材料
       if game_bg_music_rc_g.down_readfile then
        begin
         try
           show_share_text:= nethttpclient1.Get(ss).ContentAsString(tencoding.UTF8);
         except
           show_share_text:= '';
         end;

        end;

          if show_share_text='' then
           begin
             if FileExists(game_app_path_G +'dat\read.txt') then
               Game_read_stringlist.LoadFromFile(game_app_path_G +'dat\read.txt')
               else
                 Game_read_stringlist.Add('阅读材料不存在。http://www.finer2.com/wordgame/');
           end;
       Suspend; //线程挂起
     until Terminated;

  nethttpclient1.Free;
end;

end.
