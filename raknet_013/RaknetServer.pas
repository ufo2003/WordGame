unit RaknetServer;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Server interface

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

uses RaknetStruct,
     RaknetTypes,
     RaknetBitStream,
     RaknetPlugin,
     RaknetRPC;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type

 // ------------------------------------
 //
 // Server Class declarations
 //
 // ------------------------------------

 TRakServer = class(TRaknetInterfaceAbstract)
 private
    procedure SetInterface(const Value: TRakInterface);
    function GetInterface: TRakInterface;
 protected
    procedure    SetRaknetInterface(const Value: TRakInterface); override;
 public
   property    RaknetInterface:TRakInterface read GetInterface write SetInterface;
   constructor Create;
   destructor  Destroy;
   function    Start                                (AllowedPlayers:word;depreciated:cardinal;threadSleepTimer:integer;port:word;const forceHostAddress:string):boolean;
   procedure   InitializeSecurity                   (const privKeyP,privKeyQ:string);
   procedure   DisableSecurity                      ;
   procedure   SetPassword                          (const _password:string);
   function    HasPassword                          :boolean;
   procedure   Disconnect                           (blockDuration:cardinal;orderingChannel:byte);
   function    SendBuffer                           (data:pchar;bytelength:integer;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;PlayerID:TRakInterface;broadcast:boolean):boolean;
   function    SendBitStream                        (const BitStream:TRakBitStream;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;PlayerID:TRakPlayerID;broadcast:boolean):boolean;
   function    Receive                              :TRakPacket;         overload;
   procedure   Receive                               (Packet:TRakPacket); overload;
   procedure   Kick                                 (PlayerID:TRakPlayerID);
   procedure   DeallocatePacket                     (const Packet:TRakPacket);
   procedure   SetAllowedPlayers                    (AllowedPlayers:word);
   function    GetAllowedPlayers                    :word;
   function    GetConnectedPlayers                  :word;
   procedure   GetPlayerIPFromID                    (PlayerID:TRakPlayerID;var returnValue:String;var port:word);
   procedure   PingPlayer                           (PlayerID:TRakPlayerID);
   function    GetAveragePing                       (PlayerID:TRakPlayerID):integer;
   function    GetLastPing                          (PlayerID:TRakPlayerID):integer;
   function    GetLowestPing                        (PlayerID:TRakPlayerID):integer;
   procedure   StartOccasionalPing                  ;
   procedure   StopOccasionalPing                   ;
   function    IsActive                             :boolean;
   function    GetSynchronizedRandomInteger         ():cardinal;
   procedure   StartSynchronizedRandomInteger       ;
   procedure   StopSynchronizedRandomInteger        ;
   function    GenerateCompressionLayer             (inputFrequencyTable:PFrequencyTable;inputLayer:boolean):boolean;
   function    DeleteCompressionLayer               (inputLayer:boolean):boolean;
   procedure   SetTrackFrequencyTable               (b:boolean);
   function    GetSendFrequencyTable                (outputFrequencyTable:PFrequencyTable):boolean;
   function    GetCompressionRatio                  :single;
   function    GetDecompressionRatio                :single;
   function    GetStaticServerData                  :TRakBitStream;
   procedure   SetStaticServerData                  (data:Pchar;bytelength:integer);
   procedure   SetStaticClientData                  (PlayerID:TRakPlayerID;data:Pchar;bytelength:integer);
   procedure   SetRelayStaticClientData             (b:boolean);
   procedure   SendStaticServerDataToClient         (PlayerID:TRakPlayerID);
   procedure   SetOfflinePingResponse               (data:pchar;bytelength:cardinal);
   function    GetStaticClientData                  (PlayerID:TRakPlayerID):TRakBitStream;
   procedure   ChangeStaticClientData               (playerChangedId,playerToSendToId:TRakPlayerID);
   function    GetNumberOfAddresses                 ():cardinal;
   function    GetLocalIP                           (index:cardinal):String;
   function    GetInternalID                        ():TRakPlayerID;
   procedure   PushBackPacket                       (const Packet:TRakPacket;pushAtHead:boolean);
   function    GetIndexFromPlayerID                 (PlayerID:TRakPlayerID):integer;
   function    GetPlayerIDFromIndex                 (index:integer):TRakPlayerID;
   procedure   AddToBanList                         (const IP:string);
   procedure   RemoveFromBanList                    (const IP:string);
   procedure   ClearBanList                         ();
   function    IsBanned                             (const IP:string):boolean;
   function    IsActivePlayerID                     (PlayerID:TRakPlayerID):boolean;
   procedure   SetTimeoutTime                       (timeMS:cardinal;PlayerID:TRakPlayerID);
   function    SetMTUSize                           (size:integer):boolean;
   function    GetMTUSize                           ():integer;
   procedure   AdvertiseSystem                      (const host:string;remotePort:word;data:Pchar;dataLength:integer);
   function    GetStatistics                        (PlayerID:TRakPlayerID):PRakNetStatisticsStruct;
   procedure   ApplyNetworkSimulator                (maxSendBPS:double;minExtraPing,extraPingVariance:word);
   function    IsNetworkSimulatorActive             :boolean;
   procedure   UnregisterAsRemoteProcedureCall      (const uniqueID:string);
   function    RegisterAsRemoteProcedureCall        (const uniqueID:string;ClassPointer:pointer;Callback:TRPCCallbackObj):cardinal;
   function    RPCFromBuffer                        (const uniqueID:String;data:Pchar;bitLength:cardinal;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;PlayerID:TRakPlayerID;broadcast,shiftTimestamp:boolean;BitStreamReplyFromTarget:TRakBitStream):boolean;
   function    RPCFromBitStream                     (const uniqueID:String;BitStream:TRakBitStream;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;PlayerID:TRakPlayerID;broadcast,shiftTimestamp:boolean;BitStreamReplyFromTarget:TRakBitStream):boolean;
   procedure   AttachPlugin                         (const Plugin:TRakPlugin);
   procedure   DetachPlugin                         (const Plugin:TRakPlugin);

 end;



