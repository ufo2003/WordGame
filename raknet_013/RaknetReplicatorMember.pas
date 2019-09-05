unit RaknetReplicatorMember;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Replicator base class

 Delphi wrapper and c port author : Joe Oszlanczi (BigJoe)
                                    Hungary
                                    raknetwrapper@freemail.hu
                                    Please send me any error report
 Wrapper version :  0.13

 This source published under GPL - General public license

 Original right visit www.rakkarsoft.com



}
{=============================================================================}
interface

uses RakNetTypes,
     RakNetStruct,
     RakNetBitStream;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type

                  // parent object of all implemented game object
                  TRakReplicatorMember = class(TRaknetInterfaceAbstract)
                    private
                     InternalCallback:PTReplicaMemberCallback;
                    protected
                     { callback list for network state }
                     function    SendConstruction       (currentTime:cardinal;const PlayerID:TRakPlayerID;const outBitStream:TRakBitStream;var includeTimestamp:boolean):TReplicaReturnResult; virtual;
                     procedure   SendDestruction        (const outBitStream:TRakBitStream;const PlayerID:TRakPlayerID); virtual;
                     function    ReceiveDestruction     (const inBitStream:TRakBitStream;const PlayerID:TRakPlayerID):TReplicaReturnResult; virtual;
                     function    SendScopeChange        (inScope:boolean;outBitStream:TRakBitStream;currentTime:cardinal;PlayerID:TRakPlayerID):TReplicaReturnResult; virtual;
                     function    ReceiveScopeChange     (inBitStream:TRakBitStream;PlayerID:TRakPlayerID):TReplicaReturnResult; virtual;
                     function    Serialize              (var sendTimestamp:Boolean;outBitStream:TRakBitStream;lastSendTime:cardinal;priority,reliability:Pinteger;currentTime:cardinal;PlayerID:TRakPlayerID):TReplicaReturnResult; virtual;
                     function    Deserialize            (inBitStream:TRakBitStream;timestamp,lastDeserializeTime:cardinal;PlayerID:TRakPlayerID):TReplicaReturnResult; virtual;
                    public
                     constructor Create;  virtual;
                     destructor  Destroy; override;
                     procedure   SetServer              (Server:boolean);
                     function    GetNetworkID           :TRakNetworkID;
                     procedure   SetNetworkID           (NetworkID:TRakNetworkID);
                     function    GetParent              :TObject;
                     function    GetStaticNetworkID     :word;
                     procedure   SetStaticNetworkID     (id:word);
                     function    IsNetworkIDAuthority   :boolean;
                     procedure   SetExternalPlayerID    (PlayerID:TRakPlayerID);
                     function    GetExternalPlayerID    :TRakPlayerID;
                     function    GET_BASE_OBJECT_FROM_ID(NetworkID:TRakNetworkID):TObject;
                     function    GET_OBJECT_FROM_ID     (NetworkID:TRakNetworkID):TObject;

                  end;



implementation
uses RaknetDLL;

var IntRepBitStream:TRakBitStream;
    IntRepPlayerId:TRakPlayerID;

