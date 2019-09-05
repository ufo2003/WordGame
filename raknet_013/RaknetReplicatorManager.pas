unit RaknetReplicatorManager;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Replicator manager

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
     RakNetBitStream,
     RaknetPlugin,
     RakNetReplicatorMember;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type            TRakReplicatorManager=class;

                TRakReplicatorDownloadReceiver = class
                  function ReceiveConstructionCB(inBitStream:TRakBitStream;timestamp:Cardinal;NetworkID:TRakNetworkID;PlayerID:TRakPlayerID;ReplicaManager:TRakReplicatorManager):TReplicaReturnResult; virtual;
                  function SendDownloadCompleteCB(outBitStream:TRakBitStream;currentTime:cardinal;PlayerID:TRakPlayerID;ReplicaManager:TRakReplicatorManager):TReplicaReturnResult; virtual;
                  function receiveDownloadCompleteCB(inBitStream:TRakBitStream;PlayerId:TRakPlayerID;ReplicaManager:TRakReplicatorManager):TReplicaReturnResult; virtual;
                end;

                TRakReplicatorManager = class(TRakPlugin)
                 private
                 protected
                 public
                  constructor Create;  override;
                  Destructor  Destroy; override;
                  procedure SetAutoParticipateNewConnections  (autoAdd:boolean);
                  procedure AddParticipant                 (const PlayerID:TRakPlayerID);
                  procedure RemoveParticipant              (const PlayerID:TRakPlayerID);
                  procedure Construct                      (const Replica:TRakReplicatorMember;isCopy:boolean;const PlayerID:TRakPlayerID;broadcast:boolean);
                  procedure Destruct                       (const Replica:TRakReplicatorMember;const PlayerID:TRakPlayerID;broadcast:boolean);
                  procedure ReferencePointer               (const Replica:TRakReplicatorMember);
                  procedure DereferencePointer             (const Replica:TRakReplicatorMember);
                  procedure SetScope                       (const Replica:TRakReplicatorMember;inScope:boolean;const PlayerID:TRakPlayerID;broadcast:boolean);
                  procedure SignalSerializeNeeded          (const Replica:TRakReplicatorMember;const PlayerID:TRakPlayerID;broadcast:boolean);
                  procedure SetReceiveConstructionCB       (constructionCB:TRakReplicatorDownloadReceiver);
                  procedure SetDownloadCompleteCB          (sendDownloadCompleteCB,receiveDownloadCompleteCB:TRakReplicatorDownloadReceiver);
                  procedure SetSendChannel                 (channel:byte);
                  procedure SetAutoConstructToNewParticipants  (autoConstruct:boolean);
                  procedure SetDefaultScope                (scope:boolean);
                  procedure EnableReplicaInterfaces        (const Replica:TRakReplicatorMember;interfaceFlags:byte);
                  procedure DisableReplicaInterfaces       (const Replica:TRakReplicatorMember;interfaceFlags:byte);
                  function  IsConstructed                  (const Replica:TRakReplicatorMember;const PlayerID:TRakPlayerID):boolean;
                  function  IsInScope                      (const Replica:TRakReplicatorMember;const PlayerID:TRakPlayerID):boolean;
                  function  GetReplicaCount                :cardinal;
                  function  GetReplicaAtIndex              (const index:cardinal):TRakReplicatorMember;
                end;



implementation
uses RaknetDLL;

var intMBitStream:TRakBitStream;
    intMPlayerID :TRakPlayerID;
    intMNetworkID:TRakNetworkID;
    intMRepManager:TRakReplicatorManager;