implementation

uses RaknetDLL,
     RaknetInterface;

{ TRakServer }

procedure TRakServer.AddToBanList(const IP: string);
begin
  TRAKSERVER_AddToBanList(IntRaknetInterface,Pchar(IP));
end;

procedure TRakServer.AdvertiseSystem(const host: string; remotePort: word;
  data: Pchar; dataLength: integer);
begin
     TRAKSERVER_AdvertiseSystem(IntRaknetInterface,Pchar(host),remotePort,data,dataLength);
end;

procedure TRakServer.ApplyNetworkSimulator(maxSendBPS: double; minExtraPing,
  extraPingVariance: word);
begin
  TRAKSERVER_ApplyNetworkSimulator(IntRaknetInterface,maxSendBPS,minExtraPing,extraPingVariance);
end;

procedure TRakServer.AttachPlugin(const Plugin: TRakPlugin);
begin
 TRAKSERVER_AttachPlugin(IntRaknetInterface,Plugin.RaknetInterface);
end;

procedure TRakServer.ChangeStaticClientData(playerChangedId,
  playerToSendToId: TRakPlayerID);
begin
   TRAKSERVER_ChangeStaticClientData(IntRaknetInterface,playerChangedId.RaknetInterface,playerToSendToId.RaknetInterface);
end;

procedure TRakServer.ClearBanList;
begin
   TRAKSERVER_ClearBanList(IntRaknetInterface);
end;

constructor TRakServer.Create;
begin
  IntRaknetInterface := TRAKNET_InitServerInterface;
end;

procedure TRakServer.DeallocatePacket(const Packet: TRakPacket);
begin
   TRAKSERVER_DeallocatePacket(IntRaknetInterface,Packet.RaknetInterface);
   Packet.Free;
end;

function TRakServer.DeleteCompressionLayer(inputLayer: boolean): boolean;
begin
   Result := TRAKSERVER_DeleteCompressionLayer(IntRaknetInterface,inputLayer);
end;

destructor TRakServer.Destroy;
begin
  if IntRaknetInterface<>nil then  
  TRAKNET_UnInitServerInterface(IntRaknetInterface);
end;

procedure TRakServer.DetachPlugin(const Plugin: TRakPlugin);
begin
 TRAKSERVER_DetachPlugin(IntRaknetInterface,Plugin.RaknetInterface);
end;

procedure TRakServer.DisableSecurity;
begin
  TRAKSERVER_DisableSecurity(IntRaknetInterface);
end;

procedure TRakServer.Disconnect(blockDuration: cardinal; orderingChannel: byte);
begin
   TRAKSERVER_Disconnect(IntRaknetInterface,blockDuration,orderingChannel);
end;

