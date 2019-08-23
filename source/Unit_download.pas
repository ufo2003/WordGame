unit Unit_download;

interface

uses
  Classes,windows,URLMon,unit_data;

type
  gm_download = class(TThread)
  private
    { Private declarations }
    Fhandle1: integer; //form1 handle
    Fpage_id: integer; //page id
    FSource,FDest: string;
  protected
    procedure Execute; override;
    public
    Constructor Create(const n: string; id,hd1: integer);
  end;

implementation

{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure gm_download.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ gm_download }

constructor gm_download.Create(const n: string; id, hd1: integer);
begin
 inherited Create(false);
  Fhandle1:= hd1;
  if (length(n)>3) and (n[1]= 'B') and (n[2]='G') and (n[3]='_') then
  Fpage_id:= id * 2  //背景图像，做特殊处理
  else
   Fpage_id:= id;
  FSource:= Game_app_img_url_G + n;
  FDest:= Game_app_img_path_G + n;

 FreeOnTerminate:=True; //线程对象自动释放（FreeOnTerminate）为True

end;

procedure gm_download.Execute;
begin
  { Place thread code here }
  if UrlDownloadToFile(nil, Pchar(FSource), Pchar(FDest), 0, nil)= 0 then
   begin

    postmessage(fhandle1,game_const_script_after,1086,fpage_id);
   end else begin
               //下载失败，累计错误次数
             inc(Game_error_count_G);
             postmessage(fhandle1,game_const_script_after,1087,fpage_id);
            end;
end;

end.
 