{Multiplexers}

     function  IntconstructionCB (inBitStream:TRakInterface;timestamp:Cardinal;NetworkID,PlayerID,ReplicaManager:TRakInterface;DelphiObj:pointer):TReplicaReturnResult; stdcall;
     begin
       intMBitStream.RaknetInterface := inBitStream;
       intMNetworkID.RaknetInterface := NetworkID;
       intMPlayerID.RaknetInterface  := PlayerID;
       intMRepManager.RaknetInterface:= ReplicaManager;
       Result := TRakReplicatorDownloadReceiver(DelphiObj).ReceiveConstructionCB(intMBitStream,timestamp,intMNetworkID,intMPlayerID,intMRepManager);
       intMBitStream.ToNull;
       intMRepManager.ToNull;
     end;

     function   IntsendDownloadCompleteCB(outBitStream:TRakInterface;currentTime:cardinal;PlayerID:TRakInterface;ReplicaManager:TRakInterface;DelphiObj:pointer):TReplicaReturnResult; stdcall;
     begin
       intMBitStream.RaknetInterface := outBitStream;
       intMPlayerID.RaknetInterface  := PlayerID;
       intMRepManager.RaknetInterface:= ReplicaManager;
       Result := TRakReplicatorDownloadReceiver(DelphiObj).SendDownloadCompleteCB(intMBitStream,currentTime,intMPlayerID,intMRepManager);
       intMBitStream.ToNull;
       intMRepManager.ToNull;
     end;

     function IntreceiveDownloadCompleteCB(inBitStream,PlayerId,ReplicaManager:TRakInterface;DelphiObj:pointer):TReplicaReturnResult; stdcall;
     begin
       intMBitStream.RaknetInterface := inBitStream;
       intMPlayerID.RaknetInterface  := PlayerID;
       intMRepManager.RaknetInterface:= ReplicaManager;
       Result := TRakReplicatorDownloadReceiver(DelphiObj).receiveDownloadCompleteCB(intMBitStream,intMPlayerID,intMRepManager);
       intMBitStream.ToNull;
       intMRepManager.ToNull;
     end;

{ TRakReplicatorManager }