function TRakServer.GenerateCompressionLayer(
  inputFrequencyTable: PFrequencyTable; inputLayer: boolean): boolean;
begin
   Result := TRAKSERVER_GenerateCompressionLayer(IntRaknetInterface,Pchar(inputFrequencyTable),inputLayer)
end;

function TRakServer.GetAllowedPlayers: word;
begin
  Result := TRAKSERVER_GetAllowedPlayers(IntRaknetInterface);
end;

function TRakServer.GetAveragePing(PlayerID: TRakPlayerID): integer;
begin
  Result := TRAKSERVER_GetAveragePing(IntRaknetInterface,PlayerID.RaknetInterface);
end;

function TRakServer.GetCompressionRatio: single;
begin
  Result := TRAKSERVER_GetCompressionRatio(IntRaknetInterface);
end;

function TRakServer.GetConnectedPlayers: word;
begin
  Result := TRAKSERVER_GetConnectedPlayers(IntRaknetInterface);
end;

function TRakServer.GetDecompressionRatio: single;
begin
  Result := TRAKSERVER_GetDecompressionRatio(IntRaknetInterface);
end;

function TRakServer.GetIndexFromPlayerID(PlayerID: TRakPlayerID): integer;
begin
  Result := TRAKSERVER_GetIndexFromPlayerID(IntRaknetInterface,PlayerID.RaknetInterface);
end;


function TRakServer.GetInterface: TRakInterface;
begin

end;

function TRakServer.GetInternalID: TRakPlayerID;
begin
      Result := TRakPlayerID.Create;
      Result.RaknetInterface := TRAKSERVER_GetInternalID(IntRaknetInterface);
      if Result.RaknetInterface=nil then
       begin
          Result.Destroy;
          Result := nil;
       end;
      Assert((Result.RaknetInterface<>nil),'Server GetInternalID');
end;

function TRakServer.GetLastPing(PlayerID: TRakPlayerID): integer;
begin
   Result := TRAKSERVER_GetLastPing(IntRaknetInterface,PlayerID.RaknetInterface);
end;

function TRakServer.GetLocalIP(index: cardinal): String;
begin
  Result := string(TRAKSERVER_GetLocalIP(IntRaknetInterface,index));
end;

function TRakServer.GetLowestPing(PlayerID: TRakPlayerID): integer;
begin
   Result := TRAKSERVER_GetLowestPing(IntRaknetInterface,PlayerID.RaknetInterface);
end;

function TRakServer.GetMTUSize: integer;
begin
   Result := TRAKSERVER_GetMTUSize(IntRaknetInterface);
end;

function TRakServer.GetNumberOfAddresses: cardinal;
begin
  Result := TRAKSERVER_GetNumberOfAddresses(IntRaknetInterface);
end;

function TRakServer.GetPlayerIDFromIndex(index: integer): TRakPlayerID;
begin
      Result := TRakPlayerID.Create;
      Result.RaknetInterface := TRAKSERVER_GetPlayerIDFromIndex(IntRaknetInterface,index);
      if Result.RaknetInterface=nil then
       begin
          Result.Destroy;
          Result := nil;
       end;
      Assert((Result.RaknetInterface<>nil),'Client GetInternalID');

end;

procedure TRakServer.GetPlayerIPFromID(PlayerID: TRakPlayerID;
  var returnValue: String; var port: word);
begin
  SetLength(returnValue,22);
  TRAKSERVER_GetPlayerIPFromID(IntRaknetInterface,PlayerID.RaknetInterface,Pchar(returnValue),Port);
end;

function TRakServer.GetSendFrequencyTable(outputFrequencyTable: PFrequencyTable): boolean;
begin
  Result := TRAKSERVER_GetSendFrequencyTable(IntRaknetInterface,Pchar(outputFrequencyTable));
end;

function TRakServer.GetStaticClientData(PlayerID: TRakPlayerID): TRakBitStream;
begin
     Result := TRakBitStream.Create;
     Result.RaknetInterface := TRAKSERVER_GetStaticClientData(IntRaknetInterface,PlayerID.RaknetInterface);
end;

function TRakServer.GetStaticServerData: TRakBitStream;
begin
     Result := TRakBitStream.Create;
     Result.RaknetInterface := TRAKSERVER_GetStaticServerData(IntRaknetInterface);
end;

function TRakServer.GetStatistics(
  PlayerID: TRakPlayerID): PRakNetStatisticsStruct;
