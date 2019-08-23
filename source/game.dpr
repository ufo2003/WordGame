program game;

uses
  Forms,windows,
  Unit1 in 'Unit1.pas' {Form1},
  Unit_player in 'Unit_player.pas',
  Unit_data in 'Unit_data.pas' {Data2: TDataModule},
  unit_save in 'unit_save.pas' {Form_save},
  Unit_goods in 'Unit_goods.pas' {Form_goods},
  Unit_ZJ_LY in 'Unit_ZJ_LY.pas' {Form_ZJ_LY},
  Unit_trade in 'Unit_trade.pas' {Form_trade},
  Unit_pop in 'Unit_pop.pas' {Form_pop},
  Unit_task in 'Unit_task.pas' {Form_task},
  Unit_set in 'Unit_set.pas' {Form_set},
  Unit_show in 'Unit_show.pas' {Form_show},
  Unit2 in 'Unit2.pas',
  Unit_pic in 'Unit_pic.pas' {Form_pic},
  Unit_net in 'Unit_net.pas' {Data_net: TDataModule},
  Unit_chat in 'Unit_chat.pas' {Form_chat},
  Unit_net_set in 'Unit_net_set.pas' {Form_net_set},
  Unit_download in 'Unit_download.pas',
  Unit_glb in '..\..\背单词游戏服务器端\Unit_glb.pas',
  Unit_note in 'Unit_note.pas' {Form_note},
  Unit_dwjh in 'Unit_dwjh.pas' {Form_dwjh},
  Unit_music in 'Unit_music.pas',
  Unit_downhttp in 'Unit_downhttp.pas',
  Unit_down_tips in 'Unit_down_tips.pas',
  Unit_wuziqi in 'Unit_wuziqi.pas',
  Unit_chinese in 'Unit_chinese.pas' {Form_chinese},
  Unit_exit in 'Unit_exit.pas' {Form_exit},
  Unit_mp3_yodao in 'Unit_mp3_yodao.pas',
  Unit_langdu in 'Unit_langdu.pas' {Form_langdu};

//  Unit3 in 'Unit3.pas';

//Unit_msg in 'Unit_msg.pas' {Form_msg};

//KSVOICELib_TLB in 'D:\Program Files\Borland\Delphi6\Imports\KSVOICELib_TLB.pas';

// VTxtAuto_TLB in 'D:\Program Files\Borland\Delphi6\Imports\VTxtAuto_TLB.pas';




{$R *.res}

begin
  Application.Initialize;
  SetThreadLocale(LOCALE_SYSTEM_DEFAULT);
   Form_show:= TForm_show.Create(application);
  Form_show.Show;
  Form_show.Update;
  Application.Title := '游戏背单词 2017';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm_note, Form_note);
  Application.CreateForm(TForm_exit, Form_exit);
  Application.CreateForm(TForm_chinese, Form_chinese);
  Application.CreateForm(TForm_langdu, Form_langdu);
  //Application.CreateForm(TForm_msg, Form_msg);
  Form_pop:= Tform_pop.Create(application);
  Application.CreateForm(TData2, Data2);
  Application.CreateForm(TForm_save, Form_save);
  Application.CreateForm(TForm_set, Form_set);
  Application.CreateForm(TForm_goods, Form_goods);
  Application.CreateForm(TForm_pic, Form_pic);
  Application.CreateForm(TData_net, Data_net);
  //Application.CreateForm(TForm_chat, Form_chat);
   Application.CreateForm(TForm_net_set, Form_net_set);
  Form_show.Close;
  Application.Run;
end.