{ TRakReplicatorMember internal multiplexer}


  function  DelphiSendConstruction       (DelphiObj:pointer;currentTime:cardinal;PlayerID:TRakInterface;outBitStream:TRakInterface;includeTimestamp:pboolean):TReplicaReturnResult; stdcall;
  begin
    IntRepBitStream.RaknetInterface := outBitStream;
    Result := TRakReplicatorMember(DelphiObj).SendConstruction(currentTime,IntRepPlayerId,IntRepBitStream,includeTimestamp^);
    IntRepBitStream.ToNull;
  end;

  procedure DelphiSendDestruction        (DelphiObj:pointer;outBitStream:TRakInterface;PlayerID:TRakInterface); stdcall;
  begin
    IntRepBitStream.RaknetInterface := outBitStream;
    TRakReplicatorMember(DelphiObj).SendDestruction(IntRepBitStream,IntRepPlayerId);
    IntRepBitStream.ToNull;
  end;

  function  DelphiReceiveDestruction     (DelphiObj:pointer;inBitStream:TRakInterface;PlayerID:TRakInterface):TReplicaReturnResult; stdcall;
  begin
    IntRepBitStream.RaknetInterface := inBitStream;
    Result := TRakReplicatorMember(DelphiObj).ReceiveDestruction(IntRepBitStream,IntRepPlayerId);
    IntRepBitStream.ToNull;
  end;

  function  DelphiSendScopeChange        (DelphiObj:pointer;inScope:boolean;outBitStream:TRakInterface;currentTime:cardinal;PlayerID:TRakInterface):TReplicaReturnResult; stdcall;
  begin
    IntRepBitStream.RaknetInterface := outBitStream;
    Result := TRakReplicatorMember(DelphiObj).SendScopeChange(inScope,IntRepBitStream,currentTime,IntRepPlayerId);
    IntRepBitStream.ToNull;
  end;

  function  DelphiReceiveScopeChange     (DelphiObj:pointer;inBitStream:TRakInterface;PlayerID:TRakInterface):TReplicaReturnResult; stdcall;
  begin
    IntRepBitStream.RaknetInterface := inBitStream;
    Result := TRakReplicatorMember(DelphiObj).ReceiveScopeChange(IntRepBitStream,IntRepPlayerId);
    IntRepBitStream.ToNull;
  end;

  function  DelphiSerialize              (DelphiObj:pointer;sendTimestamp:PBoolean;outBitStream:TRakInterface;lastSendTime:cardinal;priority,reliability:PInteger;currentTime:cardinal;PlayerID:TRakInterface):TReplicaReturnResult; stdcall;
  begin
    IntRepBitStream.RaknetInterface := outBitStream;
    Result := TRakReplicatorMember(DelphiObj).Serialize(sendTimestamp^,IntRepBitStream,lastSendTime,priority,reliability,currentTime,IntRepPlayerId);
    IntRepBitStream.ToNull;
  end;

  function  DelphiDeserialize            (DelphiObj:pointer;inBitStream:TRakInterface;timestamp,lastDeserializeTime:cardinal;PlayerID:TRakInterface):TReplicaReturnResult; stdcall;
  begin
    IntRepBitStream.RaknetInterface := inBitStream;
    Result := TRakReplicatorMember(DelphiObj).Deserialize(IntRepBitStream,timestamp,lastDeserializeTime,IntRepPlayerId);
    IntRepBitStream.ToNull;
  end;

{ TRakReplicatorMember }

constructor TRakReplicatorMember.Create;
begin
   IntRaknetInterface := TRAKReplicaMember_Constructor;
   InternalCallback   := PTReplicaMemberCallback(TRAKReplicaMember_GetInternalCallback(InternalCallback));
   Assert((InternalCallback<>nil),'Replicator Member Internal callback nil' );
   InternalCallback^.SendConstruction   :=  DelphiSendConstruction;
   InternalCallback^.SendDestruction    :=  DelphiSendDestruction;
   InternalCallback^.ReceiveDestruction :=  DelphiReceiveDestruction;
   InternalCallback^.SendScopeChange    :=  DelphiSendScopeChange;
   InternalCallback^.ReceiveScopeChange :=  DelphiReceiveScopeChange;
   InternalCallback^.Serialize          :=  DelphiSerialize;
   InternalCallback^.Deserialize        :=  DelphiDeserialize;
   TRAKReplicaMember_SetParent(InternalCallback,self);
end;

function TRakReplicatorMember.Deserialize(inBitStream: TRakBitStream; timestamp,
  lastDeserializeTime: cardinal; PlayerID: TRakPlayerID): TReplicaReturnResult;
begin
   Result := REPLICA_PROCESSING_DONE;
end;

destructor TRakReplicatorMember.Destroy;
begin
  TRAKReplicaMember_Destructor(IntRaknetInterface);
  inherited;
end;

function TRakReplicatorMember.GetExternalPlayerID: TRakPlayerID;
begin
  Result := TRakPlayerID.CreateEmpty;
  Result.RaknetInterface := TRAKReplicaMember_GetExternalPlayerID(IntRaknetInterface);