begin
   Result := PRakNetStatisticsStruct(TRAKSERVER_GetStatistics(IntRaknetInterface,PlayerID.RaknetInterface));
end;

function TRakServer.GetSynchronizedRandomInteger: cardinal;
begin
  Result := TRAKSERVER_GetSynchronizedRandomInteger(IntRaknetInterface);
end;

function TRakServer.HasPassword: boolean;
begin
 Result := TRAKSERVER_HasPassword(IntRaknetInterface);
end;

procedure TRakServer.InitializeSecurity(const privKeyP, privKeyQ: string);
begin
  TRAKSERVER_InitializeSecurity(IntRaknetInterface,Pchar(privKeyP),Pchar(privKeyQ));
end;

function TRakServer.IsActive: boolean;
begin
 Result := TRAKSERVER_IsActive(IntRaknetInterface);
end;

function TRakServer.IsActivePlayerID(PlayerID: TRakPlayerID): boolean;
begin
  Result := TRAKSERVER_IsActivePlayerID(IntRaknetInterface, PlayerID.RaknetInterface);
end;

function TRakServer.IsBanned(const IP: string): boolean;
begin
  Result := TRAKSERVER_IsBanned(IntRaknetInterface,Pchar(IP));
end;

function TRakServer.IsNetworkSimulatorActive: boolean;
begin
  Result := TRAKSERVER_IsNetworkSimulatorActive(IntRaknetInterface);
end;

