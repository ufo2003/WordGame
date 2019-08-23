unit Unit_mp3_yodao;

interface

uses
  Windows, Messages, SysUtils, Classes,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  Tmp3_yodao = class(TThread)
  private
    FTAcceptTypes,
    FTAgent,
    FTURL,
    FTStringResult,
    FTUserName,
    FTPassword,
    FTPostQuery,
    FTReferer: String;
    FTBinaryData,
    FTUseCache: Boolean;
    FTResult: Boolean;
    FTFileSize: Integer;
    FTToFile: Boolean;
    fhandle: thandle;
    BytesToRead, BytesReaded: DWord;
    
   // FTProgress: TOnProgressEvent;
    procedure down_mp3;
  protected
    procedure Execute; override;
  public
    
    file_path,file_name,Tcp_path,guid: string;
    constructor Create(afile_path: String; h: thandle); //tmp关键字指定是否下载临时关键字指定的文件
  end;

  var
    token_expires: integer;
    baidu_busy: boolean;
    token: string;
    mp3FileName: string;
    mp3_yodao1: Tmp3_yodao;
implementation
      uses bass,unit_data;
constructor Tmp3_yodao.Create(afile_path: String;h: thandle);  //tmp关键字指定是否下载临时关键字指定的文件
begin
  FreeOnTerminate := True;
  inherited Create(True);

  fhandle:= h;
   file_path:= afile_path;
  FTAcceptTypes := '*/*';
  FTAgent := 'Mozilla/4.0 (compatible; MSIE 6.0; Win32)';

    FTUserName := '';
    FTPassword := '';
  //FTPostQuery := aPostQuery;
    FTPostQuery := '';
 // FTReferer := aReferer;
    FTReferer := 'file://D|\Yodao\DeskDict\resultui\images\voice.swf..x-flash-version: 9,0,124,0';
 // FTProgress := aProgress;
  FTBinaryData := false;
  FTUseCache := false;

  FTToFile := true;
 // Resume;
end;

procedure Tmp3_yodao.down_mp3;
var

  mem: TMemoryStream;
  memstr: TStringStream;
    idhttp1: Tidhttp;
     ssl: tIdSSLIOHandlerSocketOpenSSL;
     i: integer;
     ss: string;
begin
   postmessage(fhandle,WM_USER + $7127,1022,0);
    idhttp1:= tidhttp.Create(nil);

     if token='' then
      begin
        //先取得授权
       memstr:= TStringStream.Create('');
       ssl:= tIdSSLIOHandlerSocketOpenSSL.Create(nil);
       idhttp1.ReadTimeout:= 15000;
       idhttp1.ConnectTimeout := 15000;
       idhttp1.IOHandler:= ssl;
        ssl.SSLOptions.Method:= sslvSSLv3;
       try
      IdHTTP1.get('https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id=zaEIK0oDtjlaiPyq6tyN2ume&client_secret=AMzfP4j6RDLgaGzZ3wq0pSFlNVDu7O7l',memstr);
     except
        postmessage(fhandle,WM_USER + $7127,1024,0); //获取授权出错
        memstr.Free;
        idhttp1.Free;
       exit;
     end;

      ss:= memstr.DataString;
      //token 提取
       i:= pos('access_token',ss);
       if i=0 then
         postmessage(fhandle,WM_USER + $7127,1024,0); //获取授权出错
       token:= copy(ss,i,255);
      delete(token,1,pos(':',token));
      delete(token,1,pos('"',token));
      token:= copy(token,1,pos('"',token)-1);

        i:= pos('expires_in',ss);
       ss:= copy(ss,i,64);
       delete(ss,1,pos(':',ss));
        for i := 1 to 20 do
          if ss[i] in ['0'..'9'] then
            token_expires:= token_expires * 10 + ord(ss[i])-48
            else break;
            
        if token_expires=0 then
           postmessage(fhandle,WM_USER + $7127,1024,0); //获取授权出错
      memstr.Free;
      ssl.Free;
      end;
    postmessage(fhandle,WM_USER + $7127,1023,0);  //保存新的token
   {
    TempStr:='http://tsn.baidu.com/text2audio?tex='
    +file_name +
    '&lan=zh&cuid='+guid+
    '&ctp=1&tok='+token;

    mem:= TMemoryStream.Create;
    //  idhttp1.Get(TempStr,mem);
    if mem.Size=0 then
       begin
         inc(yodao_error_count);
         mem.Free;
         idhttp1.Free;
         exit;
       end;

     mem.Position:= 0;
     mem.SaveToFile(file_path+ file_name +'.mp3');
     mem.Free;
                 }
    idhttp1.Free;

end;

function AnsiToWide(const S: AnsiString): WideString;
var
len: integer;
ws: WideString;
begin
Result:='';
if (Length(S) = 0) then
exit;
len:=MultiByteToWideChar(CP_ACP, 0, PChar(s), -1, nil, 0);
SetLength(ws, len);
MultiByteToWideChar(CP_ACP, 0, PChar(s), -1, PWideChar(ws), len);
Result:=ws;
end; 

