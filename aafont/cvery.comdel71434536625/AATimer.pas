{*******************************************************************************

                          AAFont - 平滑特效字体控件包
                          ---------------------------
                           (C)Copyright 2001-2004
                            CnPack 开发组 周劲羽

            这一控件包是自由软件，您可以遵照自由软件基金会出版的GNU 较
        宽松通用公共许可证协议来修改和重新发布这一程序，或者用许可证的
        第二版，或者（根据您的选择）用任何更新的版本。

            发布这一控件包的目的是希望它有用，但没有任何担保。甚至没有
        适合特定目的而隐含的担保。更详细的情况请参阅 GNU 较宽松通用公
        共许可证。

            您应该已经和控件包一起收到一份 GNU 较宽松通用公共许可证的
        副本。如果还没有，写信给：
            Free Software Foundation, Inc., 59 Temple Place - Suite
        330, Boston, MA 02111-1307, USA.

            单元作者：CnPack 开发组 周劲羽
            下载地址：http://www.yygw.net
            电子邮件：yygw@yygw.net

*******************************************************************************}

unit AATimer;
{* |<PRE>
================================================================================
* 软件名称：平滑特效字体控件包
* 单元名称：高精度定时器组件TAATimer单元
* 单元作者：CnPack 开发组 周劲羽
* 备    注：- Delphi自带的TTimer使用操作系统以消息方式提供的定时器，在Win9X下
*             定时精度仅为55ms，NT下约10ms。
*           - TAATimer采用单独的线程进行定时控制，精度比TTimer要高，相应地也占
*             用较多的CPU资源，其使用方式与TTimer完成兼容，并提供了更多的功能。
*           - TAATimerList定时器列表可以同时产生多个定时器。
*           - 所有定时器使用同一个线程定时，适合大量使用的场合。
*           - 由于Win32是抢占式多任务操作系统，各个线程轮流享用CPU时间片，如果
*             其它的线程占用大量CPU时间，即使设置最高精度，也不一定能保证精确
*             的定时间隔。
* 开发平台：PWin98SE + Delphi 5.0
* 兼容测试：PWin9X/2000/XP + Delphi 5/6
* 本 地 化：该单元中的字符串均符合本地化处理方式
* 更新记录：2002.11.05 V2.0
*               重写全部代码，增加定时器列表，所有定时器使用同一线程定时
*           2002.04.18 V1.0
*               创建单元
================================================================================
|</PRE>}

interface

{$I AAFont.inc}

uses
  Windows, SysUtils, Classes, Forms;

type

//==============================================================================
// 高精度定时器对象
//==============================================================================

{ TAATimerObject }

  TAATimerObject = class(TObject)
  private
    FActualFPS: Double;
    FEnabled: Boolean;
    FExecCount: Cardinal;
    FInterval: Cardinal;
    FLastTickCount: Cardinal;
    FOnTimer: TNotifyEvent;
    FRepeatCount: Cardinal;
    FSyncEvent: Boolean;
    function GetFPS: Double;
    procedure SetEnabled(Value: Boolean);
    procedure SetFPS(Value: Double);
    procedure SetInterval(Value: Cardinal);
    procedure SetRepeatCount(Value: Cardinal);
  protected
    procedure Timer; dynamic;
  public
    constructor Create;
    destructor Destroy; override;
    property ActualFPS: Double read FActualFPS;
    property ExecCount: Cardinal read FExecCount;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property FPS: Double read GetFPS write SetFPS stored False;
    property Interval: Cardinal read FInterval write SetInterval default 1000;
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
    property RepeatCount: Cardinal read FRepeatCount write SetRepeatCount
      default 0;
    property SyncEvent: Boolean read FSyncEvent write FSyncEvent default True;
  end;

//==============================================================================
// 高精度定时器组件
//==============================================================================

