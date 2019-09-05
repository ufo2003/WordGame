unit RaknetClient;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Raknet Client server interface

 Delphi wrapper and c port author : Joe Oszlanczi (BigJoe)
                                    Hungary
                                    raknetwrapper@freemail.hu
                                    Please send me any error report
 Wrapper version :  0.13

 This source published under GPL - General public license

 Original right visit www.rakkarsoft.com


 Information :


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

TRakClient = class(TRaknetInterfaceAbstract)
 private
    procedure    SetRaknetInterface(const Value: TRakInterface); override;
    function     GetInterface: TRakInterface;
 protected

 public
   constructor Create;
   destructor  Destroy;
   function    Connect                              (const host:String;serverPort,clientPort:word;depreciated,threadSleepTimer:integer):boolean;
   procedure   Disconnect                           (blockDuration:cardinal;orderingChannel:byte);
   procedure   SetPassword                          (const _password:string);
   function    HasPassword                          :boolean;
   function    SendBuffer                           (data:pchar;bytelength:integer;priority:TPacketPriority;reliability:TPacketReliability ;orderingChannel:byte):boolean;
   function    SendBitStream                        (BitStream:TRakBitStream;priority:TPacketPriority;reliability:TPacketReliability ;orderingChannel:byte):boolean;
   function    Receive                              :TRakPacket;   overload;
   procedure   Receive                              (Packet:TRakPacket); overload;
   procedure   DeallocatePacket                     (Packet:TRakPacket);
   procedure   PingServer                           ;
   procedure   PingServerHost                       (const host:String;ServerPort,ClientPort:word;onlyReplyOnAcceptingConnections:boolean);
   function    GetAveragePing                       :integer;
   function    GetLastPing                          :integer;
   function    GetLowestPing                        :integer;
   function    GetPlayerPing                        (PlayerID:TRakPlayerID):integer;
   procedure   StartOccasionalPing                  ;
   procedure   StopOccasionalPing                   ;
   function    IsConnected                          :boolean;
   function    GetSynchronizedRandomInteger         :cardinal;
   function    GenerateCompressionLayer             (inputFrequencyTable:PFrequencyTable;inputLayer:boolean):boolean;
   function    DeleteCompressionLayer               (inputLayer:boolean):boolean;
   procedure   SetTrackFrequencyTable               (b:boolean);
   function    GetSendFrequencyTable                (outputFrequencyTable:PFrequencyTable):boolean;
   function    GetCompressionRatio                  :single;
   function    GetDecompressionRatio                :single;
   function    GetStaticServerData                  ():TRakBitStream;
   procedure   SetStaticServerData                  (data:Pchar;bytelength:integer);
   function    GetStaticClientData                  (PlayerID:TRakPlayerID):TRakBitStream;
   procedure   SetStaticClientData                  (PlayerID:TRakPlayerID;data:Pchar;bytelength:integer);
   procedure   SendStaticClientDataToServer         ;
   function    GetServerID                          ():TRakPlayerID;
   function    GetPlayerID                          ():TRakPlayerID;
   function    GetInternalID                        ():TRakPlayerID;
   function    PlayerIDToDottedIP                   (PlayerID:TRakPlayerID):string;
   procedure   PushBackPacket                       (Packet:TRakPacket;pushAtHead:boolean);
   procedure   SetTimeoutTime                       (timeMS:cardinal);
   function    SetMTUSize                           (size:integer):boolean;
   function    GetMTUSize                           :integer;
   procedure   AllowConnectionResponseIPMigration   (allow:boolean);
   procedure   AdvertiseSystem                      (const host:string;remotePort:word;data:Pchar;dataLength:integer);
   function    GetStatistics                        :PRakNetStatisticsStruct;
   procedure   ApplyNetworkSimulator                (maxSendBPS:double;minExtraPing,extraPingVariance:word);
   function    IsNetworkSimulatorActive             :boolean;
   function    GetPlayerIndex                       :word;
   procedure   DisableSecurity                      ;
   procedure   InitializeSecurity                   (const privKeyP,privKeyQ:String);
   procedure   UnregisterAsRemoteProcedureCall      (const uniqueID:string);
   procedure   RegisterAsRemoteProcedureCall        (const uniqueID: string;ClassPointer:pointer;Callback:TRPCCallbackObj);
   function    RPCFromBuffer                        (uniqueID:string;data:Pchar;bitLength:cardinal;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;shiftTimestamp:boolean;BitStreamReplyFromTarget:TRakBitStream):boolean;
   function    RPCFromBitStream                     (uniqueID:string;BitStream:TRakBitStream;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;shiftTimestamp:boolean;BitStreamReplyFromTarget:TRakBitStream):boolean;
   procedure   AttachPlugin                         (const Plugin:TRakPlugin);
   procedure   DetachPlugin                         (const Plugin:TRakPlugin);

