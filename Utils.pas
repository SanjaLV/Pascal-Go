unit utils;
 
{$mode objfpc}{$H+}
 
interface
 
uses
  glut,glu,gl;
 
function GetTotalTime: Single;
function GetDeltaTime: Single;
procedure FrameRendered(Count: Integer = 1);
function GetFPS: Single;
function glGetViewportWidth: Integer;
function glGetViewportHeight: Integer;
procedure glWrite(X, Y: GLfloat; Font: Pointer; Text: String);
procedure glEnter2D;
procedure glLeave2D;
 
implementation
 
var
  OldTime: Integer = 0;
  FPSTime: Integer = 0;
  FPSCount: Integer = 0;
 
function GetTotalTime: Single;
begin
  Result := glutGet(GLUT_ELAPSED_TIME) / 1000;
end;
 
function GetDeltaTime: Single;
var
  NewTime: Integer;
begin
  NewTime := glutGet(GLUT_ELAPSED_TIME);
  Result := (NewTime - OldTime) / 1000;
  OldTime := NewTime;
end;
 
procedure FrameRendered(Count: Integer);
begin
  Inc(FPSCount, Count);
end;
 
function GetFPS: Single;
var
  NewTime: Integer;
begin
  NewTime := glutGet(GLUT_ELAPSED_TIME);
 
  Result := FPSCount / ((NewTime - FPSTime) / 1000);
 
  FPSTime := NewTime;
  FPSCount := 0;
end;
 
function glGetViewportHeight: Integer;
var
  Rect: array[0..3] of Integer;
begin
  glGetIntegerv(GL_VIEWPORT, @Rect);
  Result := Rect[3] - Rect[1];
end;


function glGetViewportWidth: Integer;
var
  Rect: array[0..3] of Integer;
begin
  glGetIntegerv(GL_VIEWPORT, @Rect);
  Result := Rect[2] - Rect[0];
end;


procedure glWrite(X, Y: GLfloat; Font: Pointer; Text: String);
var
  I: Integer;
begin
  glRasterPos2f(X, Y);
  for I := 1 to Length(Text) do
    glutBitmapCharacter(Font, Integer(Text[I]));
end;

procedure glEnter2D;
begin
  glMatrixMode(GL_PROJECTION);
  glPushMatrix;
  glLoadIdentity;
  gluOrtho2D(0, glGetViewportWidth, 0, glGetViewportHeight);
 
  glMatrixMode(GL_MODELVIEW);
  glPushMatrix;
  glLoadIdentity;
 
  glDisable(GL_DEPTH_TEST);
end;
 
procedure glLeave2D;
begin
  glMatrixMode(GL_PROJECTION);
  glPopMatrix;
  glMatrixMode(GL_MODELVIEW);
  glPopMatrix;
 
  glEnable(GL_DEPTH_TEST);
end;
 
end.