procedure TRakReplicatorManager.AddParticipant(const PlayerID: TRakPlayerID);
begin
 TRAKReplicaManager_AddParticipant(IntRaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakReplicatorManager.Construct(const Replica: TRakReplicatorMember;
  isCopy: boolean; const PlayerID: TRakPlayerID; broadcast: boolean);
begin
 TRAKReplicaManager_Construct(IntRaknetInterface,Replica.RaknetInterface,isCopy,PlayerID.RaknetInterface,broadcast);
end;

constructor TRakReplicatorManager.Create;
begin
  inherited;
  IntRaknetInterface := TRAKReplicaManager_Constructor;
end;

procedure TRakReplicatorManager.DereferencePointer(const Replica: TRakReplicatorMember);
begin
  TRAKReplicaManager_DereferencePointer(IntRaknetInterface,Replica.RaknetInterface);
end;

destructor TRakReplicatorManager.Destroy;
begin
  TRAKReplicaManager_Destructor(IntRaknetInterface);
  inherited;
end;

procedure TRakReplicatorManager.Destruct(const Replica: TRakReplicatorMember;
  const PlayerID: TRakPlayerID; broadcast: boolean);
begin
  TRAKReplicaManager_Destruct(IntRaknetInterface,Replica.RaknetInterface,PlayerID.RaknetInterface,broadcast);
end;

procedure TRakReplicatorManager.DisableReplicaInterfaces(
  const Replica: TRakReplicatorMember; interfaceFlags: byte);
begin
  TRAKReplicaManager_DisableReplicaInterfaces(IntRaknetInterface,Replica.RaknetInterface,interfaceFlags);
end;

procedure TRakReplicatorManager.EnableReplicaInterfaces(
  const Replica: TRakReplicatorMember; interfaceFlags: byte);
begin
 TRAKReplicaManager_EnableReplicaInterfaces(IntRaknetInterface,Replica.RaknetInterface,interfaceFlags);
end;

function TRakReplicatorManager.GetReplicaAtIndex(const index: cardinal):TRakReplicatorMember;
begin
  Result := TRakReplicatorMember.CreateEmpty;
  Result.RaknetInterface := TRAKReplicaManager_GetReplicaAtIndex(IntRaknetInterface,index);
end;

function TRakReplicatorManager.GetReplicaCount: cardinal;
begin
  Result := TRAKReplicaManager_GetReplicaCount(IntRaknetInterface);
end;

function TRakReplicatorManager.IsConstructed(const Replica: TRakReplicatorMember; const PlayerID: TRakPlayerID): boolean;
begin
  Result := TRAKReplicaManager_IsConstructed(IntRaknetInterface,Replica.RaknetInterface,PlayerID.RaknetInterface);
end;

function TRakReplicatorManager.IsInScope(const Replica: TRakReplicatorMember; const PlayerID: TRakPlayerID): boolean;
begin
 Result := TRAKReplicaManager_IsInScope(IntRaknetInterface,Replica.RaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakReplicatorManager.ReferencePointer(const Replica: TRakReplicatorMember);
begin
  TRAKReplicaManager_ReferencePointer(IntRaknetInterface,Replica.RaknetInterface);
end;

procedure TRakReplicatorManager.RemoveParticipant(const PlayerID: TRakPlayerID);
begin
  TRAKReplicaManager_RemoveParticipant(IntRaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakReplicatorManager.SetAutoConstructToNewParticipants(autoConstruct: boolean);
begin
  TRAKReplicaManager_SetAutoConstructToNewParticipants(IntRaknetInterface,autoConstruct);
end;

procedure TRakReplicatorManager.SetAutoParticipateNewConnections(autoAdd: boolean);
begin
 TRAKReplicaManager_SetAutoParticipateNewConnections(IntRaknetInterface,autoAdd);
end;

procedure TRakReplicatorManager.SetDefaultScope(scope: boolean);
begin
  TRAKReplicaManager_SetDefaultScope(IntRaknetInterface,scope);
end;

procedure TRakReplicatorManager.SetDownloadCompleteCB(sendDownloadCompleteCB,
  receiveDownloadCompleteCB: TRakReplicatorDownloadReceiver);
begin
 TRAKReplicaManager_SetDownloadCompleteCB(IntRaknetInterface,sendDownloadCompleteCB,IntsendDownloadCompleteCB,IntreceiveDownloadCompleteCB);
end;

procedure TRakReplicatorManager.SetReceiveConstructionCB(constructionCB: TRakReplicatorDownloadReceiver);
begin
  TRAKReplicaManager_SetReceiveConstructionCB(IntRaknetInterface,constructionCB,IntconstructionCB);
end;

procedure TRakReplicatorManager.SetScope(const Replica: TRakReplicatorMember;
  inScope: boolean; const PlayerID: TRakPlayerID; broadcast: boolean);
begin
  TRAKReplicaManager_SetScope(IntRaknetInterface,Replica.RaknetInterface,inScope,PlayerID.RaknetInterface,broadcast);
end;

procedure TRakReplicatorManager.SetSendChannel(channel: byte);
begin
 TRAKReplicaManager_SetSendChannel(IntRaknetInterface,channel);
end;

procedure TRakReplicatorManager.SignalSerializeNeeded(const Replica: TRakReplicatorMember; const PlayerID: TRakPlayerID;
  broadcast: boolean);
begin
  TRAKReplicaManager_SignalSerializeNeeded(IntRaknetInterface,Replica.RaknetInterface,PlayerID.RaknetInterface,broadcast);
end;

{ TRakReplicatorReciver }



{ TRakReplicatorDownloadReceiver }

function TRakReplicatorDownloadReceiver.ReceiveConstructionCB(
  inBitStream: TRakBitStream; timestamp: Cardinal; NetworkID: TRakNetworkID;
  PlayerID: TRakPlayerID;
  ReplicaManager: TRakReplicatorManager): TReplicaReturnResult;
begin
 Result := REPLICA_PROCESSING_DONE;
end;

function TRakReplicatorDownloadReceiver.receiveDownloadCompleteCB(
  inBitStream: TRakBitStream; PlayerId: TRakPlayerID;
  ReplicaManager: TRakReplicatorManager): TReplicaReturnResult;
begin
 Result := REPLICA_PROCESSING_DONE;
end;

function TRakReplicatorDownloadReceiver.SendDownloadCompleteCB(
  outBitStream: TRakBitStream; currentTime: cardinal; PlayerID: TRakPlayerID;
  ReplicaManager: TRakReplicatorManager): TReplicaReturnResult;
begin
 Result := REPLICA_PROCESSING_DONE;
end;

initialization
    intMBitStream :=TRakBitStream.CreateEmpty;
    intMPlayerID  :=TRakPlayerID.CreateEmpty;
    intMNetworkID :=TRakNetworkID.CreateEmpty;
    intMRepManager:=TRakReplicatorManager.CreateEmpty;

finalization
    intMBitStream.ToNull;
    intMPlayerID.ToNull;
    intMNetworkID.ToNull;
    intMRepManager.ToNull;

    intMBitStream.Free;
    intMPlayerID.Free;
    intMNetworkID.Free;
    intMRepManager.Free;

end.
