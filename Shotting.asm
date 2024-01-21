proc Shots
	pusha
	mov cx,10	;there are 10 shots max
	xor si,si
	ShotsLoop:
	mov ax, [ShotsLine+si]	;loading to ax and bx specific shot position
	mov bx, [ShotsColumn+si]
	cmp ax,0	;if ax equal 0 then the shot still not exist or finished
	je NotFound
	cmp ax,4	;above line 4, the shot is finished
	jl NullifyShot
	call LazerShot	;draws the shot
	sub ax,4	;make the shot go upward for next cycle
	mov [ShotsLine+si], ax	;update shot position for next cycle
	jmp NotFound
NullifyShot:
	pusha
	add ax, 4	;cleans last shot position
	call LazerNullShot	;draws null shot
	popa
	mov [ShotsLine+si],0	;reset the shot for next use
	mov [ShotsColumn+si],0
NotFound:
	add si, 2	;move to next shot
	loop ShotsLoop
	popa
	ret
endp Shots

proc CheckCollision
	call CheckCollisionR1	;check collision in row 1
	call CheckCollisionR2	;check collision in row 2
	call CheckCollisionR3	;check collision in row 3
	call CheckCollisionR4	;check collision in row 4
	ret
endp CheckCollision

proc CheckCollisionR1
	pusha
	mov cx,10	;there are 10 shots max
	xor si,si
	ShotsR1:
	mov ax, [ShotsLine+si]	;checking if shot is exist (0 - not exist, else - line position)
	cmp ax,0
	je NextShot	;if not go to next shot
	mov bx, [ShotsColumn+si]	;load specific shot column in bx
	mov dx, [EnemyShipPositionC1]	;load first enemy ship positions
	mov di, [EnemyShipPositionL1]
	;check if the shot is in the enemy ships row 
	cmp ax,di	
	jl NextShot
	add di,19
	cmp ax, di
	jg NextShot	
	;check if the shot is in the ship hitbox 
	push cx
	push si
	xor si,si
	mov cx,6	;there are 6 ships in row 1
	NextShipR1:
	cmp bx, dx
	jl NextShip
	add dx,29
	cmp bx,dx
	jg NextShip
	mov ax, [Row1Enemies+si]	;checks if the ship is already destroyed 
	cmp ax, 0
	je AlreadyKilled
	mov [Row1Enemies+si],6	;set number for showing explosion
	pop si
	pop cx
	mov ax, [ShotsLine+si]
	add ax, 2
	mov bx, [ShotsColumn+si]
	pusha
	call LazerNullShot	;if the shot hit the enemy ship, null the shot
	popa
	mov [ShotsLine+si],0	;reset the shot for next use
	mov [ShotsColumn+si],0
	jmp NextShot
AlreadyKilled:
	pop si
	pop cx
	jmp NextShot
NextShip:
	add dx,16	;the space between the end of one ship to the start of the second ship is 16 pixels
	add si,2	;moves to next ship
	loop NextShipR1
	pop si
	pop cx
NextShot:
	add si,2	;moves to next shot
	loop ShotsR1
	popa
	ret
endp CheckCollisionR1

proc CheckCollisionR2
	pusha
	mov cx,10	;there are 10 shots max
	xor si,si
	ShotsR2:
	mov ax, [ShotsLine+si]	;checking if shot is exist (0 - not exist, else - line position)
	cmp ax,0
	je NextShot2	;if not go to next shot
	mov bx, [ShotsColumn+si]	;load specific shot column in bx
	mov dx, [EnemyShipPositionC1]	;load first enemy ship positions
	add dx,22	;between the leftmost row 1 ship to row 2 leftmost ship there is a space of 22 pixels
	mov di, [EnemyShipPositionL2]
	;check if the shot is in the enemy ships row  
	cmp ax,di
	jl NextShot2
	add di,19
	cmp ax, di
	jg NextShot2
	;check if the shot is in the ship hitbox 
	push cx
	push si
	xor si,si
	mov cx,5	;there are 5 ships in row 2
	NextShipR2:
	cmp bx, dx
	jl NextShip2
	add dx,29
	cmp bx,dx
	jg NextShip2
	mov ax, [Row2Enemies+si]	;checks if the ship is already destroyed 
	cmp ax, 0
	je AlreadyKilled2
	mov [Row2Enemies+si],6	;set number for showing explosion
	pop si
	pop cx
	mov ax, [ShotsLine+si]
	add ax, 2
	mov bx, [ShotsColumn+si]
	pusha
	call LazerNullShot	;if the shot hit the enemy ship, null the shot
	popa
	mov [ShotsLine+si],0	;reset the shot for next use
	mov [ShotsColumn+si],0
	jmp NextShot2
