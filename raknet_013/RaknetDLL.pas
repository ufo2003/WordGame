unit RaknetDLL;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - raknetc.dll wrapper

 Delphi wrapper and c port author : Joe Oszlanczi (BigJoe)
                                    Hungary
                                    raknetwrapper@freemail.hu
                                    Please send me any error report
 Wrapper version :  0.13

 This source published under GPL - General public license

 Original right visit www.rakkarsoft.com


 Information :

2007.02.09.  Repaired some cdecl error
2007.02.17.  Added main plugin interface
}
{=============================================================================}
interface
uses RaknetTypes;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type

// ------------------------------------
//
// Default interfaces initialization
//
// ------------------------------------

TRakInterface = pointer;


RAKNET_InitClientInterface         =  function  : TRakInterface        ; cdecl ;
RAKNET_InitServerInterface         =  function  : TRakInterface        ; cdecl ;
RAKNET_InitPeerInterface           =  function  : TRakInterface        ; cdecl ;
RAKNET_InitConsoleServer           =  function  : TRakInterface        ; cdecl ;
RAKNET_InitReplicaManager          =  function  : TRakInterface        ; cdecl ;
RAKNET_InitLogCommandParser        =  function  : TRakInterface        ; cdecl ;
RAKNET_InitPacketLogger            =  function  : TRakInterface        ; cdecl ;
RAKNET_InitRaknetTransport         =  function  : TRakInterface        ; cdecl ;
RAKNET_InitTelnetTransport         =  function  : TRakInterface        ; cdecl ;
RAKNET_InitPacketConsoleLogger     =  function  : TRakInterface        ; cdecl ;
RAKNET_InitPacketFileLogger        =  function  : TRakInterface        ; cdecl ;
RAKNET_InitRouter                  =  function  : TRakInterface        ; cdecl ;
RAKNET_InitConnectionGraph         =  function  : TRakInterface        ; cdecl ;
RAKNET_GetUnAssignedPlayerID       =  function  : TRakInterface        ; cdecl ;
RAKNET_InitCommandParser           =  function  : TRakInterface        ; cdecl ;


// ------------------------------------
//
// Default interfaces destroy
//
// ------------------------------------


RAKNET_UnInitClientInterface       = procedure         ( RakClientInterface   : TRakInterface); cdecl ;
RAKNET_UnInitServerInterface       = procedure         ( RakServerInterface   : TRakInterface); cdecl ;
RAKNET_UnInitPeerInterface         = procedure         ( RakPeerInterface     : TRakInterface); cdecl ;
RAKNET_UnInitConsoleServer         = procedure         ( ConsoleServer        : TRakInterface); cdecl ;
RAKNET_UnInitReplicaManager        = procedure         ( ReplicaManager       : TRakInterface); cdecl ;
RAKNET_UnInitLogCommandParser      = procedure         ( LogCommandParser     : TRakInterface); cdecl ;
RAKNET_UnInitPacketLogger          = procedure 	       ( PacketLogger         : TRakInterface); cdecl ;
RAKNET_UnInitCommandParser         = procedure         ( RakNetCommandParser  : TRakInterface); cdecl ;
RAKNET_UnInitRaknetTransport       = procedure         ( RakNetTransport      : TRakInterface); cdecl ;
RAKNET_UnInitTelnetTransport       = procedure         ( TelnetTransport      : TRakInterface); cdecl ;
RAKNET_UnInitPacketConsoleLogger   = procedure         ( PacketConsoleLogger  : TRakInterface); cdecl ;
RAKNET_UnInitPacketFileLogger      = procedure         ( PacketFileLogger     : TRakInterface); cdecl ;
RAKNET_UnInitRouter                = procedure         ( Router               : TRakInterface); cdecl ;
RAKNET_UnInitConnectionGraph       = procedure         ( ConnectionGraph      : TRakInterface); cdecl ;


// ------------------------------------
//
// Bitstream
//
// ------------------------------------

BITSTREAM_constructor1             = function  : TRakInterface cdecl;
BITSTREAM_constructor2             = function  (initialBytesToAllocate:integer):TRakInterface ;cdecl;
BITSTREAM_constructor3             = function  (_data:Pchar;lengthInBytes:cardinal;_copyData:boolean ):TRakInterface ;cdecl;
BITSTREAM_destructor               = procedure  (BitStream:TRakInterface); cdecl;
BITSTREAM_reset                    = procedure  (BitStream:TRakInterface); cdecl;
BITSTREAM_BSWriteFromWSize         = procedure  (BitStream,bitStreamTo:TRakInterface;numberOfBits:integer); cdecl;
BITSTREAM_BSWriteFrom              = procedure  (BitStream,bitStreamTo:TRakInterface);cdecl;
BITSTREAM_ResetReadPointer         = procedure  (BitStream:TRakInterface);cdecl;
BITSTREAM_ResetWritePointer        = procedure  (BitStream:TRakInterface);cdecl;
BITSTREAM_AssertStreamEmpty        = procedure  (BitStream:TRakInterface);cdecl;
BITSTREAM_PrintBits                = procedure  (BitStream:TRakInterface);cdecl;
BITSTREAM_IgnoreBits               = procedure  (BitStream:TRakInterface;numberOfBits: integer);cdecl;
BITSTREAM_SetWriteOffset           = procedure  (BitStream:TRakInterface;offset: integer);cdecl;
BITSTREAM_GetNumberOfBitsUsed      = function   (BitStream:TRakInterface):integer; cdecl;
BITSTREAM_GetWriteOffset           = function   (BitStream:TRakInterface):integer; cdecl;
BITSTREAM_GetNumberOfBytesUsed     = function   (BitStream:TRakInterface):integer; cdecl;
BITSTREAM_GetReadOffset            = function   (BitStream:TRakInterface):integer; cdecl;
BITSTREAM_SetReadOffset            = procedure  (BitStream:TRakInterface;offset: integer);cdecl;
BITSTREAM_GetNumberOfUnreadBits    = function   (BitStream:TRakInterface):integer; cdecl;
BITSTREAM_CopyData                 = function   (BitStream:TRakInterface;var _data:Pchar):integer; cdecl;
BITSTREAM_SetData                  = procedure  (BitStream:TRakInterface;input: Pchar);cdecl;
BITSTREAM_GetData                  = function   (BitStream:TRakInterface):Pchar;cdecl;
BITSTREAM_WriteBits                = procedure  (BitStream:TRakInterface;input:Pchar;numberOfBitsToWrite:integer;rightAlignedBits:boolean); cdecl;
BITSTREAM_WriteAlignedBytes        = procedure  (BitStream:TRakInterface;input:Pchar;numberOfBytesToWrite:integer); cdecl;
BITSTREAM_ReadAlignedBytes         = function   (BitStream:TRakInterface;output:Pchar;numberOfBytesToRead:integer):boolean; cdecl;
BITSTREAM_AlignWriteToByteBoundary = procedure  (BitStream:TRakInterface);cdecl;
BITSTREAM_AlignReadToByteBoundary  = procedure  (BitStream:TRakInterface);cdecl;
BITSTREAM_ReadBits                 = function   (BitStream:TRakInterface;output:Pchar;numberOfBitsToRead:integer;alignBitsToRight:boolean):boolean; cdecl;
BITSTREAM_Write                    = procedure  (BitStream:TRakInterface;input:Pchar;numberOfBytes:integer);  cdecl;
BITSTREAM_Write0                   = procedure  (BitStream:TRakInterface);cdecl;
BITSTREAM_Write1                   = procedure  (BitStream:TRakInterface);cdecl;
BITSTREAM_ReadBit                  = function   (BitStream:TRakInterface):boolean;cdecl;
BITSTREAM_AssertCopyData           = procedure  (BitStream:TRakInterface);cdecl;
BITSTREAM_SetNumberOfBitsAllocated = procedure  (BitStream:TRakInterface;lengthInBits:cardinal );  cdecl;
BITSTREAM_AddBitsAndReallocate     = procedure  (BitStream:TRakInterface;numberOfBitsToWrite:integer);  cdecl;

// ----

BITSTREAM_Serialize_Byte           = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:byte):boolean;  cdecl;
BITSTREAM_Serialize_Word           = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:word):boolean;  cdecl;
BITSTREAM_Serialize_LongWord       = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:cardinal):boolean; cdecl;
BITSTREAM_Serialize_Float          = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:single):boolean; cdecl;
BITSTREAM_Serialize_Double         = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:double):boolean; cdecl;

BITSTREAM_SerializeDelta_Byte      = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:byte):boolean;  cdecl;
BITSTREAM_SerializeDelta_Word      = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:word):boolean;  cdecl;
BITSTREAM_SerializeDelta_LongWord  = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:cardinal):boolean; cdecl;
BITSTREAM_SerializeDelta_Float     = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:single):boolean; cdecl;
BITSTREAM_SerializeDelta_Double    = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:double):boolean; cdecl;


// ----

BITSTREAM_Write_Byte               = procedure  (BitStream:TRakInterface;Indata:byte);    cdecl;
BITSTREAM_Write_Word               = procedure  (BitStream:TRakInterface;Indata:word);    cdecl;
BITSTREAM_Write_LongWord           = procedure  (BitStream:TRakInterface;Indata:cardinal); cdecl;
BITSTREAM_Write_Float              = procedure  (BitStream:TRakInterface;Indata:single);   cdecl;
BITSTREAM_Write_Double             = procedure  (BitStream:TRakInterface;Indata:double);  cdecl;


BITSTREAM_WriteCompressed_Byte     = procedure  (BitStream:TRakInterface;Indata:byte);    cdecl;
BITSTREAM_WriteCompressed_Word     = procedure  (BitStream:TRakInterface;Indata:word);    cdecl;
BITSTREAM_WriteCompressed_LongWord = procedure  (BitStream:TRakInterface;Indata:cardinal); cdecl;
BITSTREAM_WriteCompressed_Float    = procedure  (BitStream:TRakInterface;Indata:single);   cdecl;
BITSTREAM_WriteCompressed_Double   = procedure  (BitStream:TRakInterface;Indata:double);  cdecl;

BITSTREAM_WriteDelta_Byte          = procedure  (BitStream:TRakInterface;Indata:byte);    cdecl;
BITSTREAM_WriteDelta_Word          = procedure  (BitStream:TRakInterface;Indata:word);    cdecl;
BITSTREAM_WriteDelta_LongWord      = procedure  (BitStream:TRakInterface;Indata:cardinal); cdecl;
BITSTREAM_WriteDelta_Float         = procedure  (BitStream:TRakInterface;Indata:single);   cdecl;
BITSTREAM_WriteDelta_Double        = procedure  (BitStream:TRakInterface;Indata:double);  cdecl;


BITSTREAM_WriteCompressedDelta_Byte          = procedure  (BitStream:TRakInterface;Indata:byte);    cdecl;
BITSTREAM_WriteCompressedDelta_Word          = procedure  (BitStream:TRakInterface;Indata:word);    cdecl;
BITSTREAM_WriteCompressedDelta_LongWord      = procedure  (BitStream:TRakInterface;Indata:cardinal); cdecl;
BITSTREAM_WriteCompressedDelta_Float         = procedure  (BitStream:TRakInterface;Indata:single);   cdecl;
BITSTREAM_WriteCompressedDelta_Double        = procedure  (BitStream:TRakInterface;Indata:double);  cdecl;


// ----


BITSTREAM_Read_Byte                            = function  (BitStream:TRakInterface;var Indata:byte):boolean;    cdecl;
BITSTREAM_Read_Word                            = function  (BitStream:TRakInterface;var Indata:word):boolean;    cdecl;
BITSTREAM_Read_LongWord                        = function  (BitStream:TRakInterface;var Indata:cardinal):boolean; cdecl;
BITSTREAM_Read_Float                           = function  (BitStream:TRakInterface;var Indata:single):boolean;  cdecl;
BITSTREAM_Read_Double                          = function  (BitStream:TRakInterface;var Indata:single):boolean;   cdecl;


BITSTREAM_ReadCompressed_Byte                  = function  (BitStream:TRakInterface;var Indata:byte):boolean;    cdecl;
BITSTREAM_ReadCompressed_Word                  = function  (BitStream:TRakInterface;var Indata:word):boolean;    cdecl;
BITSTREAM_ReadCompressed_LongWord              = function  (BitStream:TRakInterface;var Indata:cardinal):boolean; cdecl;
BITSTREAM_ReadCompressed_Float                 = function  (BitStream:TRakInterface;var Indata:single):boolean;  cdecl;
BITSTREAM_ReadCompressed_Double                = function  (BitStream:TRakInterface;var Indata:single):boolean;   cdecl;

BITSTREAM_ReadDelta_Byte                       = function  (BitStream:TRakInterface;var Indata:byte):boolean;    cdecl;
BITSTREAM_ReadDelta_Word                       = function  (BitStream:TRakInterface;var Indata:word):boolean;    cdecl;
BITSTREAM_ReadDelta_LongWord                   = function  (BitStream:TRakInterface;var Indata:cardinal):boolean; cdecl;
BITSTREAM_ReadDelta_Float                      = function  (BitStream:TRakInterface;var Indata:single):boolean;  cdecl;
BITSTREAM_ReadDelta_Double                     = function  (BitStream:TRakInterface;var Indata:single):boolean;   cdecl;

BITSTREAM_ReadCompressedDelta_Byte             = function  (BitStream:TRakInterface;var Indata:byte):boolean;    cdecl;
BITSTREAM_ReadCompressedDelta_Word             = function  (BitStream:TRakInterface;var Indata:word):boolean;    cdecl;
BITSTREAM_ReadCompressedDelta_LongWord         = function  (BitStream:TRakInterface;var Indata:cardinal):boolean; cdecl;
BITSTREAM_ReadCompressedDelta_Float            = function  (BitStream:TRakInterface;var Indata:single):boolean;  cdecl;
BITSTREAM_ReadCompressedDelta_Double           = function  (BitStream:TRakInterface;var Indata:single):boolean;   cdecl;


// ---

BITSTREAM_SerializeCompressed_Byte             = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:byte):boolean;    cdecl;
BITSTREAM_SerializeCompressed_Word             = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:word):boolean;    cdecl;
BITSTREAM_SerializeCompressed_LongWord         = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:cardinal):boolean; cdecl;
BITSTREAM_SerializeCompressed_Float            = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:single):boolean;  cdecl;
BITSTREAM_SerializeCompressed_Double           = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:single):boolean;   cdecl;


BITSTREAM_SerializeCompressedDelta_Byte        = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:byte):boolean;    cdecl;
BITSTREAM_SerializeCompressedDelta_Word        = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:word):boolean;    cdecl;
BITSTREAM_SerializeCompressedDelta_LongWord    = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:cardinal):boolean; cdecl;
BITSTREAM_SerializeCompressedDelta_Float       = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:single):boolean;  cdecl;
BITSTREAM_SerializeCompressedDelta_Double      = function  (BitStream:TRakInterface;writeToBitstream:boolean;var Indata:single):boolean;   cdecl;


BITSTREAM_Serialize                            = function  (BitStream:TRakInterface;writeToBitstream:boolean;input:Pchar;numberOfBytes:integer):boolean; cdecl;
BITSTREAM_SerializeBits                        = function  (BitStream:TRakInterface;writeToBitstream:boolean;input:Pchar;numberOfBitsToSerialize:integer;rightAlignedBits:boolean):boolean; cdecl;
BITSTREAM_Read                                 = function  (BitStream:TRakInterface;output:pchar;numberOfBytes:integer):boolean;cdecl;
BITSTREAM_SerializeNormVectorFloat             = function  (BitStream:TRakInterface;writeToBitstream:boolean;var x,y,z:single):boolean; cdecl;
BITSTREAM_SerializeNormVectorDouble            = function  (BitStream:TRakInterface;writeToBitstream:boolean;var x,y,z:double):boolean; cdecl;
BITSTREAM_SerializeVectorFloat                 = function  (BitStream:TRakInterface;writeToBitstream:boolean;var x,y,z:single):boolean; cdecl;
BITSTREAM_SerializeVectorDouble                = function  (BitStream:TRakInterface;writeToBitstream:boolean;var x,y,z:double):boolean; cdecl;
BITSTREAM_SerializeNormQuatFloat               = function  (BitStream:TRakInterface;writeToBitstream:boolean;var w,x,y,z:single):boolean; cdecl;
BITSTREAM_SerializeNormQuatDouble              = function  (BitStream:TRakInterface;writeToBitstream:boolean;var w,x,y,z:double):boolean; cdecl;

BITSTREAM_SerializeOrthMatrixFloat             = function  (BitStream:TRakInterface;writeToBitstream:boolean;var m00,m01,m02,m10,m11,m12,m20,m21,m22:single):boolean;  cdecl;
BITSTREAM_SerializeOrthMatrixDouble            = function  (BitStream:TRakInterface;writeToBitstream:boolean;var m00,m01,m02,m10,m11,m12,m20,m21,m22:double):boolean;   cdecl;

// ------


BITSTREAM_ReadNormVectorFloat                  = function  (BitStream:TRakInterface;var x,y,z:single):boolean; cdecl;
BITSTREAM_ReadNormVectorDouble                 = function  (BitStream:TRakInterface;var x,y,z:double):boolean; cdecl;
BITSTREAM_ReadVectorFloat                      = function  (BitStream:TRakInterface;var x,y,z:single):boolean; cdecl;
BITSTREAM_ReadVectorDouble                     = function  (BitStream:TRakInterface;var x,y,z:double):boolean; cdecl;
BITSTREAM_ReadNormQuatFloat                    = function  (BitStream:TRakInterface;var w,x,y,z:single):boolean; cdecl;
BITSTREAM_ReadNormQuatDouble                   = function  (BitStream:TRakInterface;var w,x,y,z:double):boolean; cdecl;
BITSTREAM_ReadOrthMatrixFloat                  = function  (BitStream:TRakInterface;var m00,m01,m02,m10,m11,m12,m20,m21,m22:single):boolean;   cdecl; 
BITSTREAM_ReadOrthMatrixDouble                 = function  (BitStream:TRakInterface;var m00,m01,m02,m10,m11,m12,m20,m21,m22:double):boolean;   cdecl;


