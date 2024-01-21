proc Stage2Intro
	mov bx, [RoundIntroC]	;loading the Intro position to ax,bx
	mov ax, [RoundIntroL]
	;making the Intro to go downward by 2 pixels 20 times
	mov cx,20
	Round2Down:
	add ax,2
	call Round2	;drawing the Intro to round 2
	call Delay
	loop Round2Down
	mov [RoundIntroL], ax
	mov cx,1
	WaitForPlayerToShotTheIntro2:
	call ProccessInput	;get keystroke and processes them
	call Spaceship ;draw user spaceship
	call Shots	;draw existing shots
	call CheckCollisionRoundIntro	;check if Intro 1 got hit, if it got hit, it changes ax to 1
	cmp ax,1
	jne WaitForPlayerToShotTheIntro2
	ret
	ret
endp Stage2Intro
proc Stage2
	mov [Rows3Inside],1	;flag that shows that row 3 is inside the level
	RunStage2:
	call Spaceship	;draw user spaceship
	call Shots	;draw existing shots
	call Borders	;calculating the borders for the enemies ships
	call ShowEnemies2	;drawing enemies ships and moving them
	call CheckCollision	;checking if the enemies ships got hit by the shots
	mov ax,[EnemyShipPositionL1]	;checking if the enemies ships reached the end of the screen
	mov bx, [LastLineLose]
	cmp ax,bx
	je exitStage2	;exiting if the enemies ships reached the end of the screen
	call ProccessInput	;get keystroke and processes them
	call WinStage2	;check if all enemies ship got destroyed. if it is then it's returning in [RoundState] 0
	mov bx, [RoundState]	;checking win
	cmp bx, 0
	je exitStage2
	cmp ah, 01h	;check if esc was pushed, if it is then exiting the level
	je exitStage2
	cmp ah, 2Dh	;check if 'x' button pushed, if it is then exiting the level
	je exitStage2
	cmp al, 78h	;check if 'X' button pushed, if it is then exiting the level
	jne RunStage2
exitStage2:
	ret
endp Stage2
proc ShowEnemies2
	call Row1	;show row 1 enemies
	call Row2	;show row 2 enemies
	cmp [EnemyShipPositionL1], 40	;when row 1 get to line 40 then start showing row 3
	jle	NoRow3Yet
	call Row3	;show row 3 enemies
	NoRow3Yet:
	ret
endp ShowEnemies2
proc WinStage2
	pusha
	mov cx,6	;there are 6 enemies ship in row 1
	xor si,si
	CheckColumn1Round2:
	mov ax,[Row1Enemies+si]	;check if specific enemy ship exist
	add si,2	;check next enemy ship
	cmp ax,0
	jne DoneCheckingForWin2	;if ship exist no need to check more if win
	loop CheckColumn1Round2
	mov [LastLineLose],160	;if row 1 is all destroyed then the enemies need to get farther
	xor si,si
	mov cx,5	;there are 5 enemies ship in row 2
	CheckColumn2Round2:
	mov ax,[Row2Enemies+si]	;check if specific enemy ship exist
	add si,2	;check next enemy ship
	cmp ax,0
	jne DoneCheckingForWin2	;if ship exist no need to check more if win
	loop CheckColumn2Round2
	mov [LastLineLose],180	;if row 1 is all destroyed then the enemies need to get farther
	xor si,si
	mov cx,6	;there are 6 enemies ship in row 3
	CheckColumn3Round2:
	mov ax,[Row3Enemies+si]	;check if specific enemy ship exist
	add si,2	;check next enemy ship
	cmp ax,0
	jne DoneCheckingForWin2	;if ship exist no need to check more if win
	loop CheckColumn3Round2
	mov [RoundState],0	;if all enemies rows are destroyed then the level is won
	DoneCheckingForWin2:
	popa
	ret
endp WinStage2