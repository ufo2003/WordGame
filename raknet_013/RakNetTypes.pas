unit RakNetTypes;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Raknet internal types

 Delphi wrapper and c port author : Joe Oszlanczi (BigJoe)
                                    Hungary
                                    raknetwrapper@freemail.hu
                                    Please send me any error report
 Wrapper version :  0.13

 This source published under GPL - General public license

 Original right visit www.rakkarsoft.com


 Information :

  multiplayer callback functions use  stdcall  !!!!!

}
{=============================================================================}
interface

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

const

   UNASSIGNED_NETWORK_ID = $FFFFFFFF;
   UNASSIGNED_PLAYER_INDEX = 65535;


type

// autopacher

 PTOnFile = ^TOnFile;
 TOnFile  = packed record
		fileIndex: cardinal;
		filename : Pchar;
		fileData : Pchar;
		compressedTransmissionLength : cardinal;
		finalDataLength : cardinal;
		setID:word;
		setCount:cardinal;
		setTotalCompressedTransmissionLength:cardinal;
		setTotalFinalLength:cardinal;
		context:byte;
 end;

 PTOnFileProgress=^TOnFileProgress;
 TOnFileProgress = packed record

		fileIndex:cardinal;
		filename:Pchar;
		compressedTransmissionLength:cardinal;
		finalDataLength:cardinal;
		setID:word;
		setCount:cardinal;
		setTotalCompressedTransmissionLength:cardinal;
		setTotalFinalLength:cardinal;
		context:byte;
		partCount:cardinal;
		partTotal:cardinal;
		partLength:cardinal;
   end;


    TPatchContext = (

	PC_HASH_WITH_PATCH,
	PC_WRITE_FILE,
	PC_ERROR_FILE_WRITE_FAILURE,
	PC_ERROR_PATCH_TARGET_MISSING,
	PC_ERROR_PATCH_APPLICATION_FAILURE,
	PC_ERROR_PATCH_RESULT_CHECKSUM_FAILURE,
	PC_NOTICE_WILL_COPY_ON_RESTART
      );

     PTFileListNode= ^TFileListNode;
      TFileListNode= packed record
      	filename    : Pchar;
      	data        : Pchar;
	      dataLength  : cardinal;
	      fileLength  : cardinal;
	      context     : byte;  // User specific data for whatever, describing this file.
      end;


   TRakInterface = pointer;
   PTRakInterfaceList=^TRakInterfaceList;
   TRakInterfaceList=array of pointer;

   TRaknetInterfaceAbstract=class
        private
        protected
          IntRaknetInterface:TRakInterface;
          procedure    SetRaknetInterface(const Value: TRakInterface); virtual;
        public
           property    RaknetInterface:TRakInterface read IntRaknetInterface write SetRaknetInterface;
           function    isNull:boolean;
           procedure   ToNull;
           constructor CreateEmpty; overload;
      end;


   TRPCIntCallback = procedure (ocall,oparam:TRakInterface); stdcall;


   TMultiplayerCallback= procedure(Packet,InterfaceType:TRakInterface) ;  stdcall;
   TMultiplayerUnhandledCallback= procedure(Packet:TRakInterface;MessageID:byte;InterfaceType:TRakInterface) ; stdcall;

   PTMultiPlayerCallbackList=^TMultiPlayerCallbackList;
   TMultiPlayerCallbackList=packed record
     	 ReceiveRemoteDisconnectionNotification:TMultiplayerCallback;
	 ReceiveRemoteConnectionLost:TMultiplayerCallback;
	 ReceiveRemoteNewIncomingConnection:TMultiplayerCallback;
	 ReceiveRemoteExistingConnection:TMultiplayerCallback;
	 ReceiveRemoteStaticData:TMultiplayerCallback;
	 ReceiveConnectionBanned:TMultiplayerCallback;
	 ReceiveConnectionRequestAccepted:TMultiplayerCallback;
	 ReceiveNewIncomingConnection:TMultiplayerCallback;
	 ReceiveConnectionAttemptFailed:TMultiplayerCallback;
	 ReceiveConnectionResumption:TMultiplayerCallback;
	 ReceiveNoFreeIncomingConnections:TMultiplayerCallback;
	 ReceiveDisconnectionNotification:TMultiplayerCallback;
	 ReceiveConnectionLost:TMultiplayerCallback;
	 ReceivedStaticData:TMultiplayerCallback;
	 ReceiveInvalidPassword:TMultiplayerCallback;
	 ReceiveModifiedPacket:TMultiplayerCallback;
	 ReceiveVoicePacket:TMultiplayerCallback;
	 ReceivePong:TMultiplayerCallback;
	 ReceiveAdvertisedSystem:TMultiplayerCallback;
	 ProcessUnhandledPacket:TMultiplayerUnhandledCallback;
   end;



   PFrequencyTable = ^TFrequencyTable;
   TFrequencyTable = array[0..255] of cardinal;



   MessageID = byte;
   TPacketPriority =