BITSTREAM_WriteNormVectorFloat                  = procedure  (BitStream:TRakInterface;x,y,z:single) cdecl;
BITSTREAM_WriteNormVectorDouble                 = procedure  (BitStream:TRakInterface;x,y,z:double) cdecl;
BITSTREAM_WriteVectorFloat                      = procedure  (BitStream:TRakInterface;x,y,z:single) cdecl;
BITSTREAM_WriteVectorDouble                     = procedure  (BitStream:TRakInterface;x,y,z:double) cdecl;
BITSTREAM_WriteNormQuatFloat                    = procedure  (BitStream:TRakInterface;w,x,y,z:single) cdecl;
BITSTREAM_WriteNormQuatDouble                   = procedure  (BitStream:TRakInterface;w,x,y,z:double) cdecl;
BITSTREAM_WriteOrthMatrixFloat                  = procedure  (BitStream:TRakInterface;m00,m01,m02,m10,m11,m12,m20,m21,m22:single)   cdecl;
BITSTREAM_WriteOrthMatrixDouble                 = procedure  (BitStream:TRakInterface;m00,m01,m02,m10,m11,m12,m20,m21,m22:double)   cdecl;





// ------------------------------------
//
// Packet struct
//
// ------------------------------------


 RAKPacket_PlayerIndex                          = function (Packet:TRakInterface):word; cdecl;
 RAKPacket_PlayerID                             = function (Packet:TRakInterface):TRakInterface; cdecl;
 RAKPacket_Length                               = function (Packet:TRakInterface):cardinal; cdecl;
 RAKPacket_bitSize                              = function (Packet:TRakInterface):cardinal; cdecl;
 RAKPacket_data                                 = function (Packet:TRakInterface):pchar; cdecl;



// ------------------------------------
//
//RPCParameters struct
//
// ------------------------------------


RAKRPCParameters_Input                          = function (RPCParameters:TRakInterface):pchar; cdecl;
RAKRPCParameters_NumberOfBitsOfData             = function (RPCParameters:TRakInterface):cardinal; cdecl;
RAKRPCParameters_Sender                         = function (RPCParameters:TRakInterface):TRakInterface; cdecl;  {playerid}
RAKRPCParameters_Recipient                      = function (RPCParameters:TRakInterface):TRakInterface; cdecl; {rakpeer}
RAKRPCParameters_ReplyToSender                  = function (RPCParameters:TRakInterface):TRakInterface; cdecl; {bitstream}


// ------------------------------------
//
// Player ID struct
//
// ------------------------------------

RAKPlayerID_binaryAddress                       = function (PlayerID:TRakInterface):cardinal; cdecl;
RAKPlayerID_port                                = function (PlayerID:TRakInterface):word; cdecl;
RAKPlayerID_tostring                            = function (PlayerID:TRakInterface;writeport:boolean):PChar; cdecl;



// ------------------------------------
//
// Server Class declarations
//
// ------------------------------------


 RAKSERVER_constructor                          = function  :TRakInterface; cdecl;
 RAKSERVER_destructor                           = procedure  (RakServer:TRakInterface); cdecl;
 RAKSERVER_Start                                = function   (RakServer:TRakInterface;AllowedPlayers:word;depreciated:cardinal;threadSleepTimer:integer;port:word;forceHostAddress:Pchar):boolean; cdecl;
 RAKSERVER_InitializeSecurity                   = procedure  (RakServer:TRakInterface;privKeyP,privKeyQ:PChar); cdecl;
 RAKSERVER_DisableSecurity                      = procedure  (RakServer:TRakInterface); cdecl;
 RAKSERVER_SetPassword                          = procedure  (RakServer:TRakInterface;_password:PChar); cdecl;
 RAKSERVER_HasPassword                          = function   (RakServer:TRakInterface):boolean; cdecl;
 RAKSERVER_Disconnect                           = procedure  (RakServer:TRakInterface;blockDuration:cardinal;orderingChannel:byte); cdecl;
 RAKSERVER_SendBuffer                           = function   (RakServer:TRakInterface;data:pchar;length,priority,reliability:integer;orderingChannel:byte;PlayerID:TRakInterface;broadcast:boolean):boolean; cdecl;
 RAKSERVER_SendBitStream                        = function   (RakServer,BitStream:TRakInterface;priority,reliability:integer;orderingChannel:byte;PlayerID:TRakInterface;broadcast:boolean):boolean; cdecl;
 RAKSERVER_Receive                              = function   (RakServer:TRakInterface):TRakInterface; cdecl;
 RAKSERVER_Kick                                 = procedure  (RakServer,PlayerID:TRakInterface); cdecl;
 RAKSERVER_DeallocatePacket                     = procedure  (RakServer,Packet:TRakInterface); cdecl;
 RAKSERVER_SetAllowedPlayers                    = procedure  (RakServer:TRakInterface;AllowedPlayers:word); cdecl;
 RAKSERVER_GetAllowedPlayers                    = function   (RakServer:TRakInterface):word; cdecl;
 RAKSERVER_GetConnectedPlayers                  = function   (RakServer:TRakInterface):word; cdecl;
 RAKSERVER_GetPlayerIPFromID                    = procedure  (RakServer,PlayerID:TRakInterface;returnValue:Pchar;var port:word); cdecl;
 RAKSERVER_PingPlayer                           = procedure  (RakServer,PlayerID:TRakInterface); cdecl;
 RAKSERVER_GetAveragePing                       = function   (RakServer,PlayerID:TRakInterface):integer; cdecl;
 RAKSERVER_GetLastPing                          = function   (RakServer,PlayerID:TRakInterface):integer; cdecl;
 RAKSERVER_GetLowestPing                        = function   (RakServer,PlayerID:TRakInterface):integer; cdecl;
 RAKSERVER_StartOccasionalPing                  = procedure  (RakServer:TRakInterface); cdecl;
 RAKSERVER_StopOccasionalPing                   = procedure  (RakServer:TRakInterface); cdecl;
 RAKSERVER_IsActive                             = function   (RakServer:TRakInterface):boolean; cdecl;
 RAKSERVER_GetSynchronizedRandomInteger         = function   (RakServer:TRakInterface):cardinal; cdecl;
 RAKSERVER_StartSynchronizedRandomInteger       = procedure  (RakServer:TRakInterface); cdecl;
 RAKSERVER_StopSynchronizedRandomInteger        = procedure  (RakServer:TRakInterface); cdecl;
 RAKSERVER_GenerateCompressionLayer             = function   (RakServer:TRakInterface;inputFrequencyTable:Pchar;inputLayer:boolean):boolean; cdecl;
 RAKSERVER_DeleteCompressionLayer               = function   (RakServer:TRakInterface;inputLayer:boolean):boolean; cdecl;
 RAKSERVER_SetTrackFrequencyTable               = procedure  (RakServer:TRakInterface;b:boolean); cdecl;
 RAKSERVER_GetSendFrequencyTable                = function   (RakServer:TRakInterface;outputFrequencyTable:Pchar):boolean; cdecl;
 RAKSERVER_GetCompressionRatio                  = function   (RakServer:TRakInterface):single; cdecl;
 RAKSERVER_GetDecompressionRatio                = function   (RakServer:TRakInterface):single; cdecl;
 RAKSERVER_GetStaticServerData                  = function   (RakServer:TRakInterface):TRakInterface; cdecl;
 RAKSERVER_SetStaticServerData                  = procedure  (RakServer:TRakInterface;data:Pchar;bytelength:integer);cdecl;
 RAKSERVER_SetStaticClientData                  = procedure  (RakServer,PlayerID:TRakInterface;data:Pchar;bytelength:integer); cdecl;
 RAKSERVER_SetRelayStaticClientData             = procedure  (RakServer:TRakInterface;b:boolean); cdecl;
 RAKSERVER_SendStaticServerDataToClient         = procedure  (RakServer,PlayerID:TRakInterface); cdecl;
 RAKSERVER_SetOfflinePingResponse               = procedure  (RakServer:TRakInterface;data:pchar;bytelength:cardinal); cdecl;
 RAKSERVER_GetStaticClientData                  = function   (RakServer,PlayerID:TRakInterface):TRakInterface; cdecl;
 RAKSERVER_ChangeStaticClientData               = procedure  (RakServer,playerChangedId,playerToSendToId:TRakInterface); cdecl;
 RAKSERVER_GetNumberOfAddresses                 = function   (RakServer:TRakInterface):cardinal; cdecl;
 RAKSERVER_GetLocalIP                           = function   (RakServer:TRakInterface;index:cardinal):Pchar; cdecl; 
 RAKSERVER_GetInternalID                        = function   (RakServer:TRakInterface):TRakInterface; cdecl;
 RAKSERVER_PushBackPacket                       = procedure  (RakServer,Packet:TRakInterface;pushAtHead:boolean); cdecl;
 RAKSERVER_GetIndexFromPlayerID                 = function   (RakServer,PlayerID:TRakInterface):integer; cdecl;
 RAKSERVER_GetPlayerIDFromIndex                 = function   (RakServer:TRakInterface;index:integer):TRakInterface; cdecl; 
 RAKSERVER_AddToBanList                         = procedure  (RakServer:TRakInterface;IP:Pchar);cdecl;
 RAKSERVER_RemoveFromBanList                    = procedure  (RakServer:TRakInterface;IP:Pchar);cdecl;
 RAKSERVER_ClearBanList                         = procedure  (RakServer:TRakInterface); cdecl;
 RAKSERVER_IsBanned                             = function   (RakServer:TRakInterface;IP:Pchar):boolean; cdecl;
 RAKSERVER_IsActivePlayerID                     = function   (RakServer,PlayerID:TRakInterface):boolean; cdecl;
 RAKSERVER_SetTimeoutTime                       = procedure  (RakServer:TRakInterface;timeMS:cardinal;PlayerID:TRakInterface);  cdecl;
 RAKSERVER_SetMTUSize                           = function   (RakServer:TRakInterface;size:integer):boolean; cdecl;
 RAKSERVER_GetMTUSize                           = function   (RakServer:TRakInterface):integer; cdecl;
 RAKSERVER_AdvertiseSystem                      = procedure  (RakServer:TRakInterface;host:Pchar;remotePort:word;data:Pchar;dataLength:integer); cdecl;
 RAKSERVER_GetStatistics                        = function   (RakServer,PlayerID:TRakInterface):Pchar;  cdecl;
 RAKSERVER_ApplyNetworkSimulator                = procedure  (RakServer:TRakInterface;maxSendBPS:double;minExtraPing,extraPingVariance:word);cdecl;
 RAKSERVER_IsNetworkSimulatorActive             = function   (RakServer:TRakInterface):boolean; cdecl;
 RAKSERVER_UnregisterAsRemoteProcedureCall      = procedure  (RakServer:TRakInterface;uniqueID:Pchar); cdecl;
 RAKSERVER_RegisterAsRemoteProcedureCall        = procedure  (RakServer:TRakInterface;uniqueID:Pchar;classcall:pointer;callback:TRPCIntCallback);  cdecl;
 RAKSERVER_RPCFromBuffer                        = function   (RakServer:TRakInterface;uniqueID:Pchar;data:Pchar;bitLength:cardinal;priority,reliability:integer;orderingChannel:byte;PlayerID:TRakInterface;broadcast,shiftTimestamp:boolean;BitStreamReplyFromTarget:TRakInterface):boolean; cdecl;
 RAKSERVER_RPCFromBitStream                     = function   (RakServer:TRakInterface;uniqueID:Pchar;BitStream:TRakInterface;priority,reliability:integer;orderingChannel:byte;PlayerID:TRakInterface;broadcast,shiftTimestamp:boolean;BitStreamReplyFromTarget:TRakInterface):boolean; cdecl;




