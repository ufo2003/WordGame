unit RaknetRPC;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Remote Procedure Callbacks

 Delphi wrapper and c port author : Joe Oszlanczi (BigJoe)
                                    Hungary
                                    raknetwrapper@freemail.hu
                                    Please send me any error report
 Wrapper version :  0.13

 This source published under GPL - General public license

 Original right visit www.rakkarsoft.com


 Usage :

            If you want RPC callback in your project ,
            used class need inherit from TRakRPCParameterClass

}
{=============================================================================}
interface

uses RaknetStruct,
     RaknetTypes,
     RaknetBitStream;


{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type

   

  // base class of rpcparameter record
  TRakRPCParameter=class(TRaknetInterfaceAbstract)
   private
   protected
    procedure    SetRaknetInterface(const Value: TRakInterface); override;
   public
    function  Input:pchar;
    function  NumberOfBitsOfData:cardinal;
    function  Sender:TRakPlayerID;   {playerid}
    procedure Recipient(RakConnection:TRaknetInterfaceAbstract); { pointer to class client,server or peer}
    function  ReplyToSender:TRakBitStream; { bitstream}
   end;


   TRPCCallbackObj = procedure (rpcParms:TRakRPCParameter)of object;


   TRakRPCParameterClass=class
   protected
   public
     procedure   RpcCallback(rpcParms:TRakRPCParameter); virtual;
   end;


   // multiplexer class object dont change
   procedure RPCCallbackMultiPlexer(OClass:Pointer;Param:TRakInterface); stdcall;

implementation
uses  RaknetDLL,
      RaknetInterface;


var   IntRPCMultiPlex:TRakRPCParameter;
      
{ TRakRPCParameter }



function TRakRPCParameter.Input: pchar;
begin
  Result := TRAKRPCParameters_Input(IntRaknetInterface);
end;

function TRakRPCParameter.NumberOfBitsOfData: cardinal;
begin
 Result := TRAKRPCParameters_NumberOfBitsOfData(IntRaknetInterface);
end;


procedure TRakRPCParameter.Recipient(RakConnection: TRaknetInterfaceAbstract);
begin
   RakConnection.RaknetInterface := TRAKRPCParameters_Recipient(IntRaknetInterface);
end;

function TRakRPCParameter.ReplyToSender: TRakBitStream;
begin
  Result := TRakBitStream.Create;
  Result.RaknetInterface := TRAKRPCParameters_ReplyToSender(IntRaknetInterface);
end;

function TRakRPCParameter.Sender: TRakPlayerID;
begin
      Result := TRakPlayerID.Create;
      Result.RaknetInterface := TRAKRPCParameters_Sender(IntRaknetInterface);
end;

procedure TRakRPCParameter.SetRaknetInterface(const Value: TRakInterface);
begin
 IntRaknetInterface := Value;
end;



procedure RPCCallbackMultiPlexer(OClass:Pointer;Param:TRakInterface);
begin
  IntRPCMultiPlex.RaknetInterface := Param;
  TRakRPCParameterClass(OClass).RpcCallback(IntRPCMultiPlex);
end;

{ TRakRPCParameterClass }



procedure TRakRPCParameterClass.RpcCallback(rpcParms: TRakRPCParameter);
begin

end;

initialization
 IntRPCMultiPlex := TRakRPCParameter.CreateEmpty;

finalization
 IntRPCMultiPlex.ToNull;
 IntRPCMultiPlex.Free;

end.
