unit RaknetTCPInterface;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - TCP interface

 Delphi wrapper and c port author : Joe Oszlanczi (BigJoe)
                                    Hungary
                                    raknetwrapper@freemail.hu
                                    Please send me any error report
 Wrapper version :  0.13

 This source published under GPL - General public license

 Original right visit www.rakkarsoft.com

}
{=============================================================================}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

interface
 uses RaknetTypes,
      RaknetStruct;

 type

                 TRakTCPInterface = class(TRaknetInterfaceAbstract)
                  private
                  protected
                  public
                   function  Start               (port:word;maxIncomingConnections:word):boolean;
                   procedure Stop                ;
                   function  Connect             (const host:String;remotePort:Word):TRakPlayerID;
                   procedure Send                (Data:Pchar;dlength:cardinal;PlayerID:TRakPlayerID);
                   function  Receive             :TRakPacket; overload;
                   procedure Receive             (const Packet:TRakPacket); overload;
                   procedure CloseConnection     (const PlayerID:TRakPlayerID);
                   procedure DeallocatePacket    (var   Packet:TRakPacket);
                   procedure DeallocateIntPacket (const Packet:TRakPacket);
                   function  HasNewConnection    :TRakPlayerID;
                   function  HasLostConnection   :TRakPlayerID;
                   constructor Create;
                   destructor  Destroy; override;
                  end;





implementation
uses RaknetDLL,
     sysutils;


{ TRakTCPInterface }

procedure TRakTCPInterface.CloseConnection(const PlayerID: TRakPlayerID);
begin
  TRAKNETTCPInterface_CloseConnection(IntRaknetInterface,PlayerID.RaknetInterface);
end;

function TRakTCPInterface.Connect(const host: String;
  remotePort: Word): TRakPlayerID;
begin
  result := TRakPlayerID.CreateEmpty;
  Result.RaknetInterface := TRAKNETTCPInterface_Connect(IntRaknetInterface,Pchar(Host),remotePort);
end;

constructor TRakTCPInterface.Create;
begin                         
  IntRaknetInterface := TRAKNETTCPInterface_constructor;
  Assert((RaknetInterface<>nil),'TCP RaknetInterface is nil');
end;

procedure TRakTCPInterface.DeallocateIntPacket(const Packet: TRakPacket);
begin
 TRAKNETTCPInterface_DeallocatePacket(IntRaknetInterface,Packet.RaknetInterface);
end;

procedure TRakTCPInterface.DeallocatePacket(var Packet: TRakPacket);
begin
 TRAKNETTCPInterface_DeallocatePacket(IntRaknetInterface,Packet.RaknetInterface);
 FreeAndNil(Packet);
end;

destructor TRakTCPInterface.Destroy;
begin
  TRAKNETTCPInterface_destructor(IntRaknetInterface);
  inherited;
end;

function TRakTCPInterface.HasLostConnection: TRakPlayerID;
begin
  Result := TRakPlayerID.CreateEmpty;
  Result.RaknetInterface := TRAKNETTCPInterface_HasLostConnection(IntRaknetInterface);
end;

function TRakTCPInterface.HasNewConnection: TRakPlayerID;
begin
  Result := TRakPlayerID.CreateEmpty;
  Result.RaknetInterface := TRAKNETTCPInterface_HasNewConnection(IntRaknetInterface);
end;

procedure TRakTCPInterface.Receive(const Packet: TRakPacket);
begin
  Packet.RaknetInterface := TRAKNETTCPInterface_Receive(IntRaknetInterface);
end;

function TRakTCPInterface.Receive: TRakPacket;
begin
 Result := TRakPacket.CreateEmpty;
 Result.RaknetInterface := TRAKNETTCPInterface_Receive(IntRaknetInterface);
end;

procedure TRakTCPInterface.Send(Data: Pchar; dlength: cardinal;
  PlayerID: TRakPlayerID);
begin
  TRAKNETTCPInterface_Send(IntRaknetInterface,data,dlength,PlayerId.RaknetInterface);
end;

function TRakTCPInterface.Start(port, maxIncomingConnections: word): boolean;
begin
  Result := TRAKNETTCPInterface_Start(IntRaknetInterface,port,maxIncomingConnections);
end;

procedure TRakTCPInterface.Stop;
begin
 TRAKNETTCPInterface_Stop(IntRaknetInterface);
end;

end.