AlreadyKilled2:
	pop si
	pop cx
	jmp NextShot2
NextShip2:
	add dx,16	;the space between the end of one ship to the start of the second ship is 16 pixels
	add si,2 	;moves to next ship
	loop NextShipR2
	pop si
	pop cx
NextShot2:
	add si,2	;moves to next shot
	loop ShotsR2
	popa
	ret
endp CheckCollisionR2

proc CheckCollisionRoundIntro
	pusha
	mov cx,10	;there are 10 shots max
	xor si,si
	ShotsIntro:
	mov ax, [ShotsLine+si]	;checking if shot is exist (0 - not exist, else - line position)
	cmp ax,0
	je NextShotRound2	;if not go to next shot
	mov bx, [ShotsColumn+si]	;load specific shot column in bx
	mov dx, [RoundIntroC]	;load first enemy ship positions
	mov di, [RoundIntroL]
	cmp ax,di
	;check if the shot is in the intro hitbox
	jl NextShotRound2
	add di,14
	cmp ax, di
	jg NextShotRound2
	cmp bx,dx
	jl NextShotRound2
	add dx,58
	cmp bx,dx
	jg NextShotRound2
	popa
	mov ax,1
	ret
NextShotRound2:
	add si,2	;moves to next shot
	loop ShotsIntro
	popa
	ret
endp CheckCollisionRoundIntro
proc CheckCollisionR3
	pusha
	mov ax,[Rows3Inside]	;checks if row 3 is inside the level
	cmp ax,1
	jne Rows3NotInside
	mov cx,10	;there are 10 shots max
	xor si,si
	ShotsR3:
	mov ax, [ShotsLine+si]	;checking if shot is exist (0 - not exist, else - line position)
	cmp ax,0
	je NextShot3	;if not go to next shot
	mov bx, [ShotsColumn+si]      ;load specific shot column in bx
	mov dx, [EnemyShipPositionC1] 	;load first enemy ship positions
	mov di, [EnemyShipPositionL3]
	;check if the shot is in the enemy ships row  
	cmp ax,di
	jl NextShot3
	add di,19
	cmp ax, di
	jg NextShot3
	;check if the shot is in the ship hitbox
	push cx
	push si
	xor si,si
	mov cx,6	;there are 6 ships in row 3
	NextShipR3:
	cmp bx, dx
	jl NextShip3
	add dx,29
	cmp bx,dx
	jg NextShip3
	mov ax, [Row3Enemies+si]	;checks if the ship is already destroyed 
	cmp ax, 0
	je AlreadyKilled3
	mov [Row3Enemies+si],6	;set number for showing explosion
	pop si
	pop cx
	mov ax, [ShotsLine+si]
	add ax, 2
	mov bx, [ShotsColumn+si]
	pusha
	call LazerNullShot	;if the shot hit the enemy ship, null the shot
	popa
	mov [ShotsLine+si],0	;reset the shot for next use
	mov [ShotsColumn+si],0
	jmp NextShot3
AlreadyKilled3:
	pop si
	pop cx
	jmp NextShot3
NextShip3:
	add dx,16	;the space between the end of one ship to the start of the second ship is 16 pixels
	add si,2 	;moves to next ship
	loop NextShipR3
	pop si
	pop cx
NextShot3:
	add si,2	;moves to next shot
	loop ShotsR3
	Rows3NotInside:
	popa
	ret
endp CheckCollisionR3

proc CheckCollisionR4
	pusha
	mov ax,[Rows4Inside]	;checks if row 3 is inside the level
	cmp ax,1
	jne Rows4NotInside
	mov cx,10	;there are 10 shots max
	xor si,si
	ShotsR4:
	mov ax, [ShotsLine+si]	;checking if shot is exist (0 - not exist, else - line position)
	cmp ax,0
	je NextShot4	;if not go to next shot
	mov bx, [ShotsColumn+si]	;load specific shot column in bx
	mov dx, [EnemyShipPositionC1]	;load first enemy ship positions
	add dx,22	;between the leftmost row 1 ship to row 2 leftmost ship there is a space of 22 pixels
	mov di, [EnemyShipPositionL4]
	;check if the shot is in the enemy ships row 
	cmp ax,di
	jl NextShot4
	add di,19
	cmp ax, di
	jg NextShot4
	;check if the shot is in the ship hitbox 
	push cx
	push si
	xor si,si
	mov cx,5	;there are 5 ships in row 4
	NextShipR4:
	cmp bx, dx
	jl NextShip4
	add dx,29
	cmp bx,dx
	jg NextShip4
	mov ax, [Row4Enemies+si]	;checks if the ship is already destroyed
	cmp ax, 0
	je AlreadyKilled4
	mov [Row4Enemies+si],6	;set number for showing explosion
	pop si
	pop cx
	mov ax, [ShotsLine+si]
	add ax, 2
	mov bx, [ShotsColumn+si]
	pusha
	call LazerNullShot	;if the shot hit the enemy ship, null the shot
	popa
	mov [ShotsLine+si],0	;reset the shot for next use
	mov [ShotsColumn+si],0
	jmp NextShot4
