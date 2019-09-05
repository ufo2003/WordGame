unit RaknetBitStream;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - BitStream

 Delphi wrapper and c port author : Joe Oszlanczi (BigJoe)
                                    Hungary
                                    raknetwrapper@freemail.hu
                                    Please send me any error report
 Wrapper version :  0.13

 This source published under GPL - General public license

 Original right visit www.rakkarsoft.com


 Information :


}
{=============================================================================}

interface
uses RakNetTypes;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type


// ------------------------------------
 //
 // Bitstream
 //
 // ------------------------------------

 TRakBitStream = class(TRaknetInterfaceAbstract)
   private
   protected
    procedure    SetRaknetInterface(const Value: TRakInterface); override;
   public
   constructor Create;    overload;
   constructor Create(initialBytesToAllocate:integer); overload;
   constructor Create(_data:Pchar;lengthInBytes:cardinal;_copyData:boolean); overload;
   destructor  Destroy;   override;
   procedure  reset                    ;
   procedure  BSWriteFromWSize         (bitStreamTo:TRakBitStream;numberOfBits:integer);
   procedure  BSWriteFrom              (bitStreamTo:TRakBitStream);
   procedure  ResetReadPointer         ;
   procedure  ResetWritePointer        ;
   procedure  AssertStreamEmpty        ;
   procedure  PrintBits                ;
   procedure  IgnoreBits               (numberOfBits: integer);
   procedure  SetWriteOffset           (offset: integer);
   function   GetNumberOfBitsUsed      :integer;
   function   GetWriteOffset           :integer;
   function   GetNumberOfBytesUsed     :integer;
   function   GetReadOffset            :integer;
   procedure  SetReadOffset            (offset: integer);
   function   GetNumberOfUnreadBits    :integer;
   function   CopyData                 (var _data:Pchar):integer;
   procedure  SetData                  (input: Pchar);
   function   GetData                  :Pchar;
   procedure  WriteBits                (input:Pchar;numberOfBitsToWrite:integer;rightAlignedBits:boolean);
   procedure  WriteAlignedBytes        (input:Pchar;numberOfBytesToWrite:integer);
   function   ReadAlignedBytes         (output:Pchar;numberOfBytesToRead:integer):boolean;
   procedure  AlignWriteToByteBoundary ;
   procedure  AlignReadToByteBoundary  ;
   function   ReadBits                 (output:Pchar;numberOfBitsToRead:integer;alignBitsToRight:boolean):boolean;
   procedure  Write                    (input:Pchar;numberOfBytes:integer);
   procedure  Write0                   ;
   procedure  Write1                   ;
   function   ReadBit                  :boolean;
   procedure  AssertCopyData           ;
   procedure  SetNumberOfBitsAllocated (lengthInBits:cardinal );
   procedure  AddBitsAndReallocate     (numberOfBitsToWrite:integer);
   function   Serialize_Byte           (writeToBitstream:boolean;var Indata:byte):boolean;
   function   Serialize_Word           (writeToBitstream:boolean;var Indata:word):boolean;
   function   Serialize_LongWord       (writeToBitstream:boolean;var Indata:cardinal):boolean;
   function   Serialize_Float          (writeToBitstream:boolean;var Indata:single):boolean;
   function   Serialize_Double         (writeToBitstream:boolean;var Indata:double):boolean;
   function   SerializeDelta_Byte      (writeToBitstream:boolean;var Indata:byte):boolean;
   function   SerializeDelta_Word      (writeToBitstream:boolean;var Indata:word):boolean;
   function   SerializeDelta_LongWord  (writeToBitstream:boolean;var Indata:cardinal):boolean;
   function   SerializeDelta_Float     (writeToBitstream:boolean;var Indata:single):boolean;
   function   SerializeDelta_Double    (writeToBitstream:boolean;var Indata:double):boolean;
   procedure  Write_Byte               (Indata:byte);
   procedure  Write_Word               (Indata:word);
   procedure  Write_LongWord           (Indata:cardinal);
   procedure  Write_Float              (Indata:single);
   procedure  Write_Double             (Indata:double);
   procedure  WriteCompressed_Byte     (Indata:byte);
   procedure  WriteCompressed_Word     (Indata:word);
   procedure  WriteCompressed_LongWord (Indata:cardinal);
   procedure  WriteCompressed_Float    (Indata:single);
   procedure  WriteCompressed_Double   (Indata:double);
   procedure  WriteDelta_Byte          (Indata:byte);
   procedure  WriteDelta_Word          (Indata:word);
   procedure  WriteDelta_LongWord      (Indata:cardinal);
   procedure  WriteDelta_Float         (Indata:single);
   procedure  WriteDelta_Double        (Indata:double);
   procedure  WriteCompressedDelta_Byte          (Indata:byte);
   procedure  WriteCompressedDelta_Word          (Indata:word);
   procedure  WriteCompressedDelta_LongWord      (Indata:cardinal);
   procedure  WriteCompressedDelta_Float         (Indata:single);
   procedure  WriteCompressedDelta_Double        (Indata:double);
   function   Read_Byte                          (var Indata:byte):boolean;
   function   Read_Word                          (var Indata:word):boolean;
   function   Read_LongWord                      (var Indata:cardinal):boolean;
   function   Read_Float                         (var Indata:single):boolean;
   function   Read_Double                        (var Indata:single):boolean;
   function   ReadCompressed_Byte                (var Indata:byte):boolean;
   function   ReadCompressed_Word                (var Indata:word):boolean;
   function   ReadCompressed_LongWord            (var Indata:cardinal):boolean;
   function   ReadCompressed_Float               (var Indata:single):boolean;
   function   ReadCompressed_Double              (var Indata:single):boolean;
   function   ReadDelta_Byte                     (var Indata:byte):boolean;
   function   ReadDelta_Word                     (var Indata:word):boolean;
   function   ReadDelta_LongWord                 (var Indata:cardinal):boolean;
   function   ReadDelta_Float                    (var Indata:single):boolean;
   function   ReadDelta_Double                   (var Indata:single):boolean;
   function   ReadCompressedDelta_Byte           (var Indata:byte):boolean;
   function   ReadCompressedDelta_Word           (var Indata:word):boolean;
   function   ReadCompressedDelta_LongWord       (var Indata:cardinal):boolean;
   function   ReadCompressedDelta_Float          (var Indata:single):boolean;
   function   ReadCompressedDelta_Double         (var Indata:single):boolean;
   function   SerializeCompressed_Byte             (writeToBitstream:boolean;var Indata:byte):boolean;
   function   SerializeCompressed_Word             (writeToBitstream:boolean;var Indata:word):boolean;
   function   SerializeCompressed_LongWord         (writeToBitstream:boolean;var Indata:cardinal):boolean;
   function   SerializeCompressed_Float            (writeToBitstream:boolean;var Indata:single):boolean;
   function   SerializeCompressed_Double           (writeToBitstream:boolean;var Indata:single):boolean;
   function   SerializeCompressedDelta_Byte        (writeToBitstream:boolean;var Indata:byte):boolean;
   function   SerializeCompressedDelta_Word        (writeToBitstream:boolean;var Indata:word):boolean;
   function   SerializeCompressedDelta_LongWord    (writeToBitstream:boolean;var Indata:cardinal):boolean;
   function   SerializeCompressedDelta_Float       (writeToBitstream:boolean;var Indata:single):boolean;
   function   SerializeCompressedDelta_Double      (writeToBitstream:boolean;var Indata:single):boolean;
   function   Serialize                            (writeToBitstream:boolean;input:Pchar;numberOfBytes:integer):boolean;
   function   SerializeBits                        (writeToBitstream:boolean;input:Pchar;numberOfBitsToSerialize:integer;rightAlignedBits:boolean):boolean;
   function   Read                                 (output:pchar;numberOfBytes:integer):boolean;
   function   SerializeNormVectorFloat             (writeToBitstream:boolean;var x,y,z:single):boolean;
   function   SerializeNormVectorDouble            (writeToBitstream:boolean;var x,y,z:double):boolean;
   function   SerializeVectorFloat                 (writeToBitstream:boolean;var x,y,z:single):boolean;
   function   SerializeVectorDouble                (writeToBitstream:boolean;var x,y,z:double):boolean;
   function   SerializeNormQuatFloat               (writeToBitstream:boolean;var w,x,y,z:single):boolean;
   function   SerializeNormQuatDouble              (writeToBitstream:boolean;var w,x,y,z:double):boolean;
   function   SerializeOrthMatrixFloat             (writeToBitstream:boolean;var m00,m01,m02,m10,m11,m12,m20,m21,m22:single):boolean;
   function   SerializeOrthMatrixDouble            (writeToBitstream:boolean;var m00,m01,m02,m10,m11,m12,m20,m21,m22:double):boolean;   
   function   ReadNormVectorFloat                  (var x,y,z:single):boolean;
   function   ReadNormVectorDouble                 (var x,y,z:double):boolean;
   function   ReadVectorFloat                      (var x,y,z:single):boolean;
   function   ReadVectorDouble                     (var x,y,z:double):boolean;
   function   ReadNormQuatFloat                    (var w,x,y,z:single):boolean;
   function   ReadNormQuatDouble                   (var w,x,y,z:double):boolean;
   function   ReadOrthMatrixFloat                  (var m00,m01,m02,m10,m11,m12,m20,m21,m22:single):boolean;
   function   ReadOrthMatrixDouble                 (var m00,m01,m02,m10,m11,m12,m20,m21,m22:double):boolean;
   procedure  WriteNormVectorFloat                 (x,y,z:single);
   procedure  WriteNormVectorDouble                (x,y,z:double);
   procedure  WriteVectorFloat                     (x,y,z:single);
   procedure  WriteVectorDouble                    (x,y,z:double);
   procedure  WriteNormQuatFloat                   (w,x,y,z:single);
   procedure  WriteNormQuatDouble                  (w,x,y,z:double);
   procedure  WriteOrthMatrixFloat                 (m00,m01,m02,m10,m11,m12,m20,m21,m22:single);
   procedure  WriteOrthMatrixDouble                (m00,m01,m02,m10,m11,m12,m20,m21,m22:double);

 

