
Unit CODE;

Interface
  Procedure Draw(); // Draw smthing @60
  Procedure Init(); // Before all code 
  Procedure Mouse_Pressed(Button , State , mX , mY : LongInt ) ;  // subj
  Procedure Key_Pressed(Key : LongInt ) ; // subj
 

Implementation
  Uses FastGraph , MATH , SysUtils ;
  Const ClientWidth = 800;
        ClientHeight = 800;
    
		
	const BLACK = 69;
	      WHITE = 1337;
				
	
	function NextTurn ( t : LongInt ) : LongInt;
	begin
	  if ( t = WHITE ) then
		  exit ( BLACK )
		else
		  exit ( WHITE ) ; 
	end;
				
	
	var Board : array [ 1 .. 100 , 1 .. 100 ] of LongInt;
      Size : LongInt;
			
			Turn : LongInt;
			
			x , y : LongInt;
			
	
	
	function Liberties ( a , b : LongInt ) : LongInt;
	  var res : LongInt;
		    Visited : array [ 1 .. 100 , 1 .. 100 ] of Boolean;

    
		procedure DFS ( i , j : LongInt ) ; 
		begin
		  if ( Visited[i][j] ) then
			  exit();
		
			Visited[i][j] := true;
			
		  if ( Board[i][j] = 0 ) then
			begin
			  inc ( res ) ;
				exit();
			end;
			
			if ( Board[i][j] <> Board[a][b] ) then
			  exit();
			
			
			// Left
			if ( i > 1 ) then
			  DFS ( i-1 , j ) ; 
			// Right
			if ( i < Size ) then
			  DFS ( i+1 , j ) ; 
			// Up
			if ( j < Size ) then
			  DFS ( i , j+1 ) ; 
			// Down
			if ( j > 1 ) then
			  DFS ( i , j-1 ) ; 
			
		end;
				
	begin
	  
		res := 0 ; 
		
		FillChar ( Visited , SizeOf(Visited) , false ) ; 
		
		DFS ( a , b ) ; 
		
		Liberties := res;
		
	end;
	
	procedure KillaKill () ;
    var toKill : array [ 1 .. 100 , 1 .. 100 ] of Boolean;
        i , j : LongInt;		
	begin
	  FillChar ( toKill , SizeOf(toKill) , false ) ;
		
		for i := 1 to Size do
		begin
		  for j := 1 to Size do
			begin
			  if ( Board[i][j] = NextTurn ( Turn ) ) then
				begin
				  if ( Liberties( i , j ) = 0 ) then
					  toKill[i][j] := true;
				end;
			end;
		end;
		
		
		for i := 1 to Size do
		begin
		  for j := 1 to Size do
			begin
			  
				if ( toKill[i][j] ) then
				  Board[i][j] := 0 ; 
				
			end;
		end;
	end;
	
	
	Procedure DrawField ( ) ; 
	  var i , j  : LongInt;
	begin
	  
		
		SetColor ( 255 , 255 , 255 ) ;
		
		if ( Turn = BLACK ) then
		  OutText ( Size*50 + 30 ,700  , 0 , 'Turn : BLACK' )
		else
      OutText ( Size*50 + 30 ,700  , 0 , 'Turn : WHITE' ) ; 		
		
		 
		
		for i := 0 to Size-1 do
		begin
		  Line ( 50 , 50 + 50*i , Size*50 , 50 + 50*i ) ;
      Line ( 50 + 50*i , 50 , 50+50*i , 50*Size ) ;			
		end;
		
		for i := 1 to Size do
		begin
		  for j := 1 to Size do
			begin
			  if ( Board[i][j] <> 0 ) then
				begin
				  
					if ( Board[i][j] = WHITE ) then
					  SetColor ( 255 , 255 , 255 ) 
					else
					  SetColor ( 128 , 128 , 128 ) ; 
					
			    Circle ( 50*i , 50*j , 20 ) ;

          SetColor (  0 , 250 , 0 ) ;
          OutText ( 50*i - 25 , 50*j-25 , 0 , IntToStr ( Liberties(i,j) ) ) ; 					
					
					
				end;
				
				if ( x = i ) and ( y = j ) then
				begin
				  SetColor ( 230 , 7 , 7 ) ; 
					Circle ( 50*i , 50*j , 10 ) ; 
				end;
				
			end;
		end;
		
	end;
    
  Procedure Draw();
  begin
    
    Clear();
		
		DrawField();
    
    Paint();
		
  end;
  
  Procedure Init();
	  var i , j : LongInt;
  begin 
	 
	  
		writeLn ( 'Pick de boards size ' ) ; 
		readLn ( Size ) ;
		
		x := Size div 2 + 1 ;
		y := Size div 2 + 1 ;
		
		Turn := WHITE;
		
		for i := 1 to Size do
		  for j := 1 to Size do
			  Board[i][j] := 0 ;
		
  end;
  
  Procedure Mouse_Pressed(Button , State , mX , mY : LongInt ) ;  // subj
  begin
  end;
    
  Procedure Key_Pressed(Key : LongInt ) ; // subj
  begin
		
		
		if ( Key = Ord ( 'a' ) ) and ( x > 1 ) then
      dec ( x ) ;
    if ( Key = Ord ( 'd' ) ) and ( x < Size ) then
      inc ( x ) ; 
    if ( Key = Ord ( 'w' ) ) and ( y < Size ) then
      inc ( y ) ;
    if ( Key = Ord ( 's' ) ) and ( y > 1 ) then
      dec ( y ) ; 
		
		
		if ( Key = 32 ) then
      Board[x][y] := 0 ;		
		
    if ( Key = 13 ) and ( Board[x][y] = 0 ) then
    begin
		  
			Board[x][y] := Turn;
			
		  KillaKill (	) ; 
			
			Turn := NextTurn ( Turn ) ; 
			
    end;
		
		
		Draw();

  end;
  

Initialization
end.