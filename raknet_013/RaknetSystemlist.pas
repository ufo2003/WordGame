unit RaknetSystemlist;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Raknet router system list

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

uses RaknetTypes,
     RaknetStruct,
     RaknetBitStream;


{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type
        TRakSystemList = class(TRaknetInterfaceAbstract)
         private
         protected
          procedure   SetRaknetInterface(const Value: TRakInterface); override;
         public
          constructor Create;                             overload;
          constructor Create(const PlayerID:TRakPlayerID);overload;
          destructor  Destroy; override;
          procedure   AddSystem                     (PlayerID:TRakPlayerID);
          procedure   RandomizeOrder                ;
          procedure   Serialize                     (const BitStream:TRakBitStream);
          procedure   Deserialize                   (const BitStream:TRakBitStream);
          procedure   Save                          (const filename:String);
          procedure   Load                          (const filename:String);
          procedure   RemoveSystem                  (const PlayerID:TRakPlayerID);
          function    Size                          :cardinal;
          procedure   Clear                         ;
          function    Item                          (Position:cardinal):TRakPlayerID;
      end;
      
implementation

uses RaknetDLL,
     RaknetInterface,
     Sysutils;

{ TRakSystemList }

procedure TRakSystemList.AddSystem(PlayerID:TRakPlayerID);
begin
  
  TRAKNETSYSTEMADDRL_AddSystem(IntRaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakSystemList.Clear;
begin
  TRAKNETSYSTEMADDRL_Clear(IntRaknetInterface);
end;

constructor TRakSystemList.Create;
begin
  IntRaknetInterface := TRAKNETSYSTEMADDRL_constructor1;
end;

constructor TRakSystemList.Create(const PlayerID: TRakPlayerID);
begin
  IntRaknetInterface := TRAKNETSYSTEMADDRL_constructor2(PlayerID.RaknetInterface);
end;

procedure TRakSystemList.Deserialize(const BitStream: TRakBitStream);
begin
  TRAKNETSYSTEMADDRL_Deserialize(IntRaknetInterface,BitStream.RaknetInterface);
end;

destructor TRakSystemList.Destroy;
begin
 if IntRaknetInterface<>nil then 
 TRAKNETSYSTEMADDRL_destructor(IntRaknetInterface);
end;


function TRakSystemList.Item(Position: cardinal): TRakPlayerID;
begin
   Result := TRakPlayerID.Create;
   Result.RaknetInterface := TRAKNETSYSTEMADDRL_Item(IntRaknetInterface,Position);
   if Result.RaknetInterface=nil then FreeAndNil(Result);
end;

procedure TRakSystemList.Load(const filename: String);
begin
  TRAKNETSYSTEMADDRL_Load(IntRaknetInterface,Pchar(Filename));
end;

procedure TRakSystemList.RandomizeOrder;
begin
  TRAKNETSYSTEMADDRL_RandomizeOrder(IntRaknetInterface);
end;

procedure TRakSystemList.RemoveSystem(const PlayerID: TRakPlayerID);
begin
  TRAKNETSYSTEMADDRL_RemoveSystem(IntRaknetInterface,PlayerID.RaknetInterface);
end;

procedure TRakSystemList.Save(const filename: String);
begin
  TRAKNETSYSTEMADDRL_Save(IntRaknetInterface,Pchar(filename));
end;

procedure TRakSystemList.Serialize(const BitStream: TRakBitStream);
begin
  TRAKNETSYSTEMADDRL_Serialize(IntRaknetInterface,BitStream.RaknetInterface);
end;


procedure TRakSystemList.SetRaknetInterface(const Value: TRakInterface);
begin
  if IntRaknetInterface<>nil then
    begin
     UnInitClientInterface(IntRaknetInterface);
    end;
  IntRaknetInterface:=Value;
end;

function TRakSystemList.Size: cardinal;
begin
  Result := TRAKNETSYSTEMADDRL_Size(IntRaknetInterface);
end;

end.
