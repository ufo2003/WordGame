unit RaknetPeer;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Raknet Peer connection interface

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
     RaknetRouter,
     RaknetRPC;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type

TRakPeer=class(TRaknetInterfaceAbstract)
  private
  protected
       procedure    SetRaknetInterface(const Value: TRakInterface); override;
  public
      constructor Create;
      destructor  Destroy;   override;
      function  Initialize                              (maxConnections,localPort:word;_threadSleepTimer:integer;const forceHostAddress:string):boolean;
      procedure InitializeSecurity                      (const pubKeyE,pubKeyN,privKeyP,privKeyQ:String);
      procedure DisableSecurity                         ();
      procedure SetMaximumIncomingConnections           (numberAllowed:word);
      function  GetMaximumIncomingConnections           ():word ;
      procedure SetIncomingPassword                     (const passwordData:String;passwordDataLength:integer);
      procedure GetIncomingPassword                     (var passwordData:String;var passwordDataLength:integer);
      function  Connect                                 (const host:String;remotePort:word;const passwordData:String;passwordDataLength:integer ):boolean;
      procedure Disconnect                              (blockDuration:integer;orderingChannel:byte );
      function  IsActive                                ():boolean ;
      function  GetConnectionList                       (var remoteplayerPlayerID:PTRakInterfaceList;var numberOfSystems:word):boolean;
      function  SendBuffer                              (data:Pchar;bytelength:integer;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;PlayerID:TRakPlayerID;broadcast:boolean):boolean;
      function  SendBitStream                           (BitStream:TRakBitStream;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;PlayerID:TRakPlayerID;broadcast:boolean):boolean;
      function  Receive                                 ():TRakPacket; overload;
      procedure Receive                                 (Packet:TRakPacket); overload;
      procedure DeallocatePacket                        (const Packet:TRakPacket);
      function  GetMaximumNumberOfPeers                 ():word ;
      procedure RegisterAsRemoteProcedureCall           (const uniqueID:String;ClassPointer:TObject;Callback:TRPCCallbackObj);
      procedure UnregisterAsRemoteProcedureCall         (const uniqueID:String);
      function  RPCBuffer                               (const uniqueID:String;data:Pchar;bitLength:cardinal;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;PlayerID:TRakPlayerID;broadcast,shiftTimestamp:boolean;NetworkID:TRakNetworkID;BsreplyFromTarget:TRakBitStream):boolean;
      function  RPCBitStream                            (const uniqueID:String;BitStream:TRakBitStream;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;PlayerID:TRakPlayerID;broadcast,shiftTimestamp:boolean;NetworkID:TRakNetworkID;bsreplyFromTarget:TRakBitStream):boolean;
      procedure CloseConnection                         (PlayerID:TRakPlayerID;sendDisconnectionNotification:boolean;orderingChannel:byte);
      function  GetIndexFromPlayerID                    (PlayerID:TRakPlayerID):integer;
      function  GetPlayerIDFromIndex                    (index:integer):TRakPlayerID;
      procedure AddToBanList                            (const RakPeerIP:String;milliseconds:cardinal);
      procedure RemoveFromBanList                       (const RakPeerIP:String);
      procedure ClearBanList                            ();
      function  IsBanned                                (const IP:String):boolean;
      procedure Ping                                    (PlayerID:TRakPlayerID);
      procedure PingHost                                (const host:string;remotePort:word;onlyReplyOnAcceptingConnections:boolean);
      function  GetAveragePing                          (PlayerID:TRakPlayerID):integer;
      function  GetLastPing                             (PlayerID:TRakPlayerID):integer ;
      function  GetLowestPing                           (PlayerID:TRakPlayerID):integer ;
      procedure SetOccasionalPing                       (doPing:boolean);
      function  GetRemoteStaticData                     (PlayerID:TRakPlayerID):TRakBitStream;
      procedure SetRemoteStaticData                     (PlayerID:TRakPlayerID;data:Pchar;bytelength:integer);
      procedure SendStaticData                          (PlayerID:TRakPlayerID);
      procedure SetOfflinePingResponse                  (data:Pchar;bytelength:cardinal);
      function  GetInternalID                           :TRakPlayerID;
      function  GetExternalID                           (PlayerID:TRakPlayerID):TRakPlayerID;
      procedure SetTimeoutTime                          (timeMS:cardinal;PlayerID:TRakPlayerID);
      function  SetMTUSize                              (size:integer):boolean;
      function  GetMTUSize                              :integer;
      function  GetNumberOfAddresses                    :cardinal;
      function  GetLocalIP                              (index:cardinal):string;
      function  PlayerIDToDottedIP                      (PlayerID:TRakPlayerID):String;
      procedure IPToPlayerID                            (const host:string;remotePort:word;PlayerID:TRakPlayerID);
      procedure AllowConnectionResponseIPMigration      (allow:boolean);
      procedure AdvertiseSystem                         (const host:string;remotePort:word;data:Pchar;dataLength:integer);
      procedure SetSplitMessageProgressInterval         (interval:integer);
      procedure SetUnreliableTimeout                    (timeoutMS:cardinal);
      procedure SetCompileFrequencyTable                (doCompile:boolean);
      function  GetOutgoingFrequencyTable               (outputFrequencyTable:PFrequencyTable):boolean;
      function  GenerateCompressionLayer                (outputFrequencyTable:PFrequencyTable;inputLayer:boolean):boolean;
      function  DeleteCompressionLayer                  (inputLayer:boolean ):boolean;
      function  GetCompressionRatio                     :single ;
      function  GetDecompressionRatio                   :single ;
      procedure AttachPlugin                            (MessageHandler:TRakPlugin);
      procedure DetachPlugin                            (MessageHandler:TRakPlugin);
      procedure PushBackPacket                          (Packet:TRakPacket;pushAtHead:boolean);
      procedure SetRouterInterface                      (RouterInterface:TRakRouter);
      procedure RemoveRouterInterface                   (RouterInterface:TRakRouter);
      procedure ApplyNetworkSimulator                   (maxSendBPS:double;minExtraPing,extraPingVariance:word);
      function  IsNetworkSimulatorActive                :boolean;
      function  GetStatistics                           (PlayerID:TRakPlayerID):PRakNetStatisticsStruct;


