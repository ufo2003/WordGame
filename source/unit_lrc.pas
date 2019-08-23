unit unit_lrc;

interface 
 uses Classes,SysUtils,Graphics,windows,forms;

type 
 TOneLyric=Record
   time:longint; 
   lyStr:string[200];
 end; 

 TLyric=class 
 private 
   FFilename:string;
   findex: integer; //当前歌词位置
   FOffset:integer; //时间补偿值 其单位是毫秒，正值表示整体提前，负值相反。这是用于总体调整显示快慢的。
   FAur:string; //艺人名 
   FBy:string; //编者（指编辑LRC歌词的人） 
   FAl:string; //专辑名 
   FTi:string; //曲名
   FCount:integer; 

   FLyricArray : array of TOneLyric;
   function GetLyric(i:integer): TOneLyric ;
   function ExistTime(vTime:longint):boolean; 

   procedure sortLyric; 
   procedure ResetLyrics(FTxt:Tstrings); 
 protected 
 public 
   constructor Create; 
   destructor Destroy; override; 
   procedure loadLyric(afilename:string); 
   procedure SetTxt(aLyrics:Tstrings); 
   procedure UnloadLyric(strs:Tstrings); 

   //整体提前(正值)或整体延后(负值)atime毫秒 
   function ChgOffset(atime:integer):boolean; 

   //提前(正值)/延后(负值)某一句歌词 aTime毫秒 
   function ChgOneLyric(oldTime:longint;aTime:integer):boolean; 

   //保存歌词内容到文件 
   function SaveLyricsToFile(vFileName:string):boolean; 
   function get_lrc_string(t: integer): boolean;
   property filename:string read ffilename; 
   property Ar:string read FAur; 
   property By:string read FBy; 
   property Al:string read FAl; 
   property Ti:string read FTi; 
   property Offset :integer read FOffset; 

   property LyricArray[i:integer]: TOneLyric read GetLyric ;

   property Count:integer read FCount; 
 end; 

implementation 


constructor TLyric.Create; 
begin 
 inherited Create; 
 FTi:='';
 FAur:='';
 Fal:='';
 FBy:='';
 FOffset:=0; 
end; 

function TLyric.ExistTime(vTime:longint):boolean; 
var i:integer; 
begin 
 result:=false; 
 for i:=0 to length(FLyricArray) -1 do 
   if  FLyricArray[i].time =vTime then 
   begin 
       result:=true; 
       break; 
   end; 
end; 

procedure TLyric.loadLyric(afilename:string); 
var 
 FTxt:Tstrings; 
begin 
 FTi:='';
 FAur:='';
 Fal:='';
 FBy:='';
 FOffset:=0; 

 FFilename:=afilename; 
 //载入歌词 

 FTxt:=TStringlist.create; 
 FTxt.LoadFromFile(Ffilename); 

 ResetLyrics(FTxt);

 FTxt.Clear; 
 FTxt.free;
 findex:= -1;

end; 

procedure TLyric.SetTxt(aLyrics:Tstrings); 
begin 
 FTi:='';
 FAur:='';
 Fal:='';
 FBy:='';
 FOffset:=0; 

 //载入歌词 
 ResetLyrics(aLyrics); 
end; 

