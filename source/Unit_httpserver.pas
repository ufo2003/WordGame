unit Unit_httpserver;

interface

uses
  System.Classes; //,winapi.windows

type
  Thttpserver = class(TThread)
  private
    { Private declarations }
    //IdHTTPServer1:TIdHTTPServer;
  // procedure CommandGet(AContext: TIdContext;
    //  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  protected
    procedure Execute; override;
  end;

  
  var httpserver1: Thttpserver;
implementation
   uses unit1;
{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure httpserver.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; 
    
    or 
    
    Synchronize( 
      procedure 
      begin
        Form1.Caption := 'Updated in thread via an anonymous method' 
      end
      )
    );
    
  where an anonymous method is passed.
  
  Similarly, the developer can call the Queue method with similar parameters as 
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
    
}

{ httpserver }
{
procedure Thttpserver.CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  var ss: string;
      strem1: TStream;
begin
    //ARequestInfo.CharSet:='gbk';
   ss:= ARequestInfo.Params.Values['p'];
   ss:= HexToStr(ss);

   //ss:= UTF8Decode(ss);
   if ss<>'' then
    begin
     //OutputDebugString(pchar(ss));
      AResponseInfo.ContentType:= 'image/bmp';
      strem1:= TMemoryStream.Create;
      form1.game_pic_from_text(strem1,ss);
      strem1.Position:= 0;
       AResponseInfo.ContentStream:= strem1;
      //strem1.Free;
    end;

end;
      }
procedure Thttpserver.Execute;
begin
  { Place thread code here }
 // IdHTTPServer1:= TIdHTTPServer.Create(nil);
  // IdHTTPServer1.defaultport:= 8081;
  // IdHTTPServer1.OnCommandGet:= CommandGet;
  // IdHTTPServer1.Active:= true;
   repeat
    sleep(20);
   until Terminated;

 // IdHTTPServer1.Active:= false;
 // IdHTTPServer1.Free;
end;

end.
