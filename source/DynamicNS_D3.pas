unit DynamicNS_D3;

{
[yellow]
Dynamic Protocol For Delphi 3 or High.

--------------------------------------------

Create Time : 2001.12.6
Update Time : 2002.7.9
Version : Release 3
Author : JoJo

--------------------------------------------
Copyright 1996-2001 Think Space Soft
--------------------------------------------

Note : If use in Delphi 3, you must update urlmon unit.[/yellow]
}

interface

uses

Classes, Windows, Forms, Axctrls, dialogs, SysUtils, ComObj, ActiveX, UrlMon;

const

Class_DynamicNS: TGUID = '{C379EAD1-CB34-4B09-AF6B-7E587F8BCD80}';

type

    TDynamicNS = class(TComObject, IInternetProtocol)
    private
      Url: string;
      HaveData : Boolean;
      Written, TotalSize: Integer;
      ProtSink: IInternetProtocolSink;
      DataStream: IStream;

    protected

// IInternetProtocol Methods

      function Start(szUrl: PWideChar; OIProtSink: IInternetProtocolSink;
      OIBindInfo: IInternetBindInfo; grfPI, dwReserved: DWORD): HResult; stdcall;

      function Continue(const ProtocolData: TProtocolData): HResult; stdcall;
      function Abort(hrReason: HResult; dwOptions: DWORD): HResult; stdcall;
      function Terminate(dwOptions: DWORD): HResult; stdcall;
      function Suspend: HResult; stdcall;
      function Resume: HResult; stdcall;
      function Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult; stdcall;
      function Seek(dlibMove: LARGE_INTEGER; dwOrigin: DWORD;
      out libNewPosition: ULARGE_INTEGER): HResult; stdcall;

      function LockRequest(dwOptions: DWORD): HResult; stdcall;
      function UnlockRequest: HResult; stdcall;

      //Load Data Function
      function LoadData(URL:String):Boolean;

    end;

    TAcceptEvent = procedure (const URL:String;var Accept:Boolean) of object;
    TContentEvent = procedure (const URL:String;var Stream:TStream) of object;

    TDynamicProtocol = class(TObject)
    private

      Factory: IClassFactory;
      InternetSession: IInternetSession;
      FOnAccept : TAcceptEvent;
      FOnGetContent : TContentEvent;
      FProtocolName : String;
      FEnabled : Boolean;

      function GetProtocolName : String;
      procedure SetProtocolName(const Value:String);
      function GetEnabled : Boolean;
      procedure SetEnabled(const Value:Boolean);
      procedure StartProtocol;
      procedure StopProtocol;
    protected

      function Accept(const URL:String):Boolean;
      function LoadContent(const URL:String):TStream;

    public

      constructor Create;
      destructor Destroy; override;
      property ProtocolName : String read GetProtocolName write SetProtocolName;
      property Enabled : Boolean read GetEnabled write SetEnabled;
      property OnAccept : TAcceptEvent read FOnAccept write FOnAccept;
      property OnGetContent : TContentEvent read FOnGetContent write FOnGetContent;

    end;

var
   DynamicProtocol : TDynamicProtocol;

implementation

uses

comserv;

function TDynamicNS.Start(szUrl: PWideChar; OIProtSink: IInternetProtocolSink;
OIBindInfo: IInternetBindInfo; grfPI, dwReserved: DWORD): HResult; stdcall;
begin
  Url := SzUrl;
  written := 0;
  HaveData := False;
// ShowMessage(URL);
//Load data here
  if not LoadData(URL) then Result := S_FALSE else begin
      HaveData := True;
      ProtSink := OIProtSink;
      ProtSink.ReportData(BSCF_FIRSTDATANOTIFICATION or
      BSCF_LASTDATANOTIFICATION or BSCF_DATAFULLYAVAILABLE, TotalSize, TotalSize);
      ProtSink.ReportResult(S_OK, S_OK, nil);
      Result := S_OK;
  end;
end;

function TDynamicNS.Read(pv: Pointer; cb: ULONG; out cbRead: ULONG): HResult;
begin
  DataStream.Read(pv, cb, @cbRead);
  Inc(written, cbread);
  if (written = totalSize) then result := S_FALSE else Result := E_PENDING;
end;

