unit RakNetStruct;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Raknet internal structures

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

uses RaknetTypes,
     RaknetBitStream,
     Sysutils;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type


  // ------------------------------------
 //
 // Player ID struct
 //
 // ------------------------------------
 TRakPlayerID = class(TRaknetInterfaceAbstract)
   private
   protected
    procedure    SetRaknetInterface(const Value: TRakInterface); override;
   public
   function  binaryAddress:cardinal;
   function  port:word;
   function  tostring(const writeport:boolean):String;
 end;


 // ------------------------------------
 //
 // Packet struct
 //
 // ------------------------------------

 TRakPacket=class (TRaknetInterfaceAbstract)
   private
   protected
    procedure    SetRaknetInterface(const Value: TRakInterface); override;
   public
   function   PlayerIndex:word;
   function   PlayerID:TRakPlayerID;
   function   Length:cardinal;
   function   bitSize:cardinal;
   function   data:pchar;
   function   AsBitStream:TRakBitStream;
 end;



 // ------------------------------------
 //
 // Network id struct
 //
 // ------------------------------------

   TRakNetworkID=class(TRaknetInterfaceAbstract)
     protected
      procedure    SetRaknetInterface(const Value: TRakInterface); override;
     public
      function  PeerToPeerMode:boolean;
      procedure PlayerID(RakPlayerID:TRaknetInterfaceAbstract);
      function  LocalSystemID:word;
   end;


   // use for server broadcasting
   function   GetUnAssignedPlayerID       : TRakPlayerID;
   procedure  ConvertRaknetStatToStr(stat:PRakNetStatisticsStruct;var ReturnStr:string;verbosityLevel:integer);





implementation
uses RaknetDLL;


   function   GetUnAssignedPlayerID       : TRakPlayerID;
   begin
      Result := TRakPlayerID.Create;
      Result.RaknetInterface := TRAKNET_GetUnAssignedPlayerID;
      if Result.RaknetInterface =nil then
       begin
          Result.Destroy;
          Result := nil;
       end;
      Assert((Result.RaknetInterface<>nil),'Unassigned playerid is nil');
   end;

   procedure  ConvertRaknetStatToStr(stat:PRakNetStatisticsStruct;var ReturnStr:string;verbosityLevel:integer);
   begin
     SetLength(ReturnStr,1024);
     TRAKNETSTAT_ConvertToString(Pchar(stat),Pchar(returnStr),verbosityLevel);
     ReturnStr := StringReplace(ReturnStr,#10,#13#10,[rfReplaceAll]);
   end;

{ TRakPacket }

function TRakPacket.AsBitStream: TRakBitStream;
begin
  Result := TRakBitStream.Create(TRAKPacket_data(IntRaknetInterface),TRAKPacket_Length(IntRaknetInterface),false);
end;

function TRakPacket.bitSize: cardinal;
begin
 Result := TRAKPacket_bitSize(IntRaknetInterface);
end;


function TRakPacket.data: pchar;
begin
 Result := TRAKPacket_data(IntRaknetInterface);
end;


function TRakPacket.Length: cardinal;
begin
 Result := TRAKPacket_Length(IntRaknetInterface);
end;

function TRakPacket.PlayerID: TRakPlayerID;
begin
      Result := TRakPlayerID.Create;
      Result.IntRaknetInterface := TRAKPacket_PlayerID(IntRaknetInterface);
end;

function TRakPacket.PlayerIndex: word;
begin
 Result := TRAKPacket_PlayerIndex(IntRaknetInterface);
end;

procedure TRakPacket.SetRaknetInterface(const Value: TRakInterface);
begin
  IntRaknetInterface := Value;
end;

{ TRakPlayerID }

function TRakPlayerID.binaryAddress: cardinal;
begin
  Result := TRAKPlayerID_binaryAddress(IntRaknetInterface);
end;


function TRakPlayerID.port: word;
begin
  Result := TRAKPlayerID_port(IntRaknetInterface);
end;

procedure TRakPlayerID.SetRaknetInterface(const Value: TRakInterface);
begin
 IntRaknetInterface := Value;
end;

function TRakPlayerID.tostring(const writeport: boolean): String;
begin
    Result := string(TRAKPlayerID_tostring(IntRaknetInterface,writeport));
end;



{ TRakNetworkID }

function TRakNetworkID.LocalSystemID: word;
begin
  Result := TRAKNETWORKID_localSystemId(IntRaknetInterface);
end;

function TRakNetworkID.PeerToPeerMode: boolean;
begin
  Result := TRAKNETWORKID_peerToPeerMode(IntRaknetInterface);
end;


procedure TRakNetworkID.SetRaknetInterface(const Value: TRakInterface);
begin
    IntRaknetInterface := Value;
end;

procedure TRakNetworkID.PlayerID(RakPlayerID:TRaknetInterfaceAbstract);
begin
      RakPlayerID.RaknetInterface := TRAKNETWORKID_playerId(IntRaknetInterface);
end;

end.