end;
implementation
uses RaknetDLL,RaknetInterface;

{ TRakPeer }

procedure TRakPeer.AddToBanList(const RakPeerIP: String;
  milliseconds: cardinal);
begin
  TRAKPEER_AddToBanList(intRaknetInterface,Pchar(RakPeerIP),milliseconds);
end;

procedure TRakPeer.AdvertiseSystem(const host: string; remotePort: word;
  data: Pchar; dataLength: integer);
begin
 TRAKPEER_AdvertiseSystem(intRaknetInterface,Pchar(host),remotePort,data,dataLength);
end;

procedure TRakPeer.AllowConnectionResponseIPMigration(allow: boolean);
begin
 TRAKPEER_AllowConnectionResponseIPMigration(intRaknetInterface,allow);
end;

procedure TRakPeer.ApplyNetworkSimulator(maxSendBPS: double; minExtraPing,
  extraPingVariance: word);
begin
 TRAKPEER_ApplyNetworkSimulator(intRaknetInterface ,maxSendBPS,minExtraPing,extraPingVariance);
end;

procedure TRakPeer.AttachPlugin(MessageHandler: TRakPlugin);
begin
  TRAKPEER_AttachPlugin(IntRaknetInterface,MessageHandler.RaknetInterface);
end;

procedure TRakPeer.ClearBanList;
begin
  TRAKPEER_ClearBanList(intRaknetInterface);
end;

procedure TRakPeer.CloseConnection(PlayerID: TRakPlayerID;
  sendDisconnectionNotification: boolean; orderingChannel: byte);
