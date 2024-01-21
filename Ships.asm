;all of the images are turned around 90 degrees and flipped
proc Spaceship
	pusha
	mov dh, UserSpaceship_height	;load in dh user ship width
	mov dl, UserSpaceship_width		;load in dh user ship hight
	mov ax, 165	;the user ship starts always at the line of 165 pixels
	mov bx,[SpaceshipPosition]	;load in bx spaceship column position 
	lea si, [UserSpaceship]  ;si points at UserSpaceship data
DrawUserSpaceship:
	mov cl, [byte ptr si]	;cl get the next pixel to draw
	call Pixel	;draws the pixel on the screen
	inc si	;increase to read the next data index
	inc ax	;increase to next line
	dec dl	;decrease height
	jnz DrawUserSpaceship   ;check if finished to run on all the column             
	mov dl, UserSpaceship_width	;restore user ship height
	sub ax, UserSpaceship_width	;moves to the next line
	inc bx	;go to next column
	dec dh	;decrease width
	jnz DrawUserSpaceship   ;check if finished to run on all the lines         
	popa
	ret
endp Spaceship

proc EnemyShip
;draws enemy spaceship
	pusha
	mov dh, EnemySpaceship_height
	mov dl, EnemySpaceship_width
	lea si, [EnemySpaceship]  
DrawEnemySpaceship:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawEnemySpaceship                  
	mov dl, EnemySpaceship_width
	sub ax, EnemySpaceship_width
	inc bx
	dec dh
	jnz DrawEnemySpaceship                 
	popa
	ret
endp EnemyShip

proc LazerShot
;draws user shots
	pusha
	mov dh, Shots_height
	mov dl, Shots_width
	lea si, [LaserBullet] 
	DrawUserShots:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawUserShots                  
	mov dl, Shots_width
	sub ax, Shots_width
	inc bx
	dec dh
	jnz DrawUserShots  
	popa
	ret
endp LazerShot

proc LazerNullShot
;draws null user shots
	pusha
	mov dh, Shots_height
	mov dl, Shots_width
	lea si, [LaserNullBullet] 
	DrawUserNullShots:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawUserNullShots                  
	mov dl, Shots_width
	sub ax, Shots_width
	inc bx
	dec dh
	jnz DrawUserNullShots  
	popa
	ret
endp LazerNullShot

proc NullEnemySpaceship
;draws null enemy spaceship
	pusha
	mov dh, EnemySpaceship_height
	mov dl, EnemySpaceship_width
	lea si, [EnemyNullSpaceship]  
DrawEnemyNullSpaceship:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawEnemyNullSpaceship                  
	mov dl, EnemySpaceship_width
	sub ax, EnemySpaceship_width
	inc bx
	dec dh
	jnz DrawEnemyNullSpaceship                
	popa
	ret
endp NullEnemySpaceship

proc EnemyExplosionShip
;draws regular enemy explosion
	pusha
	mov dh, EnemySpaceship_height
	mov dl, EnemySpaceship_width
	lea si, [EnemyExplosion]  
DrawsEnemyExplosion:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawsEnemyExplosion                 
	mov dl, EnemySpaceship_width
	sub ax, EnemySpaceship_width
	inc bx
	dec dh
	jnz DrawsEnemyExplosion                
	popa
	ret
endp EnemyExplosionShip

proc Round1
;draws Intro to round 1
	pusha
	mov dh, RoundIntro_height
	mov dl, RoundIntro_width
	lea si, [Round1Start]  
DrawRound1Intro:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawRound1Intro              
	mov dl, RoundIntro_width
	sub ax, RoundIntro_width
	inc bx
	dec dh
	jnz DrawRound1Intro               
	popa
	ret
endp Round1

proc Round2
;draws Intro to round 2
	pusha
	mov dh, RoundIntro_height
	mov dl, RoundIntro_width
	lea si, [Round2Start]  
DrawRound2Intro:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawRound2Intro              
	mov dl, RoundIntro_width
	sub ax, RoundIntro_width
	inc bx
	dec dh
	jnz DrawRound2Intro               
	popa
	ret
endp Round2

