unit RaknetInterface;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Internal interfaces

 Delphi wrapper and c port author : Joe Oszlanczi (BigJoe)
                                    Hungary
                                    raknetwrapper@freemail.hu
                                    Please send me any error report
 Wrapper version :  0.1

 This source published under GPL - General public license

 Original right visit www.rakkarsoft.com



}
{=============================================================================}

interface

uses RakNetTypes;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}




    function  InitClientInterface: TRakInterface;
    function  InitServerInterface: TRakInterface;
    function  InitPeerInterface: TRakInterface;
    function  InitConsoleServer: TRakInterface;
    function  InitReplicaManager: TRakInterface;
    function  InitLogCommandParser: TRakInterface;
    function  InitPacketLogger: TRakInterface;
    function  InitCommandParser: TRakInterface;
    function  InitRaknetTransport: TRakInterface;
    function  InitTelnetTransport: TRakInterface;
    function  InitPacketConsoleLogger: TRakInterface;
    function  InitPacketFileLogger: TRakInterface;
    function  InitRouter: TRakInterface;
    function  InitConnectionGraph: TRakInterface;
    function  InitMultiplayerClient: TRakInterface;
    function  InitMultiplayerServer: TRakInterface;
    function  InitMultiplayerPeer  : TRakInterface;

    procedure  UnInitClientInterface       ( RakClientInterface   : TRakInterface);
    procedure  UnInitServerInterface       ( RakServerInterface   : TRakInterface);
    procedure  UnInitPeerInterface         ( RakPeerInterface     : TRakInterface);
    procedure  UnInitConsoleServer         ( ConsoleServer        : TRakInterface);
    procedure  UnInitReplicaManager        ( ReplicaManager       : TRakInterface);
    procedure  UnInitLogCommandParser      ( LogCommandParser     : TRakInterface);
    procedure  UnInitPacketLogger          ( PacketLogger         : TRakInterface);
    procedure  UnInitCommandParser         ( RakNetCommandParser  : TRakInterface);
    procedure  UnInitRaknetTransport       ( RakNetTransport      : TRakInterface);
    procedure  UnInitTelnetTransport       ( TelnetTransport      : TRakInterface);
    procedure  UnInitPacketConsoleLogger   ( PacketConsoleLogger  : TRakInterface);
    procedure  UnInitPacketFileLogger      ( PacketFileLogger     : TRakInterface);
    procedure  UnInitRouter                ( Router               : TRakInterface);
    procedure  UnInitConnectionGraph       ( ConnectionGraph      : TRakInterface);
    procedure UnInitMultiplayerClient     ( RakMultiplayerInterface   : TRakInterface);
    procedure UnInitMultiplayerServer     ( RakMultiplayerInterface   : TRakInterface);
    procedure UnInitMultiplayerPeer       ( RakMultiplayerInterface   : TRakInterface);