begin
 TRAKPEER_CloseConnection(intRaknetInterface,PlayerID.RaknetInterface,sendDisconnectionNotification,orderingChannel);
end;

function TRakPeer.Connect(const host: String; remotePort: word;
  const passwordData: String; passwordDataLength: integer): boolean;
begin
 Result := TRAKPEER_Connect(intRaknetInterface,Pchar(host),remotePort,Pchar(passwordData),passwordDataLength);
end;

constructor TRakPeer.Create;
begin
  intRaknetInterface := InitPeerInterface;
end;

procedure TRakPeer.DeallocatePacket(const Packet: TRakPacket);
begin
 TRAKPEER_DeallocatePacket(intRaknetInterface,Packet.RaknetInterface);
end;

function TRakPeer.DeleteCompressionLayer(inputLayer: boolean): boolean;
begin
  Result := TRAKPEER_DeleteCompressionLayer(intRaknetInterface,inputLayer);
end;

destructor TRakPeer.Destroy;
begin
  if intRaknetInterface<>nil then
  UnInitPeerInterface(intRaknetInterface);
end;

procedure TRakPeer.DetachPlugin(MessageHandler: TRakPlugin);
begin
 TRAKPEER_DetachPlugin(IntRaknetInterface,MessageHandler.RaknetInterface);
end;

procedure TRakPeer.DisableSecurity;
begin
 TRAKPEER_DisableSecurity(intRaknetInterface);
end;

procedure TRakPeer.Disconnect(blockDuration: integer; orderingChannel: byte);
begin
  TRAKPEER_Disconnect(intRaknetInterface,blockDuration,orderingChannel);
end;

function TRakPeer.GenerateCompressionLayer(
  outputFrequencyTable: PFrequencyTable; inputLayer: boolean): boolean;
begin
  Result := TRAKPEER_GenerateCompressionLayer(intRaknetInterface,pchar(outputFrequencyTable),inputLayer);
end;

function TRakPeer.GetAveragePing(PlayerID: TRakPlayerID): integer;
begin
  Result := TRAKPEER_GetAveragePing(intRaknetInterface,PlayerID.RaknetInterface);
end;

function TRakPeer.GetCompressionRatio: single;
begin
 Result := TRAKPEER_GetCompressionRatio(intRaknetInterface);
end;

function TRakPeer.GetConnectionList(
  var remoteplayerPlayerID: PTRakInterfaceList;
  var numberOfSystems: word): boolean;
begin
  Result := TRAKPEER_GetConnectionList(intRaknetInterface,remoteplayerPlayerID,numberOfSystems);
end;

function TRakPeer.GetDecompressionRatio: single;
begin
 Result := TRAKPEER_GetDecompressionRatio(intRaknetInterface);
end;

function TRakPeer.GetExternalID(PlayerID: TRakPlayerID): TRakPlayerID;
var intTemp:TRakInterface;
begin
     Result  := nil;
     inttemp := TRAKPEER_GetExternalID(intRaknetInterface,PlayerID.RaknetInterface);
     if intTemp<>nil then
      begin
         Result := TRakPlayerID.Create;
         Result.RaknetInterface := intTemp;
      end;
end;

procedure TRakPeer.GetIncomingPassword(var passwordData: string;
  var passwordDataLength: integer);
begin
  SetLength(passwordData,passwordDataLength);
  TRAKPEER_GetIncomingPassword(intRaknetInterface,Pchar(passwordData),passwordDataLength);
end;

function TRakPeer.GetIndexFromPlayerID(PlayerID: TRakPlayerID): integer;
begin
 Result := TRAKPEER_GetIndexFromPlayerID(intRaknetInterface,PlayerID.RaknetInterface);
end;