proc Round3
;draws Intro to round 3
	pusha
	mov dh, RoundIntro_height
	mov dl, RoundIntro_width
	lea si, [Round3Start]  
DrawRound3Intro:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawRound3Intro              
	mov dl, RoundIntro_width
	sub ax, RoundIntro_width
	inc bx
	dec dh
	jnz DrawRound3Intro               
	popa
	ret
endp Round3

proc Round4
;draws Intro to round 4
	pusha
	mov dh, RoundIntro_height
	mov dl, RoundIntro_width
	lea si, [Round4Start]  
DrawRound4Intro:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawRound4Intro              
	mov dl, RoundIntro_width
	sub ax, RoundIntro_width
	inc bx
	dec dh
	jnz DrawRound4Intro               
	popa
	ret
endp Round4

proc Round5
;draws Intro to round 5
	pusha
	mov dh, RoundIntro_height
	mov dl, RoundIntro_width
	lea si, [Round5Start]  
DrawRound5Intro:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawRound5Intro              
	mov dl, RoundIntro_width
	sub ax, RoundIntro_width
	inc bx
	dec dh
	jnz DrawRound5Intro               
	popa
	ret
endp Round5

proc Juggernut
;draws enemy ship class jugger
	pusha
	mov dh, Jugger_height
	mov dl, Jugger_width
	lea si, [Jugger]  
DrawJuggernut:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawJuggernut              
	mov dl, Jugger_width
	sub ax, Jugger_width
	inc bx
	dec dh
	jnz DrawJuggernut               
	popa
	ret
endp Juggernut

proc NullJugger
;draws enemy ship null class jugger
	pusha
	mov dh, Jugger_height
	mov dl, Jugger_width
	lea si, [JuggerNull]  
DrawNullJuggernut:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawNullJuggernut              
	mov dl, Jugger_width
	sub ax, Jugger_width
	inc bx
	dec dh
	jnz DrawNullJuggernut             
	popa
	ret
endp NullJugger

proc ExplodeJugger
;draws jugger explosion
	pusha
	mov dh, Jugger_height
	mov dl, Jugger_width
	lea si, [JuggerExplosion]  
DrawExplodeJuggernut:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawExplodeJuggernut              
	mov dl, Jugger_width
	sub ax, Jugger_width
	inc bx
	dec dh
	jnz DrawExplodeJuggernut             
	popa
	ret
endp ExplodeJugger

proc OutPost
;draws outpost
	pusha
	mov dh, OutPost_height
	mov dl, OutPost_width
	lea si, [AlienOutPost]  
DrawOutPost:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawOutPost              
	mov dl, OutPost_width
	sub ax, OutPost_width
	inc bx
	dec dh
	jnz DrawOutPost             
	popa
	ret
endp OutPost

proc ExplodeOutPost
;draws outpost explosion 
	pusha
	mov dh, OutPost_height
	mov dl, OutPost_width
	lea si, [OutPostExplosion]  
DrawOutPostExplosion:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawOutPostExplosion              
	mov dl, OutPost_width
	sub ax, OutPost_width
	inc bx
	dec dh
	jnz DrawOutPostExplosion             
	popa
	ret
endp ExplodeOutPost

proc OutPostNull
;draws null outpost
	pusha
	mov dh, OutPost_height
	mov dl, OutPost_width
	lea si, [NullOutPost]  
DrawOutPostNull:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawOutPostNull              
	mov dl, OutPost_width
	sub ax, OutPost_width
	inc bx
	dec dh
	jnz DrawOutPostNull             
	popa
	ret
endp OutPostNull

proc Lazer_OutPost
;draws outposts lazer
	pusha
	mov dh, OutPostLazer_height
	mov dl, OutPostLazer_width
	lea si, [OutPostLazer]  
DrawOutPostLazer:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawOutPostLazer              
	mov dl, OutPostLazer_width
	sub ax, OutPostLazer_width
	inc bx
	dec dh
	jnz DrawOutPostLazer             
	popa
	ret
endp Lazer_OutPost