AlreadyKilled4:
	pop si
	pop cx
	jmp NextShot4
NextShip4:
	add dx,16	;the space between the end of one ship to the start of the second ship is 16 pixels
	add si,2 	;moves to next ship
	loop NextShipR4
	pop si
	pop cx
NextShot4:
	add si,2	;moves to next shot
	loop ShotsR4
	Rows4NotInside:
	popa
	ret
endp CheckCollisionR4

proc CheckCollisionJugger
	pusha
	mov cx,10	;there are 10 shots max
	xor si,si
	ShotsJugg:
	mov ax, [ShotsLine+si]	;checking if shot is exist (0 - not exist, else - line position)
	cmp ax,0
	je NextShotJ	;if not go to next shot
	mov bx, [ShotsColumn+si]	;load specific shot column in bx
	mov dx, [JuggerPositionC]	;load first enemy ship positions
	mov di, [JuggerPositionL]
	;check if the shot is in the jugger row
	cmp ax,di
	jl NextShotJ
	add di,22
	cmp ax, di
	jg NextShotJ
	;check if the shot is in the jugger hitbox 
	push cx
	push si
	xor si,si
	mov cx,8	;there are 8 jugger ships in the jugger row
	NextShipJugg:
	cmp bx, dx
	jl NextShipJ
	add dx,36
	cmp bx,dx
	jg NextShipJ
	mov ax, [RowJugger+si]	;checks if the jugger is already destroyed
	cmp ax,5
	jle AlreadyKilledJ
	dec [RowJugger+si]
	pop si
	pop cx
	mov ax, [ShotsLine+si]
	add ax, 2
	mov bx, [ShotsColumn+si]
	pusha
	call LazerNullShot	;if the shot hit the enemy ship, null the shot
	popa
	mov [ShotsLine+si],0	;reset the shot for next use
	mov [ShotsColumn+si],0
	jmp NextShotJ
AlreadyKilledJ:
	pop si
	pop cx
	jmp NextShotJ
NextShipJ:
	add dx,4	;the space between the end of one ship to the start of the second ship is 4 pixels
	add si,2	;moves to next ship
	loop NextShipJugg
	pop si
	pop cx
NextShotJ:
	add si,2	;moves to next shot
	loop ShotsJugg
	popa
	ret
endp CheckCollisionJugger
proc CheckCollisionOutPost
	pusha
	mov cx,10	;there are 10 shots max
	xor si,si
	ShotsOutPost:
	mov ax, [ShotsLine+si]	;checking if shot is exist (0 - not exist, else - line position)
	cmp ax,0
	je NextShotOP	;if not go to next shot
	mov bx, [ShotsColumn+si]	;load specific shot column in bx
	mov dx, [OutPostPositionC]	;load first enemy ship positions
	mov di, [OutPostPositionL]
	;check if the shot is in the OutPost row
	cmp ax,di
	jl NextShotOP
	add di,23
	cmp ax, di
	jg NextShotOP
	;check if the shot is in the outpost hitbox 
	pusha
	xor si,si
	mov cx,3	;there are 3 outpost in the outpost row
	NextShipOutPost:
	cmp bx, dx
	jl NextShipOP
	add dx,80
	cmp bx,dx
	jg NextShipOP
	mov ax, [RowOutPost+si]	;checks if the outpost is already destroyed
	cmp ax,5
	jle AlreadyKilledOP
	dec ax
	mov [RowOutPost+si], ax
	cmp ax,5
	jg OutPostDoesNotKilled
	dec [OutPostCount]
	mov [OutPostLazerShooting+si],0
