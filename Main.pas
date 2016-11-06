{$MODE OBJFPC}
Program Main;
  Uses FastGraph,GL,GLUT,GLU,UTILS,CODE,sysutils;
  
procedure glutInitPascal(ParseCmdLine: Boolean); 
var
  Cmd: array of PChar;
  CmdCount, I: Integer;
begin
  if ParseCmdLine then
    CmdCount := ParamCount + 1
  else
    CmdCount := 1;
  SetLength(Cmd, CmdCount);
  for I := 0 to CmdCount - 1 do
    Cmd[I] := PChar(ParamStr(I));
  glutInit(@CmdCount, @Cmd);
end;


procedure DrawGLScene; cdecl;
begin
  CODE.DRAW();
end;

procedure ReSizeGLScene(Width, Height: Integer); cdecl;
begin
  if Height = 0 then
    Height := 1;

  glViewport(0, 0, Width, Height);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(45, Width / Height, 0.1, 1000);

  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  gluLookAt(0, 20, 25, 0, 0, 0, 0, 1, 0);
end;

procedure GLKeyboard(Key: Byte; X, Y: Longint); cdecl;
begin
  CODE.Key_Pressed ( Key ) ; 
  if Key = 27 then
    Halt(0);
end;

procedure GLMouse(Button , State , X, Y : LongInt ) ; cdecl;
begin
  CODE.Mouse_Pressed ( Button , State , X , Y ) ; 
  //writeLn ( Button , ' [ ' , State , ' ] ' , ' @ ' , x , ':' , y ) ; 
end;
  
  
const 
  AppWidth = 800; 
  AppHeight = 800; 


var 
  ScreenWidth, ScreenHeight: Integer; 
begin 
  CODE.INIT();
  glutInitPascal(True); 
  glutInitDisplayMode(GLUT_DOUBLE or GLUT_RGB or GLUT_DEPTH); 
  glutInitWindowSize(AppWidth, AppHeight); 
  ScreenWidth := glutGet(GLUT_SCREEN_WIDTH); 
  ScreenHeight := glutGet(GLUT_SCREEN_HEIGHT); 
  glutInitWindowPosition((ScreenWidth - AppWidth) div 2,
    (ScreenHeight - AppHeight) div 2); 
  glutCreateWindow('FastGraph'); 


  glutDisplayFunc(@DrawGLScene); 
  glutReshapeFunc(@ReSizeGLScene); 
  glutKeyboardFunc(@GLKeyboard); 
  glutMouseFunc(@GLMouse);
  //glutIDLEFunc(@DrawGLScene);

  glutMainLoop; 
end.