// ------------------------------------
//
// Client Class declarations
//
// ------------------------------------


 RAKCLIENT_constructor                          = function   :TRakInterface; cdecl;
 RAKCLIENT_destructor                           = procedure  (RakServer:TRakInterface); cdecl;
 RAKCLIENT_Connect                              = function   (RakServer:TRakInterface;host:Pchar;serverPort,clientPort:word;depreciated,threadSleepTimer:integer):boolean; cdecl;
 RAKCLIENT_Disconnect                           = procedure  (RakServer:TRakInterface;blockDuration:cardinal;orderingChannel:byte); cdecl;
 RAKCLIENT_SetPassword                          = procedure  (RakServer:TRakInterface;_password:PChar); cdecl;
 RAKCLIENT_HasPassword                          = function   (RakServer:TRakInterface):boolean; cdecl;
 RAKCLIENT_SendBuffer                           = function   (RakServer:TRakInterface;data:pchar;bytelength,priority,reliability:integer;orderingChannel:byte):boolean; cdecl;
 RAKCLIENT_SendBitStream                        = function   (RakServer,BitStream:TRakInterface;priority,reliability:integer;orderingChannel:byte):boolean; cdecl;
 RAKCLIENT_Receive                              = function   (RakServer:TRakInterface):TRakInterface; cdecl;
 RAKCLIENT_DeallocatePacket                     = procedure  (RakServer,Packet:TRakInterface); cdecl;
 RAKCLIENT_PingServer                           = procedure  (RakServer:TRakInterface); cdecl;
 RAKCLIENT_PingServerHost                       = procedure  (RakServer:TRakInterface;host:Pchar;ServerPort,ClientPort:word;onlyReplyOnAcceptingConnections:boolean); cdecl;
 RAKCLIENT_GetAveragePing                       = function   (RakServer:TRakInterface):integer; cdecl;
 RAKCLIENT_GetLastPing                          = function   (RakServer:TRakInterface):integer; cdecl;
 RAKCLIENT_GetLowestPing                        = function   (RakServer:TRakInterface):integer; cdecl;
 RAKCLIENT_GetPlayerPing                        = function   (RakServer,PlayerID:TRakInterface):integer; cdecl;
 RAKCLIENT_StartOccasionalPing                  = procedure  (RakServer:TRakInterface); cdecl;
 RAKCLIENT_StopOccasionalPing                   = procedure  (RakServer:TRakInterface); cdecl;
 RAKCLIENT_IsConnected                          = function   (RakServer:TRakInterface):boolean; cdecl;
 RAKCLIENT_GetSynchronizedRandomInteger         = function   (RakServer:TRakInterface):cardinal; cdecl;
 RAKCLIENT_GenerateCompressionLayer             = function   (RakServer:TRakInterface;inputFrequencyTable:Pchar;inputLayer:boolean):boolean; cdecl;
 RAKCLIENT_DeleteCompressionLayer               = function   (RakServer:TRakInterface;inputLayer:boolean):boolean; cdecl;
 RAKCLIENT_SetTrackFrequencyTable               = procedure  (RakServer:TRakInterface;b:boolean); cdecl;
 RAKCLIENT_GetSendFrequencyTable                = function   (RakServer:TRakInterface;outputFrequencyTable:Pchar):boolean; cdecl;
 RAKCLIENT_GetCompressionRatio                  = function   (RakServer:TRakInterface):single; cdecl;
 RAKCLIENT_GetDecompressionRatio                = function   (RakServer:TRakInterface):single; cdecl;
 RAKCLIENT_GetStaticServerData                  = function   (RakServer:TRakInterface):TRakInterface; cdecl;
 RAKCLIENT_SetStaticServerData                  = procedure  (RakServer:TRakInterface;data:Pchar;bytelength:integer);cdecl;
 RAKCLIENT_GetStaticClientData                  = function   (RakServer,PlayerID:TRakInterface):TRakInterface; cdecl;
 RAKCLIENT_SetStaticClientData                  = procedure  (RakServer,PlayerID:TRakInterface;data:Pchar;bytelength:integer); cdecl;
 RAKCLIENT_SendStaticClientDataToServer         = procedure  (RakServer:TRakInterface); cdecl;
 RAKCLIENT_GetServerID                          = function   (RakServer:TRakInterface):TRakInterface; cdecl;
 RAKCLIENT_GetPlayerID                          = function   (RakServer:TRakInterface):TRakInterface; cdecl;
 RAKCLIENT_GetInternalID                        = function   (RakServer:TRakInterface):TRakInterface; cdecl;
 RAKCLIENT_PlayerIDToDottedIP                   = function   (RakServer,PlayerID:TRakInterface):Pchar ; cdecl;
 RAKCLIENT_PushBackPacket                       = procedure  (RakServer,Packet:TRakInterface;pushAtHead:boolean); cdecl;
 RAKCLIENT_SetTimeoutTime                       = procedure  (RakServer:TRakInterface;timeMS:cardinal);  cdecl;
 RAKCLIENT_SetMTUSize                           = function   (RakServer:TRakInterface;size:integer):boolean; cdecl;
 RAKCLIENT_GetMTUSize                           = function   (RakServer:TRakInterface):integer; cdecl;
 RAKCLIENT_AllowConnectionResponseIPMigration   = procedure  (RakServer:TRakInterface;allow:boolean); cdecl;
 RAKCLIENT_AdvertiseSystem                      = procedure  (RakServer:TRakInterface;host:Pchar;remotePort:word;data:Pchar;dataLength:integer); cdecl;
 RAKCLIENT_GetStatistics                        = function   (RakServer:TRakInterface):Pchar;  cdecl;
 RAKCLIENT_ApplyNetworkSimulator                = procedure  (RakServer:TRakInterface;maxSendBPS:double;minExtraPing,extraPingVariance:word);cdecl;
 RAKCLIENT_IsNetworkSimulatorActive             = function   (RakServer:TRakInterface):boolean; cdecl;
 RAKCLIENT_GetPlayerIndex                       = function   (RakServer:TRakInterface):word; cdecl;
 RAKCLIENT_DisableSecurity                      = procedure  (RakServer:TRakInterface); cdecl;
 RAKCLIENT_InitializeSecurity                   = procedure  (RakServer:TRakInterface;privKeyP,privKeyQ:PChar); cdecl;
 RAKCLIENT_UnregisterAsRemoteProcedureCall      = procedure  (RakServer:TRakInterface;uniqueID:Pchar); cdecl;
 RAKCLIENT_RegisterAsRemoteProcedureCall        = procedure  (RakServer:TRakInterface;uniqueID:Pchar;classcall:pointer;callback:TRPCIntCallback); cdecl;
 RAKCLIENT_RPCFromBuffer                        = function   (RakServer:TRakInterface;uniqueID:Pchar;data:Pchar;bitLength:cardinal;priority,reliability:integer;orderingChannel:byte;shiftTimestamp:boolean;BitStreamReplyFromTarget:TRakInterface):boolean; cdecl;
 RAKCLIENT_RPCFromBitStream                     = function   (RakServer:TRakInterface;uniqueID:Pchar;BitStream:TRakInterface;priority,reliability:integer;orderingChannel:byte;shiftTimestamp:boolean;BitStreamReplyFromTarget:TRakInterface):boolean; cdecl;



 RAKPEER_Initialize                             = function  (RakPeer:TRakInterface;maxConnections,localPort:word;_threadSleepTimer:integer;forceHostAddress:Pchar):boolean; cdecl;
 RAKPEER_InitializeSecurity                     = procedure (RakPeer:TrakInterface;pubKeyE,pubKeyN,privKeyP,privKeyQ:Pchar); cdecl;
 RAKPEER_DisableSecurity                        = procedure (RakPeer:TRakInterface); cdecl;
 RAKPEER_SetMaximumIncomingConnections          = procedure (RakPeer:TRakInterface;numberAllowed:word); cdecl;
 RAKPEER_GetMaximumIncomingConnections          = function  (RakPeer:TRakInterface):word ; cdecl;
 RAKPEER_SetIncomingPassword                    = procedure (RakPeer:TRakInterface;passwordData:pchar;passwordDataLength:integer); cdecl;
 RAKPEER_GetIncomingPassword                    = procedure (RakPeer:TRakInterface;passwordData:pchar;var passwordDataLength:integer); cdecl;
 RAKPEER_Connect                                = function  (RakPeer:TRakInterface;host:Pchar;remotePort:word;passwordData:Pchar;passwordDataLength:integer ):boolean; cdecl;
 RAKPEER_Disconnect                             = procedure (RakPeer:TRakInterface;blockDuration:integer;orderingChannel:byte ); cdecl;
 RAKPEER_IsActive                               = function  (RakPeer:TRakInterface):boolean ; cdecl;
 RAKPEER_GetConnectionList                      = function  (RakPeer:TRakInterface;var remoteplayerPlayerID:PTRakInterfaceList;var numberOfSystems:word):boolean; cdecl;
 RAKPEER_SendBuffer                             = function  (RakPeer:TRakInterface;data:Pchar;bytelength:integer;priority,reliability:integer;orderingChannel:byte;PlayerID:TRakInterface;broadcast:boolean):boolean; cdecl;
 RAKPEER_SendBitStream                          = function  (RakPeer,BitStream:TRakInterface;priority,reliability:integer;orderingChannel:byte;PlayerID:TRakInterface;broadcast:boolean):boolean; cdecl;
 RAKPEER_Receive                                = function  (RakPeer:TRakInterface):TRakInterface; cdecl;
 RAKPEER_DeallocatePacket                       = procedure (RakPeer:TRakInterface;Packet:TRakInterface); cdecl;
 RAKPEER_GetMaximumNumberOfPeers                = function  (RakPeer:TRakInterface):word ; cdecl;
 RAKPEER_RegisterAsRemoteProcedureCall          = procedure (RakPeer:TRakInterface;uniqueID:Pchar;classcall:pointer;callback:TRPCIntCallback);   cdecl;
 RAKPEER_UnregisterAsRemoteProcedureCall        = procedure (RakPeer:TRakInterface;uniqueID:Pchar); cdecl;
 RAKPEER_RPCBuffer                              = function  (RakPeer:TRakInterface;uniqueID:Pchar;data:Pchar;bitLength:cardinal;priority,reliability:integer;orderingChannel:byte;PlayerID:TRakInterface;broadcast,shiftTimestamp:boolean;NetworkID:TRakInterface;BsreplyFromTarget:TRakInterface):boolean; cdecl;
 RAKPEER_RPCBitStream                           = function  (RakPeer:TRakInterface;uniqueID:Pchar;BitStream:TRakInterface;priority,reliability:integer;orderingChannel:byte;PlayerID:TRakInterface;broadcast,shiftTimestamp:boolean;NetworkID,bsreplyFromTarget:TRakInterface):boolean; cdecl;
 RAKPEER_CloseConnection                        = procedure (RakPeer,PlayerID:TRakInterface;sendDisconnectionNotification:boolean;orderingChannel:byte); cdecl;
 RAKPEER_GetIndexFromPlayerID                   = function  (RakPeer,PlayerID:TRakInterface):integer; cdecl;
 RAKPEER_GetPlayerIDFromIndex                   = function  (RakPeer:TRakInterface;index:integer):TRakInterface;cdecl;
 RAKPEER_AddToBanList                           = procedure (RakPeerRakPeer:TRakInterface;IP:Pchar;milliseconds:cardinal); cdecl;
 RAKPEER_RemoveFromBanList                      = procedure (RakPeerRakPeer:TRakInterface;IP:Pchar); cdecl;
 RAKPEER_ClearBanList                           = procedure (RakPeer:TRakInterface); cdecl;
 RAKPEER_IsBanned                               = function  (RakPeer:TRakInterface;IP:Pchar):boolean; cdecl;
 RAKPEER_Ping                                   = procedure (RakPeer:TRakInterface;PlayerID:TRakInterface); cdecl;
 RAKPEER_PingHost                               = procedure (RakPeer:TRakInterface;host:Pchar;remotePort:word;onlyReplyOnAcceptingConnections:boolean); cdecl;
 RAKPEER_GetAveragePing                         = function  (RakPeer,PlayerID:TRakInterface):integer; cdecl;
 RAKPEER_GetLastPing                            = function  (RakPeer,PlayerID:TRakInterface):integer ; cdecl;
 RAKPEER_GetLowestPing                          = function  (RakPeer,PlayerID:TRakInterface):integer ; cdecl;
 RAKPEER_SetOccasionalPing                      = procedure (RakPeer:TRakInterface;doPing:boolean); cdecl;
 RAKPEER_GetRemoteStaticData                    = function  (RakPeer,PlayerID:TRakInterface):TRakInterface ; cdecl;
 RAKPEER_SetRemoteStaticData                    = procedure (RakPeer,PlayerID:TRakInterface;data:Pchar;bytelength:integer); cdecl;
 RAKPEER_SendStaticData                         = procedure (RakPeer,PlayerID:TRakInterface); cdecl;
 RAKPEER_SetOfflinePingResponse                 = procedure (RakPeer:TRakInterface;data:Pchar;bytelength:cardinal); cdecl;
 RAKPEER_GetInternalID                          = function  (RakPeer:TRakInterface):TRakInterface; cdecl;
 RAKPEER_GetExternalID                          = function  (RakPeer,PlayerID:TRakInterface):TRakInterface; cdecl;
 RAKPEER_SetTimeoutTime                         = procedure (RakPeer:TRakInterface;timeMS:cardinal;PlayerID:TRakInterface); cdecl;
 RAKPEER_SetMTUSize                             = function  (RakPeer:TRakInterface;size:integer):boolean; cdecl;
 RAKPEER_GetMTUSize                             = function  (RakPeer:TRakInterface ):integer; cdecl;
 RAKPEER_GetNumberOfAddresses                   = function  (RakPeer:TRakInterface ):cardinal; cdecl;
 RAKPEER_GetLocalIP                             = function  (RakPeer:TRakInterface;index:cardinal):Pchar; cdecl;
 RAKPEER_PlayerIDToDottedIP                     = function  (RakPeer,PlayerID:TRakInterface):Pchar; cdecl;
 RAKPEER_IPToPlayerID                           = procedure (RakPeer:TRakInterface;host:Pchar;remotePort:word;PlayerID:TRakInterface); cdecl;
 RAKPEER_AllowConnectionResponseIPMigration     = procedure (RakPeer:TRakInterface;allow:boolean); cdecl;
 RAKPEER_AdvertiseSystem                        = procedure (RakPeer:TRakInterface;host:Pchar;remotePort:word;data:Pchar;dataLength:integer); cdecl;
 RAKPEER_SetSplitMessageProgressInterval        = procedure (RakPeer:TRakInterface;interval:integer); cdecl;
 RAKPEER_SetUnreliableTimeout                   = procedure (RakPeer:TRakInterface;timeoutMS:cardinal); cdecl;
 RAKPEER_SetCompileFrequencyTable               = procedure (RakPeer:TRakInterface;doCompile:boolean); cdecl;
 RAKPEER_GetOutgoingFrequencyTable              = function  (RakPeer:TRakInterface;outputFrequencyTable:Pchar):boolean; cdecl;
 RAKPEER_GenerateCompressionLayer               = function  (RakPeer:TRakInterface;outputFrequencyTable:Pchar;inputLayer:boolean):boolean; cdecl;
 RAKPEER_DeleteCompressionLayer                 = function  (RakPeer:TRakInterface;inputLayer:boolean ):boolean; cdecl;
 RAKPEER_GetCompressionRatio                    = function  (RakPeer:TRakInterface):single ; cdecl;
 RAKPEER_GetDecompressionRatio                  = function  (RakPeer:TRakInterface):single ; cdecl;
 RAKPEER_AttachPlugin                           = procedure (RakPeer,MessageHandler:TRakInterface); cdecl;
 RAKPEER_DetachPlugin                           = procedure (RakPeer,MessageHandler:TRakInterface); cdecl;
 RAKPEER_PushBackPacket                         = procedure (RakPeer,Packet:TRakInterface;pushAtHead:boolean); cdecl;
 RAKPEER_SetRouterInterface                     = procedure (RakPeer,RouterInterface:TRakInterface); cdecl;
 RAKPEER_RemoveRouterInterface                  = procedure (RakPeer,RouterInterface:TRakInterface); cdecl;
 RAKPEER_ApplyNetworkSimulator                  = procedure (RakPeer:TRakInterface;maxSendBPS:double;minExtraPing,extraPingVariance:word); cdecl;
 RAKPEER_IsNetworkSimulatorActive               = function  (RakPeer:TRakInterface):boolean; cdecl;
 RAKPEER_GetStatistics                          = function  (RakPeer,PlayerID:TRakInterface):Pchar;  cdecl;

 RAKNETWORKID_peerToPeerMode                    = function (NetworkID:TRakInterface):boolean; cdecl;
 RAKNETWORKID_playerId                          = function (NetworkID:TRakInterface):TRakInterface; cdecl;
 RAKNETWORKID_localSystemId                     = function (NetworkID:TRakInterface):word; cdecl;


 RAKNETSTAT_ConvertToString                     = procedure (RakNetStatisticsStruct:Pchar;ResStr:Pchar;verbosityLevel:integer); cdecl;
 RAKSERVER_AttachPlugin                         = procedure (RakServer,MessageHandler:TRakInterface); cdecl;
 RAKSERVER_DetachPlugin                         = procedure (RakServer,MessageHandler:TRakInterface); cdecl;
 RAKCLIENT_AttachPlugin                         = procedure (RakClient,MessageHandler:TRakInterface); cdecl;
 RAKCLIENT_DetachPlugin                         = procedure (RakClient,MessageHandler:TRakInterface); cdecl;


 RAKMULTIPLAYER_ClientConstructor               = function  :TRakInterface; cdecl;
 RAKMULTIPLAYER_ServerConstructor               = function  :TRakInterface; cdecl;
 RAKMULTIPLAYER_PeerConstructor                 = function  :TRakInterface; cdecl;

 RAKMULTIPLAYER_ClientDestructor                = procedure (MultiplayerInterfce:TRakInterface); cdecl;
 RAKMULTIPLAYER_ServerDestructor                = procedure (MultiplayerInterfce:TRakInterface); cdecl;
 RAKMULTIPLAYER_PeerDestructor                  = procedure (MultiplayerInterfce:TRakInterface); cdecl;

 RAKMULTIPLAYER_ProcessPacketsPeer              = procedure (MultiplayerInterfce:TRakInterface); cdecl;
 RAKMULTIPLAYER_ProcessPacketsServer            = procedure (MultiplayerInterfce:TRakInterface); cdecl;
 RAKMULTIPLAYER_ProcessPacketsClient            = procedure (MultiplayerInterfce:TRakInterface); cdecl;

 RAKMULTIPLAYER_CallbackPeer                    = procedure (MultiplayerInterfce:TRakInterface;callbacklist:Pchar); cdecl;
 RAKMULTIPLAYER_CallbackServer                  = procedure (MultiplayerInterfce:TRakInterface;callbacklist:Pchar); cdecl;
 RAKMULTIPLAYER_CallbackClient                  = procedure (MultiplayerInterfce:TRakInterface;callbacklist:Pchar); cdecl;


 RAKMULTIPLAYER_GetCallbackClient               = function (MultiplayerInterfce:TRakInterface):Pchar; cdecl;
 RAKMULTIPLAYER_GetCallbackServer               = function (MultiplayerInterfce:TRakInterface):Pchar; cdecl;
 RAKMULTIPLAYER_GetCallbackPeer                 = function (MultiplayerInterfce:TRakInterface):Pchar; cdecl;

 RAKMULTIPLAYER_GetInternalClient               = function (MultiplayerInterfce:TRakInterface):TRakInterface; cdecl;
 RAKMULTIPLAYER_GetInternalServer               = function (MultiplayerInterfce:TRakInterface):TRakInterface; cdecl;
 RAKMULTIPLAYER_GetInternalPeer                 = function (MultiplayerInterfce:TRakInterface):TRakInterface; cdecl;



RAKNETROUTER_SetRestrictRoutingByType           = procedure (Router:TRakInterface;restrict:boolean); cdecl;
RAKNETROUTER_AddAllowedType                     = procedure (Router:TRakInterface;messageId:byte); cdecl;
RAKNETROUTER_RemoveAllowedType                  = procedure (Router:TRakInterface;messageId:byte); cdecl;
RAKNETROUTER_SetConnectionGraph                 = procedure (Router:TRakInterface;connectionGraph:TRakInterface); cdecl;
RAKNETROUTER_SendToSystemList                   = function  (Router:TRakInterface;data:Pchar;bitLength:cardinal;priority,reliability:integer;orderingChannel:byte;SystemAddressList:TRakInterface):boolean; cdecl;
RAKNETROUTER_Send                               = function  (Router:TRakInterface;data:Pchar;bitLength:cardinal;priority,reliability:integer;orderingChannel:byte;PlayerID:TRakInterface):boolean; cdecl;

RAKNETSYSTEMADDRL_constructor1                  = function  :TRakInterface; cdecl;
RAKNETSYSTEMADDRL_constructor2                  = function  (PlayerID:TRakInterface):TRakInterface; cdecl;
RAKNETSYSTEMADDRL_destructor                    = procedure (SystemaddrPointer:TRakInterface); cdecl;
RAKNETSYSTEMADDRL_AddSystem                     = procedure (SystemaddrPointer,PlayerID:TRakInterface); cdecl;
RAKNETSYSTEMADDRL_RandomizeOrder                = procedure (SystemaddrPointer:TRakInterface); cdecl;
RAKNETSYSTEMADDRL_Serialize                     = procedure (SystemaddrPointer,BitStream:TRakInterface); cdecl;
RAKNETSYSTEMADDRL_Deserialize                   = procedure (SystemaddrPointer,BitStream:TRakInterface); cdecl;
RAKNETSYSTEMADDRL_Save                          = procedure (SystemaddrPointer:TRakInterface;filename:Pchar); cdecl;
RAKNETSYSTEMADDRL_Load                          = procedure (SystemaddrPointer:TRakInterface;filename:Pchar); cdecl;
RAKNETSYSTEMADDRL_RemoveSystem                  = procedure (SystemaddrPointer,PlayerID:TRakInterface); cdecl;
RAKNETSYSTEMADDRL_Size                          = function  (SystemaddrPointer:TRakInterface):cardinal; cdecl;
RAKNETSYSTEMADDRL_Clear                         = procedure (SystemaddrPointer:TRakInterface); cdecl;
RAKNETSYSTEMADDRL_Item                          = function  (SystemaddrPointer:TRakInterface;Position:cardinal):TRakInterface; cdecl;

RAKNETConnGraph_constructor1                    = function  :TRakInterface; cdecl;
RAKNETConnGraph_destructor                      = procedure (ConnectionGraph:TRakInterface); cdecl;
RAKNETConnGraph_SetPassword                     = procedure (ConnectionGraph:TRakInterface;password:Pchar); cdecl;
RAKNETConnGraph_GetGraph                        = function  (ConnectionGraph:TRakInterface):TRakInterface;  cdecl;
RAKNETConnGraph_SetAutoAddNewConnections        = procedure (ConnectionGraph:TRakInterface;autoAdd:boolean);  cdecl;
RAKNETConnGraph_RequestConnectionGraph          = procedure (ConnectionGraph,RakPeerInterface,PlayerID:TRakInterface);   cdecl;
RAKNETConnGraph_AddNewConnection                = procedure (ConnectionGraph,RakPeerInterface,PlayerID:TRakInterface;groupId:byte);   cdecl;
RAKNETConnGraph_SetGroupId                      = procedure (ConnectionGraph:TRakInterface;groupId:byte);    cdecl;
RAKNETConnGraph_SubscribeToGroup                = procedure (ConnectionGraph:TRakInterface;groupId:byte);   cdecl;
RAKNETConnGraph_UnsubscribeFromGroup            = procedure (ConnectionGraph:TRakInterface;groupId:byte);  cdecl;


RAKNETPluginDelphi_constructor                  = function  : TRakInterface; cdecl;
RAKNETPluginDelphi_destructor                   = procedure (Plugin:TRakInterface); cdecl;
RAKNETPluginDelphi_GetCallbackList              = function  (Plugin:TRakInterface):TRakInterface; cdecl;

RAKNETTCPInterface_constructor                  = function : TRakInterface; cdecl;
RAKNETTCPInterface_destructor                   = procedure  (TCPInterface:TRakInterface); cdecl;
RAKNETTCPInterface_Start                        = function   (TCPInterface:TRakInterface;port:word;maxIncomingConnections:word):boolean; cdecl;
RAKNETTCPInterface_Stop                         = procedure  (TCPInterface:TRakInterface); cdecl;
RAKNETTCPInterface_Connect                      = function   (TCPInterface:TRakInterface;host:Pchar;remotePort:Word):TRakInterface; cdecl;
RAKNETTCPInterface_Send                         = procedure  (TCPInterface:TRakInterface;data:Pchar;length:cardinal;PlayerID:TRakInterface); cdecl;
RAKNETTCPInterface_Receive                      = function   (TCPInterface:TRakInterface):TRakInterface; cdecl;
RAKNETTCPInterface_CloseConnection              = procedure  (TCPInterface,PlayerID:TRakInterface); cdecl;
RAKNETTCPInterface_DeallocatePacket             = procedure  (TCPInterface,Packet:TRakInterface); cdecl;
RAKNETTCPInterface_HasNewConnection             = function   (TCPInterface:TRakInterface):TRakInterface; cdecl;
RAKNETTCPInterface_HasLostConnection            = function   (TCPInterface:TRakInterface):TRakInterface; cdecl;

