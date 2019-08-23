program Edit;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit_password in 'Unit_password.pas' {Form_password},
  Unit_p_edit in 'Unit_p_edit.pas' {Form_P_edit},
  Unit_scene_option in 'Unit_scene_option.pas' {Form_scene_option},
  Unit_gpic in 'Unit_gpic.pas' {Form_gpic},
  Unit_paiban in 'Unit_paiban.pas' {Form_paiban},
  Unit_sijian in 'Unit_sijian.pas' {Form_shijian},
  Unit_debug in 'Unit_debug.pas' {Form_debug},
  Unit_tihuan in 'Unit_tihuan.pas' {Form_tihuan};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '³¡¾°±à¼­Æ÷ 2.1';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm_password, Form_password);
  Application.CreateForm(TForm_P_edit, Form_P_edit);
  Application.CreateForm(TForm_scene_option, Form_scene_option);
  Application.CreateForm(TForm_gpic, Form_gpic);
  Application.CreateForm(TForm_shijian, Form_shijian);
  Application.CreateForm(TForm_debug, Form_debug);
  Application.CreateForm(TForm_tihuan, Form_tihuan);
  Application.Run;
end.
