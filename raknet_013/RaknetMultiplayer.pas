unit RaknetMultiplayer;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Multiplayer standard class

 Delphi wrapper and c port author : Joe Oszlanczi (BigJoe)
                                    Hungary
                                    raknetwrapper@freemail.hu
                                    Please send me any error report
 Wrapper version :  0.1

 This source published under GPL - General public license

 Original right visit www.rakkarsoft.com


 Information :

  multiplayer callback functions use  stdcall  !!!!!

}
{=============================================================================}


{ ---- information  -------

2007.02.09.       Finished Raknet Peer
2007.02.09.       Added get callback list



}


interface
uses RakNetStruct,
     RakNetTypes,
     RakNetServer,
     RakNetClient,
     RakNetPeer;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type



     TRaknetMultiplayerServer=class
     private
     protected
       MultiplayerInterface:TRakInterface;
     public
       Server:TRakServer;
       CallbackProcs:TMultiPlayerCallbackList;
       constructor Create;
       destructor  Destroy;  override;
       procedure   ProcessMessages;
       function    GetCallbackList:PTMultiPlayerCallbackList;
     end;

    TRaknetMultiplayerClient=class
     private
     protected
       MultiplayerInterface:TRakInterface;
     public
       Client:TRakClient;
       CallbackProcs:TMultiPlayerCallbackList;
       constructor Create;
       destructor  Destroy;  override;
       procedure   ProcessMessages;
       function    GetCallbackList:PTMultiPlayerCallbackList;

     end;


    TRaknetMultiplayerPeer=class
     private
     protected
       MultiplayerInterface:TRakInterface;
     public
       Peer:TRakPeer;
       CallbackProcs:TMultiPlayerCallbackList;
       function    GetCallbackList:PTMultiPlayerCallbackList;
       procedure   ProcessMessages;
       constructor Create;
       destructor  Destroy;  override;
     end;



implementation
uses RaknetDLL;

{===========================}
{ TRaknetMultiplayerServer }
{===========================}


constructor TRaknetMultiplayerServer.Create;
begin
  MultiplayerInterface := TRAKMULTIPLAYER_ServerConstructor;
  Server := TRakServer.CreateEmpty;
  TRaknetInterfaceAbstract(Server).RaknetInterface := TRAKMULTIPLAYER_GetInternalServer(MultiplayerInterface);
end;

destructor TRaknetMultiplayerServer.Destroy;
begin
  TRAKMULTIPLAYER_ServerDestructor(MultiplayerInterface);
  Server.ToNull;
  Server.Free;
end;

function TRaknetMultiplayerServer.GetCallbackList: PTMultiPlayerCallbackList;
begin
   Result := PTMultiPlayerCallbackList(TRAKMULTIPLAYER_GetCallbackServer(MultiplayerInterface));
end;

procedure TRaknetMultiplayerServer.ProcessMessages;
begin
 TRAKMULTIPLAYER_ProcessPacketsServer(MultiplayerInterface);
end;


{===========================}
{ TRaknetMultiplayerClient }
{===========================}

constructor TRaknetMultiplayerClient.Create;
begin
  MultiplayerInterface := TRAKMULTIPLAYER_ClientConstructor;
  Client := TRakClient.CreateEmpty;
  TRaknetInterfaceAbstract(Client).RaknetInterface := TRAKMULTIPLAYER_GetInternalClient(MultiplayerInterface);

end;

destructor TRaknetMultiplayerClient.Destroy;
begin
  TRAKMULTIPLAYER_ClientDestructor(MultiplayerInterface);
  Client.ToNull;
  Client.Free;
end;

function TRaknetMultiplayerClient.GetCallbackList: PTMultiPlayerCallbackList;
begin
 Result := PTMultiPlayerCallbackList( TRAKMULTIPLAYER_GetCallbackClient(MultiplayerInterface) );
end;

procedure TRaknetMultiplayerClient.ProcessMessages;
begin
 TRAKMULTIPLAYER_ProcessPacketsClient(MultiplayerInterface);
end;


{===========================}
{ TRaknetMultiplayerPeer }
{===========================}

constructor TRaknetMultiplayerPeer.Create;
begin
  MultiplayerInterface := TRAKMULTIPLAYER_PeerConstructor;
  Peer := TRakPeer.CreateEmpty;
  TRaknetInterfaceAbstract(Peer).RaknetInterface := TRAKMULTIPLAYER_GetInternalPeer(MultiplayerInterface);
end;

destructor TRaknetMultiplayerPeer.Destroy;
begin
  TRAKMULTIPLAYER_PeerDestructor(MultiplayerInterface);
  Peer.ToNull;
  Peer.Free;
end;

function TRaknetMultiplayerPeer.GetCallbackList: PTMultiPlayerCallbackList;
begin
  Result := PTMultiPlayerCallbackList(TRAKMULTIPLAYER_GetCallbackPeer(MultiplayerInterface) );
end;

procedure TRaknetMultiplayerPeer.ProcessMessages;
begin
 TRAKMULTIPLAYER_ProcessPacketsPeer(MultiplayerInterface);
end;

end.
