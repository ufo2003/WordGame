unit RaknetRouter;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Router interface plugin

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
     RaknetStruct,
     RaknetSystemlist,
     RaknetPlugin,
     RaknetConnectionGraph;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type
             TRakRouter=class(TRakPlugin)
              private
              protected
                procedure    SetRaknetInterface(const Value: TRakInterface); override;
              public
               constructor Create;  override;
               destructor  Destroy; override;
               procedure   SetRestrictRoutingByType (restrict:boolean);
               procedure   AddAllowedType           (messageId:TPacketType);
               procedure   RemoveAllowedType        (messageId:TPacketType);
               function    SendToSystemList         (data:Pchar;bitLength:cardinal;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;SystemAddressList:TRakSystemList):boolean;
               function    Send                     (data:Pchar;bitLength:cardinal;priority:TPacketPriority;reliability:TPacketReliability;orderingChannel:byte;PlayerID:TRakPlayerID):boolean;
               procedure   SetConnectionGraph       (connectionGraph:TRakConnectionGraph);
             end;

implementation
uses RaknetDLL,
     RaknetInterface;

{ TRakRouter }

procedure TRakRouter.AddAllowedType(messageId: TPacketType);
begin
 TRAKNETROUTER_AddAllowedType(IntRaknetInterface,byte(messageID));
end;

constructor TRakRouter.Create;
begin
  IntRaknetInterface := InitRouter;
end;

destructor TRakRouter.Destroy;
begin
  if IntRaknetInterface<>nil then
   UnInitRouter(IntRaknetInterface);
end;



procedure TRakRouter.RemoveAllowedType(messageId: TPacketType);
begin
 TRAKNETROUTER_RemoveAllowedType(IntRaknetInterface,byte(messageId));
end;

function TRakRouter.Send(data: Pchar; bitLength: cardinal;
  priority: TPacketPriority; reliability: TPacketReliability;
  orderingChannel: byte; PlayerID: TRakPlayerID): boolean;
begin
 result := TRAKNETROUTER_Send(IntRaknetInterface,data,bitLength,integer(priority),integer(reliability),orderingChannel,PlayerID.RaknetInterface);
end;

function TRakRouter.SendToSystemList(data: Pchar; bitLength: cardinal;
  priority: TPacketPriority; reliability: TPacketReliability;
  orderingChannel: byte; SystemAddressList: TRakSystemList): boolean;
begin
 result := TRAKNETROUTER_SendToSystemList(IntRaknetInterface,data,bitLength,integer(priority),integer(reliability),orderingChannel,SystemAddressList.RaknetInterface);
end;

procedure TRakRouter.SetConnectionGraph(connectionGraph: TRakConnectionGraph);
begin
  TRAKNETROUTER_SetConnectionGraph(IntRaknetInterface,connectionGraph.RaknetInterface);
end;

procedure TRakRouter.SetRaknetInterface(const Value: TRakInterface);
begin

end;

procedure TRakRouter.SetRestrictRoutingByType(restrict: boolean);
begin
  TRAKNETROUTER_SetRestrictRoutingByType(IntRaknetInterface,restrict);
end;

end.