end;


implementation
uses RaknetDLL,
     RaknetInterface;

{ TRakBitStream }

procedure TRakBitStream.AddBitsAndReallocate(numberOfBitsToWrite: integer);
begin

  TBITSTREAM_AddBitsAndReallocate(RaknetInterface,numberOfBitsToWrite);
end;

procedure TRakBitStream.AlignReadToByteBoundary;
begin
   TBITSTREAM_AlignReadToByteBoundary(RaknetInterface);
end;

procedure TRakBitStream.AlignWriteToByteBoundary;
begin
  TBITSTREAM_AlignWriteToByteBoundary(RaknetInterface);
end;

procedure TRakBitStream.AssertCopyData;
begin
  TBITSTREAM_AssertCopyData(RaknetInterface);
end;

procedure TRakBitStream.AssertStreamEmpty;
begin
 TBITSTREAM_AssertStreamEmpty(RaknetInterface);
end;

procedure TRakBitStream.BSWriteFrom(bitStreamTo: TRakBitStream);
begin
 TBITSTREAM_BSWriteFrom(RaknetInterface,bitStreamTo.RaknetInterface);
end;

procedure TRakBitStream.BSWriteFromWSize(bitStreamTo: TRakBitStream;
  numberOfBits: integer);
begin
  TBITSTREAM_BSWriteFromWSize(RaknetInterface,bitStreamTo.RaknetInterface,numberOfBits);