//根据歌词文件  载入每行歌词 
procedure TLyric.ResetLyrics(FTxt:Tstrings); 
var i:integer; 
 function makeOneLyric(CurLyric:string):string; 
 var p1,p2,p3:integer; 
    timestr,lyricstr:string; 
    time1,time2:longint; 

    isFuSign:boolean; 
 begin 
   p1:=pos('[',CurLyric);//第一个‘[’位置 
   if p1=0 then begin   //判断是否非法行 
     result:= CurLyric;          //无 '[' 
     exit; 
   end; 
   p2:=pos(']',CurLyric); //第一个‘]’位置 
   if p2=0 then begin 
     result:= CurLyric; 
     exit;          //无 ']' 
   end; 

   timestr:=copy(curLyric,p1+1,p2-p1-1); 
   //左右两边为歌词 
   lyricStr:= copy(curLyric,1,p1-1) + copy(curLyric,p2+1,length(curLyric)-p2) ; 

   lyricStr:=makeOneLyric(lyricStr); 

   if copy(Lowercase(timeStr),1,2)='ar' then  //作者信息 
      FAur:= copy(timestr,4,length(timestr)-3) 
   else if copy(Lowercase(timeStr),1,2)='ti' then  //曲目标题 
      FTi:= copy(timestr,4,length(timestr)-3) 
   else if copy(Lowercase(timeStr),1,2)='al' then  //专辑名 
      FAl:= copy(timestr,4,length(timestr)-3) 
   else if copy(Lowercase(timeStr),1,2)='by' then  //编辑LRC歌词的人 
      FBy:= copy(timestr,4,length(timestr)-3) 
   else if copy(Lowercase(timeStr),1,6)='offset' then  //时间补偿值 
     try 
       FOffset:= strtoint(copy(timestr,8,length(timestr)-7)) 
     except 
       FOffset:=0; 
     end 
   else   //此时为 时间标记 
   begin 
      p3:= pos(':',timestr) ; 
      if p3>0 then begin //判断是否非法行 
         isFuSign:=false; 
        try 
         time1:=strtoint(copy(timestr,1,p3-1))*1000; 
         if time1<0 then 
         isFuSign:=true;  //记录 该 时间标签 为 负（小于零） 
        except 
         //非法歌词行 
         exit;          //分钟有误 
        end; 

        try 
         time2:= trunc( strtofloat(copy(timestr,p3+1,length(timestr)-p3)) *1000); 
         if isFuSign then 
         time2:=-time2; 
        except 
         exit;          //秒 有误 
        end; 

        if not ExistTime(time1*60+time2) then 
        begin 
         setLength(FLyricArray,length(FLyricArray)+1); 
         //if trim(lyricStr)=' then 
         //  lyricStr:= '(Music)'; 
         with FLyricArray[length(FLyricArray)-1] do 
         begin 
         time :=time1*60+time2; 
         lystr:=lyricStr; 
         end; 
         result:=lyricStr; 
        end; 
      end; 
   end; 

 end; 
begin 
 SetLength(FLyricArray,0);

 //解析歌词各部分 
 for i:= 0 to FTxt.count-1 do 
 begin 
     makeOneLyric(FTxt[i]) ; 
 end; 

 FCount:=length(FLyricArray) ; 
 sortLyric;

 {if FTi<>' then FTi:= replaceWithchr(FTi,'&','&&'); 
 if FAur<>' then FAur:= replaceWithchr(FAur,'&','&&'); 
 if FAl<>' then FAl:= replaceWithchr(FAl,'&','&&'); 
 if FBy<>' then FBy:= replaceWithchr(FBy,'&','&&'); 
 } 
 //根据 整体时间偏移，重新计算每句歌词时间 
   for i:=0 to length(FLyricArray)-1 do 
   begin 
      //FLyricArray[i].lyStr := replaceWithchr(FLyricArray[i].lyStr,'&','&&'); 

      if FLyricArray[i].time >= 0 then 
        begin 
         if FLyricArray[i].time - FOffset>=0 then 
         FLyricArray[i].time:=FLyricArray[i].time - FOffset ; 

        end 
      else 
        FLyricArray[i].time:=0; 
   end; 
end; 

procedure TLyric.UnloadLyric(strs:Tstrings); 
var i:integer; 
begin 
  SetLength(FLyricArray,strs.Count ); 
  FCount:= strs.Count; 
  for i:=0 to strs.Count -1 do 
  begin 
     FLyricArray[i].time :=0; 
     FLyricArray[i].lyStr := strs[i]; 
  end; 

  FTi:='';
  FAur:='';
  Fal:='';
  FBy:='';
  FOffset:=0; 

end; 

destructor TLyric.Destroy; 
begin 
 SetLength(FLyricArray,0); 

 inherited Destroy; 
end; 

function TLyric.GetLyric(i:integer): TOneLyric ; 
begin 
 if (i>=0) and (i<length(FLyricArray)) then
   result:=FLyricArray[i] ;
end; 

procedure TLyric.sortLyric; 
var i,j:integer; 
 tmpLyric:TOneLyric; 
begin 
  for i:=0 to length(FLyricArray)-2 do
  begin 
    for j:=i to length(FLyricArray)-1 do 
    begin 
       if FLyricArray[j].time < FLyricArray[i].time then 
       begin 
         tmpLyric:= FLyricArray[i]; 
         FLyricArray[i]:= FLyricArray[j]; 
         FLyricArray[j]:= tmpLyric; 
       end; 
    end; 
  end; 
end; 

function TLyric.ChgOffset(atime:integer):boolean;//提前(正值)或延后(负值)atime毫秒 
var i,numberLine:integer; 
 p1,p2,p3:integer; 
    timestr,lyricstr,CurLyric,signStr:string; 
    aOffset:longint; 
    afind:boolean; 
 FTxt:Tstrings; 