(
	SYSTEM_PRIORITY,   /// \internal Used by RakNet to send above-high priority messages.
	HIGH_PRIORITY,   /// High priority messages are send before medium priority messages.
	MEDIUM_PRIORITY,   /// Medium priority messages are send before low priority messages.
	LOW_PRIORITY,   /// Low priority messages are only sent when no other messages are waiting.
	NUMBER_OF_PRIORITIES
);

  TPacketReliability = 
(
	UNRELIABLE,   /// Same as regular UDP, except that it will also discard duplicate datagrams.  RakNet adds (6 to 17) + 21 bits of overhead, 16 of which is used to detect duplicate packets and 6 to 17 of which is used for message length.
	UNRELIABLE_SEQUENCED,  /// Regular UDP with a sequence counter.  Out of order messages will be discarded.  This adds an additional 13 bits on top what is used for UNRELIABLE.
	RELIABLE,   /// The message is sent reliably, but not necessarily in any order.  Same overhead as UNRELIABLE.
	RELIABLE_ORDERED,   /// This message is reliable and will arrive in the order you sent it.  Messages will be delayed while waiting for out of order messages.  Same overhead as UNRELIABLE_SEQUENCED.
	RELIABLE_SEQUENCED /// This message is reliable and will arrive in the sequence you sent it.  Out or order messages will be dropped.  Same overhead as UNRELIABLE_SEQUENCED.
);


 TPluginReceiveResult=
(
	RR_STOP_PROCESSING_AND_DEALLOCATE=0, // The plugin used this message and it shouldn't be given to the user.
	RR_CONTINUE_PROCESSING, // This message will be processed by other plugins, and at last by the user.
	RR_STOP_PROCESSING // The plugin is going to hold on to this message.  Do not deallocate it but do not pass it to other plugins either.
);



const
	REPLICA_RECEIVE_DESTRUCTION=1;
	REPLICA_RECEIVE_SERIALIZE=2;
	REPLICA_RECEIVE_SCOPE_CHANGE=4;
	REPLICA_SEND_CONSTRUCTION=8;
	REPLICA_SEND_DESTRUCTION=16;
	REPLICA_SEND_SCOPE_CHANGE=32;
	REPLICA_SEND_SERIALIZE=64;
	REPLICA_SET_ALL = 255; // Allow all of the above


	REPLICA_EXPLICIT_CONSTRUCTION=1;
	REPLICA_IMPLICIT_CONSTRUCTION=2; // Overridden by REPLICA_EXPLICIT_CONSTRUCTION.  IMPLICIT assumes the object exists on the remote system.
	REPLICA_SCOPE_TRUE=4; // Mutually exclusive REPLICA_SCOPE_FALSE
	REPLICA_SCOPE_FALSE=8; // Mutually exclusive REPLICA_SCOPE_TRUE
	REPLICA_SERIALIZE=16;

 type




 TReplicaReturnResult =