procedure TRakServer.Kick(PlayerID: TRakPlayerID);
begin
  TRAKSERVER_Kick(IntRaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakServer.PingPlayer(PlayerID: TRakPlayerID);
begin
  TRAKSERVER_PingPlayer(IntRaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakServer.PushBackPacket(const Packet: TRakPacket;
  pushAtHead: boolean);
begin
  TRAKSERVER_PushBackPacket(IntRaknetInterface,Packet.RaknetInterface,pushAtHead);
end;

function TRakServer.Receive: TRakPacket;
var TempInt:TRakInterface;
begin
    Result  := nil;
    TempInt := TRAKCLIENT_Receive(IntRaknetInterface);
    if TempInt<>nil then
     begin
       Result := TRakPacket.Create;
       Result.RaknetInterface := TempInt;
     end;                 
end;

procedure TRakServer.Receive(Packet: TRakPacket);
begin
    Packet.RaknetInterface := TRAKCLIENT_Receive(IntRaknetInterface);
end;

function  TRakServer.RegisterAsRemoteProcedureCall(const uniqueID: string;ClassPointer:pointer;Callback:TRPCCallbackObj):cardinal;
begin
  TRAKSERVER_RegisterAsRemoteProcedureCall(IntRaknetInterface,Pchar(UniqueID),ClassPointer,RaknetRPC.RPCCallbackMultiPlexer);
end;


procedure TRakServer.RemoveFromBanList(const IP: string);
begin
   TRAKSERVER_RemoveFromBanList(IntRaknetInterface,Pchar(IP));
end;

function TRakServer.RPCFromBitStream(const uniqueID: String;
  BitStream: TRakBitStream; priority: TPacketPriority;
  reliability: TPacketReliability; orderingChannel: byte;
  PlayerID: TRakPlayerID; broadcast, shiftTimestamp: boolean;
  BitStreamReplyFromTarget: TRakBitStream): boolean;
begin
   Result := TRAKSERVER_RPCFromBitStream(IntRaknetInterface,Pchar(uniqueID),BitStream.RaknetInterface,
            integer(priority),integer(reliability),orderingChannel,PlayerID.RaknetInterface,broadcast,shiftTimestamp,BitStreamReplyFromTarget.RaknetInterface);

end;

function TRakServer.RPCFromBuffer(const uniqueID: String; data: Pchar;
  bitLength: cardinal; priority: TPacketPriority;
  reliability: TPacketReliability; orderingChannel: byte;
  PlayerID: TRakPlayerID; broadcast, shiftTimestamp: boolean;
  BitStreamReplyFromTarget: TRakBitStream): boolean;
begin
  Result := TRAKSERVER_RPCFromBuffer(IntRaknetInterface,Pchar(uniqueID),data,bitLength,
            integer(priority),integer(reliability),orderingChannel,PlayerID.RaknetInterface,broadcast,shiftTimestamp,BitStreamReplyFromTarget.RaknetInterface);

end;

function TRakServer.SendBitStream(const BitStream: TRakBitStream;
  priority: TPacketPriority; reliability: TPacketReliability;
  orderingChannel: byte; PlayerID: TRakPlayerID; broadcast: boolean): boolean;
begin
   Result := TRAKSERVER_SendBitStream(IntRaknetInterface,BitStream.RaknetInterface,integer(priority),integer(reliability),orderingChannel,PlayerID.RaknetInterface,broadcast);
end;

function TRakServer.SendBuffer(data: pchar; bytelength:integer;
  priority: TPacketPriority; reliability: TPacketReliability;
  orderingChannel: byte; PlayerID: TRakInterface; broadcast: boolean): boolean;
begin
   Result := TRAKSERVER_SendBuffer(IntRaknetInterface,data,bytelength,integer(priority),integer(reliability),orderingChannel,PlayerID,broadcast);
end;

procedure TRakServer.SendStaticServerDataToClient(PlayerID: TRakPlayerID);
begin
   TRAKSERVER_SendStaticServerDataToClient(IntRaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakServer.SetAllowedPlayers(AllowedPlayers: word);
begin
  TRAKSERVER_SetAllowedPlayers(IntRaknetInterface,AllowedPlayers);
end;


procedure TRakServer.SetInterface(const Value: TRakInterface);
begin

end;

function TRakServer.SetMTUSize(size: integer): boolean;
begin
  Result := TRAKSERVER_SetMTUSize(IntRaknetInterface,size);
end;

procedure TRakServer.SetOfflinePingResponse(data: pchar; bytelength: cardinal);
begin
  TRAKSERVER_SetOfflinePingResponse(IntRaknetInterface,data,bytelength);
end;

procedure TRakServer.SetPassword(const _password: string);
begin
   TRAKSERVER_SetPassword(IntRaknetInterface,Pchar(_password));
end;

procedure TRakServer.SetRaknetInterface(const Value: TRakInterface);
begin
 if IntRaknetInterface<>nil then
    begin
     UnInitClientInterface(IntRaknetInterface);
    end;
  IntRaknetInterface:=Value;
end;

procedure TRakServer.SetRelayStaticClientData(b: boolean);
begin
   TRAKSERVER_SetRelayStaticClientData(IntRaknetInterface,b);
end;

procedure TRakServer.SetStaticClientData(PlayerID: TRakPlayerID; data: Pchar;
  bytelength: integer);
begin
  TRAKSERVER_SetStaticClientData(IntRaknetInterface,PlayerID.RaknetInterface,data,bytelength);
end;

procedure TRakServer.SetStaticServerData(data: Pchar; bytelength: integer);
begin
 TRAKSERVER_SetStaticServerData(IntRaknetInterface,data,bytelength);
end;

procedure TRakServer.SetTimeoutTime(timeMS: cardinal; PlayerID: TRakPlayerID);
begin
 TRAKSERVER_SetTimeoutTime(IntRaknetInterface,timeMS,PlayerID.RaknetInterface);
end;

procedure TRakServer.SetTrackFrequencyTable(b: boolean);
begin
  TRAKSERVER_SetTrackFrequencyTable(IntRaknetInterface,b);
end;

function TRakServer.Start(AllowedPlayers: word; depreciated: cardinal;
  threadSleepTimer: integer; port: word;
  const forceHostAddress: string): boolean;
begin
  Result := TRAKSERVER_Start(IntRaknetInterface,AllowedPlayers,depreciated,threadSleepTimer,port,Pchar(forceHostAddress));
end;

procedure TRakServer.StartOccasionalPing;
begin
  TRAKSERVER_StartOccasionalPing(IntRaknetInterface);
end;

procedure TRakServer.StartSynchronizedRandomInteger;
begin
  TRAKSERVER_StartSynchronizedRandomInteger(IntRaknetInterface);
end;

procedure TRakServer.StopOccasionalPing;
begin
  TRAKSERVER_StopOccasionalPing(IntRaknetInterface);
end;

procedure TRakServer.StopSynchronizedRandomInteger;
begin
  TRAKSERVER_StopSynchronizedRandomInteger(IntRaknetInterface);
end;

procedure TRakServer.UnregisterAsRemoteProcedureCall(const uniqueID: string);
begin
  TRAKSERVER_UnregisterAsRemoteProcedureCall(IntRaknetInterface,Pchar(uniqueID));
end;

end.
