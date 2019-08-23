unit KSVOICELib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.130.1.0.1.0.1.6  $
// File generated on 2007-10-2 14:17:23 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Powerword 2007\kingsoft\Extract\KSVoice.dll (1)
// LIBID: {1939867A-E09A-4B87-B9A7-6B529329F4C4}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
// Errors:
//   Error creating palette bitmap of (TKDVoice) : Server D:\Powerword 2007\kingsoft\Extract\KSVoice.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  KSVOICELibMajorVersion = 1;
  KSVOICELibMinorVersion = 0;

  LIBID_KSVOICELib: TGUID = '{1939867A-E09A-4B87-B9A7-6B529329F4C4}';

  IID_IKDVoice: TGUID = '{34DCFFB8-6F15-4CA5-ADEF-B8FB5AE9EA5E}';
  CLASS_KDVoice: TGUID = '{385B9F5A-B588-4050-B787-B2CB7960F27C}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IKDVoice = interface;
  IKDVoiceDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  KDVoice = IKDVoice;


// *********************************************************************//
// Interface: IKDVoice
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {34DCFFB8-6F15-4CA5-ADEF-B8FB5AE9EA5E}
// *********************************************************************//
  IKDVoice = interface(IDispatch)
    ['{34DCFFB8-6F15-4CA5-ADEF-B8FB5AE9EA5E}']
    procedure PlaySound(const pbstrWord: WideString); safecall;
    procedure InitSoundEngine; safecall;
    procedure IsExistSound(const pbstrWord: WideString); safecall;
    function IsExistSoundEx(const bstrWord: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IKDVoiceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {34DCFFB8-6F15-4CA5-ADEF-B8FB5AE9EA5E}
// *********************************************************************//
  IKDVoiceDisp = dispinterface
    ['{34DCFFB8-6F15-4CA5-ADEF-B8FB5AE9EA5E}']
    procedure PlaySound(const pbstrWord: WideString); dispid 1;
    procedure InitSoundEngine; dispid 2;
    procedure IsExistSound(const pbstrWord: WideString); dispid 3;
    function IsExistSoundEx(const bstrWord: WideString): WordBool; dispid 4;
  end;

// *********************************************************************//
// The Class CoKDVoice provides a Create and CreateRemote method to          
// create instances of the default interface IKDVoice exposed by              
// the CoClass KDVoice. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoKDVoice = class
    class function Create: IKDVoice;
    class function CreateRemote(const MachineName: string): IKDVoice;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TKDVoice
// Help String      : KDVoice Class
// Default Interface: IKDVoice
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TKDVoiceProperties= class;
{$ENDIF}
  TKDVoice = class(TOleServer)
  private
    FIntf:        IKDVoice;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TKDVoiceProperties;
    function      GetServerProperties: TKDVoiceProperties;
{$ENDIF}
    function      GetDefaultInterface: IKDVoice;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IKDVoice);
    procedure Disconnect; override;
    procedure PlaySound(const pbstrWord: WideString);
    procedure InitSoundEngine;
    procedure IsExistSound(const pbstrWord: WideString);
    function IsExistSoundEx(const bstrWord: WideString): WordBool;
    property DefaultInterface: IKDVoice read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TKDVoiceProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TKDVoice
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TKDVoiceProperties = class(TPersistent)
  private
    FServer:    TKDVoice;
    function    GetDefaultInterface: IKDVoice;
    constructor Create(AServer: TKDVoice);
  protected
  public
    property DefaultInterface: IKDVoice read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

implementation

uses ComObj;

class function CoKDVoice.Create: IKDVoice;
begin
  Result := CreateComObject(CLASS_KDVoice) as IKDVoice;
end;

class function CoKDVoice.CreateRemote(const MachineName: string): IKDVoice;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_KDVoice) as IKDVoice;
end;

procedure TKDVoice.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{385B9F5A-B588-4050-B787-B2CB7960F27C}';
    IntfIID:   '{34DCFFB8-6F15-4CA5-ADEF-B8FB5AE9EA5E}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TKDVoice.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IKDVoice;
  end;
end;

procedure TKDVoice.ConnectTo(svrIntf: IKDVoice);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TKDVoice.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TKDVoice.GetDefaultInterface: IKDVoice;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TKDVoice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TKDVoiceProperties.Create(Self);
{$ENDIF}
end;

destructor TKDVoice.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TKDVoice.GetServerProperties: TKDVoiceProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TKDVoice.PlaySound(const pbstrWord: WideString);
begin
  DefaultInterface.PlaySound(pbstrWord);
end;

procedure TKDVoice.InitSoundEngine;
begin
  DefaultInterface.InitSoundEngine;
end;

procedure TKDVoice.IsExistSound(const pbstrWord: WideString);
begin
  DefaultInterface.IsExistSound(pbstrWord);
end;

function TKDVoice.IsExistSoundEx(const bstrWord: WideString): WordBool;
begin
  Result := DefaultInterface.IsExistSoundEx(bstrWord);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TKDVoiceProperties.Create(AServer: TKDVoice);
begin
  inherited Create;
  FServer := AServer;
end;

function TKDVoiceProperties.GetDefaultInterface: IKDVoice;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TKDVoice]);
end;

end.