proc NullLazer_OutPost
;draws outposts null lazer
	pusha
	mov dh, OutPostLazer_height
	mov dl, OutPostLazer_width
	lea si, [OutPostLazerNull]  
DrawOutPostNullLazer:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawOutPostNullLazer              
	mov dl, OutPostLazer_width
	sub ax, OutPostLazer_width
	inc bx
	dec dh
	jnz DrawOutPostNullLazer             
	popa
	ret
endp NullLazer_OutPost

proc ChargingOutPost
;draws outpost charged (yellow outpost)
	pusha
	mov dh, OutPost_height
	mov dl, OutPost_width
	lea si, [ChargedOutPost]  
DrawChargeOutPost:
	mov cl, [byte ptr si]
	call Pixel
	inc si
	inc ax
	dec dl
	jnz DrawChargeOutPost              
	mov dl, OutPost_width
	sub ax, OutPost_width
	inc bx
	dec dh
	jnz DrawChargeOutPost             
	popa
	ret
endp ChargingOutPost

proc GameOverSkeleton
	pusha
	call SetColorTable	;setting colour table to RRRGGGBB table
	lea dx, [Skeleton1] ;point at the name of part 1 of skeleton image
	call LoadFile	;load part 1 of skeleton image
	mov ax,0
	mov bx,0
	mov cx, FullScreen_height	;cx holds buffer image height
	lea si, [BufferTransfer]	;si points to buffer data
	mov [BufferTransferWidth], FullScreen_width ; set the width of buffer to draw
	call DrawsBufferTransfer	;draws part one of the image
	lea dx, [Skeleton2] ;point at the name of part 2 of skeleton image
	call LoadFile	;load part 2 of skeleton image
	mov ax,50*320
	call DrawsBufferTransfer	;draws part two of the image
	lea dx, [Skeleton3]	;point at the name of part 3 of skeleton image
	call LoadFile	;load part 3 of skeleton image
	mov ax,100*320
	call DrawsBufferTransfer	;draws part three of the image
	lea dx, [Skeleton4]	;point at the name of part 4 of skeleton image
	call LoadFile	;point at the name of part 4 of skeleton image
	mov ax,150*320
	call DrawsBufferTransfer	;draws part four of the image
	popa
	ret
endp GameOverSkeleton

proc StartScreen
;draws the start screen
	pusha
	call SetColorTable
	lea dx, [Start1]
	call LoadFile
	mov ax,0
	mov bx,0
	mov cx, FullScreen_height
	lea si, [BufferTransfer]
	mov [BufferTransferWidth], FullScreen_width
	call DrawsBufferTransfer
	lea dx, [Start2]
	call LoadFile
	mov ax,50*320
	call DrawsBufferTransfer
	lea dx, [Start3]
	call LoadFile
	mov ax,100*320
	call DrawsBufferTransfer
	lea dx, [Start4]
	call LoadFile
	mov ax,150*320
	call DrawsBufferTransfer
	popa
	ret
endp StartScreen

proc WinScreen
;draws the win screen
	pusha
	call SetColorTable
	lea dx, [Win1]
	call LoadFile
	mov ax,0
	mov bx,0
	mov cx, FullScreen_height
	lea si, [BufferTransfer]
	mov [BufferTransferWidth], FullScreen_width
	call DrawsBufferTransfer
	lea dx, [Win2]
	call LoadFile
	mov ax,50*320
	call DrawsBufferTransfer
	lea     dx, [Win3]
	call LoadFile
	mov ax,100*320
	call DrawsBufferTransfer
	lea     dx, [Win4]
	call LoadFile
	mov ax,150*320
	call DrawsBufferTransfer
	popa
	ret
endp WinScreen

proc EndCredit
	pusha
	call SetColorTable	;setting colour table to RRRGGGBB table
;draws the first part of the credits rolling in
	mov cx, 25	;first part rolls in, 25 steps
	mov ax, 200*320	;start line
	mov bx,90	;start column
	lea dx, [Logo1]	;point at first credit file name
	call LoadFile	;load the file
	mov [BufferTransferWidth], credit_width	; set the width of buffer to draw
	lea si, [BufferTransfer]  ;points at the buffer before drawing
