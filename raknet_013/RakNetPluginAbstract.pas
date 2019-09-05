unit RakNetPluginAbstract;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Raknet plugin abstract layer

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
uses RakNetTypes,
     RakNetPlugin,
     RakNetStruct,
     RakNetPeer;


type

     TPluginReceiveResult =
 (
	// The plugin used this message and it shouldn't be given to the user.
	RR_STOP_PROCESSING_AND_DEALLOCATE=0,

	// This message will be processed by other plugins, and at last by the user.
	RR_CONTINUE_PROCESSING,

	// The plugin is going to hold on to this message.  Do not deallocate it but do not pass it to other plugins either.
	RR_STOP_PROCESSING
 );



            TRakMainPlugin=class(TRakPlugin)
               private
                 DCallList : PTPluginInternalCalllist;
               public
                  constructor Create; override;
                  destructor  Destroy; override;
                  procedure   OnAttach (RakPeer:TRakPeer); virtual; abstract;
	            procedure   OnDetach (RakPeer:TRakPeer); virtual; abstract;
	            procedure   OnInitialize(RakPeer:TRakPeer); virtual; abstract;
	            procedure   Update (RakPeer:TRakPeer); virtual; abstract;
	            function    OnReceive (RakPeer:TRakPeer;Packet:TRakPacket):TPluginReceiveResult; virtual;
	            procedure   OnDisconnect (DelphiClass,RakPeer:TRakInterface); virtual; abstract;
	            procedure   OnCloseConnection(RakPeer:TRakPeer;PlayerID:TRakPlayerID); virtual; abstract;
	            procedure   OnDirectSocketSend(data:Pchar;bitsUsed:cardinal;PlayerID:TRakPlayerID);  virtual; abstract;
	            procedure   OnDirectSocketReceive(data:Pchar;bitsUsed:cardinal;PlayerID:TRakPlayerID); virtual; abstract;
               end;


implementation
uses RaknetDLL;

var  IntPlugInPeer:TRakPeer;
     IntPlugInPacket:TRakPacket;
     IntPlugInPlayerID:TRakPlayerID;

{ internal plugin multiplexer }

  	procedure DelphiOnAttach (DelphiClass,RakPeer:TRakInterface); stdcall;
      begin
        IntPlugInPeer.RaknetInterface := RakPeer;
        TRakMainPlugin(DelphiClass).OnAttach(IntPlugInPeer);
        IntPlugInPeer.ToNull;
      end;

	procedure DelphiOnDetach (DelphiClass,RakPeer:TRakInterface);   stdcall;
      begin
        IntPlugInPeer.RaknetInterface := RakPeer;
        TRakMainPlugin(DelphiClass).OnDetach(IntPlugInPeer);
        IntPlugInPeer.ToNull;
      end;

	procedure DelphiOnInitialize (DelphiClass,RakPeer:TRakInterface); stdcall;
      begin
        IntPlugInPeer.RaknetInterface := RakPeer;
        TRakMainPlugin(DelphiClass).OnInitialize(IntPlugInPeer);
        IntPlugInPeer.ToNull;
      end;

	procedure DelphiUpdate (DelphiClass,RakPeer:TRakInterface);  stdcall;
      begin
        IntPlugInPeer.RaknetInterface := RakPeer;
        TRakMainPlugin(DelphiClass).Update(IntPlugInPeer);
        IntPlugInPeer.ToNull;
      end;

	function DelphiOnReceive (DelphiClass,RakPeer,Packet:TRakInterface):cardinal; stdcall;
      begin
        IntPlugInPeer.RaknetInterface := RakPeer;
        IntPlugInPacket.RaknetInterface := Packet;
        Result := cardinal(TRakMainPlugin(DelphiClass).OnReceive(IntPlugInPeer,intPlugInPacket));
        IntPlugInPeer.ToNull;
      end;

	procedure DelphiOnDisconnect (DelphiClass,RakPeer:TRakInterface); stdcall;
      begin
        IntPlugInPeer.RaknetInterface := RakPeer;
        TRakMainPlugin(DelphiClass).OnDisconnect(IntPluginPeer,IntPlugInPeer);
        IntPlugInPeer.ToNull;
      end;

	procedure DelphiOnCloseConnection (DelphiClass,RakPeer,PlayerID:TRakInterface);  stdcall;
	begin
        IntPlugInPeer.RaknetInterface := RakPeer;
        IntPlugInPlayerID.RaknetInterface := PlayerID;
        TRakMainPlugin(DelphiClass).OnCloseConnection(IntPluginPeer,IntPlugInPlayerID);
     end;

      procedure DelphiOnDirectSocketSend (DelphiClass:TRakInterface;data:Pchar;bitsUsed:cardinal;PlayerID:TRakInterface);    stdcall;
      begin
        IntPlugInPlayerID.RaknetInterface := PlayerID;
        TRakMainPlugin(DelphiClass).OnDirectSocketSend(data,bitsUsed,IntPlugInPlayerID);
      end;

	procedure DelphiOnDirectSocketReceive (DelphiClass:TRakInterface;data:Pchar;bitsUsed:cardinal;PlayerID:TRakInterface);   stdcall;
      begin
        IntPlugInPlayerID.RaknetInterface := PlayerID;
        TRakMainPlugin(DelphiClass).OnDirectSocketReceive(data,bitsUsed,IntPlugInPlayerID);
      end;

      // dont supported now
	procedure DelphiOnInternalPacket(DelphiClass:TRakInterface;InternalPacket:PInternalPacket;frameNumber:cardinal;PlayerID:TRakInterface;Time:cardinal;isSend:boolean); stdcall;
      begin

      end;



{ TRakMainPlugin }

constructor TRakMainPlugin.Create;
begin
 IntRaknetInterface := TRAKNETPluginDelphi_constructor;
 DCallList := PTPluginInternalCalllist(TRAKNETPluginDelphi_GetCallbackList(IntRaknetInterface));
 Assert((DCallList<>nil),'Plugin Callback pointer is nil');

 with DCallList^ do
  begin
 	FOnAttach         := DelphiOnAttach;
	FOnDetach         := DelphiOnDetach;
	FOnInitialize     := DelphiOnInitialize;
	FUpdate           := DelphiUpdate;
	FOnReceive        := DelphiOnReceive;
	FOnDisconnect     := DelphiOnDisconnect;
	FOnCloseConnection:= DelphiOnCloseConnection;
	FOnDirectSocketSend:= DelphiOnDirectSocketSend;
	FOnDirectSocketReceive:= DelphiOnDirectSocketReceive;
	FOnInternalPacket := DelphiOnInternalPacket;
	FClassObject      := self;
  end;

end;

destructor TRakMainPlugin.Destroy;
begin
 TRAKNETPluginDelphi_destructor(IntRaknetInterface);
end;


function TRakMainPlugin.OnReceive(RakPeer: TRakPeer;Packet: TRakPacket): TPluginReceiveResult;
begin
  Result := RR_CONTINUE_PROCESSING;
end;

initialization
 IntPlugInPeer := TRakPeer.CreateEmpty;
 IntPlugInPacket := TRakPacket.CreateEmpty;
 IntPlugInPlayerID := TRakPlayerID.CreateEmpty;

finalization
 IntPlugInPlayerID.Free;
 IntPlugInPeer.Free;
 IntPlugInPacket.Free;
end.