RAKNETHuffComp_GenerateTreeFromStrings          = procedure  (input:Pchar;inputLength:cardinal;languageID:integer); cdecl;
RAKNETHuffComp_EncodeString                     = procedure  (input:Pchar;maxCharsToWrite:Integer;output:TRakInterface;languageID:integer); cdecl;
RAKNETHuffComp_DecodeString                     = function   (output:Pchar;maxCharsToWrite:integer;input:TRakInterface;languageID:integer):boolean; cdecl;


RAKNETBZipInit                                  = procedure ; cdecl;
RAKNETBZipUnInit                                = procedure ; cdecl;
RAKNETBZip_ClearDecompress                      = procedure ; cdecl;
RAKNETBZip_ClearCompress                        = procedure ; cdecl;
RAKNETBZip_Decompress                           = function(Input:Pchar;InputLength:cardinal;ignoreStreamEnd:boolean;var outData:Pchar;var outSize:cardinal): boolean; cdecl;
RAKNETBZip_Compress                             = function(Input:Pchar;InputLength:cardinal;finish:boolean;var outData:Pchar;var outSize:cardinal): boolean; cdecl;

RAKNETFileLogger_Constructor                    = function :TRakInterface ; cdecl;
RAKNETFileLogger_Destructor                     = procedure (FileLogger:TrakInterface); cdecl;
RAKNETFileLogger_WriteLog                       = procedure (FileLogger:TrakInterface;Str:Pchar); cdecl;
RAKNETFileLogger_SetPrintID                     = procedure (FileLogger:TrakInterface;print:boolean);cdecl;
RAKNETFileLogger_SetPrintAcks                   = procedure (FileLogger:TrakInterface;print:boolean); cdecl;

RAKNETConsoleLogger_Constructor                 = function :TRakInterface ; cdecl;
RAKNETConsoleLogger_Destructor                  = procedure (FileLogger:TrakInterface); cdecl;
RAKNETConsoleLogger_WriteLog                    = procedure (FileLogger:TrakInterface;Str:Pchar); cdecl;
RAKNETConsoleLogger_SetPrintID                  = procedure (FileLogger:TrakInterface;print:boolean);cdecl;
RAKNETConsoleLogger_SetPrintAcks                = procedure (FileLogger:TrakInterface;print:boolean); cdecl;

RAKReplicaManager_Constructor                   = function:TRakInterface; cdecl;
RAKReplicaManager_Destructor                    = procedure (ReplicaManager:TRakInterface);   cdecl;
RAKReplicaManager_SetAutoParticipateNewConnections = procedure (ReplicaManager:TRakInterface;autoAdd:boolean);   cdecl;
RAKReplicaManager_AddParticipant                = procedure (ReplicaManager,PlayerID:TRakInterface); cdecl;
RAKReplicaManager_RemoveParticipant             = procedure (ReplicaManager,PlayerID:TRakInterface); cdecl;
RAKReplicaManager_Construct                     = procedure (ReplicaManager,Replica:TRakInterface;isCopy:boolean;PlayerID:TRakInterface;broadcast:boolean); cdecl;
RAKReplicaManager_Destruct                      = procedure (ReplicaManager,Replica,PlayerID:TRakInterface;broadcast:boolean); cdecl;
RAKReplicaManager_ReferencePointer              = procedure (ReplicaManager,Replica:TRakInterface);  cdecl;
RAKReplicaManager_DereferencePointer            = procedure (ReplicaManager,Replica:TRakInterface);  cdecl;
RAKReplicaManager_SetScope                      = procedure (ReplicaManager,Replica:TRakInterface;inScope:boolean;PlayerID:TRakInterface;broadcast:boolean);  cdecl;
RAKReplicaManager_SignalSerializeNeeded         = procedure (ReplicaManager,Replica,PlayerID:TRakInterface;broadcast:boolean); cdecl;
RAKReplicaManager_SetReceiveConstructionCB      = procedure (ReplicaManager,DelphiObj:TRakInterface;constructionCB:TconstructionCB);  cdecl;
RAKReplicaManager_SetDownloadCompleteCB         = procedure (ReplicaManager,DelphiObj:TRakInterface;sendDownloadCompleteCB:TsendDownloadCompleteCB;receiveDownloadCompleteCB:TreceiveDownloadCompleteCB);  cdecl;
RAKReplicaManager_SetSendChannel                = procedure (ReplicaManager:TRakInterface;channel:byte);   cdecl;
RAKReplicaManager_SetAutoConstructToNewParticipants = procedure (ReplicaManager:TRakInterface;autoConstruct:boolean);  cdecl;
RAKReplicaManager_SetDefaultScope               = procedure (ReplicaManager:TRakInterface;scope:boolean);  cdecl;
RAKReplicaManager_EnableReplicaInterfaces       = procedure (ReplicaManager,Replica:TRakInterface;interfaceFlags:byte);  cdecl;
RAKReplicaManager_DisableReplicaInterfaces      = procedure (ReplicaManager,Replica:TRakInterface;interfaceFlags:byte);   cdecl;
RAKReplicaManager_IsConstructed                 = function (ReplicaManager,Replica,PlayerID:TRakInterface):boolean;   cdecl;
RAKReplicaManager_IsInScope                     = function (ReplicaManager,Replica,PlayerID:TRakInterface):boolean;   cdecl;
RAKReplicaManager_GetReplicaCount               = function (ReplicaManager:TRakInterface):cardinal;           cdecl;
RAKReplicaManager_GetReplicaAtIndex             = function (ReplicaManager:TRakInterface;index:cardinal):TRakInterface;     cdecl;

RAKReplicaMember_Constructor                    = function  :TRakInterface ; cdecl;
RAKReplicaMember_Destructor                     = procedure (ReplicaMember:TRakInterface); cdecl;
RAKReplicaMember_GetInternalCallback            = function  (ReplicaMember:TRakInterface):pchar; cdecl;
RAKReplicaMember_SetServer                      = procedure (ReplicaMember:TRakInterface;xServer:boolean); cdecl;
RAKReplicaMember_GetNetworkID                   = function  (ReplicaMember:TRakInterface):TRakInterface; cdecl;
RAKReplicaMember_SetNetworkID                   = procedure (ReplicaMember,NetworkID:TRakInterface); cdecl;
RAKReplicaMember_SetParent                      = procedure (ReplicaMember:TRakInterface;_parent:pointer); cdecl;
RAKReplicaMember_GetParent                      = function  (ReplicaMember:TRakInterface):pointer; cdecl;
RAKReplicaMember_GetStaticNetworkID             = function  (ReplicaMember:TRakInterface):word; cdecl;
RAKReplicaMember_SetStaticNetworkID             = procedure (ReplicaMember:TRakInterface;i:word); cdecl;
RAKReplicaMember_IsNetworkIDAuthority           = function  (ReplicaMember:TRakInterface):boolean; cdecl;
RAKReplicaMember_SetExternalPlayerID            = procedure (ReplicaMember,PlayerID:TRakInterface); cdecl;
RAKReplicaMember_GetExternalPlayerID            = function  (ReplicaMember:TRakInterface):TRakInterface; cdecl;
RAKReplicaMember_GET_BASE_OBJECT_FROM_ID        = function  (ReplicaMember,NetworkID:TRakInterface):TRakInterface; cdecl;
RAKReplicaMember_GET_OBJECT_FROM_ID             = function  (ReplicaMember,NetworkID:TRakInterface):TRakInterface; cdecl;




 {    TYPE DEF DECLARATIONS }