(
	/// This means call the function again later, with the same parameters
	REPLICA_PROCESS_LATER,
	/// This means we are done processing (the normal result to return)
	REPLICA_PROCESSING_DONE,
	/// This means cancel the processing - don't send any network messages and don't change the current state.
	REPLICA_CANCEL_PROCESS,
	/// Same as REPLICA_PROCESSING_DONE, where a message is sent, but does not clear the send bit.
	/// Useful for multi-part sends with different reliability levels.
	/// Only currently used by Replica::Serialize
	REPLICA_PROCESS_AGAIN
);


  // replicator manager multiplexers

  TconstructionCB         = function (inBitStream:TRakInterface;timestamp:Cardinal;NetworkID,PlayerID,ReplicaManager:TRakInterface;DelphiObj:pointer):TReplicaReturnResult; stdcall;
  TsendDownloadCompleteCB = function (outBitStream:TRakInterface;currentTime:cardinal;PlayerID:TRakInterface;ReplicaManager:TRakInterface;DelphiObj:pointer):TReplicaReturnResult; stdcall;
  TreceiveDownloadCompleteCB = function (inBitStream,PlayerId,ReplicaManager:TRakInterface;DelphiObj:pointer):TReplicaReturnResult; stdcall;

  TDelphiSendConstruction     = function (DelphiObj:pointer;currentTime:cardinal;PlayerID:TRakInterface;outBitStream:TRakInterface;includeTimestamp:pboolean):TReplicaReturnResult; stdcall;
  TDelphiSendDestruction      = procedure(DelphiObj:pointer;outBitStream:TRakInterface;PlayerID:TRakInterface); stdcall;
  TDelphiReceiveDestruction   = function (DelphiObj:pointer;inBitStream:TRakInterface;PlayerID:TRakInterface):TReplicaReturnResult; stdcall;
  TDelphiSendScopeChange      = function (DelphiObj:pointer;inScope:boolean;outBitStream:TRakInterface;currentTime:cardinal;PlayerID:TRakInterface):TReplicaReturnResult; stdcall;
  TDelphiReceiveScopeChange   = function (DelphiObj:pointer;inBitStream:TRakInterface;PlayerID:TRakInterface):TReplicaReturnResult; stdcall;
  TDelphiSerialize            = function (DelphiObj:pointer;sendTimestamp:PBoolean;outBitStream:TRakInterface;lastSendTime:cardinal;priority,reliability:PInteger;currentTime:cardinal;PlayerID:TRakInterface):TReplicaReturnResult; stdcall;
  TDelphiDeserialize          = function (DelphiObj:pointer;inBitStream:TRakInterface;timestamp,lastDeserializeTime:cardinal;PlayerID:TRakInterface):TReplicaReturnResult; stdcall;

  PTReplicaMemberCallback = ^TReplicaMemberCallback;
  TReplicaMemberCallback= packed record
    SendConstruction    : TDelphiSendConstruction;
    SendDestruction     : TDelphiSendDestruction;
    ReceiveDestruction  : TDelphiReceiveDestruction;
    SendScopeChange     : TDelphiSendScopeChange;
    ReceiveScopeChange  : TDelphiReceiveScopeChange;
    Serialize           : TDelphiSerialize;
    Deserialize         : TDelphiDeserialize;
  end;


  // statistics struct
  PRakNetStatisticsStruct=^TRakNetStatisticsStruct;
  TRakNetStatisticsStruct=packed record
   	messageSendBuffer       : array [0 .. 3] of cardinal;
	messagesSent            : array [0 .. 3] of cardinal;
	messageDataBitsSent     : array [0 .. 3] of cardinal;
	messageTotalBitsSent    : array [0 .. 3] of cardinal;
	packetsContainingOnlyAcknowlegements,
	acknowlegementsSent,
	acknowlegementsPending,
	acknowlegementBitsSent,
	packetsContainingOnlyAcknowlegementsAndResends,
	messageResends,
	messageDataBitsResent,
	messagesTotalBitsResent,
	messagesOnResendQueue,
	numberOfUnsplitMessages,
	numberOfSplitMessages,
	totalSplits,
	packetsSent,
	encryptionBitsSent,
	totalBitsSent,
	sequencedMessagesOutOfOrder,
	sequencedMessagesInOrder,
	orderedMessagesOutOfOrder,
	orderedMessagesInOrder,
	packetsReceived,
	packetsWithBadCRCReceived,
	bitsReceived,
	bitsWithBadCRCReceived,
	acknowlegementsReceived,
	duplicateAcknowlegementsReceived,
	messagesReceived,
	invalidMessagesReceived,
	duplicateMessagesReceived,
	messagesWaitingForReassembly,
	internalOutputQueueSize :     cardinal;
	bitsPerSecond:double;
	connectionStartTime:cardinal;
  end;