begin 
  Result:=false; 

 //修改offset 保存文件 
   afind:=false; 
   aOffset:=0; 
   numberLine:=-1; 

   FTxt:=TStringlist.create; 
try 
   FTxt.LoadFromFile(FFilename); 

    for i:=0 to FTxt.Count-1 do 
    begin 
       curLyric:=fTxt[i]; 

         p1:=pos('[',CurLyric);//第一个‘[’位置 
         if p1=0 then begin   //判断是否非法行 
         continue;          //无 '[' 
         end; 
         p2:=pos(']',CurLyric); //第一个‘]’位置 
         if p2=0 then begin 
         continue;          //无 ']' 
         end; 

         timestr:=copy(curLyric,p1+1,p2-p1-1); 
         //左右两边为歌词 
         lyricStr:= copy(curLyric,1,p1-1) + copy(curLyric,p2+1,length(curLyric)-p2) ; 

         if copy(Lowercase(timeStr),1,6)='offset' then  //找到 时间补偿串 
         begin 
         try 
         aOffset:= strtoint(copy(timestr,8,length(timestr)-7)); 
         except 
         continue; 
         end ; 
         fTxt[i]:=copy(curLyric,1,p1-1) 
         +'[offset:'+inttostr(aOffset+aTime) +']' 
         +copy(curLyric,p2+1,length(curLyric)-p2); 

         if  aOffset+aTime=0 then 
         FTxt.Delete(i); 

         fTxt.SaveToFile(FFilename); 
         afind:=true; 
         break; 
         end
         else
         begin
         if numberLine=-1 then 
         begin
         signStr:=copy(Lowercase(timeStr),1,2) ; 
         if (signStr<>'ar') and (signStr<>'al') and (signStr<>'ti') and (signStr<>'by') then begin 
         p3:= pos(':',timestr) ; 
         if p3>0 then         //为时间标记 
         numberLine:=i;        //记录行号
         end; 
         end; 
         end; 
    end; 

  if (not afind) and (numberLine<>-1) then
  begin 
    //fTxt.Add('[offset:'+inttostr(aOffset+aTime) +']'); 
    fTxt.Insert(numberline, '[offset:'+inttostr(aOffset+aTime) +']'); 
    fTxt.SaveToFile(FFilename); 
  end;

  //重新载入歌词
  loadLyric(FFilename); 

  result:=true;     

  FTxt.Clear; 
finally 
  FTxt.free;
end; 
end; 

function TLyric.ChgOneLyric(oldTime:longint;aTime:integer):boolean; 
var i:integer; 
   FTxt:Tstrings; 
   AjustOk:boolean;
   thisLyric:string; 

  function AjustOneLine(var curLyric:string):boolean; 
  var 
    isFu:boolean;//该时间是否为负. 

    p1,p2,p3:integer;
    timestr,left_lyric,right_lyric:string;    // 
    time1,time2:longint; 
    findok:boolean; 
    isValid:boolean;// 
    
    NewTimeLabel:string; 
    NewTime:longint;

    UseMS:boolean; 
  begin 
       //---------该串内 是否有标签 ---------- 
       p1:=pos('[',CurLyric);//第一个‘[’位置 
       if p1=0 then begin   //判断是否非法行 
         Result:=false;          //无 '['
         exit; 
       end; 
       p2:=pos(']',CurLyric); //第一个‘]’位置 
       if p2=0 then begin 
         result:= false; 
         exit;          //无 ']' 
       end;
       //==========串内 是否有标签========== 

       //----------目前标签 是否是 指定时间的 标签---------- 
       timestr:=copy(curLyric,p1+1,p2-p1-1); 

       Left_lyric:= copy(curLyric,1,p1-1); 
       Right_lyric:= copy(curLyric,p2+1,length(curLyric)-p2)  ;

       isValid:=true; 
       findok:=false; 
       p3:= pos(':',timestr) ; 
       if p3>0 then begin //判断是否 合法时间标签 
         isFu:=false; 
         try
         time1:=strtoint(copy(timestr,1,p3-1))*1000; 
         if time1<0 then 
         isFu:=true; 
         except 
         //非法歌词行 
         isValid:=false;          //分钟有误 
         end;

         try 
         if isValid then 
         begin 
         time2:= trunc( strtofloat(copy(timestr,p3+1,length(timestr)-p3)) *1000); 
         if isFu then 
         time2:=-time2;
         end; 
         except 
         isValid:=false;          //秒 有误 
         end; 

         if isValid and (time1*60+time2 - FOffset = oldtime) then //找到 指定时间串 
         findOk:=true;  //找到 啦 啦 啦 ...


       end; //非法行 判断结束 
       //==========是否找到 指定时间标签========== 

       //-------找到 和 没找到 之后的处理 ---------- 
       if findok then begin
         Result:= true; 

         //根据 老时间标签（timerstr） 
         //生成 新的时间标签
         NewTime:=time1*60+time2 - aTime;

         //根据 原来是否使用毫秒 和 目前调整的偏移时间是否属于毫秒级别
         //          来决定 是否 使用毫秒 
         UseMS:= (Pos('.',timestr)>0) or (aTime mod 1000 <>0); 

         //转化时间为时间串例如： 72秒 ==>> '00:01:12.000'

         //图方便，临时用了个系统函数
         //NewTimeLabel:=ConvertTimeToTimestr(NewTime,0,false,true,UseMS,true);
          NewTimeLabel:= timetostr(FileDateToDateTime(NewTime));

         //返回 新的歌词部分
         curLyric := left_Lyric + '[' + NewTimeLabel + ']'+ Right_Lyric;


         end 
        else //还 没找到 
         begin  //在 该行歌词剩余部分 找找看 

         if AjustOneLine(Right_lyric) then
         begin 
         //在剩余部分内找到了 
         curLyric:= Left_lyric+ '[' + timestr +']' +Right_lyric ; 

         Result:=true; 
         end 
         //else  剩余部分内 没有的话 ，只好返回 false 啦
         //   (函数开始处，已经默认=false) 

         end; 
        //=========找到 和 没找到 之后的处理==========   

  end; //end function AjustOneLine 

