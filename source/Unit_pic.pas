unit Unit_pic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, StdCtrls, ExtCtrls;

type
  TForm_pic = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Label1: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private
    { Private declarations }
     r: trect;
     r2: tpoint;
     r_ok: boolean;
    procedure show_img(bt: Tbitmap);
  public
    { Public declarations }
    game_sex: boolean;
    game_cmd: integer;
  end;

var
  Form_pic: TForm_pic;

implementation
  uses Clipbrd,jpeg,unit_data;
{$R *.dfm}

procedure TForm_pic.Button3Click(Sender: TObject);
var bt: tbitmap;
begin
if ClipBoard.GetAsHandle(cf_Bitmap)<> 0 then
 begin
 bt:= tbitmap.Create;
 bt.LoadFromClipboardFormat(cf_BitMap,ClipBoard.GetAsHandle(cf_Bitmap),0);
 show_img(bt);
 bt.Free;
 end else image1.Canvas.TextOut(15,15,'不支持的图片格式');
end;

procedure TForm_pic.Button2Click(Sender: TObject);
var bt: tbitmap;
    jpg: TJpegImage;
begin
   if OpenPictureDialog1.Execute then
    begin
     bt:= tbitmap.Create;
     if ansicomparetext(ExtractFileExt(OpenPictureDialog1.FileName),'.jpg')=0 then
      begin
        jpg:= TJpegImage.Create;
         jpg.LoadFromFile(OpenPictureDialog1.FileName);
         bt.Assign(jpg);
        jpg.Free;
      end else bt.LoadFromFile(OpenPictureDialog1.FileName);
      show_img(bt);
     bt.Free;
    end;
end;

procedure TForm_pic.FormShow(Sender: TObject);
begin
 form_pic.DoubleBuffered:= true;
   case game_cmd of
   1: button2click(sender);
   2: button3click(sender);
   end;
end;

procedure TForm_pic.show_img(bt: Tbitmap);
begin
 if bt.Width < 48 then
    bt.Width:= 48;
 if bt.Height < 48 then
   bt.Height:= 48;

   image1.Picture.Bitmap.Assign(bt);
   //调整大小
   if (bt.Width > 580) or (bt.Height> 400) then
      form_pic.WindowState:= wsMaximized;

   image1.Top:= (form_pic.Height-80 - bt.Height) div 2;
   image1.Left:=  (form_pic.Width - bt.Width) div 2;
     r.Left:= (bt.Width-48) div 2;
     r.Top:= (bt.Height-48) div 2;
     r.Bottom:= r.Top + 48;
     r.Right:= r.Left+ 48;

     if (bt.Width= 48) and (bt.Height= 48) then
        Button1Click(self)
        else
         image1.Canvas.DrawFocusRect(r);
end;

procedure TForm_pic.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (x > r.Left) and (x < r.Right) and (y > r.Top) and (y < r.Bottom) then
    begin
     image1.Cursor:= crsizeall;
     if r_ok and (ssLeft in shift) then
      begin
       image1.Canvas.DrawFocusRect(r);
       r.Left:= x - r2.X;
       r.Top:=  y- r2.Y;
       r.Right:= r.Left+ 48;
       r.Bottom:= r.Top+ 48;
        image1.Canvas.DrawFocusRect(r);
      end;
    end else
         image1.Cursor:= crdefault;


end;

procedure TForm_pic.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if (x > r.Left) and (x < r.Right) and (y > r.Top) and (y < r.Bottom) then
    begin
     r_ok:= true; //按键在虚线内
     r2.X:= x- r.Left;  //得到差值
     r2.Y:= y- r.Top;
    end else r_ok:= false;
end;

procedure TForm_pic.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    r_ok:= false;
end;

procedure TForm_pic.Button1Click(Sender: TObject);
var bt: tbitmap;
begin
  //保存图片到文件夹
  bt:= Tbitmap.Create;
  bt.Width:= 48;
  bt.Height:= 48;
    image1.Canvas.DrawFocusRect(r); //重画，去除虚线
    bt.Canvas.CopyRect(rect(0,0,48,48),image1.Picture.Bitmap.Canvas,r);
   if game_sex then
     begin
      if game_at_net_g then
      bt.SaveToFile(Game_save_path+ '\0.bmp')
      else
      bt.SaveToFile(ExtractFilePath(application.ExeName)+ 'img\0.bmp');
      data2.ImageList2.Delete(1);
      data2.ImageList2.Insert(1,bt,nil);
     end else begin
                if game_at_net_g then
                    bt.SaveToFile(Game_save_path+ '\-1.bmp')
                   else
                bt.SaveToFile(ExtractFilePath(application.ExeName)+ 'img\-1.bmp');
                data2.ImageList2.Delete(0);
                data2.ImageList2.Insert(0,bt,nil);
              end;
  bt.Free;
  form_pic.Close;
  
   if game_at_net_g then
    begin
      //发送头像更改通知

    end;
end;

procedure TForm_pic.Image1DblClick(Sender: TObject);
begin
      if image1.Cursor= crsizeall then
         button1click(sender);
end;

end.