TPacketType =
(
	//
	// RESERVED TYPES - DO NOT CHANGE THESE
	//
	/// These types are never returned to the user.
	/// 0: Ping from a connected system.  Update timestamps (internal use only)
	ID_INTERNAL_PING,             /// 1: Ping from an unconnected system.  Reply but do not update timestamps. (internal use only)
	ID_PING,                      /// 2: Ping from an unconnected system.  Only reply if we have open connections. Do not update timestamps. (internal use only)
	ID_PING_OPEN_CONNECTIONS,     /// 3: Pong from a connected system.  Update timestamps (internal use only)
	ID_CONNECTED_PONG,            /// 4: Someone asked for our static data (internal use only)
	ID_REQUEST_STATIC_DATA,       /// 5: Asking for a new connection (internal use only)
	ID_CONNECTION_REQUEST,        /// 6: Connecting to a secured server/peer
	ID_SECURED_CONNECTION_RESPONSE,/// 7: Connecting to a secured server/peer
	ID_SECURED_CONNECTION_CONFIRMATION,	/// 8: Packet that tells us the packet contains an integer ID to name mapping for the remote system
	ID_RPC_MAPPING,               /// 9: A reliable packet to detect lost connections
	ID_DETECT_LOST_CONNECTIONS,   /// 10: Offline message so we know when to reset and start a new connection
	ID_OPEN_CONNECTION_REQUEST,   /// 11: Offline message response so we know when to reset and start a new connection
	ID_OPEN_CONNECTION_REPLY,     /// 12: Remote procedure call (internal use only)
	ID_RPC,                       /// 13: Remote procedure call reply, for RPCs that return data (internal use only)
	ID_RPC_REPLY,                 /// 14: Server / Client only - The server is broadcasting the pings of all players in the game (internal use only)
	ID_BROADCAST_PINGS,           /// 15: Server / Client only - The server is broadcasting a random number seed (internal use only)
	ID_SET_RANDOM_NUMBER_SEED,    //
	// USER TYPES - DO NOT CHANGE THESE
	//
	// Ordered from most useful to least useful
      ID_CONNECTION_REQUEST_ACCEPTED, /// [PEER|CLIENT] 16: In a client/server environment, our connection request to the server has been accepted.
      ID_CONNECTION_ATTEMPT_FAILED,   /// [PEER|SERVER|CLIENT] 17: Sent to the player when a connection request cannot be completed due to inability to connect.
	ID_NEW_INCOMING_CONNECTION,     /// [PEER|SERVER] 18: A remote system has successfully connected.
	ID_NO_FREE_INCOMING_CONNECTIONS,/// [PEER|CLIENT] 19: The system we attempted to connect to is not accepting new connections.
	ID_DISCONNECTION_NOTIFICATION,  /// [PEER|SERVER|CLIENT] 20: The system specified in Packet::playerID has disconnected from us.  For the client, this would mean the server has shutdown.
	ID_CONNECTION_LOST,             /// [PEER|SERVER|CLIENT] 21: Reliable packets cannot be delivered to the system specifed in Packet::playerID.  The connection to that system has been closed.
	ID_RSA_PUBLIC_KEY_MISMATCH,    /// [CLIENT|PEER] 22: We preset an RSA public key which does not match what the system we connected to is using.
	ID_CONNECTION_BANNED,          /// [PEER|CLIENT] 23: We are banned from the system we attempted to connect to.
	ID_INVALID_PASSWORD,           /// [PEER|CLIENT] 24: The remote system is using a password and has refused our connection because we did not set the correct password.
	ID_MODIFIED_PACKET,            /// [PEER|SERVER|CLIENT] 25: A packet has been tampered with in transit.  The sender is contained in Packet::playerID.
	ID_TIMESTAMP,                  /// [PEER|SERVER|CLIENT] 26: The four bytes following this byte represent an unsigned int which is automatically modified by the difference in system times between the sender and the recipient. Requires that you call StartOccasionalPing.
	ID_PONG,                       /// [PEER] 27: Pong from an unconnected system.  First byte is ID_PONG, second sizeof(RakNetTime) bytes is the ping, following bytes is system specific enumeration data.
	ID_RECEIVED_STATIC_DATA,       /// [PEER|SERVER|CLIENT] 28: We got a bitstream containing static data.  You can now read this data. This packet is transmitted automatically on connections, and can also be manually sent.
	ID_REMOTE_DISCONNECTION_NOTIFICATION, /// [CLIENT] 29: In a client/server environment, a client other than ourselves has disconnected gracefully.  Packet::playerID is modified to reflect the playerID of this client.
	ID_REMOTE_CONNECTION_LOST,     /// [CLIENT] 30: In a client/server environment, a client other than ourselves has been forcefully dropped. Packet::playerID is modified to reflect the playerID of this client.
	ID_REMOTE_NEW_INCOMING_CONNECTION, /// [CLIENT] 31: In a client/server environment, a client other than ourselves has connected.  Packet::playerID is modified to reflect the playerID of this client.
	ID_REMOTE_EXISTING_CONNECTION, /// [CLIENT] 32: On our initial connection to the server, we are told of every other client in the game.  Packet::playerID is modified to reflect the playerID of this client.
	ID_REMOTE_STATIC_DATA,         /// [CLIENT] - 33: Got the data for another client

	/// [FILELIST] 34:
	ID_FILE_LIST_TRANSFER_HEADER,

	/// [FILELIST] 35:
	ID_FILE_LIST_TRANSFER_FILE,

	/// [Delta Directory transfer] 36:
	ID_DDT_DOWNLOAD_REQUEST,

	/// [MASTERSERVER] 37: Request to the master server for the list of servers that contain at least one of the specified keys
	ID_QUERY_MASTER_SERVER,
	/// [MASTERSERVER] 38: Remove a game server from the master server.
	ID_MASTER_SERVER_DELIST_SERVER,
	/// [MASTERSERVER|MASTERCLIENT] 39: Add or update the information for a server.
	ID_MASTER_SERVER_UPDATE_SERVER,
	/// [MASTERSERVER|MASTERCLIENT] 40: Add or set the information for a server.
	ID_MASTER_SERVER_SET_SERVER,
	/// [MASTERSERVER|MASTERCLIENT] 41: This message indicates a game client is connecting to a game server, and is relayed through the master server.
	ID_RELAYED_CONNECTION_NOTIFICATION,

	/// [PEER|SERVER|CLIENT] 42: Inform a remote system of our IP/Port.
	ID_ADVERTISE_SYSTEM,

	/// [RakNetTransport] 43
	ID_TRANSPORT_STRING,

	/// [ReplicaManager] 44
	ID_REPLICA_MANAGER_CONSTRUCTION,
	/// [ReplicaManager] 45
	ID_REPLICA_MANAGER_DESTRUCTION,
	/// [ReplicaManager] 46
	ID_REPLICA_MANAGER_SCOPE_CHANGE,
	/// [ReplicaManager] 47
	ID_REPLICA_MANAGER_SERIALIZE,
	/// [ReplicaManager] 48
	ID_REPLICA_MANAGER_DOWNLOAD_COMPLETE,

	/// [ConnectionGraph] 49
	ID_CONNECTION_GRAPH_REQUEST,
	/// [ConnectionGraph] 50
	ID_CONNECTION_GRAPH_REPLY,
	/// [ConnectionGraph] 51
	ID_CONNECTION_GRAPH_UPDATE,
	/// [ConnectionGraph] 52
	ID_CONNECTION_GRAPH_NEW_CONNECTION,
	/// [ConnectionGraph] 53
	ID_CONNECTION_GRAPH_CONNECTION_LOST,
	/// [ConnectionGraph] 54
	ID_CONNECTION_GRAPH_DISCONNECTION_NOTIFICATION,

	/// [Router] 55
	ID_ROUTE_AND_MULTICAST,

	/// [RakVoice] 56
	ID_RAKVOICE_OPEN_CHANNEL_REQUEST,
	/// [RakVoice] 57
	ID_RAKVOICE_OPEN_CHANNEL_REPLY,
	/// [RakVoice] 58
	ID_RAKVOICE_CLOSE_CHANNEL,
	/// [RakVoice] 59
	ID_RAKVOICE_DATA,

	/// [Autopatcher] 60
	ID_AUTOPATCHER_GET_CHANGELIST_SINCE_DATE,
	ID_AUTOPATCHER_CREATION_LIST,
	ID_AUTOPATCHER_DELETION_LIST,
	ID_AUTOPATCHER_GET_PATCH,
	ID_AUTOPATCHER_PATCH_LIST,
	ID_AUTOPATCHER_REPOSITORY_FATAL_ERROR, // Returned to user
	ID_AUTOPATCHER_FINISHED,
	ID_AUTOPATCHER_RESTART_APPLICATION, // Returned to user

	/// [NAT Punchthrough]
	ID_NAT_PUNCHTHROUGH_REQUEST,

	/// [NAT Punchthrough] Returned to user.  PlayerID binary address / port is written to the stream
	ID_NAT_TARGET_NOT_CONNECTED,

	/// [NAT Punchthrough] Returned to user.  PlayerID binary address / port is written to the stream
	ID_NAT_TARGET_CONNECTION_LOST,

	// [NAT Punchthrough]
	ID_NAT_CONNECT_AT_TIME,

	// [NAT Punchthrough]
	ID_NAT_SEND_OFFLINE_MESSAGE_AT_TIME,

	// [Database] Internal
	ID_DATABASE_QUERY_REQUEST,

	// [Database] Internal
	ID_DATABASE_UPDATE_ROW,

	// [Database] Internal
	ID_DATABASE_REMOVE_ROW,

	// [Database] A serialized table.  Bytes 1+ contain the table.  Pass to TableSerializer::DeserializeTable
	ID_DATABASE_QUERY_REPLY,

	// [Database] Specified table not found
	ID_DATABASE_UNKNOWN_TABLE,

	// [Database] Incorrect password
	ID_DATABASE_INCORRECT_PASSWORD,

	// RakPeer - Downloading a large message. Format is ID_DOWNLOAD_PROGRESS (MessageID), partCount (unsigned int), partTotal (unsigned int), partLength (unsigned int), first part data (length <= MAX_MTU_SIZE)
	ID_DOWNLOAD_PROGRESS,
	
	/// Depreciated
	ID_RESERVED9,
	// For the user to use.  Start your first enumeration at this value.
	ID_USER_PACKET_ENUM,
	//-------------------------------------------------------------------------------------------------------------

      ID_NetMainData
);