end;

implementation

uses RaknetDLL,
     RaknetInterface;

{ TRakClient }

procedure TRakClient.AdvertiseSystem(const host: string; remotePort: word;
  data: Pchar; dataLength: integer);
begin
  TRAKCLIENT_AdvertiseSystem(RaknetInterface,Pchar(Host),remotePort,data,dataLength);
end;

procedure TRakClient.AllowConnectionResponseIPMigration(allow: boolean);
begin
 TRAKCLIENT_AllowConnectionResponseIPMigration(RaknetInterface,allow);
end;

procedure TRakClient.ApplyNetworkSimulator(maxSendBPS: double; minExtraPing,
  extraPingVariance: word);
begin
 TRAKCLIENT_ApplyNetworkSimulator(RaknetInterface,maxSendBPS,minExtraPing,extraPingVariance);
end;

procedure TRakClient.AttachPlugin(const Plugin: TRakPlugin);
begin
  TRAKCLIENT_AttachPlugin(RaknetInterface,Plugin.RaknetInterface);
end;

function TRakClient.Connect(const host: String; serverPort, clientPort: word;
  depreciated, threadSleepTimer: integer): boolean;
begin
  result := TRAKCLIENT_Connect(RaknetInterface,Pchar(Host),serverPort,clientPort,depreciated,threadSleepTimer);
end;

constructor TRakClient.Create;
begin
 RaknetInterface := TRAKNET_InitClientInterface; 
end;

procedure TRakClient.DeallocatePacket(Packet: TRakPacket);
begin
  TRAKCLIENT_DeallocatePacket(RaknetInterface,Packet.RaknetInterface);
end;

function TRakClient.DeleteCompressionLayer(inputLayer: boolean): boolean;
begin
  Result := TRAKCLIENT_DeleteCompressionLayer(RaknetInterface,inputLayer);    

end;

destructor TRakClient.Destroy;
begin
  if RaknetInterface<>nil then  
  TRAKNET_UnInitClientInterface(RaknetInterface);
end;

procedure TRakClient.DetachPlugin(const Plugin: TRakPlugin);
begin
  TRAKCLIENT_DetachPlugin(RaknetInterface,Plugin.RaknetInterface);
end;

procedure TRakClient.DisableSecurity;
begin
  TRAKCLIENT_DisableSecurity(RaknetInterface);
end;

procedure TRakClient.Disconnect(blockDuration: cardinal; orderingChannel: byte);
begin
  TRAKCLIENT_Disconnect(RaknetInterface,blockDuration,orderingChannel);
end;

function TRakClient.GenerateCompressionLayer(
  inputFrequencyTable: PFrequencyTable; inputLayer: boolean): boolean;
begin
  Result := TRAKCLIENT_GenerateCompressionLayer(RaknetInterface,RaknetInterface,inputLayer);
end;

function TRakClient.GetAveragePing: integer;
begin
  Result := TRAKCLIENT_GetAveragePing(RaknetInterface);
end;

function TRakClient.GetCompressionRatio: single;
begin
  Result := TRAKCLIENT_GetCompressionRatio(RaknetInterface);
end;

function TRakClient.GetDecompressionRatio: single;
begin
  Result := TRAKCLIENT_GetCompressionRatio(RaknetInterface);
end;

function TRakClient.GetInterface: TRakInterface;
begin
 Result := RaknetInterface;
end;

function TRakClient.GetInternalID: TRakPlayerID;
begin
      Result := TRakPlayerID.Create;
      Result.RaknetInterface := TRAKCLIENT_GetInternalID(RaknetInterface);
      if Result.RaknetInterface=nil then
       begin
          Result.Destroy;
          Result := nil;
       end;
      Assert((Result.RaknetInterface<>nil),'Client GetInternalID');
end;

function TRakClient.GetLastPing: integer;
begin
   Result := TRAKCLIENT_GetLastPing(RaknetInterface);
end;

function TRakClient.GetLowestPing: integer;
begin
  REsult := TRAKCLIENT_GetLowestPing(RaknetInterface);
end;

function TRakClient.GetMTUSize: integer;
begin
 Result := TRAKCLIENT_GetMTUSize(RaknetInterface);