function TRakPeer.GetInternalID: TRakPlayerID;
var intTemp:TRakInterface;
begin
     Result  := nil;
     inttemp := TRAKPEER_GetInternalID(intRaknetInterface);
     if intTemp<>nil then
      begin
         Result := TRakPlayerID.Create;
         Result.RaknetInterface := intTemp;
      end;
end;

function TRakPeer.GetLastPing(PlayerID: TRakPlayerID): integer;
begin
 Result := TRAKPEER_GetLastPing(intRaknetInterface,PlayerID.RaknetInterface);
end;

function TRakPeer.GetLocalIP(index: cardinal): string;
begin
 Result := string(TRAKPEER_GetLocalIP(intRaknetInterface,index));
end;

function TRakPeer.GetLowestPing(PlayerID: TRakPlayerID): integer;
begin
 Result := TRAKPEER_GetLowestPing(intRaknetInterface,PlayerID.RaknetInterface);
end;

function TRakPeer.GetMaximumIncomingConnections: word;
begin
 Result := TRAKPEER_GetMaximumIncomingConnections(intRaknetInterface);
end;

function TRakPeer.GetMaximumNumberOfPeers: word;
begin
 Result := TRAKPEER_GetMaximumNumberOfPeers(intRaknetInterface);
end;

function TRakPeer.GetMTUSize: integer;
begin
 Result := TRAKPEER_GetMTUSize(intRaknetInterface);
end;

function TRakPeer.GetNumberOfAddresses: cardinal;
begin
 Result := TRAKPEER_GetNumberOfAddresses(intRaknetInterface);
end;

function TRakPeer.GetOutgoingFrequencyTable(
  outputFrequencyTable: PFrequencyTable): boolean;
begin
  Result := TRAKPEER_GetOutgoingFrequencyTable(intRaknetInterface,Pchar(outputFrequencyTable));
end;

function TRakPeer.GetPlayerIDFromIndex(index: integer): TRakPlayerID;
begin
      Result := TRakPlayerID.Create;
      Result.RaknetInterface := TRAKPeer_GetPlayerIDFromIndex(intRaknetInterface,index);
      if Result.RaknetInterface=nil then
       begin
          Result.Destroy;
          Result := nil;
       end;
      Assert((Result.RaknetInterface<>nil),'Peer GetInternalID');
end;

function TRakPeer.GetRemoteStaticData(PlayerID: TRakPlayerID): TRakBitStream;
var IntTemp:TRakInterface;
begin
     Result  := nil;
     IntTemp := TRAKPEER_GetRemoteStaticData(intRaknetInterface,PlayerID.RaknetInterface);
     if inttemp<>nil then
      begin
        Result := TRakBitStream.Create;
        Result.RaknetInterface := inttemp;
      end;
end;

function TRakPeer.GetStatistics(
  PlayerID: TRakPlayerID): PRakNetStatisticsStruct;
begin
  Result := PRakNetStatisticsStruct(TRAKPEER_GetStatistics(intRaknetInterface,PlayerID.RaknetInterface));
end;

function TRakPeer.Initialize(maxConnections, localPort: word;
  _threadSleepTimer: integer;const forceHostAddress:string): boolean;
begin
  Result := TRAKPEER_Initialize(intRaknetInterface,maxConnections,localPort,_threadSleepTimer,Pchar(forceHostAddress));
end;

procedure TRakPeer.InitializeSecurity(const pubKeyE, pubKeyN, privKeyP,
  privKeyQ: String);
begin
 TRAKPEER_InitializeSecurity(intRaknetInterface,Pchar(pubKeyE),Pchar(pubKeyN),Pchar(privKeyP),Pchar(privKeyQ));
end;

procedure TRakPeer.IPToPlayerID(const host: string; remotePort: word;
  PlayerID: TRakPlayerID);
begin
 TRAKPEER_IPToPlayerID(intRaknetInterface,Pchar(Host),remotePort,PlayerID.RaknetInterface);
end;

function TRakPeer.IsActive: boolean;
begin
 Result := TRAKPEER_IsActive(intRaknetInterface);
