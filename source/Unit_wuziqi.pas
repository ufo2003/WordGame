unit Unit_wuziqi;

interface

uses
  Windows, Messages, SysUtils,Classes;
const
  wuziqi_char_count_cn= 255;
  wuziqi_msg_c= $0400 + $6613;
type
  Twuziqi = class(TThread)
  private
   filename: string;
   hh: thandle;
   MyInput, ChildOutput,ChildInput, MyOutput: THandle;
si: STARTUPINFO;
lsa: SECURITY_ATTRIBUTES;
pi: PROCESS_INFORMATION;
cchReadBuffer: DWORD;
fname: array[0..max_path] of Char;
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create(aFileName: String; h:thandle); //载入的五子棋ai引擎

  end;

  var wuziqi_CriticalSection: TRTLCriticalSection; //关键代码段
     wuziqi_flag: integer;
       {0 无效状态
        1 读取数据写入中
        2数据获取完毕，可读取了
        3 读取中
        4 读取完毕
        5 发送数据写入中
        6 数据可以发送了
        7 数据发送中
        8数据发送完毕
        }
      wuziqi_receive,wuziqi_send: array[0..wuziqi_char_count_cn] of char;
implementation

{ wuziqi }
constructor Twuziqi.Create(aFileName: String; h:thandle);  //tmp关键字指定是否下载临时关键字指定的文件
begin
  FreeOnTerminate := True;
  inherited Create(True);

   FileName:= aFileName;
   hh:= h;
   if not FileExists(filename) then
     begin
      //发出消息，提示引擎不存在
      postmessage(hh,wuziqi_msg_c,0,999);
      exit;
     end;

     //载入引擎

lsa.nLength := sizeof(SECURITY_ATTRIBUTES);
lsa.lpSecurityDescriptor := nil;
lsa.bInheritHandle := True;
      //  建立输入管道（从被调进程送往本进程）
  if CreatePipe(MyInput, ChildOutput, @lsa, 0) = false then
    begin
     //发出消息，创建管道失败
      postmessage(hh,wuziqi_msg_c,1,999);
      exit;
    end;


    //建立输出管道（从本进程送往被调进程）
  if CreatePipe(ChildInput, MyOutput , @lsa, wuziqi_char_count_cn) = false then
    begin
     //发出消息，创建管道失败
      postmessage(hh,wuziqi_msg_c,1,999);
      exit;
    end;

fillchar(si, sizeof(STARTUPINFO), 0);
si.cb := sizeof(STARTUPINFO);
si.dwFlags := (STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW);
si.wShowWindow := SW_HIDE;
si.hStdOutput := ChildOutput;
si.hStdInput:= ChildInput;
fillchar(fname, sizeof(fname), #0);


//fname := 'cmd.exe cmd/c ';
lstrcat(fname, pchar(filename));

    if CreateProcess( nil, fname, nil, nil, true, NORMAL_PRIORITY_CLASS, nil, nil, si, pi) = False  then
     begin
      //发回错误信息，创建引擎失败
      postmessage(hh,wuziqi_msg_c,2,999);
      exit;
     end;
     
 writefile(MyOutput,'START 15'+#13#10,10,cchreadbuffer,nil);

     InitializeCriticalSection(wuziqi_CriticalSection); //初始化关键代码段变量

  Resume;
end;

procedure Twuziqi.Execute;
begin
  { Place thread code here }


while not Terminated do
begin
 cchReadBuffer:= 0;
  if not PeekNamedPipe(MyInput, @wuziqi_receive, wuziqi_char_count_cn, @cchReadBuffer, nil, nil) then
    break;

     if cchReadBuffer <> 0 then
     begin
      //EnterCriticalSection(wuziqi_CriticalSection);
       //wuziqi_flag:= 1;// 数据获取中
      //读取数据
       fillchar(wuziqi_receive, sizeof(wuziqi_receive), #0);
        if ReadFile(MyInput, wuziqi_receive, wuziqi_char_count_cn, cchReadBuffer, nil) = false then
           break;
       // wuziqi_flag:= 2;// 数据获取完毕，可供读取
      //LeaveCriticalSection(wuziqi_CriticalSection);
       //发出消息，数据准备好了
        sendmessage(hh,wuziqi_msg_c,3,999);

     end else begin
              //往管道写数据
              if wuziqi_flag= 6 then
               begin
              EnterCriticalSection(wuziqi_CriticalSection);
               wuziqi_flag:= 7; //数据发送中
               writefile(MyOutput,wuziqi_send,byte(wuziqi_send[wuziqi_char_count_cn]),cchreadbuffer,nil);
               wuziqi_flag:= 8; //数据发送完毕
              LeaveCriticalSection(wuziqi_CriticalSection);
               end;
             end;

  // if(WaitForSingleObject(pi.hProcess , 0) = WAIT_OBJECT_0) then break;

  Sleep(50);
end;

//发送引擎退出消息
  writefile(MyOutput,'end'+#13#10,5,cchreadbuffer,nil);

 DeleteCriticalSection(wuziqi_CriticalSection);
CloseHandle(MyOutput);
CloseHandle(Myinput);
CloseHandle(ChildInput);
CloseHandle(Childoutput);
CloseHandle(pi.hThread);
CloseHandle(pi.hProcess);


end;


end.
 