var
TRAKNET_InitCommandParser                       : RAKNET_InitCommandParser           ;
TRAKNET_InitClientInterface                     : RAKNET_InitClientInterface         ;
TRAKNET_InitServerInterface                     : RAKNET_InitServerInterface         ;
TRAKNET_InitPeerInterface                       : RAKNET_InitPeerInterface           ;
TRAKNET_InitConsoleServer                       : RAKNET_InitConsoleServer           ;
TRAKNET_InitReplicaManager                      : RAKNET_InitReplicaManager          ;
TRAKNET_InitLogCommandParser                    : RAKNET_InitLogCommandParser        ;
TRAKNET_InitPacketLogger                        : RAKNET_InitPacketLogger            ;
TRAKNET_InitRaknetTransport                     : RAKNET_InitRaknetTransport         ;
TRAKNET_InitTelnetTransport                     : RAKNET_InitTelnetTransport         ;
TRAKNET_InitPacketConsoleLogger                 : RAKNET_InitPacketConsoleLogger     ;
TRAKNET_InitPacketFileLogger                    : RAKNET_InitPacketFileLogger        ;
TRAKNET_InitRouter                              : RAKNET_InitRouter                  ;
TRAKNET_InitConnectionGraph                     : RAKNET_InitConnectionGraph         ;
TRAKNET_GetUnAssignedPlayerID                   : RAKNET_GetUnAssignedPlayerID       ;
TRAKNET_UnInitClientInterface                   : RAKNET_UnInitClientInterface       ;
TRAKNET_UnInitServerInterface                   : RAKNET_UnInitServerInterface       ;
TRAKNET_UnInitPeerInterface                     : RAKNET_UnInitPeerInterface         ;
TRAKNET_UnInitConsoleServer                     : RAKNET_UnInitConsoleServer         ;
TRAKNET_UnInitReplicaManager                    : RAKNET_UnInitReplicaManager        ;
TRAKNET_UnInitLogCommandParser                  : RAKNET_UnInitLogCommandParser      ;
TRAKNET_UnInitPacketLogger                      : RAKNET_UnInitPacketLogger          ;
TRAKNET_UnInitCommandParser                     : RAKNET_UnInitCommandParser         ;
TRAKNET_UnInitRaknetTransport                   : RAKNET_UnInitRaknetTransport       ;
TRAKNET_UnInitTelnetTransport                   : RAKNET_UnInitTelnetTransport       ;
TRAKNET_UnInitPacketConsoleLogger               : RAKNET_UnInitPacketConsoleLogger   ;
TRAKNET_UnInitPacketFileLogger                  : RAKNET_UnInitPacketFileLogger      ;
TRAKNET_UnInitRouter                            : RAKNET_UnInitRouter                ;
TRAKNET_UnInitConnectionGraph                   : RAKNET_UnInitConnectionGraph       ;
TBITSTREAM_constructor1                         : BITSTREAM_constructor1             ;
TBITSTREAM_constructor2                         : BITSTREAM_constructor2             ;
TBITSTREAM_constructor3                         : BITSTREAM_constructor3             ;
TBITSTREAM_destructor                           : BITSTREAM_destructor               ;
TBITSTREAM_reset                                : BITSTREAM_reset                    ;
TBITSTREAM_BSWriteFromWSize                     : BITSTREAM_BSWriteFromWSize         ;
TBITSTREAM_BSWriteFrom                          : BITSTREAM_BSWriteFrom              ;
TBITSTREAM_ResetReadPointer                     : BITSTREAM_ResetReadPointer         ;
TBITSTREAM_ResetWritePointer                    : BITSTREAM_ResetWritePointer        ;
TBITSTREAM_AssertStreamEmpty                    : BITSTREAM_AssertStreamEmpty        ;
TBITSTREAM_PrintBits                            : BITSTREAM_PrintBits                ;
TBITSTREAM_IgnoreBits                           : BITSTREAM_IgnoreBits               ;
TBITSTREAM_SetWriteOffset                       : BITSTREAM_SetWriteOffset           ;
TBITSTREAM_GetNumberOfBitsUsed                  : BITSTREAM_GetNumberOfBitsUsed      ;
TBITSTREAM_GetWriteOffset                       : BITSTREAM_GetWriteOffset           ;
TBITSTREAM_GetNumberOfBytesUsed                 : BITSTREAM_GetNumberOfBytesUsed     ;
TBITSTREAM_GetReadOffset                        : BITSTREAM_GetReadOffset            ;
TBITSTREAM_SetReadOffset                        : BITSTREAM_SetReadOffset            ;
TBITSTREAM_GetNumberOfUnreadBits                : BITSTREAM_GetNumberOfUnreadBits    ;
TBITSTREAM_CopyData                             : BITSTREAM_CopyData                 ;
TBITSTREAM_SetData                              : BITSTREAM_SetData                  ;
TBITSTREAM_GetData                              : BITSTREAM_GetData                  ;
TBITSTREAM_WriteBits                            : BITSTREAM_WriteBits                ;
TBITSTREAM_WriteAlignedBytes                    : BITSTREAM_WriteAlignedBytes        ;
TBITSTREAM_ReadAlignedBytes                     : BITSTREAM_ReadAlignedBytes         ;
TBITSTREAM_AlignWriteToByteBoundary             : BITSTREAM_AlignWriteToByteBoundary ;
TBITSTREAM_AlignReadToByteBoundary              : BITSTREAM_AlignReadToByteBoundary  ;
TBITSTREAM_ReadBits                             : BITSTREAM_ReadBits                 ;
TBITSTREAM_Write                                : BITSTREAM_Write                    ;
TBITSTREAM_Write0                               : BITSTREAM_Write0                   ;
TBITSTREAM_Write1                               : BITSTREAM_Write1                   ;
TBITSTREAM_ReadBit                              : BITSTREAM_ReadBit                  ;
TBITSTREAM_AssertCopyData                       : BITSTREAM_AssertCopyData           ;
TBITSTREAM_SetNumberOfBitsAllocated             : BITSTREAM_SetNumberOfBitsAllocated ;
TBITSTREAM_AddBitsAndReallocate                 : BITSTREAM_AddBitsAndReallocate     ;
TBITSTREAM_Serialize_Byte                       : BITSTREAM_Serialize_Byte           ;
TBITSTREAM_Serialize_Word                       : BITSTREAM_Serialize_Word           ;
TBITSTREAM_Serialize_LongWord                   : BITSTREAM_Serialize_LongWord       ;
TBITSTREAM_Serialize_Float                      : BITSTREAM_Serialize_Float          ;
TBITSTREAM_Serialize_Double                     : BITSTREAM_Serialize_Double         ;
TBITSTREAM_SerializeDelta_Byte                  : BITSTREAM_SerializeDelta_Byte      ;
TBITSTREAM_SerializeDelta_Word                  : BITSTREAM_SerializeDelta_Word      ;
TBITSTREAM_SerializeDelta_LongWord              : BITSTREAM_SerializeDelta_LongWord  ;
TBITSTREAM_SerializeDelta_Float                 : BITSTREAM_SerializeDelta_Float     ;
TBITSTREAM_SerializeDelta_Double                : BITSTREAM_SerializeDelta_Double    ;
TBITSTREAM_Write_Byte                           : BITSTREAM_Write_Byte               ;
TBITSTREAM_Write_Word                           : BITSTREAM_Write_Word               ;
TBITSTREAM_Write_LongWord                       : BITSTREAM_Write_LongWord           ;
TBITSTREAM_Write_Float                          : BITSTREAM_Write_Float              ;
TBITSTREAM_Write_Double                         : BITSTREAM_Write_Double             ;
TBITSTREAM_WriteCompressed_Byte                 : BITSTREAM_WriteCompressed_Byte     ;
TBITSTREAM_WriteCompressed_Word                 : BITSTREAM_WriteCompressed_Word     ;
TBITSTREAM_WriteCompressed_LongWord             : BITSTREAM_WriteCompressed_LongWord ;
TBITSTREAM_WriteCompressed_Float                : BITSTREAM_WriteCompressed_Float    ;
TBITSTREAM_WriteCompressed_Double               : BITSTREAM_WriteCompressed_Double   ;
TBITSTREAM_WriteDelta_Byte                      : BITSTREAM_WriteDelta_Byte          ;
TBITSTREAM_WriteDelta_Word                      : BITSTREAM_WriteDelta_Word          ;
TBITSTREAM_WriteDelta_LongWord                  : BITSTREAM_WriteDelta_LongWord      ;
TBITSTREAM_WriteDelta_Float                     : BITSTREAM_WriteDelta_Float         ;
TBITSTREAM_WriteDelta_Double                    : BITSTREAM_WriteDelta_Double        ;
TBITSTREAM_WriteCompressedDelta_Byte            : BITSTREAM_WriteCompressedDelta_Byte          ;
TBITSTREAM_WriteCompressedDelta_Word            : BITSTREAM_WriteCompressedDelta_Word          ;
TBITSTREAM_WriteCompressedDelta_LongWord        : BITSTREAM_WriteCompressedDelta_LongWord      ;
TBITSTREAM_WriteCompressedDelta_Float           : BITSTREAM_WriteCompressedDelta_Float         ;
TBITSTREAM_WriteCompressedDelta_Double          : BITSTREAM_WriteCompressedDelta_Double        ;
TBITSTREAM_Read_Byte                            : BITSTREAM_Read_Byte                            ;
TBITSTREAM_Read_Word                            : BITSTREAM_Read_Word                            ;
TBITSTREAM_Read_LongWord                        : BITSTREAM_Read_LongWord                        ;
TBITSTREAM_Read_Float                           : BITSTREAM_Read_Float                           ;
TBITSTREAM_Read_Double                          : BITSTREAM_Read_Double                          ;
TBITSTREAM_ReadCompressed_Byte                  : BITSTREAM_ReadCompressed_Byte                  ;
TBITSTREAM_ReadCompressed_Word                  : BITSTREAM_ReadCompressed_Word                  ;
TBITSTREAM_ReadCompressed_LongWord              : BITSTREAM_ReadCompressed_LongWord              ;
TBITSTREAM_ReadCompressed_Float                 : BITSTREAM_ReadCompressed_Float                 ;
TBITSTREAM_ReadCompressed_Double                : BITSTREAM_ReadCompressed_Double                ;
TBITSTREAM_ReadDelta_Byte                       : BITSTREAM_ReadDelta_Byte                       ;
TBITSTREAM_ReadDelta_Word                       : BITSTREAM_ReadDelta_Word                       ;
TBITSTREAM_ReadDelta_LongWord                   : BITSTREAM_ReadDelta_LongWord                   ;
TBITSTREAM_ReadDelta_Float                      : BITSTREAM_ReadDelta_Float                      ;
TBITSTREAM_ReadDelta_Double                     : BITSTREAM_ReadDelta_Double                     ;
TBITSTREAM_ReadCompressedDelta_Byte             : BITSTREAM_ReadCompressedDelta_Byte             ;
TBITSTREAM_ReadCompressedDelta_Word             : BITSTREAM_ReadCompressedDelta_Word             ;
TBITSTREAM_ReadCompressedDelta_LongWord         : BITSTREAM_ReadCompressedDelta_LongWord         ;
TBITSTREAM_ReadCompressedDelta_Float            : BITSTREAM_ReadCompressedDelta_Float            ;
TBITSTREAM_ReadCompressedDelta_Double           : BITSTREAM_ReadCompressedDelta_Double           ;
TBITSTREAM_SerializeCompressed_Byte             : BITSTREAM_SerializeCompressed_Byte             ;
TBITSTREAM_SerializeCompressed_Word             : BITSTREAM_SerializeCompressed_Word             ;
TBITSTREAM_SerializeCompressed_LongWord         : BITSTREAM_SerializeCompressed_LongWord         ;
TBITSTREAM_SerializeCompressed_Float            : BITSTREAM_SerializeCompressed_Float            ;
TBITSTREAM_SerializeCompressed_Double           : BITSTREAM_SerializeCompressed_Double           ;
TBITSTREAM_SerializeCompressedDelta_Byte        : BITSTREAM_SerializeCompressedDelta_Byte        ;
TBITSTREAM_SerializeCompressedDelta_Word        : BITSTREAM_SerializeCompressedDelta_Word        ;
TBITSTREAM_SerializeCompressedDelta_LongWord    : BITSTREAM_SerializeCompressedDelta_LongWord    ;
TBITSTREAM_SerializeCompressedDelta_Float       : BITSTREAM_SerializeCompressedDelta_Float       ;
TBITSTREAM_SerializeCompressedDelta_Double      : BITSTREAM_SerializeCompressedDelta_Double      ;
TBITSTREAM_Serialize                            : BITSTREAM_Serialize                            ;
TBITSTREAM_SerializeBits                        : BITSTREAM_SerializeBits                        ;
TBITSTREAM_Read                                 : BITSTREAM_Read                                 ;
TBITSTREAM_SerializeNormVectorFloat             : BITSTREAM_SerializeNormVectorFloat             ;
TBITSTREAM_SerializeNormVectorDouble            : BITSTREAM_SerializeNormVectorDouble            ;
TBITSTREAM_SerializeVectorFloat                 : BITSTREAM_SerializeVectorFloat                 ;
TBITSTREAM_SerializeVectorDouble                : BITSTREAM_SerializeVectorDouble                ;
TBITSTREAM_SerializeNormQuatFloat               : BITSTREAM_SerializeNormQuatFloat               ;
TBITSTREAM_SerializeNormQuatDouble              : BITSTREAM_SerializeNormQuatDouble              ;
TBITSTREAM_SerializeOrthMatrixFloat             : BITSTREAM_SerializeOrthMatrixFloat             ;
TBITSTREAM_SerializeOrthMatrixDouble            : BITSTREAM_SerializeOrthMatrixDouble            ;
TBITSTREAM_ReadNormVectorFloat                  : BITSTREAM_ReadNormVectorFloat                  ;
TBITSTREAM_ReadNormVectorDouble                 : BITSTREAM_ReadNormVectorDouble                 ;
TBITSTREAM_ReadVectorFloat                      : BITSTREAM_ReadVectorFloat                      ;
TBITSTREAM_ReadVectorDouble                     : BITSTREAM_ReadVectorDouble                     ;
TBITSTREAM_ReadNormQuatFloat                    : BITSTREAM_ReadNormQuatFloat                    ;
TBITSTREAM_ReadNormQuatDouble                   : BITSTREAM_ReadNormQuatDouble                   ;
TBITSTREAM_ReadOrthMatrixFloat                  : BITSTREAM_ReadOrthMatrixFloat                  ;
TBITSTREAM_ReadOrthMatrixDouble                 : BITSTREAM_ReadOrthMatrixDouble                 ;
TBITSTREAM_WriteNormVectorFloat                 : BITSTREAM_WriteNormVectorFloat                  ;
TBITSTREAM_WriteNormVectorDouble                : BITSTREAM_WriteNormVectorDouble                 ;
TBITSTREAM_WriteVectorFloat                     : BITSTREAM_WriteVectorFloat                      ;
TBITSTREAM_WriteVectorDouble                    : BITSTREAM_WriteVectorDouble                     ;
TBITSTREAM_WriteNormQuatFloat                   : BITSTREAM_WriteNormQuatFloat                    ;
TBITSTREAM_WriteNormQuatDouble                  : BITSTREAM_WriteNormQuatDouble                   ;
TBITSTREAM_WriteOrthMatrixFloat                 : BITSTREAM_WriteOrthMatrixFloat                  ;
TBITSTREAM_WriteOrthMatrixDouble                : BITSTREAM_WriteOrthMatrixDouble                 ;
TRAKPacket_PlayerIndex                          : RAKPacket_PlayerIndex                          ;
TRAKPacket_PlayerID                             : RAKPacket_PlayerID                             ;
TRAKPacket_Length                               : RAKPacket_Length                               ;
TRAKPacket_bitSize                              : RAKPacket_bitSize                              ;
TRAKPacket_data                                 : RAKPacket_data                                 ;
TRAKRPCParameters_Input                         : RAKRPCParameters_Input                          ;
TRAKRPCParameters_NumberOfBitsOfData            : RAKRPCParameters_NumberOfBitsOfData             ;
TRAKRPCParameters_Sender                        : RAKRPCParameters_Sender                         ;
TRAKRPCParameters_Recipient                     : RAKRPCParameters_Recipient                      ;
TRAKRPCParameters_ReplyToSender                 : RAKRPCParameters_ReplyToSender                  ;
TRAKPlayerID_binaryAddress                      : RAKPlayerID_binaryAddress                       ;
TRAKPlayerID_port                               : RAKPlayerID_port                                ;
TRAKPlayerID_tostring                           : RAKPlayerID_tostring                            ;
TRAKSERVER_constructor                          : RAKSERVER_constructor                          ;
TRAKSERVER_destructor                           : RAKSERVER_destructor                           ;
TRAKSERVER_Start                                : RAKSERVER_Start                                ;
TRAKSERVER_InitializeSecurity                   : RAKSERVER_InitializeSecurity                   ;
TRAKSERVER_DisableSecurity                      : RAKSERVER_DisableSecurity                      ;
TRAKSERVER_SetPassword                          : RAKSERVER_SetPassword                          ;
TRAKSERVER_HasPassword                          : RAKSERVER_HasPassword                          ;
TRAKSERVER_Disconnect                           : RAKSERVER_Disconnect                           ;
TRAKSERVER_SendBuffer                           : RAKSERVER_SendBuffer                           ;
TRAKSERVER_SendBitStream                        : RAKSERVER_SendBitStream                        ;
TRAKSERVER_Receive                              : RAKSERVER_Receive                              ;
TRAKSERVER_Kick                                 : RAKSERVER_Kick                                 ;
TRAKSERVER_DeallocatePacket                     : RAKSERVER_DeallocatePacket                     ;
TRAKSERVER_SetAllowedPlayers                    : RAKSERVER_SetAllowedPlayers                    ;
TRAKSERVER_GetAllowedPlayers                    : RAKSERVER_GetAllowedPlayers                    ;
TRAKSERVER_GetConnectedPlayers                  : RAKSERVER_GetConnectedPlayers                  ;
TRAKSERVER_GetPlayerIPFromID                    : RAKSERVER_GetPlayerIPFromID                    ;
TRAKSERVER_PingPlayer                           : RAKSERVER_PingPlayer                           ;
TRAKSERVER_GetAveragePing                       : RAKSERVER_GetAveragePing                       ;
TRAKSERVER_GetLastPing                          : RAKSERVER_GetLastPing                          ;
TRAKSERVER_GetLowestPing                        : RAKSERVER_GetLowestPing                        ;
TRAKSERVER_StartOccasionalPing                  : RAKSERVER_StartOccasionalPing                  ;
TRAKSERVER_StopOccasionalPing                   : RAKSERVER_StopOccasionalPing                   ;
TRAKSERVER_IsActive                             : RAKSERVER_IsActive                             ;
TRAKSERVER_GetSynchronizedRandomInteger         : RAKSERVER_GetSynchronizedRandomInteger         ;
TRAKSERVER_StartSynchronizedRandomInteger       : RAKSERVER_StartSynchronizedRandomInteger       ;
TRAKSERVER_StopSynchronizedRandomInteger        : RAKSERVER_StopSynchronizedRandomInteger        ;
TRAKSERVER_GenerateCompressionLayer             : RAKSERVER_GenerateCompressionLayer             ;
TRAKSERVER_DeleteCompressionLayer               : RAKSERVER_DeleteCompressionLayer               ;
TRAKSERVER_SetTrackFrequencyTable               : RAKSERVER_SetTrackFrequencyTable               ;
TRAKSERVER_GetSendFrequencyTable                : RAKSERVER_GetSendFrequencyTable                ;
TRAKSERVER_GetCompressionRatio                  : RAKSERVER_GetCompressionRatio                  ;
TRAKSERVER_GetDecompressionRatio                : RAKSERVER_GetDecompressionRatio                ;
TRAKSERVER_GetStaticServerData                  : RAKSERVER_GetStaticServerData                  ;
TRAKSERVER_SetStaticServerData                  : RAKSERVER_SetStaticServerData                  ;
TRAKSERVER_SetStaticClientData                  : RAKSERVER_SetStaticClientData                  ;
TRAKSERVER_SetRelayStaticClientData             : RAKSERVER_SetRelayStaticClientData             ;
TRAKSERVER_SendStaticServerDataToClient         : RAKSERVER_SendStaticServerDataToClient         ;
TRAKSERVER_SetOfflinePingResponse               : RAKSERVER_SetOfflinePingResponse               ;
TRAKSERVER_GetStaticClientData                  : RAKSERVER_GetStaticClientData                  ;
TRAKSERVER_ChangeStaticClientData               : RAKSERVER_ChangeStaticClientData               ;
TRAKSERVER_GetNumberOfAddresses                 : RAKSERVER_GetNumberOfAddresses                 ;
TRAKSERVER_GetLocalIP                           : RAKSERVER_GetLocalIP                           ;
TRAKSERVER_GetInternalID                        : RAKSERVER_GetInternalID                        ;
TRAKSERVER_PushBackPacket                       : RAKSERVER_PushBackPacket                       ;
TRAKSERVER_GetIndexFromPlayerID                 : RAKSERVER_GetIndexFromPlayerID                 ;
TRAKSERVER_GetPlayerIDFromIndex                 : RAKSERVER_GetPlayerIDFromIndex                 ;
TRAKSERVER_AddToBanList                         : RAKSERVER_AddToBanList                         ;
TRAKSERVER_RemoveFromBanList                    : RAKSERVER_RemoveFromBanList                    ;
TRAKSERVER_ClearBanList                         : RAKSERVER_ClearBanList                         ;
TRAKSERVER_IsBanned                             : RAKSERVER_IsBanned                             ;
TRAKSERVER_IsActivePlayerID                     : RAKSERVER_IsActivePlayerID                     ;
TRAKSERVER_SetTimeoutTime                       : RAKSERVER_SetTimeoutTime                       ;
TRAKSERVER_SetMTUSize                           : RAKSERVER_SetMTUSize                           ;
TRAKSERVER_GetMTUSize                           : RAKSERVER_GetMTUSize                           ;
TRAKSERVER_AdvertiseSystem                      : RAKSERVER_AdvertiseSystem                      ;
TRAKSERVER_GetStatistics                        : RAKSERVER_GetStatistics                        ;
TRAKSERVER_ApplyNetworkSimulator                : RAKSERVER_ApplyNetworkSimulator                ;
TRAKSERVER_IsNetworkSimulatorActive             : RAKSERVER_IsNetworkSimulatorActive             ;
TRAKSERVER_UnregisterAsRemoteProcedureCall      : RAKSERVER_UnregisterAsRemoteProcedureCall      ;
TRAKSERVER_RegisterAsRemoteProcedureCall        : RAKSERVER_RegisterAsRemoteProcedureCall        ;
TRAKSERVER_RPCFromBuffer                        : RAKSERVER_RPCFromBuffer                        ;
TRAKSERVER_RPCFromBitStream                     : RAKSERVER_RPCFromBitStream                     ;
TRAKCLIENT_constructor                          :  RAKCLIENT_constructor                          ;
TRAKCLIENT_destructor                           :  RAKCLIENT_destructor                           ;
TRAKCLIENT_Connect                              :  RAKCLIENT_Connect                              ;
TRAKCLIENT_Disconnect                           :  RAKCLIENT_Disconnect                           ;
TRAKCLIENT_SetPassword                          :  RAKCLIENT_SetPassword                          ;
TRAKCLIENT_HasPassword                          :  RAKCLIENT_HasPassword                          ;
TRAKCLIENT_SendBuffer                           :  RAKCLIENT_SendBuffer                           ;
TRAKCLIENT_SendBitStream                        :  RAKCLIENT_SendBitStream                        ;
TRAKCLIENT_Receive                              :  RAKCLIENT_Receive                              ;
TRAKCLIENT_DeallocatePacket                     :  RAKCLIENT_DeallocatePacket                     ;
TRAKCLIENT_PingServer                           :  RAKCLIENT_PingServer                           ;
TRAKCLIENT_PingServerHost                       :  RAKCLIENT_PingServerHost                       ;
TRAKCLIENT_GetAveragePing                       :  RAKCLIENT_GetAveragePing                       ;
TRAKCLIENT_GetLastPing                          :  RAKCLIENT_GetLastPing                          ;
TRAKCLIENT_GetLowestPing                        :  RAKCLIENT_GetLowestPing                        ;
TRAKCLIENT_GetPlayerPing                        :  RAKCLIENT_GetPlayerPing                        ;
TRAKCLIENT_StartOccasionalPing                  :  RAKCLIENT_StartOccasionalPing                  ;
TRAKCLIENT_StopOccasionalPing                   :  RAKCLIENT_StopOccasionalPing                   ;
TRAKCLIENT_IsConnected                          :  RAKCLIENT_IsConnected                          ;
TRAKCLIENT_GetSynchronizedRandomInteger         :  RAKCLIENT_GetSynchronizedRandomInteger         ;
TRAKCLIENT_GenerateCompressionLayer             :  RAKCLIENT_GenerateCompressionLayer             ;
TRAKCLIENT_DeleteCompressionLayer               :  RAKCLIENT_DeleteCompressionLayer               ;
TRAKCLIENT_SetTrackFrequencyTable               :  RAKCLIENT_SetTrackFrequencyTable               ;
TRAKCLIENT_GetSendFrequencyTable                :  RAKCLIENT_GetSendFrequencyTable                ;
TRAKCLIENT_GetCompressionRatio                  :  RAKCLIENT_GetCompressionRatio                  ;
TRAKCLIENT_GetDecompressionRatio                :  RAKCLIENT_GetDecompressionRatio                ;
TRAKCLIENT_GetStaticServerData                  :  RAKCLIENT_GetStaticServerData                  ;
TRAKCLIENT_SetStaticServerData                  :  RAKCLIENT_SetStaticServerData                  ;
TRAKCLIENT_GetStaticClientData                  :  RAKCLIENT_GetStaticClientData                  ;
TRAKCLIENT_SetStaticClientData                  :  RAKCLIENT_SetStaticClientData                  ;
TRAKCLIENT_SendStaticClientDataToServer         :  RAKCLIENT_SendStaticClientDataToServer         ;
TRAKCLIENT_GetServerID                          :  RAKCLIENT_GetServerID                          ;
TRAKCLIENT_GetPlayerID                          :  RAKCLIENT_GetPlayerID                          ;
TRAKCLIENT_GetInternalID                        :  RAKCLIENT_GetInternalID                        ;
TRAKCLIENT_PlayerIDToDottedIP                   :  RAKCLIENT_PlayerIDToDottedIP                   ;
TRAKCLIENT_PushBackPacket                       :  RAKCLIENT_PushBackPacket                       ;
TRAKCLIENT_SetTimeoutTime                       :  RAKCLIENT_SetTimeoutTime                       ;
TRAKCLIENT_SetMTUSize                           :  RAKCLIENT_SetMTUSize                           ;
TRAKCLIENT_GetMTUSize                           :  RAKCLIENT_GetMTUSize                           ;
TRAKCLIENT_AllowConnectionResponseIPMigration   :  RAKCLIENT_AllowConnectionResponseIPMigration   ;
TRAKCLIENT_AdvertiseSystem                      :  RAKCLIENT_AdvertiseSystem                      ;
TRAKCLIENT_GetStatistics                        :  RAKCLIENT_GetStatistics                        ;
TRAKCLIENT_ApplyNetworkSimulator                :  RAKCLIENT_ApplyNetworkSimulator                ;
TRAKCLIENT_IsNetworkSimulatorActive             :  RAKCLIENT_IsNetworkSimulatorActive             ;
TRAKCLIENT_GetPlayerIndex                       :  RAKCLIENT_GetPlayerIndex                       ;
TRAKCLIENT_DisableSecurity                      :  RAKCLIENT_DisableSecurity                      ;
TRAKCLIENT_InitializeSecurity                   :  RAKCLIENT_InitializeSecurity                   ;
TRAKCLIENT_UnregisterAsRemoteProcedureCall      :  RAKCLIENT_UnregisterAsRemoteProcedureCall      ;
TRAKCLIENT_RegisterAsRemoteProcedureCall        :  RAKCLIENT_RegisterAsRemoteProcedureCall        ;
TRAKCLIENT_RPCFromBuffer                        :  RAKCLIENT_RPCFromBuffer                        ;
TRAKCLIENT_RPCFromBitStream                     :  RAKCLIENT_RPCFromBitStream                     ;



