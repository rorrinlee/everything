program EveryThingTest;

{$APPTYPE CONSOLE}

uses
  Everything,
  SysUtils;

var
  I, iCnt: Integer;
  buf: PChar;
  sVersion: string;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  Everything_SetSearchA(PChar('Test'));
  Everything_QueryA(True);
  sVersion := IntToStr(Everything_GetRevision) + '.' + IntToStr(Everything_GetMajorVersion)  + '.' + IntToStr(Everything_GetMinorVersion);
  Writeln(sVersion);
  iCnt := Everything_GetNumResults;
  for I := 0 to iCnt - 1 do
  begin
    buf := StrAlloc($FF);
    Everything_GetResultFullPathNameA(I, buf, StrBufSize(buf));
    Writeln(StrPas(buf));  
    StrDispose(buf);
  end;
end.