end;

function TRakPeer.IsBanned(const IP: String): boolean;
begin
 Result := TRAKPEER_IsBanned(intRaknetInterface,Pchar(IP));
end;

function TRakPeer.IsNetworkSimulatorActive: boolean;
begin
 Result := TRAKPEER_IsNetworkSimulatorActive(intRaknetInterface);
end;

procedure TRakPeer.Ping(PlayerID: TRakPlayerID);
begin
  TRAKPEER_Ping(intRaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakPeer.PingHost(const host: string; remotePort: word;
  onlyReplyOnAcceptingConnections: boolean);
begin
 TRAKPEER_PingHost(intRaknetInterface,Pchar(host),remotePort,onlyReplyOnAcceptingConnections);
end;

function TRakPeer.PlayerIDToDottedIP(PlayerID: TRakPlayerID): String;
begin
 Result := string(TRAKPEER_PlayerIDToDottedIP(intRaknetInterface,PlayerID.RaknetInterface));
end;

procedure TRakPeer.PushBackPacket(Packet: TRakPacket; pushAtHead: boolean);
begin
 TRAKPEER_PushBackPacket(intRaknetInterface,Packet.RaknetInterface,pushAtHead);
end;

function TRakPeer.Receive: TRakPacket;
var intTemp:TRakInterface;
begin
     Result  := nil;
     inttemp := TRAKPEER_Receive(intRaknetInterface);
     if intTemp<>nil then
      begin
         Result := TRakPacket.Create;
         Result.RaknetInterface := intTemp;
      end;
end;

procedure TRakPeer.Receive(Packet: TRakPacket);
begin
     Packet.RaknetInterface := TRAKPEER_Receive(intRaknetInterface);
end;

procedure TRakPeer.RegisterAsRemoteProcedureCall(const uniqueID: String;ClassPointer:TObject;Callback:TRPCCallbackObj);
begin
  TRAKPEER_RegisterAsRemoteProcedureCall(intRaknetInterface,Pchar(uniqueID),@ClassPointer,RaknetRPC.RPCCallbackMultiPlexer);
end;

procedure TRakPeer.RemoveFromBanList(const RakPeerIP: String);
begin
 TRAKPEER_RemoveFromBanList(intRaknetInterface,Pchar(RakPeerIP));
end;

procedure TRakPeer.RemoveRouterInterface(RouterInterface: TRakRouter);
begin
  TRAKPEER_RemoveRouterInterface(intRaknetInterface,RouterInterface);
end;

function TRakPeer.RPCBitStream(const uniqueID: String; BitStream: TRakBitStream;
  priority: TPacketPriority; reliability: TPacketReliability;
  orderingChannel: byte; PlayerID: TRakPlayerID; broadcast,
  shiftTimestamp: boolean; NetworkID: TRakNetworkID;
  bsreplyFromTarget: TRakBitStream): boolean;
begin
       Result := TRAKPEER_RPCBitStream(intRaknetInterface,Pchar(uniqueID),BitStream.RaknetInterface,
            integer(priority),integer(reliability),orderingChannel,PlayerID.RaknetInterface,broadcast,shiftTimestamp,NetworkID.RaknetInterface,bsreplyFromTarget.RaknetInterface);

end;

function TRakPeer.RPCBuffer(const uniqueID: String; data: Pchar;
  bitLength: cardinal; priority: TPacketPriority;
  reliability: TPacketReliability; orderingChannel: byte;
  PlayerID: TRakPlayerID; broadcast, shiftTimestamp: boolean;
  NetworkID: TRakNetworkID; BsreplyFromTarget: TRakBitStream): boolean;
begin
   Result := TRAKPEER_RPCBuffer(intRaknetInterface,Pchar(uniqueID),data,bitLength,
            integer(priority),integer(reliability),orderingChannel,PlayerID.RaknetInterface,broadcast,shiftTimestamp,NetworkID.RaknetInterface,bsreplyFromTarget.RaknetInterface);

end;

function TRakPeer.SendBitStream(BitStream: TRakBitStream;
  priority: TPacketPriority; reliability: TPacketReliability;
  orderingChannel: byte; PlayerID: TRakPlayerID; broadcast: boolean): boolean;
begin
    Result := TRAKPEER_SendBitStream(intRaknetInterface,BitStream.RaknetInterface,integer(priority),integer(reliability),orderingChannel,PlayerID.RaknetInterface,broadcast);

end;

function TRakPeer.SendBuffer(data: Pchar; bytelength: integer;
  priority: TPacketPriority; reliability: TPacketReliability;
  orderingChannel: byte; PlayerID: TRakPlayerID; broadcast: boolean): boolean;
begin
    Result := TRAKPEER_SendBuffer(intRaknetInterface,data,bytelength,integer(priority),integer(reliability),orderingChannel,PlayerID.RaknetInterface,broadcast);

end;

procedure TRakPeer.SendStaticData(PlayerID: TRakPlayerID);
begin
  TRAKPEER_SendStaticData(intRaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakPeer.SetCompileFrequencyTable(doCompile: boolean);
begin
  TRAKPEER_SetCompileFrequencyTable(intRaknetInterface,doCompile);
end;

procedure TRakPeer.SetIncomingPassword(const passwordData: String;
  passwordDataLength: integer);
begin
  TRAKPEER_SetIncomingPassword(intRaknetInterface,Pchar(passwordData),Length((passwordData)));
end;



procedure TRakPeer.SetMaximumIncomingConnections(numberAllowed: word);
begin
  TRAKPEER_SetMaximumIncomingConnections(intRaknetInterface,numberAllowed);
end;

function TRakPeer.SetMTUSize(size: integer): boolean;
begin
  Result := TRAKPEER_SetMTUSize(intRaknetInterface,size);
end;

procedure TRakPeer.SetOccasionalPing(doPing: boolean);
begin
  TRAKPEER_SetOccasionalPing(intRaknetInterface,doPing);
end;

procedure TRakPeer.SetOfflinePingResponse(data: Pchar; bytelength: cardinal);
begin
  TRAKPEER_SetOfflinePingResponse(intRaknetInterface,data,bytelength);
end;

procedure TRakPeer.SetRaknetInterface(const Value: TRakInterface);
begin
 if IntRaknetInterface<>nil then
     UnInitClientInterface(IntRaknetInterface);
    IntRaknetInterface:=Value;
end;

procedure TRakPeer.SetRemoteStaticData(PlayerID: TRakPlayerID; data: Pchar;
  bytelength: integer);
begin
  TRAKPEER_SetRemoteStaticData(intRaknetInterface,PlayerID.RaknetInterface,data,bytelength);
end;

procedure TRakPeer.SetRouterInterface(RouterInterface: TRakRouter);
begin
  TRAKPEER_SetRouterInterface(intRaknetInterface,RouterInterface.RaknetInterface);
end;

procedure TRakPeer.SetSplitMessageProgressInterval(interval: integer);
begin
 TRAKPEER_SetSplitMessageProgressInterval(intRaknetInterface,interval);
end;

procedure TRakPeer.SetTimeoutTime(timeMS: cardinal; PlayerID:TRakPlayerID);
begin
 TRAKPEER_SetTimeoutTime(intRaknetInterface,timeMS,PlayerID.RaknetInterface);
end;

procedure TRakPeer.SetUnreliableTimeout(timeoutMS: cardinal);
begin
 TRAKPEER_SetUnreliableTimeout(intRaknetInterface,timeoutMS);
end;

procedure TRakPeer.UnregisterAsRemoteProcedureCall(const uniqueID: String);
begin
 TRAKPEER_UnregisterAsRemoteProcedureCall(intRaknetInterface,Pchar(uniqueID));
end;

end.