function WideToUTF8(const WS: WideString): UTF8String;
var
len: integer;
us: UTF8String;
begin
Result:='';
if (Length(WS) = 0) then
exit;
len:=WideCharToMultiByte(CP_UTF8, 0, PWideChar(WS), -1, nil, 0, nil, nil);
SetLength(us, len);
WideCharToMultiByte(CP_UTF8, 0, PWideChar(WS), -1, PChar(us), len, nil, nil);
Result:=us;
end;
function URLEncode(const S: string; const InQueryString: Boolean): string;
var
  Idx: Integer; // loops thru characters in string
begin
  Result := '';
  for Idx := 1 to Length(S) do
  begin
    case S[Idx] of
      'A'..'Z', 'a'..'z', '0'..'9', '-', '_', '.':
        Result := Result + S[Idx];
      ' ':
        if InQueryString then
          Result := Result + '+'
        else
          Result := Result + '%20';
      else
        Result := Result + '%' + SysUtils.IntToHex(Ord(S[Idx]), 2);
    end;
  end;
end;

procedure Tmp3_yodao.Execute;
var strs: HSTREAM;
    act: DWORD;
    TempStr: utf8string;
    mem: TMemoryStream;
    idhttp1: Tidhttp;
    ss: string;
   // const msg_langdu_huancong= WM_USER + $7127;
begin

    if not BASS_Init(-1, 44100, 0, fhandle, nil) then
      exit;

   repeat
     baidu_busy:= true;
     ss:= '';
     if file_name= '' then
        file_name:= 'ufo';

     //if not FileExists(file_path+ file_name +'.mp3') then
     if token='' then
        down_mp3;

        // sleep(25);
       if pos('bd_vsp=',file_name)=1 then
          begin
           ss:= copy(file_name,8,pos(';',file_name)-1);
           delete(file_name,1,pos(';',file_name));
          end;

       TempStr:='http://tsn.baidu.com/text2audio?tex='
    +URLEncode(WideToUTF8(AnsiToWide(file_name)),false) +
    '&lan=zh&cuid='+guid+
    '&ctp=1&tok='+token;

       if ss<>'' then
        begin
         TempStr:= TempStr+ss;
        end else begin
        if game_bg_music_rc_g.baidu_vol<>5 then
          TempStr:= TempStr+ '&vol='+inttostr(game_bg_music_rc_g.baidu_vol);
        if game_bg_music_rc_g.baidu_spd<>5 then
          TempStr:= TempStr+ '&spd='+inttostr(game_bg_music_rc_g.baidu_spd);
        if game_bg_music_rc_g.baidu_sex<>0 then
          TempStr:= TempStr+ '&per=1';
        if game_bg_music_rc_g.baidu_pit<>5 then
          TempStr:= TempStr+ '&pit='+inttostr(game_bg_music_rc_g.baidu_pit);
                end;
    if mp3FileName<>'' then
     begin
       //下载
       mem:= TMemoryStream.Create;
       idhttp1:= tidhttp.Create(nil);
      idhttp1.Get(TempStr,mem);
     mem.Position:= 0;
     mem.SaveToFile(mp3FileName);
     mem.Free;
      idhttp1.Free;
      strs:= BASS_StreamCreateFile(False, pchar(mp3FileName), 0, 0, 0);
      mp3FileName:= '';
     end else begin
               strs:= BASS_StreamCreateURL(pchar(TempStr), 0,BASS_SAMPLE_MONO,nil,0);
              end;
       //朗读
          if strs<> 0 then
            begin
             // BASS_SetConfig(BASS_CONFIG_GVOL_STREAM,game_bg_music_rc_g.bg_yl * 100); //设定音量
             BASS_ChannelPlay(strs, False);
             act := BASS_ChannelIsActive(strs);
             if act= 0 then
              begin
               token_expires:=  BASS_ErrorGetCode;
               postmessage(fhandle,WM_USER + $7127,1026,0); //播放百度语音出错
               //messagebox(0,pchar('播放有道单词发音时出现了错误，您可以在游戏设置页面内关闭“优先使用有道发音”。错误号：'+ inttostr(act)),'错误',mb_ok);
              end;

             while act > 0 do
               begin
                sleep(50);
                act := BASS_ChannelIsActive(strs);
               end; //end while

            end else begin
                      token_expires:=  BASS_ErrorGetCode;

                      postmessage(fhandle,WM_USER + $7127,1025,0); //获取百度语音出错
                      // messagebox(0,pchar('播放有道单词发音时出现了错误，您可以在游戏设置页面内关闭“优先使用有道发音”。错误号：'+ inttostr(act)),'错误',mb_ok);
                     end;

         BASS_ChannelStop(strs);
        BASS_StreamFree(strs);
       baidu_busy:= false;
       // postmessage(fhandle,msg_langdu_huancong,1022,0);  //原先下载和朗读不同步，现在已经是先下载后朗读了，所以这个过程不需要了


      Suspend; //线程挂起
    until Terminated;

   BASS_Free(); //释放bass 库
end;

end.


