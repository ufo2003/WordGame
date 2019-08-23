unit Unit_sijian;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TWatchThread = class(TThread)
  private
    FInfo : String;
    hHandles : array of THandle;
    WatchTarget : array of String;
    procedure ShowNotifyInfo;
    procedure AddNotifyRec;
  public
    procedure Execute; override;
  end;

  TForm_shijian = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    CheckBox2: TCheckBox;
    OpenDialog1: TOpenDialog;
    procedure Memo1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    WatchThread : TWatchThread;
    file_time: integer;
    procedure save_file;
  public
    { Public declarations }
    can_save: boolean;
    open_name: string;
    procedure open_file(n: string);
    procedure index_line(const s: string);
    procedure reload_file; //重新载入文件
  end;

var
  Form_shijian: TForm_shijian;

implementation

{$R *.dfm}
procedure TWatchThread.ShowNotifyInfo;
begin
  //ShowMessage(Self.FInfo);
  Form_shijian.reload_file;
end;

procedure TWatchThread.AddNotifyRec;
begin
 // MainForm.DirectoryListBox.Items.Add(MainForm.DirectoryEdit.Text);
end;

var
  CreateNotifyEvent : THandle;

procedure TWatchThread.Execute;
var
  Id : Integer;
  WAIT_OBJECT_N : Integer;
begin
  SetLength(hHandles, 1);
  SetLength(WatchTarget, 1);
  hHandles[0] := CreateNotifyEvent;
  WatchTarget[0] := '';

  repeat
    WAIT_OBJECT_N := WaitForMultipleObjects(Length(hHandles), @hHandles[0], false, INFINITE);
   // if WAIT_OBJECT_N = WAIT_FAILED then break;

    WAIT_OBJECT_N := WAIT_OBJECT_N - WAIT_OBJECT_0;
    if WAIT_OBJECT_N = 0 then
    begin
      ResetEvent(hHandles[0]);

      // 添加一个新的监视记录
      Id := Length(hHandles);
      SetLength(hHandles, Id+1);
      SetLength(WatchTarget, Id+1);
      WatchTarget[Id] := ExtractFilePath(application.ExeName) +'highlighters\';

      hHandles[Id] := FindFirstChangeNotification(PChar(WatchTarget[Id]), true,
        FILE_NOTIFY_CHANGE_FILE_NAME or
        FILE_NOTIFY_CHANGE_DIR_NAME or
        FILE_NOTIFY_CHANGE_LAST_WRITE);
      if hHandles[Id] <> INVALID_HANDLE_VALUE then
        Synchronize(AddNotifyRec)
      else
      begin
        FInfo := '监视不成功(不存在?): ' + WatchTarget[Id];
        Synchronize(ShowNotifyInfo);
        SetLength(hHandles, Id);
        SetLength(WatchTarget, Id);
      end;
    end
    else
    begin
      if WAIT_OBJECT_N >= Length(hHandles) then Continue;

      FInfo := '目录中存在修改: ' + WatchTarget[WAIT_OBJECT_N];
      Synchronize(ShowNotifyInfo);
      FindNextChangeNotification(hHandles[WAIT_OBJECT_N]);
    end;
  until Terminated;
end;
{ TForm_shijian }
function get_file_date(const n: string): integer;
var iFileHandle:integer;
begin
  iFileHandle :=FileOpen(n,fmShareDenyNone);
  result:=FileGetDate(iFileHandle); //取得文件时间
  FileClose(iFileHandle);
end;
procedure TForm_shijian.open_file(n: string);
begin
 memo1.Lines.Clear;
 memo1.Lines.LoadFromFile(n);
 can_save:= false;
 button2.Enabled:= false;
 file_time:= get_file_date(n); //保存文件的时间
end;

procedure TForm_shijian.Memo1Change(Sender: TObject);
begin
  can_save:= true;
  Button2.Enabled:= true;
end;

procedure TForm_shijian.save_file;
begin
 if open_name= '' then
    exit;

  memo1.Lines.SaveToFile(ExtractFilePath(application.ExeName) +'highlighters\' + open_name + '.txt');
  can_save:= false;
  Button2.Enabled:= false;
end;

procedure TForm_shijian.Button2Click(Sender: TObject);
begin
  if can_save then
     save_file;
end;

procedure TForm_shijian.FormDeactivate(Sender: TObject);
begin
  if can_save then
     save_file;
end;

procedure TForm_shijian.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    begin
     memo1.Lines.LoadFromFile(OpenDialog1.FileName);
     can_save:= true;
    end;
end;

procedure TForm_shijian.index_line(const s: string);
var i,j: integer;
begin
    //定位到
screen.Cursor:= crhourglass;
    for i:= 0 to memo1.Lines.Count-1 do
     begin
      if pos(s,memo1.Lines.strings[i])= 1 then
        begin
         j := memo1.Perform(EM_LINEINDEX, i, 0);
 memo1.SelStart := j;
 memo1.SelLength:= Length(Memo1.Lines[i]);
 memo1.Perform(EM_SCROLLCARET, 0, 0);
 Memo1.Perform(EM_LINESCROLL ,0, i- Memo1.Perform(EM_GETFIRSTVISIBLELINE,0,0));
         break;
        end;
     end;
screen.Cursor:= crdefault;
end;

procedure TForm_shijian.FormCreate(Sender: TObject);
begin
CreateNotifyEvent := CreateEvent(nil, True, False, '');
  WatchThread := TWatchThread.Create(false);
  setEvent(CreateNotifyEvent);
end;

procedure TForm_shijian.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   WatchThread.Terminate;
end;

procedure TForm_shijian.reload_file;
begin
   //
   if open_name= '' then
      exit;

   if file_time<> get_file_date(ExtractFilePath(application.ExeName) +'highlighters\' + open_name + '.txt') then
     begin
      memo1.Lines.Clear;
      memo1.Lines.loadfromFile(ExtractFilePath(application.ExeName) +'highlighters\' + open_name + '.txt');
      can_save:= false;
      Button2.Enabled:= false;
     end;
end;

end.
