unit RaknetPlugin;
{=============================================================================}
{
 Description :  Raknet Delphi wrapper - Raknet plugins

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
uses RakNetTypes,
     RakNetStruct;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

type


               TRakPlugin=class(TRaknetInterfaceAbstract)
                public
                 protected
                 public
                 constructor Create; virtual;
                 destructor  Destroy; virtual;
               end;


              TFileLoggerPlugin= class(TRakPlugin)
                private
                protected
                public
                 procedure   WriteLog(const Log:string);
                 procedure   PrintID(const Print:boolean);
                 procedure   PrintAcks(const Print:boolean);
                 constructor Create; override;
                 destructor  Destroy; override;
              end;


             TConsoleLoggerPlugin= class(TRakPlugin)
                private
                protected
                public
                 procedure   WriteLog(const Log:string);
                 procedure   PrintID(const Print:boolean);
                 procedure   PrintAcks(const Print:boolean);
                 constructor Create; override;
                 destructor  Destroy; override;
              end;



implementation
uses RaknetDLL;
{ TRakPlugin }


constructor TRakPlugin.Create;
begin

end;

destructor TRakPlugin.Destroy;
begin

end;



{ TConsoleLoggerPlugin }

constructor TConsoleLoggerPlugin.Create;
begin
  inherited;
  IntRaknetInterface := TRAKNETConsoleLogger_Constructor;
end;

destructor TConsoleLoggerPlugin.Destroy;
begin
  TRAKNETConsoleLogger_Destructor(IntRaknetInterface);
  inherited;
end;

procedure TConsoleLoggerPlugin.PrintAcks(const Print: boolean);
begin
  TRAKNETConsoleLogger_SetPrintAcks(IntRaknetInterface,Print);
end;

procedure TConsoleLoggerPlugin.PrintID(const Print: boolean);
begin
  TRAKNETConsoleLogger_SetPrintID(IntRaknetInterface,Print);
end;

procedure TConsoleLoggerPlugin.WriteLog(const Log: string);
begin
  TRAKNETConsoleLogger_WriteLog(IntRaknetInterface,Pchar(Log));
end;

{ TFileLoggerPlugin }

constructor TFileLoggerPlugin.Create;
begin
  inherited;
  IntRaknetInterface := TRAKNETFileLogger_Constructor;
end;

destructor TFileLoggerPlugin.Destroy;
begin
  TRAKNETFileLogger_Destructor(IntRaknetInterface);
  inherited;
end;

procedure TFileLoggerPlugin.PrintAcks(const Print: boolean);
begin
  TRAKNETFileLogger_SetPrintAcks(IntRaknetInterface,Print);
end;

procedure TFileLoggerPlugin.PrintID(const Print: boolean);
begin
 TRAKNETFileLogger_SetPrintID(IntRaknetInterface,Print);
end;

procedure TFileLoggerPlugin.WriteLog(const Log: string);
begin
 TRAKNETFileLogger_WriteLog(IntRaknetInterface,Pchar(Log));
end;

end.