CreditLoop1:
	sub ax, 4*320	;update to next line to draw
	mov dx, cx	;saves cx at dx
	mov cx, [CreditR]	;load how much of credit rows from credit image are being shown
	add [CreditR], 4	;update for next time
	call DrawsBufferTransfer	;draws the first part of credits
	mov cx, dx	;restoring the cx for the loop
	loop CreditLoop1
	mov cx, 25	;second part rolls in, 25 steps
	mov [CreditR], 4	;reset CreditR
CreditLoop2:
	sub ax, 4*320	;update to next line to draw
	lea dx, [Logo1] ;point at first credit file name
	call LoadFile   ;load the file
	mov dx, cx	;saves cx at dx
	mov cx, credit_height	;set credit height of the image
	call DrawsBufferTransfer	;draws the first part of credits
	mov cx, dx	;restoring the cx, using dx to load the file
	lea dx, [Logo2] ;point at second credit file name
	call LoadFile   ;load the file
	add ax, 100*320	;update to next line to draw
	mov dx, cx	;saves cx at dx
	mov cx, [CreditR]	;load how much of credit rows from credit image are being shown
	add [CreditR], 4	;update for next time
	call DrawsBufferTransfer	;draws the second part of credits
	sub ax, 100*320	;update to next line to draw
	mov cx, dx	;restoring the cx for the loop
	loop CreditLoop2
	mov cx, 25	;third part rolls in, 25 steps
	mov [CreditR], 100	;reset CreditR
	mov di, 0	;holds number of rows to skip drawing in first image
CreditLoop3:
	sub ax, 4*320	;update to next line to draw
	lea dx, [Logo1] ;point at first credit file name
	call LoadFile   ;load the file
	pusha
	mov cx, [CreditR]	;load how much of credit rows from credit image are being shown
	sub [CreditR], 4	;update for next time
	lea si, [BufferTransfer]	;si points at start of buffer
	add si, di	;skip di lines
	xor ax, ax	;set the draw line at first line of the screen
	call DrawsBufferTransfer	;draws the first part of credits
	popa
	add di, 4*credit_width	;calculate number of rows to skip next time
	lea dx, [Logo2] ;point at second credit file name
	call LoadFile   ;load the file
	add ax, 100*320	;update to next line to draw
	mov dx, cx	;saves cx at dx
	mov cx, credit_height	;set credit height of the image
	lea si, [BufferTransfer]  	;si points at start of buffer
	call DrawsBufferTransfer	;draws the second part of credits
	sub ax, 100*320	;update to next line to draw
	mov cx, dx	;restore cx for the loop
	loop CreditLoop3
	mov cx, 25	;fourth part rolls in, 25 steps
	mov [CreditR], 100	;load how much of credit rows from second credit image are being shown
	mov di, 0	;holds number of rows to skip drawing in second image
	lea dx, [Logo2] ;point at second credit file name
	call LoadFile   ;load the file
CreditLoop4:
	sub ax, 4*320	;update to next line to draw
	pusha
	mov cx, [CreditR]	;load how much of credit rows from second credit image are being shown
	sub [CreditR], 4	;update for next time
	lea si, [BufferTransfer]	;si points at start of buffer
	add si, di	;skip di lines
	xor ax, ax	;set the draw line at first line of the screen
	call DrawsBufferTransfer	;draws the second part of credits
	popa
	add di, 4*credit_width	;calculate number of rows to skip next time
	loop CreditLoop4
	popa
	ret
endp EndCredit


proc DrawsBufferTransfer
	pusha
	mov dx, [BufferTransferWidth]	;takes the width of the image to draw
DrawFromBT:
	call Pixel2	;draw the pixel
	inc si	;increase to read the next data index
	inc ax	;increase to next line
	dec dx	;decrease height
	jnz DrawFromBT      ;check if finished to run on all the column                    
	mov dx, [BufferTransferWidth]	;restore user ship height
	sub ax, [BufferTransferWidth]	;moves to the next line
	add bx, 320	;go to next line
	dec cx	;check if height finished
	jnz DrawFromBT               
	popa
	ret
endp DrawsBufferTransfer