TRAKPEER_Initialize                             :RAKPEER_Initialize;
TRAKPEER_InitializeSecurity                     :RAKPEER_InitializeSecurity;
TRAKPEER_DisableSecurity                        :RAKPEER_DisableSecurity;
TRAKPEER_SetMaximumIncomingConnections          :RAKPEER_SetMaximumIncomingConnections;
TRAKPEER_GetMaximumIncomingConnections          :RAKPEER_GetMaximumIncomingConnections;
TRAKPEER_SetIncomingPassword                    :RAKPEER_SetIncomingPassword;
TRAKPEER_GetIncomingPassword                    :RAKPEER_GetIncomingPassword;
TRAKPEER_Connect                                :RAKPEER_Connect;
TRAKPEER_Disconnect                             :RAKPEER_Disconnect;
TRAKPEER_IsActive                               :RAKPEER_IsActive;
TRAKPEER_GetConnectionList                      :RAKPEER_GetConnectionList;
TRAKPEER_SendBuffer                             :RAKPEER_SendBuffer;
TRAKPEER_SendBitStream                          :RAKPEER_SendBitStream;
TRAKPEER_Receive                                :RAKPEER_Receive;
TRAKPEER_DeallocatePacket                       :RAKPEER_DeallocatePacket;
TRAKPEER_GetMaximumNumberOfPeers                :RAKPEER_GetMaximumNumberOfPeers;
TRAKPEER_RegisterAsRemoteProcedureCall          :RAKPEER_RegisterAsRemoteProcedureCall;
TRAKPEER_UnregisterAsRemoteProcedureCall        :RAKPEER_UnregisterAsRemoteProcedureCall;
TRAKPEER_RPCBuffer                              :RAKPEER_RPCBuffer;
TRAKPEER_RPCBitStream                           :RAKPEER_RPCBitStream;
TRAKPEER_CloseConnection                        :RAKPEER_CloseConnection;
TRAKPEER_GetIndexFromPlayerID                   :RAKPEER_GetIndexFromPlayerID;
TRAKPEER_GetPlayerIDFromIndex                   :RAKPEER_GetPlayerIDFromIndex;
TRAKPEER_AddToBanList                           :RAKPEER_AddToBanList;
TRAKPEER_RemoveFromBanList                      :RAKPEER_RemoveFromBanList;
TRAKPEER_ClearBanList                           :RAKPEER_ClearBanList;
TRAKPEER_IsBanned                               :RAKPEER_IsBanned;
TRAKPEER_Ping                                   :RAKPEER_Ping;
TRAKPEER_PingHost                               :RAKPEER_PingHost;
TRAKPEER_GetAveragePing                         :RAKPEER_GetAveragePing;
TRAKPEER_GetLastPing                            :RAKPEER_GetLastPing;
TRAKPEER_GetLowestPing                          :RAKPEER_GetLowestPing;
TRAKPEER_SetOccasionalPing                      :RAKPEER_SetOccasionalPing;
TRAKPEER_GetRemoteStaticData                    :RAKPEER_GetRemoteStaticData;
TRAKPEER_SetRemoteStaticData                    :RAKPEER_SetRemoteStaticData;
TRAKPEER_SendStaticData                         :RAKPEER_SendStaticData;
TRAKPEER_SetOfflinePingResponse                 :RAKPEER_SetOfflinePingResponse;
TRAKPEER_GetInternalID                          :RAKPEER_GetInternalID;
TRAKPEER_GetExternalID                          :RAKPEER_GetExternalID;
TRAKPEER_SetTimeoutTime                         :RAKPEER_SetTimeoutTime;
TRAKPEER_SetMTUSize                             :RAKPEER_SetMTUSize;
TRAKPEER_GetMTUSize                             :RAKPEER_GetMTUSize;
TRAKPEER_GetNumberOfAddresses                   :RAKPEER_GetNumberOfAddresses;
TRAKPEER_GetLocalIP                             :RAKPEER_GetLocalIP;
TRAKPEER_PlayerIDToDottedIP                     :RAKPEER_PlayerIDToDottedIP;
TRAKPEER_IPToPlayerID                           :RAKPEER_IPToPlayerID;
TRAKPEER_AllowConnectionResponseIPMigration     :RAKPEER_AllowConnectionResponseIPMigration;
TRAKPEER_AdvertiseSystem                        :RAKPEER_AdvertiseSystem;
TRAKPEER_SetSplitMessageProgressInterval        :RAKPEER_SetSplitMessageProgressInterval;
TRAKPEER_SetUnreliableTimeout                   :RAKPEER_SetUnreliableTimeout;
TRAKPEER_SetCompileFrequencyTable               :RAKPEER_SetCompileFrequencyTable;
TRAKPEER_GetOutgoingFrequencyTable              :RAKPEER_GetOutgoingFrequencyTable;
TRAKPEER_GenerateCompressionLayer               :RAKPEER_GenerateCompressionLayer;
TRAKPEER_DeleteCompressionLayer                 :RAKPEER_DeleteCompressionLayer;
TRAKPEER_GetCompressionRatio                    :RAKPEER_GetCompressionRatio;
TRAKPEER_GetDecompressionRatio                  :RAKPEER_GetDecompressionRatio;
TRAKPEER_AttachPlugin                           :RAKPEER_AttachPlugin;
TRAKPEER_DetachPlugin                           :RAKPEER_DetachPlugin;
TRAKPEER_PushBackPacket                         :RAKPEER_PushBackPacket;
TRAKPEER_SetRouterInterface                     :RAKPEER_SetRouterInterface;
TRAKPEER_RemoveRouterInterface                  :RAKPEER_RemoveRouterInterface;
TRAKPEER_ApplyNetworkSimulator                  :RAKPEER_ApplyNetworkSimulator;
TRAKPEER_IsNetworkSimulatorActive               :RAKPEER_IsNetworkSimulatorActive;
TRAKPEER_GetStatistics                          :RAKPEER_GetStatistics;
TRAKNETWORKID_peerToPeerMode                    :RAKNETWORKID_peerToPeerMode;
TRAKNETWORKID_playerId                          :RAKNETWORKID_playerId;
TRAKNETWORKID_localSystemId                     :RAKNETWORKID_localSystemId;
TRAKNETSTAT_ConvertToString                     :RAKNETSTAT_ConvertToString;

TRAKSERVER_AttachPlugin                         :RAKSERVER_AttachPlugin;
TRAKSERVER_DetachPlugin                         :RAKSERVER_DetachPlugin;
TRAKCLIENT_AttachPlugin                         :RAKCLIENT_AttachPlugin;
TRAKCLIENT_DetachPlugin                         :RAKCLIENT_DetachPlugin;

TRAKMULTIPLAYER_ClientConstructor               :RAKMULTIPLAYER_ClientConstructor;
TRAKMULTIPLAYER_ServerConstructor               :RAKMULTIPLAYER_ServerConstructor;
TRAKMULTIPLAYER_PeerConstructor                 :RAKMULTIPLAYER_PeerConstructor;
TRAKMULTIPLAYER_ClientDestructor                :RAKMULTIPLAYER_ClientDestructor;
TRAKMULTIPLAYER_ServerDestructor                :RAKMULTIPLAYER_ServerDestructor;
TRAKMULTIPLAYER_PeerDestructor                  :RAKMULTIPLAYER_PeerDestructor;

TRAKMULTIPLAYER_ProcessPacketsPeer              :RAKMULTIPLAYER_ProcessPacketsPeer;
TRAKMULTIPLAYER_ProcessPacketsServer            :RAKMULTIPLAYER_ProcessPacketsServer;
TRAKMULTIPLAYER_ProcessPacketsClient            :RAKMULTIPLAYER_ProcessPacketsClient;
TRAKMULTIPLAYER_CallbackPeer                    :RAKMULTIPLAYER_CallbackPeer;
TRAKMULTIPLAYER_CallbackServer                  :RAKMULTIPLAYER_CallbackServer;
TRAKMULTIPLAYER_CallbackClient                  :RAKMULTIPLAYER_CallbackClient;

TRAKMULTIPLAYER_GetCallbackClient               : RAKMULTIPLAYER_GetCallbackClient;
TRAKMULTIPLAYER_GetCallbackServer               : RAKMULTIPLAYER_GetCallbackServer;
TRAKMULTIPLAYER_GetCallbackPeer                 : RAKMULTIPLAYER_GetCallbackPeer;

TRAKMULTIPLAYER_GetInternalClient               : RAKMULTIPLAYER_GetInternalClient;
TRAKMULTIPLAYER_GetInternalServer               : RAKMULTIPLAYER_GetInternalServer;
TRAKMULTIPLAYER_GetInternalPeer                 : RAKMULTIPLAYER_GetInternalPeer;



TRAKNETROUTER_SetRestrictRoutingByType           :RAKNETROUTER_SetRestrictRoutingByType;
TRAKNETROUTER_AddAllowedType                     :RAKNETROUTER_AddAllowedType;
TRAKNETROUTER_RemoveAllowedType                  :RAKNETROUTER_RemoveAllowedType ;
TRAKNETROUTER_SetConnectionGraph                 :RAKNETROUTER_SetConnectionGraph ;
TRAKNETROUTER_SendToSystemList                   :RAKNETROUTER_SendToSystemList ;
TRAKNETROUTER_Send                               :RAKNETROUTER_Send ;



TRAKNETSYSTEMADDRL_constructor1                  : RAKNETSYSTEMADDRL_constructor1;
TRAKNETSYSTEMADDRL_constructor2                  : RAKNETSYSTEMADDRL_constructor2;
TRAKNETSYSTEMADDRL_destructor                    : RAKNETSYSTEMADDRL_destructor ;
TRAKNETSYSTEMADDRL_AddSystem                     : RAKNETSYSTEMADDRL_AddSystem;
TRAKNETSYSTEMADDRL_RandomizeOrder                : RAKNETSYSTEMADDRL_RandomizeOrder;
TRAKNETSYSTEMADDRL_Serialize                     : RAKNETSYSTEMADDRL_Serialize;
TRAKNETSYSTEMADDRL_Deserialize                   : RAKNETSYSTEMADDRL_Deserialize;
TRAKNETSYSTEMADDRL_Save                          : RAKNETSYSTEMADDRL_Save;
TRAKNETSYSTEMADDRL_Load                          : RAKNETSYSTEMADDRL_Load;
TRAKNETSYSTEMADDRL_RemoveSystem                  : RAKNETSYSTEMADDRL_RemoveSystem;
TRAKNETSYSTEMADDRL_Size                          : RAKNETSYSTEMADDRL_Size;
TRAKNETSYSTEMADDRL_Clear                         : RAKNETSYSTEMADDRL_Clear;
TRAKNETSYSTEMADDRL_Item                          : RAKNETSYSTEMADDRL_Item;


TRAKNETConnGraph_constructor1                    : RAKNETConnGraph_constructor1;
TRAKNETConnGraph_destructor                      : RAKNETConnGraph_destructor;
TRAKNETConnGraph_SetPassword                     : RAKNETConnGraph_SetPassword;
TRAKNETConnGraph_GetGraph                        : RAKNETConnGraph_GetGraph;
TRAKNETConnGraph_SetAutoAddNewConnections        : RAKNETConnGraph_SetAutoAddNewConnections;
TRAKNETConnGraph_RequestConnectionGraph          : RAKNETConnGraph_RequestConnectionGraph;
TRAKNETConnGraph_AddNewConnection                : RAKNETConnGraph_AddNewConnection;
TRAKNETConnGraph_SetGroupId                      : RAKNETConnGraph_SetGroupId;
TRAKNETConnGraph_SubscribeToGroup                : RAKNETConnGraph_SubscribeToGroup;
TRAKNETConnGraph_UnsubscribeFromGroup            : RAKNETConnGraph_UnsubscribeFromGroup;


TRAKNETPluginDelphi_constructor                  : RAKNETPluginDelphi_constructor;
TRAKNETPluginDelphi_destructor                   : RAKNETPluginDelphi_destructor;
TRAKNETPluginDelphi_GetCallbackList              : RAKNETPluginDelphi_GetCallbackList;

TRAKNETTCPInterface_constructor                  : RAKNETTCPInterface_constructor;
TRAKNETTCPInterface_destructor                   : RAKNETTCPInterface_destructor;
TRAKNETTCPInterface_Start                        : RAKNETTCPInterface_Start;
TRAKNETTCPInterface_Stop                         : RAKNETTCPInterface_Stop;
TRAKNETTCPInterface_Connect                      : RAKNETTCPInterface_Connect;
TRAKNETTCPInterface_Send                         : RAKNETTCPInterface_Send;
TRAKNETTCPInterface_Receive                      : RAKNETTCPInterface_Receive;
TRAKNETTCPInterface_CloseConnection              : RAKNETTCPInterface_CloseConnection;
TRAKNETTCPInterface_DeallocatePacket             : RAKNETTCPInterface_DeallocatePacket;
TRAKNETTCPInterface_HasNewConnection             : RAKNETTCPInterface_HasNewConnection;
TRAKNETTCPInterface_HasLostConnection            : RAKNETTCPInterface_HasLostConnection;

TRAKNETHuffComp_GenerateTreeFromStrings          : RAKNETHuffComp_GenerateTreeFromStrings;
TRAKNETHuffComp_EncodeString                     : RAKNETHuffComp_EncodeString;
TRAKNETHuffComp_DecodeString                     : RAKNETHuffComp_DecodeString;

TRAKNETBZipInit                                  : RAKNETBZipInit;
TRAKNETBZipUnInit                                : RAKNETBZipUnInit;
TRAKNETBZip_ClearDecompress                      : RAKNETBZip_ClearDecompress;
TRAKNETBZip_ClearCompress                        : RAKNETBZip_ClearCompress;
TRAKNETBZip_Decompress                           : RAKNETBZip_Decompress;
TRAKNETBZip_Compress                             : RAKNETBZip_Compress;

TRAKNETFileLogger_Constructor                    : RAKNETFileLogger_Constructor ;
TRAKNETFileLogger_Destructor                     : RAKNETFileLogger_Destructor;
TRAKNETFileLogger_WriteLog                       : RAKNETFileLogger_WriteLog;
TRAKNETFileLogger_SetPrintID                     : RAKNETFileLogger_SetPrintID;
TRAKNETFileLogger_SetPrintAcks                   : RAKNETFileLogger_SetPrintAcks;

TRAKNETConsoleLogger_Constructor                 : RAKNETConsoleLogger_Constructor;
TRAKNETConsoleLogger_Destructor                  : RAKNETConsoleLogger_Destructor;
TRAKNETConsoleLogger_WriteLog                    : RAKNETConsoleLogger_WriteLog;
TRAKNETConsoleLogger_SetPrintID                  : RAKNETConsoleLogger_SetPrintID;
TRAKNETConsoleLogger_SetPrintAcks                : RAKNETConsoleLogger_SetPrintAcks;

TRAKReplicaManager_Constructor                   : RAKReplicaManager_Constructor;
TRAKReplicaManager_Destructor                    : RAKReplicaManager_Destructor;
TRAKReplicaManager_SetAutoParticipateNewConnections : RAKReplicaManager_SetAutoParticipateNewConnections;
TRAKReplicaManager_AddParticipant                : RAKReplicaManager_AddParticipant;
TRAKReplicaManager_RemoveParticipant             : RAKReplicaManager_RemoveParticipant;
TRAKReplicaManager_Construct                     : RAKReplicaManager_Construct;
TRAKReplicaManager_Destruct                      : RAKReplicaManager_Destruct;
TRAKReplicaManager_ReferencePointer              : RAKReplicaManager_ReferencePointer;
TRAKReplicaManager_DereferencePointer            : RAKReplicaManager_DereferencePointer;
TRAKReplicaManager_SetScope                      : RAKReplicaManager_SetScope;
TRAKReplicaManager_SignalSerializeNeeded         : RAKReplicaManager_SignalSerializeNeeded;
TRAKReplicaManager_SetReceiveConstructionCB      : RAKReplicaManager_SetReceiveConstructionCB;
TRAKReplicaManager_SetDownloadCompleteCB         : RAKReplicaManager_SetDownloadCompleteCB;
TRAKReplicaManager_SetSendChannel                : RAKReplicaManager_SetSendChannel;
TRAKReplicaManager_SetAutoConstructToNewParticipants : RAKReplicaManager_SetAutoConstructToNewParticipants;
TRAKReplicaManager_SetDefaultScope               : RAKReplicaManager_SetDefaultScope;
TRAKReplicaManager_EnableReplicaInterfaces       : RAKReplicaManager_EnableReplicaInterfaces;
TRAKReplicaManager_DisableReplicaInterfaces      : RAKReplicaManager_DisableReplicaInterfaces;
TRAKReplicaManager_IsConstructed                 : RAKReplicaManager_IsConstructed;
TRAKReplicaManager_IsInScope                     : RAKReplicaManager_IsInScope;
TRAKReplicaManager_GetReplicaCount               : RAKReplicaManager_GetReplicaCount;
TRAKReplicaManager_GetReplicaAtIndex             : RAKReplicaManager_GetReplicaAtIndex;

TRAKReplicaMember_Constructor                    : RAKReplicaMember_Constructor;
TRAKReplicaMember_Destructor                     : RAKReplicaMember_Destructor;
TRAKReplicaMember_GetInternalCallback            : RAKReplicaMember_GetInternalCallback;
TRAKReplicaMember_SetServer                      : RAKReplicaMember_SetServer;
TRAKReplicaMember_GetNetworkID                   : RAKReplicaMember_GetNetworkID;
TRAKReplicaMember_SetNetworkID                   : RAKReplicaMember_SetNetworkID;
TRAKReplicaMember_SetParent                      : RAKReplicaMember_SetParent;
TRAKReplicaMember_GetParent                      : RAKReplicaMember_GetParent;
TRAKReplicaMember_GetStaticNetworkID             : RAKReplicaMember_GetStaticNetworkID;
TRAKReplicaMember_SetStaticNetworkID             : RAKReplicaMember_SetStaticNetworkID;
TRAKReplicaMember_IsNetworkIDAuthority           : RAKReplicaMember_IsNetworkIDAuthority;
TRAKReplicaMember_SetExternalPlayerID            : RAKReplicaMember_SetExternalPlayerID;
TRAKReplicaMember_GetExternalPlayerID            : RAKReplicaMember_GetExternalPlayerID;
TRAKReplicaMember_GET_BASE_OBJECT_FROM_ID        : RAKReplicaMember_GET_BASE_OBJECT_FROM_ID;
TRAKReplicaMember_GET_OBJECT_FROM_ID             : RAKReplicaMember_GET_OBJECT_FROM_ID;


const raknetclib='raknetc.dll';


function  InitRaknetC:boolean;
procedure UnInitRaknetC;

implementation
uses windows;

Var LibHandle:cardinal;
//function  GetProcAssertAddress(Handle:cardinal;ProcName:Pchar):pointer;

function GetProcAssertAddress(Handle:cardinal;ProcName:Pchar):pointer;
begin
   Result := GetProcAddress(Handle,ProcName);
   Assert((Result<>nil),'Proc not found : '+ProcName);   
end;




procedure UnInitRaknetC;
begin
   if LibHandle>0 then FreeLibrary(LibHandle);
end;


procedure   GetLibProcess(LibHandle:cardinal);
begin