PInternalPacket=^TInternalPacket;
 TInternalPacket= packed record
 
 end;

// raknet plugin 

  	TFDelphiOnAttach = procedure (DelphiClass,RakPeer:TRakInterface); stdcall;
	TFDelphiOnDetach = procedure (DelphiClass,RakPeer:TRakInterface);   stdcall;
	TFDelphiOnInitialize= procedure (DelphiClass,RakPeer:TRakInterface); stdcall;
	TFDelphiUpdate= procedure (DelphiClass,RakPeer:TRakInterface);  stdcall;
	TFDelphiOnReceive= function (DelphiClass,RakPeer,Packet:TRakInterface):cardinal; stdcall;
	TFDelphiOnDisconnect= procedure (DelphiClass,RakPeer:TRakInterface); stdcall;
	TFDelphiOnCloseConnection= procedure (DelphiClass,RakPeer,PlayerID:TRakInterface);  stdcall;
	TFDelphiOnDirectSocketSend= procedure (DelphiClass:TRakInterface;data:Pchar;bitsUsed:cardinal;PlayerID:TRakInterface);    stdcall;
	TFDelphiOnDirectSocketReceive= procedure (DelphiClass:TRakInterface;data:Pchar;bitsUsed:cardinal;PlayerID:TRakInterface);   stdcall;
	TFDelphiOnInternalPacket= procedure (DelphiClass:TRakInterface;InternalPacket:PInternalPacket;frameNumber:cardinal;PlayerID:TRakInterface;Time:cardinal;isSend:boolean); stdcall;



 PTPluginInternalCalllist=^TPluginInternalCalllist;
 TPluginInternalCalllist=packed record
 	FOnAttach         : TFDelphiOnAttach;
	FOnDetach         : TFDelphiOnDetach;
	FOnInitialize     : TFDelphiOnInitialize;
	FUpdate           : TFDelphiUpdate;
	FOnReceive        : TFDelphiOnReceive;
	FOnDisconnect     : TFDelphiOnDisconnect;
	FOnCloseConnection: TFDelphiOnCloseConnection;
	FOnDirectSocketSend: TFDelphiOnDirectSocketSend;
	FOnDirectSocketReceive: TFDelphiOnDirectSocketReceive;
	FOnInternalPacket : TFDelphiOnInternalPacket;
	FClassObject      : pointer;
 end;

implementation

{ TRaknetInterfaceAbstract }

constructor TRaknetInterfaceAbstract.CreateEmpty;
begin
 IntRaknetInterface := nil;
end;

function TRaknetInterfaceAbstract.isNull: boolean;
begin
  Result := IntRaknetInterface=nil;
end;

procedure TRaknetInterfaceAbstract.SetRaknetInterface(
  const Value: TRakInterface);
begin
  IntRaknetInterface := Value;
end;

procedure TRaknetInterfaceAbstract.ToNull;
begin
 IntRaknetInterface := nil;
end;

end.