end;

function TRakReplicatorMember.GetNetworkID: TRakNetworkID;
begin
  Result := TRakNetworkID.CreateEmpty;
  Result.RaknetInterface := TRAKReplicaMember_GetNetworkID(IntRaknetInterface);
end;

function TRakReplicatorMember.GetParent: TObject;
begin
  Result := TRAKReplicaMember_GetParent(IntRaknetInterface);
end;

function TRakReplicatorMember.GetStaticNetworkID: word;
begin
  Result := TRAKReplicaMember_GetStaticNetworkID(IntRaknetInterface);
end;

function TRakReplicatorMember.GET_BASE_OBJECT_FROM_ID(NetworkID: TRakNetworkID): TObject;
begin
  Result := TRAKReplicaMember_GET_BASE_OBJECT_FROM_ID(IntRaknetInterface,NetworkID.RaknetInterface);
end;

function TRakReplicatorMember.GET_OBJECT_FROM_ID(NetworkID: TRakNetworkID): TObject;
begin
  Result := TRAKReplicaMember_GET_OBJECT_FROM_ID(IntRaknetInterface,NetworkID.RaknetInterface);
end;

function TRakReplicatorMember.IsNetworkIDAuthority: boolean;
begin
  Result := TRAKReplicaMember_IsNetworkIDAuthority(IntRaknetInterface);
end;

function TRakReplicatorMember.ReceiveDestruction(
  const inBitStream: TRakBitStream;
  const PlayerID: TRakPlayerID): TReplicaReturnResult;
begin
 Result := REPLICA_PROCESSING_DONE;
end;

function TRakReplicatorMember.ReceiveScopeChange(inBitStream: TRakBitStream;
  PlayerID: TRakPlayerID): TReplicaReturnResult;
begin
 Result := REPLICA_PROCESSING_DONE;
end;

function TRakReplicatorMember.SendConstruction(currentTime: cardinal;
  const PlayerID: TRakPlayerID; const outBitStream: TRakBitStream;
  var includeTimestamp: boolean): TReplicaReturnResult;
begin
   Result := REPLICA_PROCESSING_DONE;
end;

procedure TRakReplicatorMember.SendDestruction(
  const outBitStream: TRakBitStream; const PlayerID: TRakPlayerID);
begin

end;

function TRakReplicatorMember.SendScopeChange(inScope: boolean;
  outBitStream: TRakBitStream; currentTime: cardinal;
  PlayerID: TRakPlayerID): TReplicaReturnResult;
begin
 Result := REPLICA_PROCESSING_DONE;
end;

function TRakReplicatorMember.Serialize(var sendTimestamp: Boolean;
  outBitStream: TRakBitStream; lastSendTime: cardinal;priority,reliability:Pinteger; currentTime: cardinal; PlayerID: TRakPlayerID): TReplicaReturnResult;
begin
  Result := REPLICA_PROCESSING_DONE;
end;

procedure TRakReplicatorMember.SetExternalPlayerID(PlayerID: TRakPlayerID);
begin
  TRAKReplicaMember_SetExternalPlayerID(IntRaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakReplicatorMember.SetNetworkID(NetworkID: TRakNetworkID);
begin
 TRAKReplicaMember_SetNetworkID(IntRaknetInterface,NetworkID.RaknetInterface);
end;

procedure TRakReplicatorMember.SetServer(Server: boolean);
begin
 TRAKReplicaMember_SetServer(IntRaknetInterface,Server);
end;

procedure TRakReplicatorMember.SetStaticNetworkID(id: word);
begin
 TRAKReplicaMember_SetStaticNetworkID(IntRaknetInterface,ID);
end;


initialization

IntRepBitStream:=TRakBitStream.CreateEmpty;
IntRepPlayerId:=TRakPlayerID.CreateEmpty;
IntRepBitStream.ToNull;
IntRepPlayerId.ToNull;

finalization
IntRepBitStream.ToNull;
IntRepPlayerId.ToNull;
IntRepBitStream.Free;
IntRepPlayerId.Free;

end.
