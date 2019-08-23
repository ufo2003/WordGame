unit Unit_downhttp;

interface

uses
  Windows, Messages, SysUtils, Classes, WinInet;

type
  down_http = class(TThread)
  private
    FTAcceptTypes,
    FTAgent,
    FTURL,
    FTFileName,
    FTStringResult,
    FTUserName,
    FTPassword,
    FTPostQuery,
    FTReferer: String;
    FTBinaryData,
    FTUseCache: Boolean;
    Ftmp: boolean;
    FTResult: Boolean;
    FTFileSize: Integer;
    FTToFile: Boolean;

    BytesToRead, BytesReaded: DWord;

   // FTProgress: TOnProgressEvent;

   procedure UpdatePic;
  protected
    procedure Execute; override;
  public
    constructor Create(aURL, aFileName: String; tmp: boolean); //tmp关键字指定是否下载临时关键字指定的文件
  end;

implementation
    uses faststrings,unit_data,unit1;
{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure down_http.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ down_http }

constructor down_http.Create(aURL, aFileName: String; tmp: boolean);  //tmp关键字指定是否下载临时关键字指定的文件
begin
  FreeOnTerminate := True;
  inherited Create(True);

  FTAcceptTypes := '*/*';
  FTAgent := 'Mozilla/4.0 (compatible; MSIE 6.0; Win32)';
  FTURL := aURL;
  FTFileName := aFileName;
 // FTUserName := aUserName;
    FTUserName := '';
 // FTPassword := aPassword;
    FTPassword := '';
  //FTPostQuery := aPostQuery;
    FTPostQuery := '';
 // FTReferer := aReferer;
    FTReferer := ExtractFilePath(aFileName);
 // FTProgress := aProgress;
  FTBinaryData := false;
  FTUseCache := false;

  FTToFile := (FTFileName<>'');
  Ftmp:= tmp;
  Resume;
end;

procedure down_http.UpdatePic;
begin
  Form1.load_sch_pic;
end;
function ext_img_filename(const s: string): string; //提取yahoo图片文件名
var i,k: integer;
    s1,s2: string;
    label pp;
begin
  {取得图片文件名，首先搜索 herf地址，然后再搜索 src地址，如果相同，就取出}
  s1:= '';
  s2:= '';
  k:= 1;
  pp:
  k:= fastpos(s,'href="',length(s),6,k)+6;
  if k= 6 then exit;

  for i:= k to length(s) do
   begin
     if s[i]= '"' then
      begin
       s1:= copy(s,k,i- k);
       break;
      end;
   end;

  k:= fastpos(s,'src="',length(s),5,k) +5;
   if k= 5 then exit;
   for i:= k to length(s) do
   begin
     if s[i]= '"' then
      begin
       s2:= copy(s,k,i- k);
       break;
      end;
   end;

   if (length(s1)= length(s2)) and (s1=s2) then
     result:= s1
     else goto pp;

end;

procedure down_http.Execute;
var
  hSession, hConnect, hRequest: hInternet;
  HostName, FileName: String;
  f: File;
  Buf: Pointer;
  dwBufLen, dwIndex: DWord;
  Data: Array[0..$400] of Char;
  TempStr: String;
  RequestMethod: PChar;
  InternetFlag: DWord;
  AcceptType: LPStr;
  label pp;

  procedure ParseURL(URL: String; var HostName, FileName: String);

    procedure ReplaceChar(c1, c2: Char; var St: String);
    var
      p: Integer;
    begin
      while True do
       begin
        p := Pos(c1, St);
        if p = 0 then Break
        else St[p] := c2;
       end;
    end;

  var
    i: Integer;
  begin
    if Pos('http://', LowerCase(URL)) <> 0 then
      System.Delete(URL, 1, 7);

    i := Pos('/', URL);
    HostName := Copy(URL, 1, i);
    FileName := Copy(URL, i, Length(URL) - i + 1);

    if (Length(HostName) > 0) and (HostName[Length(HostName)] = '/') then
      SetLength(HostName, Length(HostName) - 1);
  end;

 procedure CloseHandles;
 begin
   InternetCloseHandle(hRequest);
   InternetCloseHandle(hConnect);
   InternetCloseHandle(hSession);
 end;