OutPostDoesNotKilled:
	popa
	mov ax, [ShotsLine+si]
	add ax, 2
	mov bx, [ShotsColumn+si]
	pusha
	call LazerNullShot	;if the shot hit the enemy ship, null the shot
	popa
	mov [ShotsLine+si],0	;reset the shot for next use
	mov [ShotsColumn+si],0
	jmp NextShotOP
AlreadyKilledOP:
	popa
	jmp NextShotOP
NextShipOP:
	add dx,20	;the space between the end of one ship to the start of the second ship is 4 pixels
	add si,2 	;moves to next ship
	loop NextShipOutPost
	popa
NextShotOP:
	add si,2	;moves to next shot
	loop ShotsOutPost
	popa
	ret
endp CheckCollisionOutPost
proc DecidingCannon
pusha
	RandAgain:
	mov bx,3	;set max limit for random (0-3)
	call GetRandom	;getting random number
	cmp [RandomResult],1	;check if first outpost selected
	jne NotCannon1
	mov cx,[RowOutPost+0]	;check if first outpost didn't got destroyed
	cmp cx,5				;if destroyed, get new random number
	jl RandAgain
	mov [OutPostLazerShooting+0],1	;setting the first outpost to shoot
	mov [OutPostLazerShooting+2],0
	mov [OutPostLazerShooting+4],0
	popa
	ret
	NotCannon1:
	cmp [RandomResult],2	;check if second outpost selected
	jne NotCannon2
	mov cx,[RowOutPost+2]	;check if second outpost didn't got destroyed
	cmp cx,5             	;if destroyed, get new random number
	jl RandAgain
	mov [OutPostLazerShooting+2],1	;setting the seconds outpost to shoot
	mov [OutPostLazerShooting+0],0
	mov [OutPostLazerShooting+4],0
	popa
	ret
	NotCannon2:
	cmp [RandomResult],3	;check if third outpost selected
	jne TwoCannons
	mov cx,[RowOutPost+4]	;check if third outpost didn't got destroyed
	cmp cx,5             	;if destroyed, get new random number
	jl RandAgain
	mov [OutPostLazerShooting+4],1	;setting the third outpost to shoot
	mov [OutPostLazerShooting+0],0
	mov [OutPostLazerShooting+2],0
	popa
	ret
	TwoCannons:
	mov cx,[OutPostCount]	;checking if there is more then 1 cannon
	cmp cx,1
	jle RandAgain	;if there is only one cannon, get new random number
	RandAgain2:
	mov bx,3	;set max limit for random (0-3)
	call GetRandom	;getting random number
	cmp [RandomResult],1	;if the random number is 1, then only the first cannon doesn't shot
	jne Cannon1Active
	mov cx,[RowOutPost+4]	;check if third outpost didn't got destroyed
	cmp cx,5                ;if destroyed, get new random number
	jl RandAgain2
	mov cx,[RowOutPost+2]	;check if second outpost didn't got destroyed
	cmp cx,5                ;if destroyed, get new random number
	jl RandAgain2
	mov [OutPostLazerShooting+0],0	;setting all the outposts to shoot except the first outpost
	mov [OutPostLazerShooting+2],1
	mov [OutPostLazerShooting+4],1
	popa
	ret
	Cannon1Active:
	cmp [RandomResult],2	;if the random number is 2, then only the second cannon doesn't shot
	jne Cannon2Active
	mov cx,[RowOutPost+0]	;check if first outpost didn't got destroyed
	cmp cx,5                ;if destroyed, get new random number
	jl RandAgain2
	mov cx,[RowOutPost+4]	;check if third outpost didn't got destroyed
	cmp cx,5                ;if destroyed, get new random number
	jl RandAgain2
	mov [OutPostLazerShooting+2],0	;setting all the outposts to shoot except the second outpost
	mov [OutPostLazerShooting+0],1
	mov [OutPostLazerShooting+4],1
	popa
	ret
	Cannon2Active:
	cmp [RandomResult],3	;if the random number is 3, then only the third cannon doesn't shot
	jne RandAgain2
	mov cx,[RowOutPost+0]	;check if first outpost didn't got destroyed
	cmp cx,5                ;if destroyed, get new random number
	jl RandAgain2
	mov cx,[RowOutPost+2]	;check if second outpost didn't got destroyed
	cmp cx,5            	;if destroyed, get new random number
	jl RandAgain2
	mov [OutPostLazerShooting+4],0	;setting all the outposts to shoot except the third outpost
	mov [OutPostLazerShooting+0],1
	mov [OutPostLazerShooting+2],1
	popa
	ret