TRAKNET_InitCommandParser   :=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitCommandParser'));
TRAKNET_InitClientInterface :=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitClientInterface'));
TRAKNET_InitServerInterface:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitServerInterface'));
TRAKNET_InitPeerInterface:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitPeerInterface'));
TRAKNET_InitConsoleServer:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitConsoleServer'));
TRAKNET_InitReplicaManager:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitReplicaManager'));
TRAKNET_InitLogCommandParser:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitLogCommandParser'));
TRAKNET_InitPacketLogger:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitPacketLogger'));
TRAKNET_InitRaknetTransport:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitRaknetTransport'));
TRAKNET_InitTelnetTransport:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitTelnetTransport'));
TRAKNET_InitPacketConsoleLogger:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitPacketConsoleLogger'));
TRAKNET_InitPacketFileLogger:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitPacketFileLogger'));
TRAKNET_InitRouter:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitRouter'));
TRAKNET_InitConnectionGraph:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_InitConnectionGraph'));
TRAKNET_GetUnAssignedPlayerID:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_GetUnAssignedPlayerID'));
TRAKNET_UnInitClientInterface:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitClientInterface'));
TRAKNET_UnInitServerInterface:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitServerInterface'));
TRAKNET_UnInitPeerInterface:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitPeerInterface'));
TRAKNET_UnInitConsoleServer:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitConsoleServer'));
TRAKNET_UnInitReplicaManager:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitReplicaManager'));
TRAKNET_UnInitLogCommandParser:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitLogCommandParser'));
TRAKNET_UnInitPacketLogger:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitPacketLogger'));
TRAKNET_UnInitCommandParser:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitCommandParser'));
TRAKNET_UnInitRaknetTransport:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitRaknetTransport'));
TRAKNET_UnInitTelnetTransport:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitTelnetTransport'));
TRAKNET_UnInitPacketConsoleLogger:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitPacketConsoleLogger'));
TRAKNET_UnInitPacketFileLogger:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitPacketFileLogger'));
TRAKNET_UnInitRouter:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitRouter'));
TRAKNET_UnInitConnectionGraph:=  GetProcAssertAddress(LibHandle,Pchar('RAKNET_UnInitConnectionGraph'));
TBITSTREAM_constructor1:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_constructor1'));
TBITSTREAM_constructor2:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_constructor2'));
TBITSTREAM_constructor3:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_constructor3'));
TBITSTREAM_destructor:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_destructor'));
TBITSTREAM_reset:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_reset'));
TBITSTREAM_BSWriteFromWSize:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_BSWriteFromWSize'));
TBITSTREAM_BSWriteFrom:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_BSWriteFrom'));
TBITSTREAM_ResetReadPointer:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ResetReadPointer'));
TBITSTREAM_ResetWritePointer:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ResetWritePointer'));
TBITSTREAM_AssertStreamEmpty:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_AssertStreamEmpty'));
TBITSTREAM_PrintBits:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_PrintBits'));
TBITSTREAM_IgnoreBits:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_IgnoreBits'));
TBITSTREAM_SetWriteOffset:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SetWriteOffset'));
TBITSTREAM_GetNumberOfBitsUsed:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_GetNumberOfBitsUsed'));
TBITSTREAM_GetWriteOffset:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_GetWriteOffset'));
TBITSTREAM_GetNumberOfBytesUsed:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_GetNumberOfBytesUsed'));
TBITSTREAM_GetReadOffset:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_GetReadOffset'));
TBITSTREAM_SetReadOffset:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SetReadOffset'));
TBITSTREAM_GetNumberOfUnreadBits:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_GetNumberOfUnreadBits'));
TBITSTREAM_CopyData:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_CopyData'));
TBITSTREAM_SetData:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SetData'));
TBITSTREAM_GetData:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_GetData'));
TBITSTREAM_WriteBits:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteBits'));
TBITSTREAM_WriteAlignedBytes:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteAlignedBytes'));
TBITSTREAM_ReadAlignedBytes:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadAlignedBytes'));
TBITSTREAM_AlignWriteToByteBoundary:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_AlignWriteToByteBoundary'));
TBITSTREAM_AlignReadToByteBoundary:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_AlignReadToByteBoundary'));
TBITSTREAM_ReadBits:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadBits'));
TBITSTREAM_Write:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Write'));
TBITSTREAM_Write0:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Write0'));
TBITSTREAM_Write1:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Write1'));
TBITSTREAM_ReadBit:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadBit'));
TBITSTREAM_AssertCopyData:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_AssertCopyData'));
TBITSTREAM_SetNumberOfBitsAllocated:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SetNumberOfBitsAllocated'));
TBITSTREAM_AddBitsAndReallocate:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_AddBitsAndReallocate'));
TBITSTREAM_Serialize_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Serialize_Byte'));
TBITSTREAM_Serialize_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Serialize_Word'));
TBITSTREAM_Serialize_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Serialize_LongWord'));
TBITSTREAM_Serialize_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Serialize_Float'));
TBITSTREAM_Serialize_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Serialize_Double'));
TBITSTREAM_SerializeDelta_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeDelta_Byte'));
TBITSTREAM_SerializeDelta_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeDelta_Word'));
TBITSTREAM_SerializeDelta_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeDelta_LongWord'));
TBITSTREAM_SerializeDelta_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeDelta_Float'));
TBITSTREAM_SerializeDelta_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeDelta_Double'));
TBITSTREAM_Write_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Write_Byte'));
TBITSTREAM_Write_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Write_Word'));
TBITSTREAM_Write_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Write_LongWord'));
TBITSTREAM_Write_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Write_Float'));
TBITSTREAM_Write_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Write_Double'));
TBITSTREAM_WriteCompressed_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteCompressed_Byte'));
TBITSTREAM_WriteCompressed_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteCompressed_Word'));
TBITSTREAM_WriteCompressed_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteCompressed_LongWord'));
TBITSTREAM_WriteCompressed_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteCompressed_Float'));
TBITSTREAM_WriteCompressed_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteCompressed_Double'));
TBITSTREAM_WriteDelta_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteDelta_Byte'));
TBITSTREAM_WriteDelta_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteDelta_Word'));
TBITSTREAM_WriteDelta_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteDelta_LongWord'));
TBITSTREAM_WriteDelta_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteDelta_Float'));
TBITSTREAM_WriteDelta_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteDelta_Double'));
TBITSTREAM_WriteCompressedDelta_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteCompressedDelta_Byte'));
TBITSTREAM_WriteCompressedDelta_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteCompressedDelta_Word'));
TBITSTREAM_WriteCompressedDelta_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteCompressedDelta_LongWord'));
TBITSTREAM_WriteCompressedDelta_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteCompressedDelta_Float'));
TBITSTREAM_WriteCompressedDelta_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteCompressedDelta_Double'));
TBITSTREAM_Read_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Read_Byte'));
TBITSTREAM_Read_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Read_Word'));
TBITSTREAM_Read_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Read_LongWord'));
TBITSTREAM_Read_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Read_Float'));
TBITSTREAM_Read_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Read_Double'));
TBITSTREAM_ReadCompressed_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadCompressed_Byte'));
TBITSTREAM_ReadCompressed_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadCompressed_Word'));
TBITSTREAM_ReadCompressed_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadCompressed_LongWord'));
TBITSTREAM_ReadCompressed_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadCompressed_Float'));
TBITSTREAM_ReadCompressed_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadCompressed_Double'));
TBITSTREAM_ReadDelta_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadDelta_Byte'));
TBITSTREAM_ReadDelta_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadDelta_Word'));
TBITSTREAM_ReadDelta_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadDelta_LongWord'));
TBITSTREAM_ReadDelta_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadDelta_Float'));
TBITSTREAM_ReadDelta_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadDelta_Double'));
TBITSTREAM_ReadCompressedDelta_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadCompressedDelta_Byte'));
TBITSTREAM_ReadCompressedDelta_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadCompressedDelta_Word'));
TBITSTREAM_ReadCompressedDelta_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadCompressedDelta_LongWord'));
TBITSTREAM_ReadCompressedDelta_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadCompressedDelta_Float'));
TBITSTREAM_ReadCompressedDelta_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadCompressedDelta_Double'));
TBITSTREAM_SerializeCompressed_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeCompressed_Byte'));
TBITSTREAM_SerializeCompressed_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeCompressed_Word'));
TBITSTREAM_SerializeCompressed_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeCompressed_LongWord'));
TBITSTREAM_SerializeCompressed_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeCompressed_Float'));
TBITSTREAM_SerializeCompressed_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeCompressed_Double'));
TBITSTREAM_SerializeCompressedDelta_Byte:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeCompressedDelta_Byte'));
TBITSTREAM_SerializeCompressedDelta_Word:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeCompressedDelta_Word'));
TBITSTREAM_SerializeCompressedDelta_LongWord:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeCompressedDelta_LongWord'));
TBITSTREAM_SerializeCompressedDelta_Float:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeCompressedDelta_Float'));
TBITSTREAM_SerializeCompressedDelta_Double:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeCompressedDelta_Double'));
TBITSTREAM_Serialize:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Serialize'));
TBITSTREAM_SerializeBits:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeBits'));
TBITSTREAM_Read:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_Read'));
TBITSTREAM_SerializeNormVectorFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeNormVectorFloat'));
TBITSTREAM_SerializeNormVectorDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeNormVectorDouble'));
TBITSTREAM_SerializeVectorFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeVectorFloat'));
TBITSTREAM_SerializeVectorDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeVectorDouble'));
TBITSTREAM_SerializeNormQuatFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeNormQuatFloat'));
TBITSTREAM_SerializeNormQuatDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeNormQuatDouble'));
TBITSTREAM_SerializeOrthMatrixFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeOrthMatrixFloat'));
TBITSTREAM_SerializeOrthMatrixDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_SerializeOrthMatrixDouble'));
TBITSTREAM_ReadNormVectorFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadNormVectorFloat'));
TBITSTREAM_ReadNormVectorDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadNormVectorDouble'));
TBITSTREAM_ReadVectorFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadVectorFloat'));
TBITSTREAM_ReadVectorDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadVectorDouble'));
TBITSTREAM_ReadNormQuatFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadNormQuatFloat'));
TBITSTREAM_ReadNormQuatDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadNormQuatDouble'));
TBITSTREAM_ReadOrthMatrixFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadOrthMatrixFloat'));
TBITSTREAM_ReadOrthMatrixDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_ReadOrthMatrixDouble'));
TBITSTREAM_WriteNormVectorFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteNormVectorFloat'));
TBITSTREAM_WriteNormVectorDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteNormVectorDouble'));
TBITSTREAM_WriteVectorFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteVectorFloat'));
TBITSTREAM_WriteVectorDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteVectorDouble'));
TBITSTREAM_WriteNormQuatFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteNormQuatFloat'));
TBITSTREAM_WriteNormQuatDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteNormQuatDouble'));
TBITSTREAM_WriteOrthMatrixFloat:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteOrthMatrixFloat'));
TBITSTREAM_WriteOrthMatrixDouble:=  GetProcAssertAddress(LibHandle,Pchar('BITSTREAM_WriteOrthMatrixDouble'));
TRAKPacket_PlayerIndex:=  GetProcAssertAddress(LibHandle,Pchar('RAKPacket_PlayerIndex'));
TRAKPacket_PlayerID:=  GetProcAssertAddress(LibHandle,Pchar('RAKPacket_PlayerID'));
TRAKPacket_Length:=  GetProcAssertAddress(LibHandle,Pchar('RAKPacket_Length'));
TRAKPacket_bitSize                                    :=  GetProcAssertAddress(LibHandle,Pchar('RAKPacket_bitSize'));
TRAKPacket_data                                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKPacket_data'));
TRAKRPCParameters_Input                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKRPCParameters_Input'));
TRAKRPCParameters_NumberOfBitsOfData                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKRPCParameters_NumberOfBitsOfData'));
TRAKRPCParameters_Sender                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKRPCParameters_Sender'));
TRAKRPCParameters_Recipient                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKRPCParameters_Recipient'));
TRAKRPCParameters_ReplyToSender                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKRPCParameters_ReplyToSender'));
TRAKPlayerID_binaryAddress                            :=  GetProcAssertAddress(LibHandle,Pchar('RAKPlayerID_binaryAddress'));
TRAKPlayerID_port                                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKPlayerID_port'));
TRAKPlayerID_tostring                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKPlayerID_tostring'));
TRAKSERVER_constructor                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_constructor'));
TRAKSERVER_destructor                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_destructor'));
TRAKSERVER_Start                                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_Start'));
TRAKSERVER_InitializeSecurity                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_InitializeSecurity'));
TRAKSERVER_DisableSecurity                            :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_DisableSecurity'));
TRAKSERVER_SetPassword                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SetPassword'));
TRAKSERVER_HasPassword                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_HasPassword'));
TRAKSERVER_Disconnect                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_Disconnect'));
TRAKSERVER_SendBuffer                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SendBuffer'));
TRAKSERVER_SendBitStream                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SendBitStream'));
TRAKSERVER_Receive                                    :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_Receive'));
TRAKSERVER_Kick                                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_Kick'));
TRAKSERVER_DeallocatePacket                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_DeallocatePacket'));
TRAKSERVER_SetAllowedPlayers                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SetAllowedPlayers'));
TRAKSERVER_GetAllowedPlayers                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetAllowedPlayers'));
TRAKSERVER_GetConnectedPlayers                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetConnectedPlayers'));
TRAKSERVER_GetPlayerIPFromID                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetPlayerIPFromID'));
TRAKSERVER_PingPlayer                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_PingPlayer'));
TRAKSERVER_GetAveragePing                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetAveragePing'));
TRAKSERVER_GetLastPing                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetLastPing'));
TRAKSERVER_GetLowestPing                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetLowestPing'));
TRAKSERVER_StartOccasionalPing                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_StartOccasionalPing'));
TRAKSERVER_StopOccasionalPing                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_StopOccasionalPing'));
TRAKSERVER_IsActive                                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_IsActive'));
TRAKSERVER_GetSynchronizedRandomInteger               :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetSynchronizedRandomInteger'));
TRAKSERVER_StartSynchronizedRandomInteger             :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_StartSynchronizedRandomInteger'));
TRAKSERVER_StopSynchronizedRandomInteger              :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_StopSynchronizedRandomInteger'));
TRAKSERVER_GenerateCompressionLayer                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GenerateCompressionLayer'));
TRAKSERVER_DeleteCompressionLayer                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_DeleteCompressionLayer'));
TRAKSERVER_SetTrackFrequencyTable                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SetTrackFrequencyTable'));
TRAKSERVER_GetSendFrequencyTable                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetSendFrequencyTable'));
TRAKSERVER_GetCompressionRatio                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetCompressionRatio'));
TRAKSERVER_GetDecompressionRatio                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetDecompressionRatio'));
TRAKSERVER_GetStaticServerData                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetStaticServerData'));
TRAKSERVER_SetStaticServerData                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SetStaticServerData'));
TRAKSERVER_SetStaticClientData                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SetStaticClientData'));
TRAKSERVER_SetRelayStaticClientData                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SetRelayStaticClientData'));
TRAKSERVER_SendStaticServerDataToClient               :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SendStaticServerDataToClient'));
TRAKSERVER_SetOfflinePingResponse                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SetOfflinePingResponse'));
TRAKSERVER_GetStaticClientData                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetStaticClientData'));
TRAKSERVER_ChangeStaticClientData                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_ChangeStaticClientData'));
TRAKSERVER_GetNumberOfAddresses                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetNumberOfAddresses'));
TRAKSERVER_GetLocalIP                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetLocalIP'));
TRAKSERVER_GetInternalID                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetInternalID'));
TRAKSERVER_PushBackPacket                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_PushBackPacket'));
TRAKSERVER_GetIndexFromPlayerID                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetIndexFromPlayerID'));
TRAKSERVER_GetPlayerIDFromIndex                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetPlayerIDFromIndex'));
TRAKSERVER_AddToBanList                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_AddToBanList'));
TRAKSERVER_RemoveFromBanList                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_RemoveFromBanList'));
TRAKSERVER_ClearBanList                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_ClearBanList'));
TRAKSERVER_IsBanned                                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_IsBanned'));
TRAKSERVER_IsActivePlayerID                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_IsActivePlayerID'));
TRAKSERVER_SetTimeoutTime                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SetTimeoutTime'));
TRAKSERVER_SetMTUSize                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_SetMTUSize'));
TRAKSERVER_GetMTUSize                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetMTUSize'));
TRAKSERVER_AdvertiseSystem                            :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_AdvertiseSystem'));
TRAKSERVER_GetStatistics                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_GetStatistics'));
TRAKSERVER_ApplyNetworkSimulator                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_ApplyNetworkSimulator'));
TRAKSERVER_IsNetworkSimulatorActive                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_IsNetworkSimulatorActive'));
TRAKSERVER_UnregisterAsRemoteProcedureCall            :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_UnregisterAsRemoteProcedureCall'));
TRAKSERVER_RegisterAsRemoteProcedureCall              :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_RegisterAsRemoteProcedureCall'));
TRAKSERVER_RPCFromBuffer                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_RPCFromBuffer'));
TRAKSERVER_RPCFromBitStream                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_RPCFromBitStream'));
TRAKCLIENT_constructor                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_constructor'));
TRAKCLIENT_destructor                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_destructor'));
TRAKCLIENT_Connect                                    :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_Connect'));
TRAKCLIENT_Disconnect                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_Disconnect'));
TRAKCLIENT_SetPassword                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_SetPassword'));
TRAKCLIENT_HasPassword                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_HasPassword'));
TRAKCLIENT_SendBuffer                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_SendBuffer'));
TRAKCLIENT_SendBitStream                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_SendBitStream'));
TRAKCLIENT_Receive                                    :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_Receive'));
TRAKCLIENT_DeallocatePacket                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_DeallocatePacket'));
TRAKCLIENT_PingServer                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_PingServer'));
TRAKCLIENT_PingServerHost                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_PingServerHost'));
TRAKCLIENT_GetAveragePing                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetAveragePing'));
TRAKCLIENT_GetLastPing                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetLastPing'));
TRAKCLIENT_GetLowestPing                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetLowestPing'));
TRAKCLIENT_GetPlayerPing                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetPlayerPing'));
TRAKCLIENT_StartOccasionalPing                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_StartOccasionalPing'));
TRAKCLIENT_StopOccasionalPing                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_StopOccasionalPing'));
TRAKCLIENT_IsConnected                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_IsConnected'));
TRAKCLIENT_GetSynchronizedRandomInteger               :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetSynchronizedRandomInteger'));
TRAKCLIENT_GenerateCompressionLayer                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GenerateCompressionLayer'));
TRAKCLIENT_DeleteCompressionLayer                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_DeleteCompressionLayer'));
TRAKCLIENT_SetTrackFrequencyTable                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_SetTrackFrequencyTable'));
TRAKCLIENT_GetSendFrequencyTable                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetSendFrequencyTable'));
TRAKCLIENT_GetCompressionRatio                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetCompressionRatio'));
TRAKCLIENT_GetDecompressionRatio                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetDecompressionRatio'));
TRAKCLIENT_GetStaticServerData                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetStaticServerData'));
TRAKCLIENT_SetStaticServerData                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_SetStaticServerData'));
TRAKCLIENT_GetStaticClientData                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetStaticClientData'));
TRAKCLIENT_SetStaticClientData                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_SetStaticClientData'));
TRAKCLIENT_SendStaticClientDataToServer               :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_SendStaticClientDataToServer'));
TRAKCLIENT_GetServerID                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetServerID'));
TRAKCLIENT_GetPlayerID                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetPlayerID'));
TRAKCLIENT_GetInternalID                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetInternalID'));
TRAKCLIENT_PlayerIDToDottedIP                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_PlayerIDToDottedIP'));
TRAKCLIENT_PushBackPacket                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_PushBackPacket'));
TRAKCLIENT_SetTimeoutTime                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_SetTimeoutTime'));
TRAKCLIENT_SetMTUSize                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_SetMTUSize'));
TRAKCLIENT_GetMTUSize                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetMTUSize'));
TRAKCLIENT_AllowConnectionResponseIPMigration         :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_AllowConnectionResponseIPMigration'));
TRAKCLIENT_AdvertiseSystem                            :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_AdvertiseSystem'));
TRAKCLIENT_GetStatistics                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetStatistics'));
TRAKCLIENT_ApplyNetworkSimulator                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_ApplyNetworkSimulator'));
TRAKCLIENT_IsNetworkSimulatorActive                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_IsNetworkSimulatorActive'));
TRAKCLIENT_GetPlayerIndex                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_GetPlayerIndex'));
TRAKCLIENT_DisableSecurity                            :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_DisableSecurity'));
TRAKCLIENT_InitializeSecurity                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_InitializeSecurity'));
TRAKCLIENT_UnregisterAsRemoteProcedureCall            :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_UnregisterAsRemoteProcedureCall'));
TRAKCLIENT_RegisterAsRemoteProcedureCall              :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_RegisterAsRemoteProcedureCall'));
TRAKCLIENT_RPCFromBuffer                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_RPCFromBuffer'));
TRAKCLIENT_RPCFromBitStream                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_RPCFromBitStream'));