begin 
   AjustOk:=false; 
   Result:=false; 

   FTxt:=TStringlist.create; 
try 
   FTxt.LoadFromFile(FFilename);

    for i:=0 to FTxt.Count-1 do 
    begin 
       thisLyric:=FTxt[i]; 

       if AjustOneLine(thisLyric) then
       begin 
         AjustOk:=true; 
         //更新 新生成 的歌词行 
         FTxt[i]:=thisLyric; 

         break;
       end; 
    end; 

  if AjustOk then 
  begin 
    //保存歌词文件
    FTxt.SaveToFile(FFilename); 

    //重新载入歌词 
    loadLyric(FFilename); 

    Result:=true;
  end; 
  
  FTxt.Clear; 
finally 
  FTxt.free; 
end;

end; 

//保存歌词内容到文件 
function TLyric.SaveLyricsToFile(vFileName:string):boolean; 
var i:integer;
  aTxt:Tstrings ; 
begin 
  result:=false; 
  if FCount<=0 then exit; 

  aTxt:=Tstringlist.Create;
  try
     if FTi <>'' then
       aTxt.Add('歌名:'+FTi);
     if FAur <>'' then
       aTxt.Add('歌手:'+FAur);
     if Fal <>'' then
       aTxt.Add('专辑:'+Fal);
    // if Fby <>' then
    //   lbxpreview.Items.Add('歌词编辑:'+Fby);
      if aTxt.Count >0 then
         aTxt.Add('--- --- --- --- --- --- ---');

    for i:=0 to FCount-1 do
       aTxt.Add(LyricArray[i].lyStr ) ;

    aTxt.SaveToFile(vFilename);

    Result:=true;
  finally
    aTxt.Free;
  end;
end;

procedure draw_to_dc(const s: string);
var  dskcanvas:TCanvas;
begin
  dskcanvas:=TCanvas.create;
  dskcanvas.handle:=getdc(0);
  dskcanvas.Font.Name:= '宋体';
 // dskcanvas.Font.Color:= clgreen;
  dskcanvas.Font.Size:= 40;
 // dskcanvas.Pen.Mode:= pmXor;
  //dskcanvas.Brush.Style:= bsClear;
   dskcanvas.FillRect(rect(40,screen.WorkAreaHeight- 58,screen.Width-40,screen.WorkAreaHeight- 3));
  dskcanvas.textout(40,screen.WorkAreaHeight- 58,s);

  ReleaseDC(0,dskcanvas.handle);
  dskcanvas.Free;
end;

function TLyric.get_lrc_string(t: integer): boolean;
var i: integer;
    label pp;
begin
result:= false;
 for i:= 0 to  high(FLyricArray) do
  begin
   if i= high(FLyricArray) then
     goto pp;
    if (FLyricArray[i].time < t) and (FLyricArray[i+1].time > t) then
      begin
       pp:
       if findex <>i then
       begin
        //画出

       draw_to_dc(FLyricArray[i].lyStr);

       findex:= i;
       end;
       result:= true;
       exit;
      end;
  end;

end;

end.