endp DecidingCannon
proc OutPostShotting
	mov ax, [Delay4Allow] ;check if 4 seconds delay is activated
	cmp ax, 0
	je NoDelay4
	call Set4SecDelay	;if not, then it activate it
NoDelay4: 
	call Check4SecDelay	;check if the delay is over
	mov ax, [Time4SecResult]
	cmp ax, 0
	je NoLazer	;if the delay isn't over, doesn't shot the lazer 
	call DecidingCannon	;deciding which cannon will shot
	call Set1SecDelay	;activate 1 second delay
NoLazer:
	mov ax, [Delay1Allow]	;check if 1 second delay is being used
	cmp ax, 1
	je NoWarning	;jump if not activated
	call Check1SecDelay	;if activated, check if finished
	mov ax, [Time1SecResult]
	cmp ax, 0
	je NoWarning
	call OutPostLazerShotting ;if finished, draws the lazer
	call Set2SecDelay	;activate 2 seconds delay
NoWarning:
	mov ax, [Delay2Allow]	;check if 2 seconds delay is activated
	cmp ax, 1
	je NoNullLazer ;jump if not activated
	call Check2SecDelay	;check if 2 seconds delay is over
	mov ax, [Time2SecResult]
	cmp ax, 0
	je NoNullLazer	;jump if not finished
	call NullingLazerOutPost	;nulling the lazer
	mov [OutPostLazerShooting+0],0	;resets the lazers
	mov [OutPostLazerShooting+2],0
	mov [OutPostLazerShooting+4],0
NoNullLazer:
	ret
endp OutPostShotting
proc OutPostLazerShotting
	mov ax, [Delay1Allow]	;check if there is 1 second delay active
	cmp ax, 0
	jne ContinueLazer	
	ret	;if active then exit
ContinueLazer:
	mov cx,3	;there are 3 outposts
	xor si,si
	mov ax,49	;all the lazers start at line 49
	mov bx,24	;the first cannon start at 24 pixels column
	OutPostLazerDrawings:
	cmp [OutPostLazerShooting+si],1	;check if the first outpost should shoot
	jne NextOutPostLazer	;if not, check next outpost
	call Lazer_OutPost	;draws first lazer
	add bx,44	;the space between 2 cannons is 44 pixels
	call Lazer_OutPost	;draws second lazer
	sub bx,44	;reset the lazer offset
	NextOutPostLazer:
	add bx,100	;the space between 2 outposts is 100 pixels
	add si,2	;moving to the next outpost
	loop OutPostLazerDrawings
	ret
endp OutPostLazerShotting

proc NullingLazerOutPost
	mov cx,3	;there are 3 outposts
	mov ax,49	;all the lazers start at line 49	
	mov bx,24	;the first cannon start at 24 pixels column
	NullingLazers:
	call NullLazer_OutPost	;nulling the first lazer
	add bx,44	;the space between 2 cannons is 44 pixels	
	call NullLazer_OutPost	;nulling the second lazer
	add bx,56	;the space between 2 outposts is 100 pixels (already added 44)
	loop NullingLazers
	ret
endp NullingLazerOutPost
proc CheckPlayerCollision
	pusha
	mov ax, [Delay2Allow]	;check if there is 2 second delay active (lazer active)
	cmp ax, 1
	je NoCheckLazer3	;if active then exit
	mov ax,[SpaceshipPosition]	;loading in ax user spaceship position
	add ax,5	;there is blank for 5 columns before the ship itself start
	mov dx, ax	
	add dx, 26	;dx holding the end of the ship (rightmost column of the ship)
	mov cx,3	;there are 3 outposts
	xor si,si
	mov bx,24	;the first cannon starts at 24 pixels column
	mov di,96	;the second cannon ends at 96 pixels column
	CheckLazerPlayerCollision:
	cmp [OutPostLazerShooting+si],1	;check if outpost shooting
	jne CheckNextLazer
	cmp dx, bx	;check right border of user spaceship with left border of the lazer
	jl CheckNextLazer
	cmp ax, di	;check left border of user spaceship with right border of the lazer
	jg CheckNextLazer
	mov [PlayerCollision],1	;if the player got hit, return at [PlayerCollision] 1
	CheckNextLazer:
	add bx, 100	;next outpost lazer offset position
	add di, 100	;next outpost lazer offset position
	add si, 2	;check next outpost
	loop CheckLazerPlayerCollision
NoCheckLazer3:
	popa
	ret
endp CheckPlayerCollision