end;

function TRakBitStream.CopyData(var _data: Pchar): integer;
begin
  Result := TBITSTREAM_CopyData(RaknetInterface,_data);
end;

constructor TRakBitStream.Create(initialBytesToAllocate: integer);
begin
  RaknetInterface := TBITSTREAM_constructor2(initialBytesToAllocate);
end;

constructor TRakBitStream.Create;
begin
end;

constructor TRakBitStream.Create(_data: Pchar; lengthInBytes: cardinal;
  _copyData: boolean);
begin
  RaknetInterface := TBITSTREAM_constructor3(_data,lengthInBytes,_copyData);
end;      

destructor TRakBitStream.Destroy;
begin
 if IntRaknetInterface<>nil then 
 TBITSTREAM_destructor(RaknetInterface);
end;

function TRakBitStream.GetData: Pchar;
begin
   Result := TBITSTREAM_GetData(RaknetInterface);
end;

function TRakBitStream.GetNumberOfBitsUsed: integer;
begin
   Result := TBITSTREAM_GetNumberOfBitsUsed(RaknetInterface);
end;

function TRakBitStream.GetNumberOfBytesUsed: integer;
begin
  Result := TBITSTREAM_GetNumberOfBytesUsed(RaknetInterface);
end;

function TRakBitStream.GetNumberOfUnreadBits: integer;
begin
 Result := TBITSTREAM_GetNumberOfUnreadBits(RaknetInterface);
