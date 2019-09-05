unit RaknetUtils;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Raknet utils

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
uses RaknetBitStream;

// huffman string encoder-decoder

  procedure GenerateTreeFromStrings(input:Pchar;inputLength:cardinal;languageID:integer=0); inline;
  procedure EncodeString(input:Pchar;maxCharsToWrite:Integer;output:TRakBitStream;languageID:integer=0); inline;
  function  DecodeString(output:Pchar;maxCharsToWrite:integer;input:TRakBitStream;languageID:integer=0):boolean; inline;


// bzip compression library

  procedure BZipLibraryInit;   inline; // initializate library
  procedure BZipLibraryUnInit; inline; // uninitializate library
  procedure BZipLibraryFinalizeDecompress; inline; // frees output pointer and zero internal data
  procedure BZipLibraryFinalizeCompress; inline; // frees output pointer and zero internal data
  function  BZipLibraryDecompress(Input:Pchar;InputLength:cardinal;ignoreStreamEnd:boolean;var outData:Pchar;var outSize:cardinal):boolean; inline;
  function  BZipLibraryCompress(Input:Pchar;InputLength:cardinal;finish:boolean;var outData:Pchar;var outSize:cardinal): boolean; inline;

  

implementation
uses RaknetDLL;

  procedure GenerateTreeFromStrings(input:Pchar;inputLength:cardinal;languageID:integer=0);
  begin
    TRAKNETHuffComp_GenerateTreeFromStrings(input,inputLength,languageID);
  end;

  procedure EncodeString(input:Pchar;maxCharsToWrite:Integer;output:TRakBitStream;languageID:integer=0);
  begin
    TRAKNETHuffComp_EncodeString(input,maxCharsToWrite,output.RaknetInterface,languageID);
  end;

  function  DecodeString(output:Pchar;maxCharsToWrite:integer;input:TRakBitStream;languageID:integer=0):boolean; 
  begin
    Result := TRAKNETHuffComp_DecodeString(output,maxCharsToWrite,input.RaknetInterface,languageID);
  end;


  procedure BZipLibraryInit;
  begin
    TRAKNETBZipInit;
  end;

  procedure BZipLibraryUnInit;
  begin
    TRAKNETBZipUnInit;
  end;

  procedure BZipLibraryFinalizeDecompress;
  begin
    TRAKNETBZip_ClearDecompress;
  end;

  procedure BZipLibraryFinalizeCompress;
  begin
    TRAKNETBZip_ClearCompress;
  end;

  function  BZipLibraryDecompress(Input:Pchar;InputLength:cardinal;ignoreStreamEnd:boolean;var outData:Pchar;var outSize:cardinal):boolean;
  begin
   Result := TRAKNETBZip_Decompress(Input,InputLength,ignoreStreamEnd,outData,outSize);
  end;

  function  BZipLibraryCompress(Input:Pchar;InputLength:cardinal;finish:boolean;var outData:Pchar;var outSize:cardinal): boolean;
  begin
   Result := TRAKNETBZip_Compress(input,InputLength,finish,outData,outSize);
  end;


end.
