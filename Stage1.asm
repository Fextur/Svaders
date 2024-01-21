proc Stage1Intro
	mov bx, [RoundIntroC]	;loading the Intro position to ax,bx
	mov ax, [RoundIntroL]
	;making the Intro to go downward by 2 pixels 20 times
	mov cx,20	
	Round1Down:
	add ax,2
	call Round1	;drawing the Intro to round 1
	call Delay
	loop Round1Down
	mov [RoundIntroL], ax
	mov cx,1
	WaitForPlayerToShotTheIntro1:
	call ProccessInput	;get keystroke and processes them
	call Spaceship ;draw user spaceship
	call Shots	;draw existing shots
	call CheckCollisionRoundIntro	;check if Intro 1 got hit, if it got hit, it changes ax to 1
	cmp ax,1
	jne WaitForPlayerToShotTheIntro1
	ret
endp Stage1Intro

proc Stage1
RunStage1:
	call Spaceship	;draw user spaceship
	call Shots	;draw existing shots
	call Borders	;calculating the borders for the enemies ships
	call ShowEnemies1	;drawing enemies ships and moving them
	call CheckCollision	;checking if the enemies ships got hit by the shots
	mov ax,[EnemyShipPositionL1]	;checking if the enemies ships reached the end of the screen
	mov bx, [LastLineLose]
	cmp ax,bx
	je exitStage1	;exiting if the enemies ships reached the end of the screen
	call ProccessInput	;get keystroke and processes them
	call WinStage1	;check if all enemies ship got destroyed. if it is then it's returning in [RoundState] 0
	mov bx, [RoundState]	;checking win
	cmp bx, 0
	je exitStage1
	cmp ah, 01h	;check if esc was pushed, if it is then exiting the level
	je exitStage1
	cmp ah, 2Dh	;check if 'x' button pushed, if it is then exiting the level
	je exitStage1
	cmp al, 78h	;check if 'X' button pushed, if it is then exiting the level
	jne RunStage1
exitStage1:
	ret
endp Stage1
proc ShowEnemies1
	call Row1	;show row 1 enemies
	call Row2	;show row 2 enemies
	ret
endp ShowEnemies1
proc WinStage1
	pusha
	mov cx,6	;there are 6 enemies ship in row 1
	xor si,si
	CheckColumn1Round1:
	mov ax,[Row1Enemies+si]	;check if specific enemy ship exist
	add si,2	;check next enemy ship
	cmp ax,0
	jne DoneCheckingForWin1	;if ship exist no need to check more if win
	loop CheckColumn1Round1
	mov [LastLineLose],160	;if row 1 is all destroyed then the enemies need to get farther
	xor si,si
	mov cx,5	;there are 5 enemies ship in row 2
	CheckColumn2Round1:
	mov ax,[Row2Enemies+si]	;check if specific enemy ship exist
	add si,2	;check next enemy ship
	cmp ax,0
	jne DoneCheckingForWin1	;if ship exist no need to check more if win
	loop CheckColumn2Round1
	mov [RoundState],0	;if all enemies rows are destroyed then the level is won
	DoneCheckingForWin1:
	popa
	ret
endp WinStage1