end;

function TRakBitStream.GetReadOffset: integer;
begin
 Result := TBITSTREAM_GetReadOffset(RaknetInterface);
end;

function TRakBitStream.GetWriteOffset: integer;
begin
  Result := TBITSTREAM_GetWriteOffset(RaknetInterface);
end;

procedure TRakBitStream.IgnoreBits(numberOfBits: integer);
begin
  TBITSTREAM_IgnoreBits(RaknetInterface,numberOfBits);
end;

procedure TRakBitStream.PrintBits;
begin
 TBITSTREAM_PrintBits(RaknetInterface);
end;

function TRakBitStream.Read(output: pchar; numberOfBytes: integer): boolean;
begin
 Result := TBITSTREAM_Read(RaknetInterface,output,numberOfBytes);
end;

function TRakBitStream.ReadAlignedBytes(output: Pchar;
  numberOfBytesToRead: integer): boolean;
begin
  Result := TBITSTREAM_ReadAlignedBytes(RaknetInterface,output,numberOfBytesToRead);
end;

function TRakBitStream.ReadBit: boolean;
begin
 Result := TBITSTREAM_ReadBit(RaknetInterface);
end;

function TRakBitStream.ReadBits(output: Pchar; numberOfBitsToRead: integer;
  alignBitsToRight: boolean): boolean;
begin
 result := TBITSTREAM_ReadBits(RaknetInterface,output,numberOfBitsToRead,alignBitsToRight);
end;

function TRakBitStream.ReadCompressedDelta_Byte(var Indata: byte): boolean;
begin
  result := TBITSTREAM_ReadCompressedDelta_Byte(RaknetInterface,indata);
end;

function TRakBitStream.ReadCompressedDelta_Double(var Indata: single): boolean;
begin
  result := TBITSTREAM_ReadCompressedDelta_Double(RaknetInterface,indata);
end;

function TRakBitStream.ReadCompressedDelta_Float(var Indata: single): boolean;
begin
   result := TBITSTREAM_ReadCompressedDelta_Float(RaknetInterface,indata);
end;

function TRakBitStream.ReadCompressedDelta_LongWord(var Indata: cardinal): boolean;
begin
   result := TBITSTREAM_ReadCompressedDelta_LongWord(RaknetInterface,indata);
end;

function TRakBitStream.ReadCompressedDelta_Word(var Indata: word): boolean;
begin
   result := TBITSTREAM_ReadCompressedDelta_Word(RaknetInterface,indata);
end;

function TRakBitStream.ReadCompressed_Byte(var Indata: byte): boolean;
begin
    result := TBITSTREAM_ReadCompressed_Byte(RaknetInterface,indata);
end;

function TRakBitStream.ReadCompressed_Double(var Indata: single): boolean;
begin
    result := TBITSTREAM_ReadCompressed_Double(RaknetInterface,indata);
end;

function TRakBitStream.ReadCompressed_Float(var Indata: single): boolean;
begin
    result := TBITSTREAM_ReadCompressed_Float(RaknetInterface,indata);
end;

function TRakBitStream.ReadCompressed_LongWord(var Indata: cardinal): boolean;
begin
      result := TBITSTREAM_ReadCompressed_Longword(RaknetInterface,indata);

end;

function TRakBitStream.ReadCompressed_Word(var Indata: word): boolean;
begin
     result := TBITSTREAM_ReadCompressed_Word(RaknetInterface,indata);
end;

function TRakBitStream.ReadDelta_Byte(var Indata: byte): boolean;
begin
    result := TBITSTREAM_ReadDelta_Byte(RaknetInterface,Indata);
end;