begin
  try
    pp:
    ParseURL(FTURL, HostName, FileName);

    if Terminated then
     begin
      FTResult := False;
      Exit;
     end;

    if FTAgent <> '' then
     hSession := InternetOpen(PChar(FTAgent),
       INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0)
    else
     hSession := InternetOpen(nil,
       INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

    hConnect := InternetConnect(hSession, PChar(HostName),
      INTERNET_DEFAULT_HTTP_PORT, PChar(FTUserName), PChar(FTPassword), INTERNET_SERVICE_HTTP, 0, 0);

    if FTPostQuery = '' then RequestMethod := 'GET'
    else RequestMethod := 'POST';

    if FTUseCache then InternetFlag := 0
    else InternetFlag := INTERNET_FLAG_RELOAD;

    AcceptType := PChar('Accept: ' + FTAcceptTypes);
    hRequest := HttpOpenRequest(hConnect, RequestMethod, PChar(FileName), 'HTTP/1.0',
                PChar(FTReferer), @AcceptType, InternetFlag, 0);

    if FTPostQuery = '' then
     HttpSendRequest(hRequest, nil, 0, nil, 0)
    else
     HttpSendRequest(hRequest, 'Content-Type: application/x-www-form-urlencoded', 47,
                     PChar(FTPostQuery), Length(FTPostQuery));

    if Terminated then
     begin
      CloseHandles;
      FTResult := False;
      Exit;
     end;
   
    dwIndex  := 0;
    dwBufLen := 1024;
    GetMem(Buf, dwBufLen);

    FTResult:=HttpQueryInfo(hRequest, HTTP_QUERY_STATUS_CODE, Buf, dwBufLen, dwIndex);

    if not FTResult or Terminated or (StrPas(Buf)<>'200') then
     begin
      FreeMem(Buf);
      CloseHandles;
      FTResult := False;

            if(pos('wait.gif',temp_pic_file_g)>0) then
             begin
                temp_pic_file_g:= ExtractFilePath(temp_pic_file_g)+'error.gif';
                Synchronize(UpdatePic); //更新图片
             end;
      Exit;
     end;

    FTResult := HttpQueryInfo(hRequest, HTTP_QUERY_CONTENT_LENGTH,
                              Buf, dwBufLen, dwIndex);

    if FTResult or not FTBinaryData then
     begin
      if FTResult then
        FTFileSize := StrToInt(StrPas(Buf));

      BytesReaded := 0;

      if FTToFile then
       begin
        AssignFile(f, FTFileName);
        Rewrite(f, 1);
       end
      else FTStringResult := '';

      while True do
       begin
        if Terminated then
         begin
          if FTToFile then CloseFile(f);
          FreeMem(Buf);
          CloseHandles;

          FTResult := False;
          Exit;
         end;

        if not InternetReadFile(hRequest, @Data, SizeOf(Data), BytesToRead) then Break
        else
         if BytesToRead = 0 then Break
         else
          begin
           if FTToFile then
            BlockWrite(f, Data, BytesToRead)
           else
            begin
             TempStr := Data;
             SetLength(TempStr, BytesToRead);
             FTStringResult := FTStringResult + TempStr;
            end;

           inc(BytesReaded, BytesToRead);
         //  if Assigned(FTProgress) then
          //  Synchronize(UpdateProgress);
          end;
       end;

      if FTToFile then
        FTResult := FTFileSize = Integer(BytesReaded)
      else
       begin
        SetLength(FTStringResult, BytesReaded);
        FTResult := BytesReaded <> 0;
       end;

      if FTToFile then
       begin
         CloseFile(f);
         if pos('\down_img',ftfilename)> 0 then
            begin
            temp_pic_file_g:= FTFileName;
            if ((temp_sch_key_g<> '') and ftmp) or (pos('wait.gif',temp_pic_file_g)>0) then
                Synchronize(UpdatePic); //更新图片
            end;
       end;
     end;

    FreeMem(Buf);

    CloseHandles;

    if not FTToFile then
     begin
      if (temp_sch_key_g<> '') and (ftmp=false) then
          exit; //处于临时状态，但tmp却不为true的

      FTURL:= ext_img_filename(FTStringResult); //提取图片文件名
      if fturl= '' then
         exit;
      FTFileName:= game_app_path_G+ 'down_img\'+ ExtractFileName(
                   StringReplace(FTURL,'/','\',[rfReplaceAll]));
     // temp_pic_file_g:= FTFileName; //保存图片路径
      FTtofile:= true;
     // goto pp;   //获取文件名后，再次下载
       down_http.Create(FTURL,FTFileName,ftmp);
     end;

  except
  end;

end;

end.
 