unit Unit_note;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm_note = class(TForm)
    RichEdit1: TRichEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
     list_index: integer;
     note_stringlist: Tstringlist;
     procedure EnableChanged(var Msg: TMessage); message WM_ENABLE;

  public
    { Public declarations }
    procedure CreateParams(var Para:TCreateParams);override;
    procedure add_and_show(const s: string);  //添加一条消息并显示它
  end;

var
  Form_note: TForm_note;

implementation
    uses unit_net_set,richedit,shellapi;
{$R *.dfm}

procedure TForm_note.Button3Click(Sender: TObject);
begin
   close;
end;

procedure TForm_note.CreateParams(var Para: TCreateParams);
begin
  inherited CreateParams(Para);
   Para.WndParent:=GetDesktopWindow;

end;

procedure TForm_note.EnableChanged(var Msg: TMessage);
begin
   EnableWindow(handle, true);
    inherited;
end;

procedure TForm_note.FormCreate(Sender: TObject);
var
mask: integer;
begin
mask := SendMessage(richedit1.Handle, EM_GETEVENTMASK, 0, 0);
SendMessage(richedit1.Handle, EM_SETEVENTMASK, 0, mask or ENM_LINK);
SendMessage(richedit1.Handle, EM_AUTOURLDETECT, Integer(True), 0);
 note_stringlist:= Tstringlist.Create;
end;

procedure TForm_note.RichEdit1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var ss: string;
begin
   ss:= form_net_set.RichWordOver(richedit1,x,y);
   if (pos('http://',ss)= 1) or (pos('www.',ss)=1) then
    begin
   ShellExecute(Handle,
  'open','IEXPLORE.EXE',pchar(ss),nil,sw_shownormal);
   end;

end;

procedure TForm_note.FormDestroy(Sender: TObject);
begin
   note_stringlist.Free;
end;

procedure TForm_note.Button4Click(Sender: TObject);
begin
   note_stringlist.Clear;
   richedit1.Lines.Clear;
   list_index:= -1;
   button1.Enabled:= false;
   button2.Enabled:= false;
end;

procedure TForm_note.add_and_show(const s: string);
begin
   note_stringlist.Append(s);
   richedit1.Lines.Clear;
   richedit1.Lines.Append(s);
    list_index:= note_stringlist.Count- 1;

    button2.Enabled:= false;
    button1.Enabled:= (list_index > 0);
    caption:= format('消息 %d / %d',[list_index+ 1,note_stringlist.Count]);

    show;
end;

procedure TForm_note.Button1Click(Sender: TObject);
begin
    //上一条
   if list_index > 0 then
    begin
    dec(list_index);
   richedit1.Lines.Clear;
   richedit1.Lines.Append(note_stringlist.Strings[list_index]);

    button2.Enabled:= (list_index < note_stringlist.Count-1);
    button1.Enabled:= (list_index > 0);
    caption:= format('消息 %d / %d',[list_index+ 1,note_stringlist.Count]);
    end;
end;

procedure TForm_note.Button2Click(Sender: TObject);
begin
  //下一条
      if list_index < note_stringlist.Count-1 then
    begin
    inc(list_index);
   richedit1.Lines.Clear;
   richedit1.Lines.Append(note_stringlist.Strings[list_index]);

    button2.Enabled:= (list_index < note_stringlist.Count-1);
    button1.Enabled:= (list_index > 0);
    caption:= format('消息 %d / %d',[list_index+ 1,note_stringlist.Count]);
    end;
end;

end.