function TRakBitStream.ReadDelta_Double(var Indata: single): boolean;
begin
   result := TBITSTREAM_ReadDelta_double(RaknetInterface,Indata);
end;

function TRakBitStream.ReadDelta_Float(var Indata: single): boolean;
begin
   result := TBITSTREAM_ReadDelta_Float(RaknetInterface,Indata);
end;

function TRakBitStream.ReadDelta_LongWord(var Indata: cardinal): boolean;
begin
  result := TBITSTREAM_ReadDelta_LongWord(RaknetInterface,Indata);
end;

function TRakBitStream.ReadDelta_Word(var Indata: word): boolean;
begin
 result := TBITSTREAM_ReadDelta_Word(RaknetInterface,Indata);
end;

function TRakBitStream.ReadNormQuatDouble(var w, x, y, z: double): boolean;
begin
 result := TBITSTREAM_ReadNormQuatDouble(RaknetInterface,w,x,y,z);
end;

function TRakBitStream.ReadNormQuatFloat(var w, x, y, z: single): boolean;
begin
  result := TBITSTREAM_ReadNormQuatFloat(RaknetInterface,w,x,y,z);
end;

function TRakBitStream.ReadNormVectorDouble(var x, y, z: double): boolean;
begin
   result := TBITSTREAM_ReadNormVectorDouble(RaknetInterface,x,y,z);
end;

function TRakBitStream.ReadNormVectorFloat(var x, y, z: single): boolean;
begin
   result := TBITSTREAM_ReadNormVectorFloat(RaknetInterface,x,y,z);
end;

function TRakBitStream.ReadOrthMatrixDouble(var m00, m01, m02, m10, m11, m12,
  m20, m21, m22: double): boolean;
begin
  result := TBITSTREAM_ReadOrthMatrixDouble(RaknetInterface,m00, m01, m02, m10, m11, m12,
  m20, m21, m22);
end;

function TRakBitStream.ReadOrthMatrixFloat(var m00, m01, m02, m10, m11, m12,
  m20, m21, m22: single): boolean;
begin
  result := TBITSTREAM_ReadOrthMatrixFloat(RaknetInterface,m00, m01, m02, m10, m11, m12,
  m20, m21, m22);
end;

function TRakBitStream.ReadVectorDouble(var x, y, z: double): boolean;
begin
  result := TBITSTREAM_ReadVectorDouble(RaknetInterface,x,y,z);
end;

function TRakBitStream.ReadVectorFloat(var x, y, z: single): boolean;
begin
   result := TBITSTREAM_ReadVectorFloat(RaknetInterface,x,y,z);
end;

function TRakBitStream.Read_Byte(var Indata: byte): boolean;
begin
   result := TBITSTREAM_Read_Byte(RaknetInterface,indata);
end;

function TRakBitStream.Read_Double(var Indata: single): boolean;
begin
   result := TBITSTREAM_Read_Double(RaknetInterface,indata);
end;

function TRakBitStream.Read_Float(var Indata: single): boolean;
begin
   result := TBITSTREAM_Read_Float(RaknetInterface,indata);
end;

function TRakBitStream.Read_LongWord(var Indata: cardinal): boolean;
begin
   result := TBITSTREAM_Read_LongWord(RaknetInterface,indata);
end;

function TRakBitStream.Read_Word(var Indata: word): boolean;
begin
   result := TBITSTREAM_Read_Word(RaknetInterface,indata);
end;

procedure TRakBitStream.reset;
begin
   if RaknetInterface<>nil then   
   TBITSTREAM_reset(RaknetInterface);
end;

procedure TRakBitStream.ResetReadPointer;
begin
  TBITSTREAM_ResetReadPointer(RaknetInterface);
end;

procedure TRakBitStream.ResetWritePointer;
begin
  TBITSTREAM_ResetWritePointer(RaknetInterface);
end;

function TRakBitStream.Serialize(writeToBitstream: boolean; input: Pchar;
  numberOfBytes: integer): boolean;
begin
   Result := TBITSTREAM_Serialize(RaknetInterface,writeToBitstream,input,numberOfBytes);
end;

function TRakBitStream.SerializeBits(writeToBitstream: boolean; input: Pchar;
  numberOfBitsToSerialize: integer; rightAlignedBits: boolean): boolean;
