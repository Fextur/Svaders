proc Stage3Intro
	mov bx, [RoundIntroC]	;loading the Intro position to ax,bx
	mov ax, [RoundIntroL]
	;making the Intro to go downward by 2 pixels 20 times
	mov cx,20
	Round3Down:
	add ax,2
	call Round3	;drawing the Intro to round 3
	call Delay
	loop Round3Down
	mov [RoundIntroL], ax
	mov cx,1
	WaitForPlayerToShotTheIntro3:
	call ProccessInput	;get keystroke and processes them
	call Spaceship ;draw user spaceship
	call Shots	;draw existing shots
	call CheckCollisionRoundIntro	;check if Intro 1 got hit, if it got hit, it changes ax to 1
	cmp ax,1
	jne WaitForPlayerToShotTheIntro3
	ret
endp Stage3Intro
proc Stage3
	mov [Rows3Inside],1	;flag that shows that row 3 is inside the level
	mov [Rows4Inside],1	;flag that shows that row 4 is inside the level
	RunStage3:
	call Spaceship	;draw user spaceship
	call Shots	;draw existing shots
	call Borders	;calculating the borders for the enemies ships
	call ShowEnemies3	;drawing enemies ships and moving them
	call CheckCollision	;checking if the enemies ships got hit by the shots
	mov ax,[EnemyShipPositionL1]	;checking if the enemies ships reached the end of the screen
	mov bx, [LastLineLose]
	cmp ax,bx
	je exitStage3	;exiting if the enemies ships reached the end of the screen
	call ProccessInput	;get keystroke and processes them
	call WinStage3	;check if all enemies ship got destroyed. if it is then it's returning in [RoundState] 0
	mov bx, [RoundState]	;checking win
	cmp bx, 0
	je exitStage3
	cmp ah, 01h	;check if esc was pushed, if it is then exiting the level
	je exitStage3
	cmp ah, 2Dh	;check if 'x' button pushed, if it is then exiting the level
	je exitStage3
	cmp al, 78h	;check if 'X' button pushed, if it is then exiting the level
	jne RunStage3
exitStage3:
	ret
endp Stage3
proc ShowEnemies3
	call Row1	;show row 1 enemies
	call Row2	;show row 2 enemies
	cmp [EnemyShipPositionL1], 40	;when row 1 get to line 40 then start showing row 3
	jle NoRow3or4Yet
	call Row3	;show row 3 enemies
	cmp [EnemyShipPositionL1], 60	;when row 1 get to line 60 then start showing row 4
	jle NoRow3or4Yet
	call Row4	;show row 3 enemies
	NoRow3or4Yet:
	ret
endp ShowEnemies3
proc WinStage3
	pusha
	mov cx,6	;there are 6 enemies ship in row 1
	xor si,si
	CheckColumn1Round3:
	mov ax,[Row1Enemies+si]	;check if specific enemy ship exist
	add si,2	;check next enemy ship
	cmp ax,0
	jne DoneCheckingForWin3	;if ship exist no need to check more if win
	loop CheckColumn1Round3
	mov [LastLineLose],160	;if row 1 is all destroyed then the enemies need to get farther
	xor si,si
	mov cx,5	;there are 5 enemies ship in row 2
	CheckColumn2Round3:
	mov ax,[Row2Enemies+si]	;check if specific enemy ship exist
	add si,2	;check next enemy ship
	cmp ax,0
	jne DoneCheckingForWin3	;if ship exist no need to check more if win
	loop CheckColumn2Round3
	mov [LastLineLose],180	;if row 1 is all destroyed then the enemies need to get farther
	xor si,si
	mov cx,6	;there are 6 enemies ship in row 3
	CheckColumn3Round3:
	mov ax,[Row3Enemies+si]	;check if specific enemy ship exist
	add si,2	;check next enemy ship
	cmp ax,0
	jne DoneCheckingForWin3	;if ship exist no need to check more if win
	loop CheckColumn3Round3
	mov [LastLineLose],200	;if row 1 is all destroyed then the enemies need to get farther
	xor si,si
	mov cx,5	;there are 5 enemies ship in row 2
	CheckColumn4Round3:
	mov ax,[Row4Enemies+si]	;check if specific enemy ship exist
	add si,2	;check next enemy ship
	cmp ax,0
	jne DoneCheckingForWin3	;if ship exist no need to check more if win
	loop CheckColumn4Round3
	mov [RoundState],0	;if all enemies rows are destroyed then the level is won
	DoneCheckingForWin3:
	popa
	ret
endp WinStage3