end;

function TRakClient.GetPlayerID: TRakPlayerID;
begin
      Result := TRakPlayerID.Create;
      Result.RaknetInterface := TRAKCLIENT_GetPlayerID(RaknetInterface);
      if Result.RaknetInterface=nil then
       begin
          Result.Destroy;
          Result := nil;
       end;
      Assert((Result.RaknetInterface<>nil),'Client GetInternalID');
end;

function TRakClient.GetPlayerIndex: word;
begin
   Result := TRAKCLIENT_GetPlayerIndex(RaknetInterface);
end;

function TRakClient.GetPlayerPing(PlayerID: TRakPlayerID): integer;
begin
  Result := TRAKCLIENT_GetPlayerPing(RaknetInterface,PlayerID.RaknetInterface);
end;

function TRakClient.GetSendFrequencyTable(
  outputFrequencyTable: PFrequencyTable): boolean;
begin
 Result := TRAKCLIENT_GetSendFrequencyTable(RaknetInterface,Pchar(outputFrequencyTable));
end;

function TRakClient.GetServerID: TRakPlayerID;
begin
      Result := TRakPlayerID.Create;
      Result.RaknetInterface := TRAKCLIENT_GetServerID(RaknetInterface);
      if Result.RaknetInterface=nil then
       begin
          Result.Destroy;
          Result := nil;
       end;
      Assert((Result.RaknetInterface<>nil),'Client GetServerID');
end;

function TRakClient.GetStaticClientData(PlayerID: TRakPlayerID): TRakBitStream;
var TempInt:TRakInterface;
begin
    Result  := nil;
    TempInt := TRAKCLIENT_GetStaticClientData(RaknetInterface,PlayerID.RaknetInterface);
    if TempInt<>nil then
     begin
       Result := TRakBitStream.Create;
       Result.RaknetInterface := TempInt;
     end;
end;

function TRakClient.GetStaticServerData: TRakBitStream;
var TempInt:TRakInterface;
begin
    Result  := nil;
    TempInt := TRAKCLIENT_GetStaticServerData(RaknetInterface);
    if TempInt<>nil then
     begin
       Result := TRakBitStream.Create;
       Result.RaknetInterface := TempInt;
     end;
end;

function TRakClient.GetStatistics: PRakNetStatisticsStruct;
begin
  Result := PRakNetStatisticsStruct(TRAKCLIENT_GetStatistics(RaknetInterface));
end;

function TRakClient.GetSynchronizedRandomInteger: cardinal;
begin
   Result := TRAKCLIENT_GetSynchronizedRandomInteger(RaknetInterface);
end;

function TRakClient.HasPassword: boolean;
begin
   Result := TRAKCLIENT_HasPassword(RaknetInterface);
end;

procedure TRakClient.InitializeSecurity(const privKeyP, privKeyQ: String);
begin
  TRAKCLIENT_InitializeSecurity(RaknetInterface,Pchar(privKeyP),Pchar(PrivKeyQ));
end;

function TRakClient.IsConnected: boolean;
begin
   Result := TRAKCLIENT_IsConnected(RaknetInterface);
end;

function TRakClient.IsNetworkSimulatorActive: boolean;
begin
  Result  := TRAKCLIENT_IsNetworkSimulatorActive(RaknetInterface);
end;

procedure TRakClient.PingServer;
begin
  TRAKCLIENT_PingServer(RaknetInterface);
end;

procedure TRakClient.PingServerHost(const host: String; ServerPort,
  ClientPort: word; onlyReplyOnAcceptingConnections: boolean);
begin
  TRAKCLIENT_PingServerHost(RaknetInterface,Pchar(host),ServerPort,ClientPort,onlyReplyOnAcceptingConnections);
end;

function TRakClient.PlayerIDToDottedIP(PlayerID: TRakPlayerID): string;
begin
  Result := string(TRAKCLIENT_PlayerIDToDottedIP(RaknetInterface,PlayerID.RaknetInterface));
end;

procedure TRakClient.PushBackPacket(Packet: TRakPacket; pushAtHead: boolean);
begin
  TRAKCLIENT_PushBackPacket(RaknetInterface,Packet.RaknetInterface,pushAtHead);
end;

function TRakClient.Receive: TRakPacket;
var TempInt:TRakInterface;
begin
    Result  := nil;
    TempInt := TRAKCLIENT_Receive(RaknetInterface);
    if TempInt<>nil then
     begin
       Result := TRakPacket.Create;
       Result.RaknetInterface := TempInt;
     end;                 
