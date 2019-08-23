unit Unit_show;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_show = class(TForm)
    Label1: TLabel;
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure show_info(const s: string);
  end;

var
  Form_show: TForm_show;

implementation
    uses AAFont;
{$R *.dfm}

procedure TForm_show.FormPaint(Sender: TObject);
var
   aafont: TAAFontEx;
begin
  AAFont := TAAFontEx.Create(self.Canvas);
      aafont.Effect.Outline:= true;
      aafont.Effect.Shadow.Enabled:= true;
      aafont.Effect.Shadow.Color:= clgray;
       aafont.Effect.Gradual.Enabled:= true;
      aafont.Effect.Gradual.StartColor:=clred;
      aafont.Effect.Gradual.EndColor:= clwindow;

        with self.Canvas do
        begin
          Font.Name := '宋体'; // 设置字体
          Font.Size := 32;
          Font.Style:= [fsbold];
          Brush.Style := bsClear; // 设置透明绘制
        end;

          AAFont.TextOut(42, 38, '玩游戏背单词');

           aafont.Effect.Gradual.Style:=gsRightToLeft;
           AAFont.TextOut(80, 150, '正在启动……');
        AAFont.Free;

end;

procedure TForm_show.show_info(const s: string);
begin
     label1.Caption:= s;
     label1.Update;
end;

end.
