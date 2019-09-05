unit RaknetConnectionGraph;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Connection Graph

 Delphi wrapper and c port author : Joe Oszlanczi (BigJoe)
                                    Hungary
                                    raknetwrapper@freemail.hu
                                    Please send me any error report
 Wrapper version :  0.13

 This source published under GPL - General public license

 Original right visit www.rakkarsoft.com


 Information :

  maximum 255 group avaliable
  internal interface dont rewrite

}
{=============================================================================}

interface
uses RaknetTypes,
     RaknetStruct;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type



            TRakConnectionGraph=class(TRaknetInterfaceAbstract)
              private
              protected
               procedure   SetRaknetInterface(const Value: TRakInterface); override;
              public
               constructor Create;
               Destructor  Destroy;
               procedure   SetPassword (const password:string);
               function    GetGraph    :TRakInterface;
               procedure   SetAutoAddNewConnections(autoAdd:boolean);
               procedure   RequestConnectionGraph(RakPeerInterface,PlayerID:TRaknetInterfaceAbstract);
               procedure   AddNewConnection (RakPeerInterface,PlayerID:TRaknetInterfaceAbstract;groupId:byte);
               procedure   SetGroupId (groupId:byte);
               procedure   SubscribeToGroup(groupId:byte);
               procedure   UnsubscribeFromGroup(groupId:byte);
            end;


implementation
uses RaknetDLL,
     RaknetInterface
     ;

{ TRakConnectionGraph }

procedure TRakConnectionGraph.AddNewConnection(RakPeerInterface,
  PlayerID: TRaknetInterfaceAbstract; groupId: byte);
begin
  
end;

constructor TRakConnectionGraph.Create;
begin
  IntRaknetInterface := TRAKNETConnGraph_constructor1;
end;

destructor TRakConnectionGraph.Destroy;
begin
   if IntRaknetInterface<>nil then   
   TRAKNETConnGraph_destructor(IntRaknetInterface);
end;

function TRakConnectionGraph.GetGraph: TRakInterface;
begin
 Result := TRAKNETConnGraph_GetGraph(IntRaknetInterface);
end;



procedure TRakConnectionGraph.RequestConnectionGraph(RakPeerInterface,
  PlayerID: TRaknetInterfaceAbstract);
begin
 TRAKNETConnGraph_RequestConnectionGraph(IntRaknetInterface,RakPeerInterface.RaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakConnectionGraph.SetAutoAddNewConnections(autoAdd: boolean);
begin
 TRAKNETConnGraph_SetAutoAddNewConnections(IntRaknetInterface,autoAdd);
end;

procedure TRakConnectionGraph.SetGroupId(groupId: byte);
begin
 TRAKNETConnGraph_SetGroupId(IntRaknetInterface,groupId);
end;

procedure TRakConnectionGraph.SetPassword(const password: string);
begin
 TRAKNETConnGraph_SetPassword(IntRaknetInterface,Pchar(password));
end;

procedure TRakConnectionGraph.SetRaknetInterface(const Value: TRakInterface);
begin

end;

procedure TRakConnectionGraph.SubscribeToGroup(groupId: byte);
begin
  TRAKNETConnGraph_SubscribeToGroup(IntRaknetInterface,groupId);
end;

procedure TRakConnectionGraph.UnsubscribeFromGroup(groupId: byte);
begin
  TRAKNETConnGraph_UnsubscribeFromGroup(IntRaknetInterface,groupId);
end;

end.