TRAKPEER_Initialize                                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_Initialize'));
TRAKPEER_InitializeSecurity                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_InitializeSecurity'));
TRAKPEER_DisableSecurity                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_DisableSecurity'));
TRAKPEER_SetMaximumIncomingConnections                :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SetMaximumIncomingConnections'));
TRAKPEER_GetMaximumIncomingConnections                :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetMaximumIncomingConnections'));
TRAKPEER_SetIncomingPassword                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SetIncomingPassword'));
TRAKPEER_GetIncomingPassword                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetIncomingPassword'));
TRAKPEER_Connect                                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_Connect'));
TRAKPEER_Disconnect                                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_Disconnect'));
TRAKPEER_IsActive                                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_IsActive'));
TRAKPEER_GetConnectionList                            :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetConnectionList'));
TRAKPEER_SendBuffer                                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SendBuffer'));
TRAKPEER_SendBitStream                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SendBitStream'));
TRAKPEER_Receive                                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_Receive'));
TRAKPEER_DeallocatePacket                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_DeallocatePacket'));
TRAKPEER_GetMaximumNumberOfPeers                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetMaximumNumberOfPeers'));
TRAKPEER_RegisterAsRemoteProcedureCall                :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_RegisterAsRemoteProcedureCall'));
TRAKPEER_UnregisterAsRemoteProcedureCall              :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_UnregisterAsRemoteProcedureCall'));
TRAKPEER_RPCBuffer                                    :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_RPCBuffer'));
TRAKPEER_RPCBitStream                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_RPCBitStream'));
TRAKPEER_CloseConnection                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_CloseConnection'));
TRAKPEER_GetIndexFromPlayerID                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetIndexFromPlayerID'));
TRAKPEER_GetPlayerIDFromIndex                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetPlayerIDFromIndex'));
TRAKPEER_AddToBanList                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_AddToBanList'));
TRAKPEER_RemoveFromBanList                            :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_RemoveFromBanList'));
TRAKPEER_ClearBanList                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_ClearBanList'));
TRAKPEER_IsBanned                                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_IsBanned'));
TRAKPEER_Ping                                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_Ping'));
TRAKPEER_PingHost                                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_PingHost'));
TRAKPEER_GetAveragePing                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetAveragePing'));
TRAKPEER_GetLastPing                                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetLastPing'));
TRAKPEER_GetLowestPing                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetLowestPing'));
TRAKPEER_SetOccasionalPing                            :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SetOccasionalPing'));
TRAKPEER_GetRemoteStaticData                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetRemoteStaticData'));
TRAKPEER_SetRemoteStaticData                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SetRemoteStaticData'));
TRAKPEER_SendStaticData                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SendStaticData'));
TRAKPEER_SetOfflinePingResponse                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SetOfflinePingResponse'));
TRAKPEER_GetInternalID                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetInternalID'));
TRAKPEER_GetExternalID                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetExternalID'));
TRAKPEER_SetTimeoutTime                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SetTimeoutTime'));
TRAKPEER_SetMTUSize                                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SetMTUSize'));
TRAKPEER_GetMTUSize                                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetMTUSize'));
TRAKPEER_GetNumberOfAddresses                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetNumberOfAddresses'));
TRAKPEER_GetLocalIP                                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetLocalIP'));
TRAKPEER_PlayerIDToDottedIP                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_PlayerIDToDottedIP'));
TRAKPEER_IPToPlayerID                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_IPToPlayerID'));
TRAKPEER_AllowConnectionResponseIPMigration           :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_AllowConnectionResponseIPMigration'));
TRAKPEER_AdvertiseSystem                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_AdvertiseSystem'));
TRAKPEER_SetSplitMessageProgressInterval              :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SetSplitMessageProgressInterval'));
TRAKPEER_SetUnreliableTimeout                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SetUnreliableTimeout'));
TRAKPEER_SetCompileFrequencyTable                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SetCompileFrequencyTable'));
TRAKPEER_GetOutgoingFrequencyTable                    :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetOutgoingFrequencyTable'));
TRAKPEER_GenerateCompressionLayer                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GenerateCompressionLayer'));
TRAKPEER_DeleteCompressionLayer                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_DeleteCompressionLayer'));
TRAKPEER_GetCompressionRatio                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetCompressionRatio'));
TRAKPEER_GetDecompressionRatio                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetDecompressionRatio'));
TRAKPEER_AttachPlugin                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_AttachPlugin'));
TRAKPEER_DetachPlugin                                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_DetachPlugin'));
TRAKPEER_PushBackPacket                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_PushBackPacket'));
TRAKPEER_SetRouterInterface                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_SetRouterInterface'));
TRAKPEER_RemoveRouterInterface                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_RemoveRouterInterface'));
TRAKPEER_ApplyNetworkSimulator                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_ApplyNetworkSimulator'));
TRAKPEER_IsNetworkSimulatorActive                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_IsNetworkSimulatorActive'));
TRAKPEER_GetStatistics                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKPEER_GetStatistics'));
TRAKNETWORKID_peerToPeerMode                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETWORKID_peerToPeerMode'));
TRAKNETWORKID_playerId                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETWORKID_playerId'));
TRAKNETWORKID_localSystemId                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETWORKID_localSystemId'));
TRAKNETSTAT_ConvertToString                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSTAT_ConvertToString'));
TRAKSERVER_AttachPlugin                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_AttachPlugin'));
TRAKSERVER_DetachPlugin                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKSERVER_DetachPlugin'));
TRAKCLIENT_AttachPlugin                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_AttachPlugin'));
TRAKCLIENT_DetachPlugin                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKCLIENT_DetachPlugin'));
TRAKMULTIPLAYER_ClientConstructor                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_ClientConstructor'));
TRAKMULTIPLAYER_ServerConstructor                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_ServerConstructor'));
TRAKMULTIPLAYER_PeerConstructor                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_PeerConstructor'));
TRAKMULTIPLAYER_ClientDestructor                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_ClientDestructor'));
TRAKMULTIPLAYER_ServerDestructor                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_ServerDestructor'));
TRAKMULTIPLAYER_PeerDestructor                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_PeerDestructor'));
TRAKMULTIPLAYER_ProcessPacketsPeer                    :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_ProcessPacketsPeer'));
TRAKMULTIPLAYER_ProcessPacketsServer                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_ProcessPacketsServer'));
TRAKMULTIPLAYER_ProcessPacketsClient                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_ProcessPacketsClient'));
TRAKMULTIPLAYER_CallbackPeer                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_CallbackPeer'));
TRAKMULTIPLAYER_CallbackServer                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_CallbackServer'));
TRAKMULTIPLAYER_CallbackClient                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_CallbackClient'));
TRAKMULTIPLAYER_GetCallbackClient                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_GetCallbackClient'));
TRAKMULTIPLAYER_GetCallbackServer                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_GetCallbackServer'));
TRAKMULTIPLAYER_GetCallbackPeer                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_GetCallbackPeer'));
TRAKMULTIPLAYER_GetInternalClient                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_GetInternalClient'));
TRAKMULTIPLAYER_GetInternalServer                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_GetInternalServer'));
TRAKMULTIPLAYER_GetInternalPeer                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKMULTIPLAYER_GetInternalPeer'));
TRAKNETROUTER_SetRestrictRoutingByType                :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETROUTER_SetRestrictRoutingByType'));
TRAKNETROUTER_AddAllowedType                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETROUTER_AddAllowedType'));
TRAKNETROUTER_RemoveAllowedType                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETROUTER_RemoveAllowedType'));
TRAKNETROUTER_SetConnectionGraph                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETROUTER_SetConnectionGraph'));
TRAKNETROUTER_SendToSystemList                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETROUTER_SendToSystemList'));
TRAKNETROUTER_Send                                    :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETROUTER_Send'));
TRAKNETSYSTEMADDRL_constructor1                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_constructor1'));
TRAKNETSYSTEMADDRL_constructor2                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_constructor2'));
TRAKNETSYSTEMADDRL_destructor                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_destructor'));
TRAKNETSYSTEMADDRL_AddSystem                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_AddSystem'));
TRAKNETSYSTEMADDRL_RandomizeOrder                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_RandomizeOrder'));
TRAKNETSYSTEMADDRL_Serialize                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_Serialize'));
TRAKNETSYSTEMADDRL_Deserialize                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_Deserialize'));
TRAKNETSYSTEMADDRL_Save                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_Save'));
TRAKNETSYSTEMADDRL_Load                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_Load'));
TRAKNETSYSTEMADDRL_RemoveSystem                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_RemoveSystem'));
TRAKNETSYSTEMADDRL_Size                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_Size'));
TRAKNETSYSTEMADDRL_Clear                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_Clear'));
TRAKNETSYSTEMADDRL_Item                               :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETSYSTEMADDRL_Item'));
TRAKNETConnGraph_constructor1                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConnGraph_constructor1'));
TRAKNETConnGraph_destructor                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConnGraph_destructor'));
TRAKNETConnGraph_SetPassword                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConnGraph_SetPassword'));
TRAKNETConnGraph_GetGraph                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConnGraph_GetGraph'));
TRAKNETConnGraph_SetAutoAddNewConnections             :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConnGraph_SetAutoAddNewConnections'));
TRAKNETConnGraph_RequestConnectionGraph               :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConnGraph_RequestConnectionGraph'));
TRAKNETConnGraph_AddNewConnection                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConnGraph_AddNewConnection'));
TRAKNETConnGraph_SetGroupId                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConnGraph_SetGroupId'));
TRAKNETConnGraph_SubscribeToGroup                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConnGraph_SubscribeToGroup'));
TRAKNETConnGraph_UnsubscribeFromGroup                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConnGraph_UnsubscribeFromGroup'));
TRAKNETPluginDelphi_constructor                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETPluginDelphi_constructor'));
TRAKNETPluginDelphi_destructor                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETPluginDelphi_destructor'));
TRAKNETPluginDelphi_GetCallbackList                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETPluginDelphi_GetCallbackList'));

TRAKNETTCPInterface_constructor                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETTCPInterface_constructor'));
TRAKNETTCPInterface_destructor                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETTCPInterface_destructor'));
TRAKNETTCPInterface_Start                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETTCPInterface_Start'));
TRAKNETTCPInterface_Stop                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETTCPInterface_Stop'));
TRAKNETTCPInterface_Connect                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETTCPInterface_Connect'));
TRAKNETTCPInterface_Send                              :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETTCPInterface_Send'));
TRAKNETTCPInterface_Receive                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETTCPInterface_Receive'));
TRAKNETTCPInterface_CloseConnection                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETTCPInterface_CloseConnection'));
TRAKNETTCPInterface_DeallocatePacket                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETTCPInterface_DeallocatePacket'));
TRAKNETTCPInterface_HasNewConnection                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETTCPInterface_HasNewConnection'));
TRAKNETTCPInterface_HasLostConnection                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETTCPInterface_HasLostConnection'));

TRAKNETHuffComp_GenerateTreeFromStrings               :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETHuffComp_GenerateTreeFromStrings'));
TRAKNETHuffComp_EncodeString                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETHuffComp_EncodeString'));
TRAKNETHuffComp_DecodeString                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETHuffComp_DecodeString'));

TRAKNETBZipInit                                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETBZipInit'));
TRAKNETBZipUnInit                                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETBZipUnInit'));
TRAKNETBZip_ClearDecompress                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETBZip_ClearDecompress'));
TRAKNETBZip_ClearCompress                             :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETBZip_ClearCompress'));
TRAKNETBZip_Decompress                                :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETBZip_Decompress'));
TRAKNETBZip_Compress                                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETBZip_Compress'));

TRAKNETFileLogger_Constructor                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETFileLogger_Constructor'));
TRAKNETFileLogger_Destructor                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETFileLogger_Destructor'));
TRAKNETFileLogger_WriteLog                            :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETFileLogger_WriteLog'));
TRAKNETFileLogger_SetPrintID                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETFileLogger_SetPrintID'));
TRAKNETFileLogger_SetPrintAcks                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETFileLogger_SetPrintAcks'));

TRAKNETConsoleLogger_Constructor                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConsoleLogger_Constructor'));
TRAKNETConsoleLogger_Destructor                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConsoleLogger_Destructor'));
TRAKNETConsoleLogger_WriteLog                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConsoleLogger_WriteLog'));
TRAKNETConsoleLogger_SetPrintID                       :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConsoleLogger_SetPrintID'));
TRAKNETConsoleLogger_SetPrintAcks                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKNETConsoleLogger_SetPrintAcks'));

TRAKReplicaManager_Constructor                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_Constructor'));
TRAKReplicaManager_Destructor                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_Destructor'));
TRAKReplicaManager_SetAutoParticipateNewConnections   :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_SetAutoParticipateNewConnections'));
TRAKReplicaManager_AddParticipant                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_AddParticipant'));
TRAKReplicaManager_RemoveParticipant                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_RemoveParticipant'));
TRAKReplicaManager_Construct                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_Construct'));
TRAKReplicaManager_Destruct                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_Destruct'));
TRAKReplicaManager_ReferencePointer                   :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_ReferencePointer'));
TRAKReplicaManager_DereferencePointer                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_DereferencePointer'));
TRAKReplicaManager_SetScope                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_SetScope'));
TRAKReplicaManager_SignalSerializeNeeded              :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_SignalSerializeNeeded'));
TRAKReplicaManager_SetReceiveConstructionCB           :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_SetReceiveConstructionCB'));
TRAKReplicaManager_SetDownloadCompleteCB              :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_SetDownloadCompleteCB'));
TRAKReplicaManager_SetSendChannel                     :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_SetSendChannel'));
TRAKReplicaManager_SetAutoConstructToNewParticipants  :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_SetAutoConstructToNewParticipants'));
TRAKReplicaManager_SetDefaultScope                    :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_SetDefaultScope'));
TRAKReplicaManager_EnableReplicaInterfaces            :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_EnableReplicaInterfaces'));
TRAKReplicaManager_DisableReplicaInterfaces           :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_DisableReplicaInterfaces'));
TRAKReplicaManager_IsConstructed                      :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_IsConstructed'));
TRAKReplicaManager_IsInScope                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_IsInScope'));
TRAKReplicaManager_GetReplicaCount                    :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_GetReplicaCount'));
TRAKReplicaManager_GetReplicaAtIndex                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaManager_GetReplicaAtIndex'));

TRAKReplicaMember_Constructor                         :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_Constructor'));
TRAKReplicaMember_Destructor                          :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_Destructor'));
TRAKReplicaMember_GetInternalCallback                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_GetInternalCallback'));
TRAKReplicaMember_SetServer                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_SetServer'));
TRAKReplicaMember_GetNetworkID                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_GetNetworkID'));
TRAKReplicaMember_SetNetworkID                        :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_SetNetworkID'));
TRAKReplicaMember_SetParent                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_SetParent'));
TRAKReplicaMember_GetParent                           :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_GetParent'));
TRAKReplicaMember_GetStaticNetworkID                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_GetStaticNetworkID'));
TRAKReplicaMember_SetStaticNetworkID                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_SetStaticNetworkID'));
TRAKReplicaMember_IsNetworkIDAuthority                :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_IsNetworkIDAuthority'));
TRAKReplicaMember_SetExternalPlayerID                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_SetExternalPlayerID'));
TRAKReplicaMember_GetExternalPlayerID                 :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_GetExternalPlayerID'));
TRAKReplicaMember_GET_BASE_OBJECT_FROM_ID             :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_GET_BASE_OBJECT_FROM_ID'));
TRAKReplicaMember_GET_OBJECT_FROM_ID                  :=  GetProcAssertAddress(LibHandle,Pchar('RAKReplicaMember_GET_OBJECT_FROM_ID'));

end;

function  InitRaknetC:boolean;
begin
 LibHandle := LoadLibrary(Pchar(raknetclib));
 Result    := LibHandle>0;
 if Result then GetLibProcess(LibHandle);
end;

end.