implementation
uses RaknetDLL;

    function  InitClientInterface: TRakInterface;
    begin
      Result := TRAKNET_InitClientInterface;
    end;

    function  InitServerInterface: TRakInterface;
    begin
      Result := TRAKNET_InitServerInterface;
    end;

    function  InitPeerInterface: TRakInterface;
    begin
      Result := TRAKNET_InitPeerInterface;
    end;

    function  InitConsoleServer: TRakInterface;
    begin
     Result := TRAKNET_InitConsoleServer;
    end;

    function  InitReplicaManager: TRakInterface;
    begin
     Result := TRAKNET_InitReplicaManager;
    end;

    function  InitLogCommandParser: TRakInterface;
    begin
      Result := TRAKNET_InitLogCommandParser;
    end;

    function  InitPacketLogger: TRakInterface;
    begin
     Result := TRAKNET_InitPacketLogger;
    end;

    function  InitCommandParser: TRakInterface;
    begin
      Result := TRAKNET_InitCommandParser;
    end;

    function  InitRaknetTransport: TRakInterface;
    begin
     Result := TRAKNET_InitRaknetTransport;
    end;

    function  InitTelnetTransport: TRakInterface;
    begin
     Result := TRAKNET_InitTelnetTransport;
    end;

    function  InitPacketConsoleLogger: TRakInterface;
    begin
     Result := TRAKNET_InitConsoleServer;
    end;

    function  InitPacketFileLogger: TRakInterface;
    begin
     Result := TRAKNET_InitPacketFileLogger;
    end;

    function  InitRouter: TRakInterface;
    begin
      Result := TRAKNET_InitRouter;
    end;

    function  InitConnectionGraph: TRakInterface;
    begin
     Result := TRAKNET_InitConnectionGraph;
    end;

    procedure  UnInitClientInterface       ( RakClientInterface   : TRakInterface);
    begin
       TRAKNET_UnInitClientInterface(RakClientInterface);
    end;

    procedure  UnInitServerInterface       ( RakServerInterface   : TRakInterface);
    begin
      TRAKNET_UnInitServerInterface(RakServerInterface);
    end;

    procedure  UnInitPeerInterface         ( RakPeerInterface     : TRakInterface);
    begin
      TRAKNET_UnInitPeerInterface(RakPeerInterface);
    end;

    procedure  UnInitConsoleServer         ( ConsoleServer        : TRakInterface);
    begin
      TRAKNET_UnInitConsoleServer(ConsoleServer);
    end;

    procedure  UnInitReplicaManager        ( ReplicaManager       : TRakInterface);
    begin
      TRAKNET_UnInitReplicaManager(ReplicaManager);
    end;

    procedure  UnInitLogCommandParser      ( LogCommandParser     : TRakInterface);
    begin
     TRAKNET_UnInitLogCommandParser(LogCommandParser);
    end;

    procedure  UnInitPacketLogger          ( PacketLogger         : TRakInterface);
    begin
     TRAKNET_UnInitPacketLogger(PacketLogger);
    end;

    procedure  UnInitCommandParser         ( RakNetCommandParser  : TRakInterface);
    begin
     TRAKNET_UnInitCommandParser(RakNetCommandParser);
    end;

    procedure  UnInitRaknetTransport       ( RakNetTransport      : TRakInterface);
    begin
      TRAKNET_UnInitRaknetTransport(RakNetTransport);
    end;

    procedure  UnInitTelnetTransport       ( TelnetTransport      : TRakInterface);
    begin
      TRAKNET_UnInitTelnetTransport(TelnetTransport);
    end;

    procedure  UnInitPacketConsoleLogger   ( PacketConsoleLogger  : TRakInterface);
    begin
      TRAKNET_UnInitPacketConsoleLogger(PacketConsoleLogger);
    end;

    procedure  UnInitPacketFileLogger      ( PacketFileLogger     : TRakInterface);
    begin
      TRAKNET_UnInitPacketFileLogger(PacketFileLogger);
    end;

    procedure  UnInitRouter                ( Router               : TRakInterface);
    begin
      TRAKNET_UnInitRouter(Router);
    end;

    procedure  UnInitConnectionGraph       ( ConnectionGraph      : TRakInterface);
    begin
      TRAKNET_UnInitConnectionGraph(ConnectionGraph);
    end;


    function  InitMultiplayerClient: TRakInterface;
    begin
     Result := TRAKMULTIPLAYER_ClientConstructor;
    end;

    function  InitMultiplayerServer: TRakInterface;
    begin
      Result := TRAKMULTIPLAYER_ServerConstructor;
    end;

    function  InitMultiplayerPeer  : TRakInterface;
    begin
      Result := TRAKMULTIPLAYER_PeerConstructor;
    end;

    procedure UnInitMultiplayerClient     ( RakMultiplayerInterface   : TRakInterface);
    begin
      TRAKMULTIPLAYER_ClientDestructor(RakMultiplayerInterface);
    end;

    procedure UnInitMultiplayerServer     ( RakMultiplayerInterface   : TRakInterface);
    begin
      TRAKMULTIPLAYER_ServerDestructor(RakMultiplayerInterface);
    end;

    procedure UnInitMultiplayerPeer       ( RakMultiplayerInterface   : TRakInterface);
    begin
      TRAKMULTIPLAYER_PeerDestructor(RakMultiplayerInterface);
    end;




end.