begin
   Result := TBITSTREAM_SerializeBits(RaknetInterface,writeToBitstream,input,numberOfBitsToSerialize,rightAlignedBits);
end;

function TRakBitStream.SerializeCompressedDelta_Byte(writeToBitstream: boolean;
  var Indata: byte): boolean;
begin
  Result := TBITSTREAM_SerializeCompressedDelta_Byte(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeCompressedDelta_Double(
  writeToBitstream: boolean; var Indata: single): boolean;
begin
  Result := TBITSTREAM_SerializeCompressedDelta_double(RaknetInterface,writeToBitstream,indata);

end;

function TRakBitStream.SerializeCompressedDelta_Float(writeToBitstream: boolean;
  var Indata: single): boolean;
begin
   Result := TBITSTREAM_SerializeCompressedDelta_Float(RaknetInterface,writeToBitstream,indata);

end;

function TRakBitStream.SerializeCompressedDelta_LongWord(
  writeToBitstream: boolean; var Indata: cardinal): boolean;
begin
    Result := TBITSTREAM_SerializeCompressedDelta_LongWord(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeCompressedDelta_Word(writeToBitstream: boolean;
  var Indata: word): boolean;
begin
     Result := TBITSTREAM_SerializeCompressedDelta_Word(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeCompressed_Byte(writeToBitstream: boolean;
  var Indata: byte): boolean;
begin
     Result := TBITSTREAM_SerializeCompressed_Byte(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeCompressed_Double(writeToBitstream: boolean;
  var Indata: single): boolean;
begin
     Result := TBITSTREAM_SerializeCompressed_Double(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeCompressed_Float(writeToBitstream: boolean;
  var Indata: single): boolean;
begin
       Result := TBITSTREAM_SerializeCompressed_Float(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeCompressed_LongWord(writeToBitstream: boolean;
  var Indata: cardinal): boolean;
begin
        Result := TBITSTREAM_SerializeCompressed_LongWord(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeCompressed_Word(writeToBitstream: boolean;
  var Indata: word): boolean;
begin
     Result := TBITSTREAM_SerializeCompressed_Word(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeDelta_Byte(writeToBitstream: boolean;
  var Indata: byte): boolean;
begin
      Result := TBITSTREAM_SerializeDelta_Byte(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeDelta_Double(writeToBitstream: boolean;
  var Indata: double): boolean;
begin
      Result := TBITSTREAM_SerializeDelta_Double(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeDelta_Float(writeToBitstream: boolean;
  var Indata: single): boolean;
begin
       Result := TBITSTREAM_SerializeDelta_Float(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeDelta_LongWord(writeToBitstream: boolean;
  var Indata: cardinal): boolean;
begin
      Result := TBITSTREAM_SerializeDelta_LongWord(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeDelta_Word(writeToBitstream: boolean;
  var Indata: word): boolean;
begin
      Result := TBITSTREAM_SerializeDelta_Word(RaknetInterface,writeToBitstream,indata);
end;

function TRakBitStream.SerializeNormQuatDouble(writeToBitstream: boolean; var w,
  x, y, z: double): boolean;
begin
    Result := TBITSTREAM_SerializeNormQuatDouble(RaknetInterface,writeToBitstream,w,x,y,z);
end;

function TRakBitStream.SerializeNormQuatFloat(writeToBitstream: boolean; var w,
  x, y, z: single): boolean;
begin
    Result := TBITSTREAM_SerializeNormQuatFloat(RaknetInterface,writeToBitstream,w,x,y,z);
end;

function TRakBitStream.SerializeNormVectorDouble(writeToBitstream: boolean;
  var x, y, z: double): boolean;
begin
    Result := TBITSTREAM_SerializeNormVectorDouble(RaknetInterface,writeToBitstream,x,y,z);
end;

function TRakBitStream.SerializeNormVectorFloat(writeToBitstream: boolean;
  var x, y, z: single): boolean;
begin
    Result := TBITSTREAM_SerializeNormVectorFloat(RaknetInterface,writeToBitstream,x,y,z);
end;

function TRakBitStream.SerializeOrthMatrixDouble(writeToBitstream: boolean;
  var m00, m01, m02, m10, m11, m12, m20, m21, m22: double): boolean;
begin
  Result := TBITSTREAM_SerializeOrthMatrixDouble(RaknetInterface,writeToBitstream,m00, m01, m02, m10, m11, m12, m20, m21, m22);
end;

function TRakBitStream.SerializeOrthMatrixFloat(writeToBitstream: boolean;
  var m00, m01, m02, m10, m11, m12, m20, m21, m22: single): boolean;
begin
  Result := TBITSTREAM_SerializeOrthMatrixFloat(RaknetInterface,writeToBitstream,m00, m01, m02, m10, m11, m12, m20, m21, m22);
end;

function TRakBitStream.SerializeVectorDouble(writeToBitstream: boolean; var x,
  y, z: double): boolean;
begin
   Result := TBITSTREAM_SerializeVectorDouble(RaknetInterface,writeToBitstream,x,y,z);
end;

function TRakBitStream.SerializeVectorFloat(writeToBitstream: boolean; var x, y,
  z: single): boolean;
begin
   Result := TBITSTREAM_SerializeVectorFloat(RaknetInterface,writeToBitstream,x,y,z);
end;

function TRakBitStream.Serialize_Byte(writeToBitstream: boolean;
  var Indata: byte): boolean;
begin
  Result := TBITSTREAM_Serialize_Byte(RaknetInterface,writeToBitstream,Indata);
end;

function TRakBitStream.Serialize_Double(writeToBitstream: boolean;
  var Indata: double): boolean;
begin
  Result := TBITSTREAM_Serialize_Double(RaknetInterface,writeToBitstream,Indata);

end;

function TRakBitStream.Serialize_Float(writeToBitstream: boolean;
  var Indata: single): boolean;
begin
   Result := TBITSTREAM_Serialize_Float(RaknetInterface,writeToBitstream,Indata);
end;

function TRakBitStream.Serialize_LongWord(writeToBitstream: boolean;
  var Indata: cardinal): boolean;
begin
   Result := TBITSTREAM_Serialize_LongWord(RaknetInterface,writeToBitstream,Indata);
end;

function TRakBitStream.Serialize_Word(writeToBitstream: boolean;
  var Indata: word): boolean;
begin
    Result := TBITSTREAM_Serialize_Word(RaknetInterface,writeToBitstream,Indata);
end;

procedure TRakBitStream.SetData(input: Pchar);
begin
    TBITSTREAM_SetData(RaknetInterface,input);
end;

procedure TRakBitStream.SetNumberOfBitsAllocated(lengthInBits: cardinal);
begin
   TBITSTREAM_SetNumberOfBitsAllocated(RaknetInterface,lengthInBits);
end;

procedure TRakBitStream.SetRaknetInterface(const Value: TRakInterface);
begin
 if IntRaknetInterface<>nil then 
  TBITSTREAM_destructor(RaknetInterface);
 IntRaknetInterface := Value;
end;

procedure TRakBitStream.SetReadOffset(offset: integer);
begin
   TBITSTREAM_SetReadOffset(RaknetInterface,offset);
end;

procedure TRakBitStream.SetWriteOffset(offset: integer);
begin
  TBITSTREAM_SetWriteOffset(RaknetInterface,offset);
end;

procedure TRakBitStream.Write(input: Pchar; numberOfBytes: integer);
begin
  TBITSTREAM_Write(RaknetInterface,input,numberOfBytes);
end;

procedure TRakBitStream.Write0;
begin
  TBITSTREAM_Write0(RaknetInterface);
end;

procedure TRakBitStream.Write1;
begin
 TBITSTREAM_Write1(RaknetInterface);
end;

procedure TRakBitStream.WriteAlignedBytes(input: Pchar;
  numberOfBytesToWrite: integer);
begin
  TBITSTREAM_WriteAlignedBytes(RaknetInterface,input,numberOfBytesToWrite);
end;

procedure TRakBitStream.WriteBits(input: Pchar; numberOfBitsToWrite: integer;
  rightAlignedBits: boolean);
begin
  TBITSTREAM_WriteBits(RaknetInterface,input,numberOfBitsToWrite,rightAlignedBits);
end;

procedure TRakBitStream.WriteCompressedDelta_Byte(Indata: byte);
begin
  TBITSTREAM_WriteCompressedDelta_Byte(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteCompressedDelta_Double(Indata: double);
begin
  TBITSTREAM_WriteCompressedDelta_Double(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteCompressedDelta_Float(Indata: single);
begin
  TBITSTREAM_WriteCompressedDelta_Float(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteCompressedDelta_LongWord(Indata: cardinal);
begin
 TBITSTREAM_WriteCompressedDelta_Longword(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteCompressedDelta_Word(Indata: word);
begin
 TBITSTREAM_WriteCompressedDelta_Word(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteCompressed_Byte(Indata: byte);
begin
  TBITSTREAM_WriteCompressed_Byte(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteCompressed_Double(Indata: double);
begin
  TBITSTREAM_WriteCompressed_Double(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteCompressed_Float(Indata: single);
begin
    TBITSTREAM_WriteCompressed_Float(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteCompressed_LongWord(Indata: cardinal);
begin
    TBITSTREAM_WriteCompressed_Longword(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteCompressed_Word(Indata: word);
begin
     TBITSTREAM_WriteCompressed_Word(RaknetInterface,Indata);

end;

procedure TRakBitStream.WriteDelta_Byte(Indata: byte);
begin
     TBITSTREAM_WriteDelta_Byte(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteDelta_Double(Indata: double);
begin
     TBITSTREAM_WriteDelta_Double(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteDelta_Float(Indata: single);
begin
       TBITSTREAM_WriteDelta_Float(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteDelta_LongWord(Indata: cardinal);
begin
   TBITSTREAM_WriteDelta_LongWord(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteDelta_Word(Indata: word);
begin
        TBITSTREAM_WriteDelta_Word(RaknetInterface,Indata);
end;

procedure TRakBitStream.WriteNormQuatDouble(w, x, y, z: double);
begin
       TBITSTREAM_WriteNormQuatDouble(RaknetInterface,w,x,y,z);
end;

procedure TRakBitStream.WriteNormQuatFloat(w, x, y, z: single);
begin
       TBITSTREAM_WriteNormQuatFloat(RaknetInterface,w,x,y,z);
end;

procedure TRakBitStream.WriteNormVectorDouble(x, y, z: double);
begin
       TBITSTREAM_WriteNormVectorDouble(RaknetInterface,x,y,z);
end;

procedure TRakBitStream.WriteNormVectorFloat(x, y, z: single);
begin
       TBITSTREAM_WriteNormVectorFloat(RaknetInterface,x,y,z);
end;

procedure TRakBitStream.WriteOrthMatrixDouble(m00, m01, m02, m10, m11, m12, m20,
  m21, m22: double);
begin
       TBITSTREAM_WriteOrthMatrixDouble(RaknetInterface,m00, m01, m02, m10, m11, m12, m20,m21, m22);
end;

procedure TRakBitStream.WriteOrthMatrixFloat(m00, m01, m02, m10, m11, m12, m20,
  m21, m22: single);
begin
      TBITSTREAM_WriteOrthMatrixFloat(RaknetInterface,m00, m01, m02, m10, m11, m12, m20,m21, m22);
end;

procedure TRakBitStream.WriteVectorDouble(x, y, z: double);
begin
    TBITSTREAM_WriteVectorDouble(RaknetInterface,x,y,z);
end;

procedure TRakBitStream.WriteVectorFloat(x, y, z: single);
begin
    TBITSTREAM_WriteVectorFloat(RaknetInterface,x,y,z);
end;

procedure TRakBitStream.Write_Byte(Indata: byte);
begin
    TBITSTREAM_Write_byte(RaknetInterface,Indata);
end;

procedure TRakBitStream.Write_Double(Indata: double);
begin
    TBITSTREAM_Write_Double(RaknetInterface,Indata);
end;

procedure TRakBitStream.Write_Float(Indata: single);
begin
   TBITSTREAM_Write_Float(RaknetInterface,Indata);
end;

procedure TRakBitStream.Write_LongWord(Indata: cardinal);
begin
   TBITSTREAM_Write_LongWord(RaknetInterface,Indata);
end;

procedure TRakBitStream.Write_Word(Indata: word);
begin
   TBITSTREAM_Write_Word(RaknetInterface,Indata);
end;

end.