function TDynamicNS.Terminate(dwOptions: DWORD): HResult; stdcall;
begin
  if HaveData then
  begin
    DataStream._Release;
    Protsink._Release;
  end;

  result := S_OK;
end;

function TDynamicNS.LockRequest(dwOptions: DWORD): HResult; stdcall;
begin
  result := S_OK;
end;

function TDynamicNS.UnlockRequest: HResult;
begin
  result := S_OK;
end;

function TDynamicNS.Continue(const ProtocolData: TProtocolData): HResult;
begin
  result := S_OK;
end;

function TDynamicNS.Abort(hrReason: HResult; dwOptions: DWORD): HResult; stdcall;
begin
  result := E_NOTIMPL;
end;

function TDynamicNS.Suspend: HResult; stdcall;
begin
  result := E_NOTIMPL;
end;

function TDynamicNS.Resume: HResult; stdcall;
begin
  result := E_NOTIMPL;
end;

function TDynamicNS.Seek(dlibMove: LARGE_INTEGER; dwOrigin: DWORD;
                                   out libNewPosition: ULARGE_INTEGER): HResult;
begin
  result := E_NOTIMPL;
end;

function TDynamicNS.LoadData(URL:String): Boolean;
var
  F:TStream;
  Dummy: LONGLONG;
begin
  Result := False;

  if Assigned(DynamicProtocol) then

  begin
    Result := DynamicProtocol.Accept(URL);
    if Result then
    begin

      F := DynamicProtocol.LoadContent(URL);
      if f.Size> 0 then
      begin
      CreateStreamOnHGlobal(0, True, DataStream);
      TOleStream.Create(DataStream).CopyFrom(F, F.Size);
      DataStream.Seek(0, STREAM_SEEK_SET, Dummy);
      TotalSize := F.Size;
      end else result:= false;
      F.Free;
    end;
  end;

end;

{ TDynamicProtocol }

function TDynamicProtocol.Accept(const URL: String): Boolean;
begin
  Result := False;
  if Assigned(FOnAccept) then
    FOnAccept(URL,Result);
end;

constructor TDynamicProtocol.Create;
begin
  inherited;
  FEnabled := False;
  FProtocolName := 'local';
end;

destructor TDynamicProtocol.Destroy;
begin
  if FEnabled then
    StopProtocol;
  inherited;
end;

function TDynamicProtocol.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function TDynamicProtocol.GetProtocolName: String;
begin
  Result := FProtocolName;
end;

function TDynamicProtocol.LoadContent(const URL: String):TStream;
begin

  //&sup2;&raquo;&iquest;&Eacute;&Ograve;&Ocirc;¡¤&micro;&raquo;&Oslash;&iquest;&Otilde;&micro;&Auml;&Aacute;¡Â

  if Assigned(FOnGetContent) then
  begin
      Result := TStringStream.Create('');
      FOnGetContent(URL,Result);
      Result.Position :=0;
     // if Result.Size = 0 then
      //  (Result as TStringStream).WriteString(Format('<html><body><h3>Load %s Error.</h3></body></html>',[URL]));
  end
  else
      Result := TStringStream.Create(Format('<html><body><h3>Load %s Error.</h3></body></html>',[URL]));
end;

procedure TDynamicProtocol.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if FEnabled then
       StartProtocol
    else
      StopProtocol;
  end;
end;

procedure TDynamicProtocol.SetProtocolName(const Value: String);
begin
  if FEnabled then exit;
  if FProtocolName <> Value then
    FProtocolName := Value;
end;

procedure TDynamicProtocol.StartProtocol;
begin
  CoGetClassObject(Class_DynamicNS, CLSCTX_SERVER, nil, IClassFactory, Factory);
  CoInternetGetSession(0, InternetSession, 0);
  InternetSession.RegisterNameSpace(Factory, Class_DynamicNS, PWideChar(WideString(FProtocolName)), 0, nil, 0);
end;

procedure TDynamicProtocol.StopProtocol;
begin
  InternetSession.UnregisterNameSpace(Factory, PWideChar(WideString(FProtocolName)));
end;

initialization

    TComObjectFactory.Create(ComServer, TDynamicNS, Class_DynamicNS,
    'DynamicNS', 'DynamicNS', ciMultiInstance);//, tmApartment);

    DynamicProtocol := TDynamicProtocol.Create;

finalization

    DynamicProtocol.Free;

end.
