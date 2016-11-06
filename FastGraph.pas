{$MODE OBJFPC}
Unit FastGraph;
//-----------------------------------------------------------------------------------------------------------------
Interface
  CONST VERSION = 'v.0420';
  Type TPoint = record
    x , y : LongInt;
  end;
  
  Procedure Paint();
  Procedure Clear();
  
  //Primitives
  Procedure Rectangle(const x1 , y1 , x2 , y2 : LongInt ) ; 
  Procedure Pixel ( const x , y : LongInt ) ; 
  Procedure Line(const x1 , y1 , x2 , y2 : LongInt ) ; 
  Procedure Polygon(const A : Array of TPoint ; Size : LongInt ) ; 
  Procedure Circle ( const mx, my ,r : LongInt );
  //Text
  Procedure OutText(const x , y , Font : LongInt ; const Text : String ) ;
  //Utils
  Procedure SetColor ( const R , G , B : LongInt ) ;

//-----------------------------------------------------------------------------------------------------------------  
Implementation
  Uses GLUT,GL,GLU,UTILS,MATH;
  
  Procedure OutText(const x , y , Font : LongInt ; const Text : String ) ;
  begin
    glWrite ( x , y , GLUT_BITMAP_9_BY_15 , Text ) ; 
  end;
  
  Procedure Rectangle(const x1 , y1 , x2 , y2 : LongInt ) ; 
  begin
    glBegin(GL_QUADS);
      glVertex2i(x1,y1);
      glVertex2i(x2,y1);
      glVertex2i(x2,y2);
      glVertex2i(x1,y2);
    glEnd;
  end;
  Procedure Pixel ( const x , y : LongInt ) ; 
  begin
    glBegin(GL_POINTS);
      glVertex2i(x,y);
    glEnd;
  end;
  
  Procedure Line(const x1 , y1 , x2 , y2 : LongInt ) ; 
  begin
    glBegin(GL_LINES);
      glVertex2i(x1,y1);
      glVertex2i(x2,y2);
    glEnd;
  end;
  
  Procedure Polygon(const A : Array of TPoint ; Size : LongInt ) ; 
    var i : LongInt;
  begin
    glBegin(GL_POLYGON);
      for i := 0 to Size-1 do
        glVertex2i(A[i].x , A[i].y ) ; 
    glEnd;
  end;
  
  Procedure Circle ( const mx, my ,r : LongInt );
    var x , y : LongInt;
        Poly : Array [ 0 .. 10000 ] of TPoint;
        size , writer : LongInt;
  begin
    size := 2*r+1;
    
    Poly[0].x := mx;
    Poly[0].y := my;
    writer := 0;
    
    for x := -r to r do
    begin
      
      inc ( writer );  
      y := round ( sqrt ( r*r  -x*x ) ) ; 
      Poly[writer].x := mx + x;
      Poly[writer].y := my + y;
      Poly[writer+size].x := mx + x;
      Poly[writer+size].y := my - y;
    end;
   

    
    Polygon ( Poly , 1+size*2 ) ; 
  end;
  
  Procedure Clear();
  begin
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glEnter2D;
  end;
  
  Procedure Paint();
  begin
    glLeave2D;
    glutSwapBuffers;
    FrameRendered;
  end;
  
  Procedure SetColor ( const R , G , B : LongInt ) ;
  begin
    glColor3f(R/255,G/255,B/255);
  end;
  
  

  
  
//-----------------------------------------------------------------------------------------------------------------
Initialization
begin
  writeLn ( 'FastGraph ' , VERSION );
  writeLn ( 'Build: ' , {$I %DATE%}, ' ' ,{$I %TIME%} );
  writeLn ( '(c) Aleksandrs Zajakins' ) ; 
end;

end.