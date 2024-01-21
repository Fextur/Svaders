proc Stage5Intro
	mov bx, [RoundIntroC]	;loading the Intro position to ax,bx
	mov ax, [RoundIntroL]
	;making the Intro to go downward by 2 pixels 20 times
	mov cx,20
	Round5Down:
	add ax,2
	call Round5	;drawing the Intro to round 5
	call Delay
	loop Round5Down
	mov [RoundIntroL], ax
	mov cx,1
	WaitForPlayerToShotTheIntro5:
	call ProccessInput	;get keystroke and processes them
	call Spaceship ;draw user spaceship
	call Shots	;draw existing shots
	call CheckCollisionRoundIntro	;check if Intro 1 got hit, if it got hit, it changes ax to 1
	cmp ax,1
	jne WaitForPlayerToShotTheIntro5
	ret
endp Stage5Intro
proc Stage5
	RunStage5:
	call OutPostShotting	;draws outpost shooting (their lazers)
	call Spaceship	;draw user spaceship
	call Shots	;draw existing shots
	call OutPostRow	;drawing outposts
	call CheckCollisionOutPost	;checking if the outposts got hit by the shots
	call ProccessInput	;get keystroke and processes them
	call WinStage5	;check if all enemies ship got destroyed. if it is then it's returning in [RoundState] 0
	call CheckPlayerCollision	;check if player got hit by outpost lazers. if it is then it's returning in [PlayerCollision] 1
	mov bx, [RoundState]	;checking win
	cmp bx, 0
	je exitStage5
	cmp ah, 01h	;check if esc was pushed, if it is then exiting the level
	je exitStage5
	cmp ah, 2Dh	;check if 'x' button pushed, if it is then exiting the level
	je exitStage5
	cmp al, 78h	;check if 'X' button pushed, if it is then exiting the level
	je exitStage5
	cmp [PlayerCollision],1	;check if player got hit by outpost lazers.
	jne RunStage5
exitStage5:
	ret
endp Stage5
proc WinStage5
	pusha
	mov cx,3	;there are 3 outposts
	xor si,si
	CheckOutPostColumn:
	mov ax,[RowOutPost+si]	;check if specific outpost exist
	add si,2	;check the next outpost
	cmp ax,0
	jne DoneCheckingForWin5	;if ship exist no need to check more if win
	loop CheckOutPostColumn
	mov [RoundState],0	;if all outposts are destroyed then the level is won
	DoneCheckingForWin5:
	popa
	ret
endp WinStage5