end;



procedure TRakClient.Receive(Packet: TRakPacket);
begin
    Packet.RaknetInterface := TRAKCLIENT_Receive(RaknetInterface);
end;

procedure TRakClient.RegisterAsRemoteProcedureCall(const uniqueID: string;ClassPointer:pointer;Callback:TRPCCallbackObj);
begin
 TRAKCLIENT_RegisterAsRemoteProcedureCall(RaknetInterface,Pchar(uniqueID),ClassPointer,RaknetRPC.RPCCallbackMultiPlexer);
end;


function TRakClient.RPCFromBitStream(uniqueID:string; BitStream: TRakBitStream;
  priority:TPacketPriority;reliability:TPacketReliability; orderingChannel: byte;
  shiftTimestamp: boolean; BitStreamReplyFromTarget:TRakBitStream): boolean;
begin
  Result := TRAKCLIENT_RPCFromBitStream(RaknetInterface,Pchar(uniqueID),BitStream.RaknetInterface,
            integer(priority),integer(reliability),orderingChannel,shiftTimestamp,BitStreamReplyFromTarget.RaknetInterface);
end;

function TRakClient.RPCFromBuffer(uniqueID:string;data: Pchar; bitLength: cardinal;
  priority:TPacketPriority;reliability:TPacketReliability; orderingChannel: byte;
  shiftTimestamp: boolean; BitStreamReplyFromTarget: TRakBitStream): boolean;
begin
  Result := TRAKCLIENT_RPCFromBuffer(RaknetInterface,Pchar(uniqueID),data,bitLength,
            integer(priority),integer(reliability),orderingChannel,shiftTimestamp,BitStreamReplyFromTarget.RaknetInterface);
end;

function TRakClient.SendBitStream(BitStream: TRakBitStream;
  priority: TPacketPriority; reliability: TPacketReliability;
  orderingChannel: byte): boolean;
begin
  Result := TRAKCLIENT_SendBitStream(RaknetInterface,BitStream.RaknetInterface,integer(priority),integer(reliability),orderingChannel);
end;

function TRakClient.SendBuffer(data: pchar; bytelength:integer;
  priority: TPacketPriority; reliability: TPacketReliability;
  orderingChannel: byte): boolean;
begin
  Result := TRAKCLIENT_SendBuffer(RaknetInterface,data,bytelength,integer(priority),integer(reliability),orderingChannel);
end;

procedure TRakClient.SendStaticClientDataToServer;
begin
  TRAKCLIENT_SendStaticClientDataToServer(RaknetInterface);
end;


function TRakClient.SetMTUSize(size: integer): boolean;
begin
  Result := TRAKCLIENT_SetMTUSize(RaknetInterface,Size);
end;

procedure TRakClient.SetPassword(const _password: string);
begin
  TRAKCLIENT_SetPassword(RaknetInterface,Pchar(_password));
end;

procedure TRakClient.SetRaknetInterface(const Value: TRakInterface);
begin
  if RaknetInterface<>nil then
     UnInitClientInterface(RaknetInterface);
  IntRaknetInterface:=Value;
end;

procedure TRakClient.SetStaticClientData(PlayerID: TRakPlayerID; data: Pchar;
  bytelength: integer);
begin
  TRAKCLIENT_SetStaticClientData(RaknetInterface,PlayerID.RaknetInterface,data,bytelength);
end;

procedure TRakClient.SetStaticServerData(data: Pchar; bytelength: integer);
begin
  TRAKCLIENT_SetStaticServerData(RaknetInterface,data,bytelength);
end;

procedure TRakClient.SetTimeoutTime(timeMS: cardinal);
begin
  TRAKCLIENT_SetTimeoutTime(RaknetInterface,timeMS);
end;

procedure TRakClient.SetTrackFrequencyTable(b: boolean);
begin
  TRAKCLIENT_SetTrackFrequencyTable(RaknetInterface,b);
end;

procedure TRakClient.StartOccasionalPing;
begin
  TRAKCLIENT_StartOccasionalPing(RaknetInterface);
end;

procedure TRakClient.StopOccasionalPing;
begin
  TRAKCLIENT_StopOccasionalPing(RaknetInterface)
end;

procedure TRakClient.UnregisterAsRemoteProcedureCall(const uniqueID: string);
begin
  TRAKCLIENT_UnregisterAsRemoteProcedureCall(IntRaknetInterface,Pchar(uniqueID));
end;

end.
