proc Stage4Intro
	mov bx, [RoundIntroC]	;loading the Intro position to ax,bx
	mov ax, [RoundIntroL]
	;making the Intro to go downward by 2 pixels 20 times
	mov cx,20
	Round4Down:
	add ax,2
	call Round4	;drawing the Intro to round 4
	call Delay
	loop Round4Down
	mov [RoundIntroL], ax
	mov cx,1
	WaitForPlayerToShotTheIntro4:
	call ProccessInput	;get keystroke and processes them
	call Spaceship ;draw user spaceship
	call Shots	;draw existing shots
	call CheckCollisionRoundIntro	;check if Intro 1 got hit, if it got hit, it changes ax to 1
	cmp ax,1
	jne WaitForPlayerToShotTheIntro4
	ret
endp Stage4Intro
proc Stage4
	RunStage4:
	call Spaceship	;draw user spaceship
	call Shots	;draw existing shots
	call RowJ	;drawing jugger ships and moving them
	call CheckCollisionJugger	;checking if the jugger ships got hit by the shots
	mov ax,[JuggerPositionL]	;checking if the jugger ships reached the end of the screen
	mov bx, [LastLineLoseJugger]
	cmp ax,bx
	je exitStage4	;exiting if the enemies ships reached the end of the screen
	call ProccessInput	;get keystroke and processes them
	call WinStage4	;check if all enemies ship got destroyed. if it is then it's returning in [RoundState] 0
	mov bx, [RoundState]	;checking win
	cmp bx, 0
	je exitStage4
	cmp ah, 01h	;check if esc was pushed, if it is then exiting the level
	je exitStage4
	cmp ah, 2Dh	;check if 'x' button pushed, if it is then exiting the level
	je exitStage4
	cmp al, 78h	;check if 'X' button pushed, if it is then exiting the level
	jne RunStage4
exitStage4:
	ret
endp Stage4
proc WinStage4
	pusha
	mov cx,8	;there are 8 jugger ship in jugger row
	xor si,si
	CheckJuggerColumn:
	mov ax,[RowJugger+si]	;check if specific jugger ship exist
	add si,2	;check next jugger ship
	cmp ax,0
	jne DoneCheckingForWin4	;if ship exist no need to check more if win
	loop CheckJuggerColumn
	mov [RoundState],0	;if all jugger ships are destroyed then the level is won
	DoneCheckingForWin4:
	popa
	ret
endp WinStage4