{ TAATimer }

  TAATimer = class(TComponent)
  {* 线程定时器组件，使用方法类似 TTimer。}
  private
    FTimerObject: TAATimerObject;
    function GetActualFPS: Double;
    function GetEnabled: Boolean;
    function GetExecCount: Cardinal;
    function GetFPS: Double;
    function GetInterval: Cardinal;
    function GetOnTimer: TNotifyEvent;
    function GetRepeatCount: Cardinal;
    function GetSyncEvent: Boolean;
    procedure SetEnabled(Value: Boolean);
    procedure SetFPS(Value: Double);
    procedure SetInterval(Value: Cardinal);
    procedure SetOnTimer(Value: TNotifyEvent);
    procedure SetRepeatCount(Value: Cardinal);
    procedure SetSyncEvent(Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    {* 类构造器}
    destructor Destroy; override;
    {* 类析构器}
    property ActualFPS: Double read GetActualFPS;
    {* 实际的定时器速率，次每秒}
    property ExecCount: Cardinal read GetExecCount;
    {* 已经执行过的次数}
  published
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    {* 定时器是否启用}
    property FPS: Double read GetFPS write SetFPS stored False;
    {* 定时器速度，次每秒}
    property Interval: Cardinal read GetInterval write SetInterval default 1000;
    {* 定时间隔，毫秒}
    property OnTimer: TNotifyEvent read GetOnTimer write SetOnTimer;
    {* 定时事件}
    property RepeatCount: Cardinal read GetRepeatCount write SetRepeatCount
      default 0;
    {* 定时事件次数，当定时事件发生指定次数后自动关闭。如果为 0 表示不限制}
    property SyncEvent: Boolean read GetSyncEvent write SetSyncEvent default
      True;
    {* 是否使用同步方式在主线程中产生定时事件，如果为 false 将在定时线程中产生事件}
  end;

//==============================================================================
// 高精度定时器列表集合子项
//==============================================================================

{ TAATimerItem }

  TAATimerItem = class(TCollectionItem)
  {* 线程定时器列表子项，使用方法类似 TTimer。}
  private
    FOnTimer: TNotifyEvent;
    FTimerObject: TAATimerObject;
    function GetActualFPS: Double;
    function GetEnabled: Boolean;
    function GetExecCount: Cardinal;
    function GetFPS: Double;
    function GetInterval: Cardinal;
    function GetRepeatCount: Cardinal;
    function GetSyncEvent: Boolean;
    procedure SetEnabled(Value: Boolean);
    procedure SetFPS(Value: Double);
    procedure SetInterval(Value: Cardinal);
    procedure SetRepeatCount(Value: Cardinal);
    procedure SetSyncEvent(Value: Boolean);
  protected
    procedure Timer(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    {* 类构造器}
    destructor Destroy; override;
    {* 类析构器}
    procedure Assign(Source: TPersistent); override;
    {* 赋值方法}
    property ActualFPS: Double read GetActualFPS;
    {* 实际的定时器速率，次每秒}
    property ExecCount: Cardinal read GetExecCount;
    {* 已经执行过的次数}
  published
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    {* 定时器是否启用}
    property FPS: Double read GetFPS write SetFPS stored False;
    {* 定时器速度，次每秒}
    property Interval: Cardinal read GetInterval write SetInterval default 1000;
    {* 定时间隔，毫秒}
    property OnTimer: TNotifyEvent read FOnTimer write FOnTimer;
    {* 定时事件}
    property RepeatCount: Cardinal read GetRepeatCount write SetRepeatCount
      default 0;
    {* 定时事件次数，当定时事件发生指定次数后自动关闭。如果为 0 表示不限制}
    property SyncEvent: Boolean read GetSyncEvent write SetSyncEvent default
      True;
    {* 是否使用同步方式在主线程中产生定时事件，如果为 false 将在定时线程中产生事件}
  end;

//==============================================================================
// 高精度定时器列表集合类
//==============================================================================

{ TAATimerCollection }

  TAATimerList = class;

  TAATimerCollection = class(TOwnedCollection)
  {* 线程定时器列表集合}
  private
    FTimerList: TAATimerList;
    function GetItems(Index: Integer): TAATimerItem;
    procedure SetItems(Index: Integer; Value: TAATimerItem);
  protected
    property TimerList: TAATimerList read FTimerList;
  public
    constructor Create(AOwner: TPersistent);
    {* 类构造器}
    property Items[Index: Integer]: TAATimerItem read GetItems write SetItems; default;
    {* 定时器数组属性}
  end;

//==============================================================================
// 高精度定时器列表组件
//==============================================================================

{ TAATimerList }

  TAATimerEvent = procedure(Sender: TObject; Index: Integer; var Handled:
    Boolean) of object;
  {* 线程定时器列表事件。Index 为产生事件的定时器子项序号，Handle 返回是否已处理，
     如果在事件中将 Handle 置为 true，将不产生该定时器子项事件}
    
  TAATimerList = class(TComponent)
  {* 线程定时器列表组件，可以定义多个定时器。}
  private
    FItems: TAATimerCollection;
    FOnTimer: TAATimerEvent;
    procedure SetItems(Value: TAATimerCollection);
  protected
    function Timer(Index: Integer): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    {* 类构造器}
    destructor Destroy; override;
    {* 类析构器}
  published
    property Items: TAATimerCollection read FItems write SetItems;
    {* 定时器列表}
    property OnTimer: TAATimerEvent read FOnTimer write FOnTimer;
    {* 定时器事件}
  end;

implementation

type

//==============================================================================
// 高精度定时器线程（私有类）
//==============================================================================

{ TAATimerThread }

  TAATimerMgr = class;

  TAATimerThread = class(TThread)
  private
    FTimerMgr: TAATimerMgr;
  protected
    FInterval: Cardinal;
    FStop: THandle;
    procedure Execute; override;
    property TimerMgr: TAATimerMgr read FTimerMgr;
  public
    constructor Create(CreateSuspended: Boolean; ATimerMgr: TAATimerMgr);
  end;

//==============================================================================
// 高精度定时器管理器（私有类）
//==============================================================================

{ TAATimerMgr }

  TAATimerMgr = class(TObject)
  private
    FTimerList: TThreadList;                
    FTimerThread: TAATimerThread;
  protected
    procedure ClearTimer;
    procedure DoTimer(Sycn: Boolean);
    procedure SyncTimer; virtual;
    procedure Timer; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function AddTimer: TAATimerObject;
    procedure DeleteTimer(TimerObject: TAATimerObject); overload;
  end;

//==============================================================================
// 高精度定时器线程（私有类）
//==============================================================================

{ TAATimerThread }

constructor TAATimerThread.Create(CreateSuspended: Boolean; ATimerMgr:
  TAATimerMgr);
begin
  inherited Create(CreateSuspended);
  Assert(Assigned(ATimerMgr));
  FTimerMgr := ATimerMgr;
  FStop := CreateEvent(nil, False, False, nil); // 创建退出用事件
end;

procedure TAATimerThread.Execute;
begin
  repeat                                // 等待退出事件置位或 FInterval 毫秒后超时退出
    if WaitForSingleObject(FStop, FInterval) = WAIT_TIMEOUT then
    begin
      TimerMgr.Timer;                   // 非同步方式产生定时事件
      Synchronize(TimerMgr.SyncTimer);  // 同步方式产生定时事件
    end;
  until Terminated;
  CloseHandle(FStop);                   // 释放事件句柄
end;

//==============================================================================
// 高精度定时器管理器（私有类）
//==============================================================================

{ TAATimerMgr }

constructor TAATimerMgr.Create;
begin
  inherited Create;
  FTimerList := TThreadList.Create;
  FTimerThread := TAATimerThread.Create(True, Self);
  FTimerThread.FreeOnTerminate := False;
  FTimerThread.Priority := tpNormal;
  FTimerThread.FInterval := 1;
  FTimerThread.Resume;
end;

destructor TAATimerMgr.Destroy;
begin
  FTimerThread.Terminate;
  SetEvent(FTimerThread.FStop);
  if FTimerThread.Suspended then FTimerThread.Resume;
  FTimerThread.WaitFor;
  ClearTimer;
  FreeAndNil(FTimerThread);
  FreeAndNil(FTimerList);
  inherited Destroy;
end;

function TAATimerMgr.AddTimer: TAATimerObject;
begin
  Result := TAATimerObject.Create;
  with FTimerList.LockList do
  try
    Add(Result);
  finally
    FTimerList.UnlockList;
  end;
end;

procedure TAATimerMgr.ClearTimer;
var
  i: Integer;
begin
  with FTimerList.LockList do
  try
    for i := Count - 1 downto 0 do
    begin
      TAATimerObject(Items[i]).Free;
      Delete(i);
    end;
  finally
    FTimerList.UnlockList;
  end;
end;

procedure TAATimerMgr.DeleteTimer(TimerObject: TAATimerObject);
var
  i: Integer;
begin
  with FTimerList.LockList do
  try
    for i := 0 to Count - 1 do
      if Items[i] = TimerObject then
      begin
        TimerObject.Free;
        Delete(i);
        Exit;
      end;
  finally
    FTimerList.UnlockList;
  end;
end;

procedure TAATimerMgr.DoTimer(Sycn: Boolean);
var
  i: Integer;
  CurrTick: Cardinal;
begin
  with FTimerList.LockList do
  try
    CurrTick := GetTickCount;
    for i := 0 to Count - 1 do
      with TAATimerObject(Items[i]) do
        if Enabled and (Interval <> 0) and (SyncEvent = Sycn) and
          (CurrTick - FLastTickCount >= Interval) and Assigned(FOnTimer) then
        begin
          if CurrTick <> FLastTickCount then
            FActualFPS := 1000 / (CurrTick - FLastTickCount)
          else
            FActualFPS := 0;
          FLastTickCount := CurrTick;
          Timer;
        end;
  finally
    FTimerList.UnlockList;
  end;
end;

procedure TAATimerMgr.SyncTimer;
begin
  try
    DoTimer(True);
  except
    Application.HandleException(Self);
  end
end;

procedure TAATimerMgr.Timer;
begin
  try
    DoTimer(False);
  except
    Application.HandleException(Self);
  end
end;

var
  TimerMgr: TAATimerMgr;

function GetTimerMgr: TAATimerMgr;
begin
  if TimerMgr = nil then
    TimerMgr := TAATimerMgr.Create;
  Result := TimerMgr;
end;

//==============================================================================
// 高精度定时器对象
//==============================================================================

{ TAATimerObject }

constructor TAATimerObject.Create;
begin
  inherited Create;
  FEnabled := True;
  FExecCount := 0;
  FInterval := 1000;
  FLastTickCount := GetTickCount;
  FRepeatCount := 0;
  FSyncEvent := True;
end;

destructor TAATimerObject.Destroy;
begin
end;

function TAATimerObject.GetFPS: Double;
begin
  if Interval = 0 then
    Result := 0
  else
    Result := 1000 / Interval;
end;

procedure TAATimerObject.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    FExecCount := 0;
    if FEnabled then
    begin
      FLastTickCount := GetTickCount;
    end;
  end;
end;

procedure TAATimerObject.SetFPS(Value: Double);
begin
  if Value < 0 then
    Exit
  else if Value < 1 / High(Word) then
    Value := 1 / High(Word)
  else if Value > 1000 then
    Value := 1000;
  FInterval := Round(1000 / Value);
end;

procedure TAATimerObject.SetInterval(Value: Cardinal);
begin
  if FInterval <> Value then
  begin
    FInterval := Value;
    FLastTickCount := GetTickCount;
  end;
end;

procedure TAATimerObject.SetRepeatCount(Value: Cardinal);
begin
  if FRepeatCount <> Value then
  begin
    FRepeatCount := Value;
  end;
end;

procedure TAATimerObject.Timer;
begin
  Inc(FExecCount);
  if Assigned(FOnTimer) then FOnTimer(Self);
  if (RepeatCount <> 0) and (FExecCount >= RepeatCount) then
  begin
    Enabled := False;
  end;
end;

//==============================================================================
// 高精度定时器组件
//==============================================================================

{ TAATimer }

constructor TAATimer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTimerObject := GetTimerMgr.AddTimer;
end;

destructor TAATimer.Destroy;
begin
  GetTimerMgr.DeleteTimer(FTimerObject);
  inherited Destroy;
end;

function TAATimer.GetActualFPS: Double;
begin
  Result := FTimerObject.ActualFPS;
end;

function TAATimer.GetEnabled: Boolean;
begin
  Result := FTimerObject.Enabled;
end;

function TAATimer.GetExecCount: Cardinal;
begin
  Result := FTimerObject.ExecCount;
end;

function TAATimer.GetFPS: Double;
begin
  Result := FTimerObject.FPS;
end;

function TAATimer.GetInterval: Cardinal;
begin
  Result := FTimerObject.Interval;
end;

function TAATimer.GetOnTimer: TNotifyEvent;
begin
  Result := FTimerObject.OnTimer;
end;

function TAATimer.GetRepeatCount: Cardinal;
begin
  Result := FTimerObject.RepeatCount;
end;

function TAATimer.GetSyncEvent: Boolean;
begin
  Result := FTimerObject.SyncEvent;
end;

procedure TAATimer.SetEnabled(Value: Boolean);
begin
  FTimerObject.Enabled := Value;
end;

procedure TAATimer.SetFPS(Value: Double);
begin
  FTimerObject.FPS := Value;
end;

procedure TAATimer.SetInterval(Value: Cardinal);
begin
  FTimerObject.Interval := Value;
end;

procedure TAATimer.SetOnTimer(Value: TNotifyEvent);
begin
  FTimerObject.OnTimer := Value;
end;

procedure TAATimer.SetRepeatCount(Value: Cardinal);
begin
  FTimerObject.RepeatCount := Value;
end;

procedure TAATimer.SetSyncEvent(Value: Boolean);
begin
  FTimerObject.SyncEvent := Value;
end;

//==============================================================================
// 高精度定时器列表集合子项
//==============================================================================

{ TAATimerItem }

constructor TAATimerItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FTimerObject := GetTimerMgr.AddTimer;
  FTimerObject.OnTimer := Timer;
end;

destructor TAATimerItem.Destroy;
begin
  GetTimerMgr.DeleteTimer(FTimerObject);
  inherited Destroy;
end;

procedure TAATimerItem.Assign(Source: TPersistent);
begin
  if Source is TAATimerItem then
  begin
    Enabled := TAATimerItem(Source).Enabled;
    Interval := TAATimerItem(Source).Interval;
    RepeatCount := TAATimerItem(Source).RepeatCount;
    SyncEvent := TAATimerItem(Source).SyncEvent;
  end
  else
    inherited;
end;

function TAATimerItem.GetActualFPS: Double;
begin
  Result := FTimerObject.ActualFPS;
end;

function TAATimerItem.GetEnabled: Boolean;
begin
  Result := FTimerObject.Enabled;
end;

function TAATimerItem.GetExecCount: Cardinal;
begin
  Result := FTimerObject.ExecCount;
end;

function TAATimerItem.GetFPS: Double;
begin
  Result := FTimerObject.FPS;
end;

function TAATimerItem.GetInterval: Cardinal;
begin
  Result := FTimerObject.Interval;
end;

function TAATimerItem.GetRepeatCount: Cardinal;
begin
  Result := FTimerObject.RepeatCount;
end;

function TAATimerItem.GetSyncEvent: Boolean;
begin
  Result := FTimerObject.SyncEvent;
end;

procedure TAATimerItem.SetEnabled(Value: Boolean);
begin
  FTimerObject.Enabled := Value;
end;

procedure TAATimerItem.SetFPS(Value: Double);
begin
  FTimerObject.FPS := Value;
end;

procedure TAATimerItem.SetInterval(Value: Cardinal);
begin
  FTimerObject.Interval := Value;
end;

procedure TAATimerItem.SetRepeatCount(Value: Cardinal);
begin
  FTimerObject.RepeatCount := Value;
end;

procedure TAATimerItem.SetSyncEvent(Value: Boolean);
begin
  FTimerObject.SyncEvent := Value;
end;

procedure TAATimerItem.Timer(Sender: TObject);
begin
  if not TAATimerList(TAATimerCollection(Collection).GetOwner).Timer(Index) then
    if Assigned(FOnTimer) then
      FOnTimer(Self);
end;

//==============================================================================
// 高精度定时器列表集合类
//==============================================================================

{ TAATimerCollection }

constructor TAATimerCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TAATimerItem);
  Assert(AOwner is TAATimerList);
end;

function TAATimerCollection.GetItems(Index: Integer): TAATimerItem;
begin
  Result := TAATimerItem(inherited Items[Index]);
end;

procedure TAATimerCollection.SetItems(Index: Integer; Value: TAATimerItem);
begin
  inherited Items[Index] := Value;
end;

//==============================================================================
// 高精度定时器列表组件
//==============================================================================

{ TAATimerList }

constructor TAATimerList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TAATimerCollection.Create(Self);
end;

destructor TAATimerList.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TAATimerList.SetItems(Value: TAATimerCollection);
begin
  FItems.Assign(Value);
end;

function TAATimerList.Timer(Index: Integer): Boolean;
begin
  Result := False;
  if Assigned(FOnTimer) then
    FOnTimer(Self, Index, Result);
end;

initialization

finalization
  if TimerMgr <> nil then
    TimerMgr.Free;

end.

