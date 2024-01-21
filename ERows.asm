proc Row1
	mov cx,6	;in row 1 there are 6 ships
	xor si,si
	mov bx, [EnemyShipPositionC1]	;bx holding column of the leftmost ship in row 1
	mov ax, [EnemyShipPositionL1]	;ax holding the line of row 1
NextEnemyShip1:
	mov dx,[Row1Enemies+si]	;checks if ship is destroyed
	cmp dx,0
	je Destroyed1	;if destroyed go to next ship
	cmp dx,1
	je DrawEnemyShip1	;if not got hit draw regular ship
	dec dx	;show explosion for few cycles
	cmp dx, 1
	jne ExplodingShip1	;if dx is equal to 1 again, then the exploding cycles are done
	dec dx
ExplodingShip1:
	mov [Row1Enemies+si],dx	;save exploding cycles counter
	call EnemyExplosionShip	;drawing the enemy exploding
	cmp dx,0	
	jne Destroyed1	;if ship finished cycles show null
	call NullEnemySpaceship
	jmp Destroyed1
DrawEnemyShip1:
	call EnemyShip	;drawing regular enemy ship
Destroyed1:
	add si,2	;moving to next ship
	add bx,45	;between each enemy ships there is a space of 45 pixels
	loop NextEnemyShip1
	mov si, [EnemyShipPositionC1]	;si holding column of the leftmost ship in row 1	
	mov dx, [EnemyShipPositionL1]   ;dx holding the line of row 1
	mov ax, [EnemyShipDirection]	;ax holding the direction of enemies ships movement (0 to left, 1 to right)
	cmp ax,0	;checks if enemies ships move to the left
	je EnemyShipGoLeft
	add si,3	;calculating new column offset for next cycle
	mov bx,si
	add bx,225+26
	cmp bx, [RightBorder]	;check if reached the right limit
	jle NotMaximumRightEnemy	;if not, continue
	sub si, 3	;change direction of enemies ships movement
	add dx, 6
	mov [EnemyShipDirection],0
NotMaximumRightEnemy:
	mov [EnemyShipPositionC1], si	;save for next cycle position
	mov [EnemyShipPositionL1], dx	
	ret
EnemyShipGoLeft:
	sub si,3	;calculating new column offset for next cycle
	cmp si,[LeftBorder]	;check if reached the left limit
	jge NotMinimumLeftEnemy	;if not, continue
	add dx,6	;change direction of enemies ships movement
	mov [EnemyShipDirection],1
NotMinimumLeftEnemy:
	mov [EnemyShipPositionC1], si	;save for next cycle position
	mov [EnemyShipPositionL1], dx
	ret
endp Row1
proc Row2
	mov cx,5	;in row 2 there are 5 ships
	xor si,si
	mov bx, [EnemyShipPositionC1]	;bx holding column of the leftmost ship in row 1
	mov ax, [EnemyShipPositionL2]	;ax holding the line of row 2
	add bx,22	;between the leftmost row 1 ship to row 2 leftmost ship there is a space of 22 pixels
NextEnemyShip2:
	mov dx,[Row2Enemies+si]	;checks if ship is destroyed
	cmp dx,0
	je Destroyed2	;if destroyed go to next ship
	cmp dx,1
	je DrawEnemyShip2	;if not got hit draw regular ship
	dec dx	;show explosion for few cycles
	cmp dx, 1
	jne ExplodingShip2	;if dx is equal to 1 again, then the exploding cycles are done
	dec dx
ExplodingShip2:
	mov [Row2Enemies+si],dx	;save exploding cycles counter
	call EnemyExplosionShip	;drawing the enemy exploding
	cmp dx,0
	jne Destroyed2	;if ship finished cycles show null
	call NullEnemySpaceship
	jmp Destroyed2
DrawEnemyShip2:
	call EnemyShip	;drawing regular enemy ship
Destroyed2:
	add si,2 	;moving to next ship
	add bx,45	;between each enemy ships there is a space of 45 pixels
	loop NextEnemyShip2	
	mov ax,[EnemyShipPositionL1]	;calculating the line for next time the ships are drawn,
	sub ax,20						;the space between row 1 to row 2 in line are 20 pixels
	mov [EnemyShipPositionL2],ax
	ret
endp Row2
proc Row3
	mov cx,6	;in row 3 there are 6 ships
	xor si,si
	mov bx, [EnemyShipPositionC1]	;bx holding column of the leftmost ship in row 1 (row 3 &1 start at the same column)
	mov ax, [EnemyShipPositionL3]	;ax holding the line of row 3
NextEnemyShip3:
	mov dx,[Row3Enemies+si]	;checks if ship is destroyed
	cmp dx,0
	je Destroyed3	;if destroyed go to next ship
	cmp dx,1
	je DrawEnemyShip3	;if not got hit draw regular ship
	dec dx	;show explosion for few cycles
	cmp dx, 1
	jne ExplodingShip3	;if dx is equal to 1 again, then the exploding cycles are done
	dec dx
ExplodingShip3:
	mov [Row3Enemies+si],dx	;save exploding cycles counter
	call EnemyExplosionShip	;drawing the enemy exploding
	cmp dx,0
	jne Destroyed3	;if ship finished cycles show null
	call NullEnemySpaceship
	jmp Destroyed3
DrawEnemyShip3:
	call EnemyShip	;drawing regular enemy ship
Destroyed3:
	add si,2	;moving to next ship
	add bx,45	;between each enemy ships there is a space of 45 pixels
	loop NextEnemyShip3
	mov ax,[EnemyShipPositionL1]	;calculating the line for next time the ships are drawn,
	sub ax,40                   	;the space between row 1 to row 2 in line are 20 pixels
	mov [EnemyShipPositionL3],ax
	ret
endp Row3
proc Row4
	mov cx,5	;in row 4 there are 5 ships
	xor si,si
	mov bx, [EnemyShipPositionC1]	;bx holding column of the leftmost ship in row 1
	mov ax, [EnemyShipPositionL4]	;ax holding the line of row 2
	add bx,22	;between the leftmost row 1 ship to row 2 leftmost ship there is a space of 22 pixels
NextEnemyShip4:
	mov dx,[Row4Enemies+si]	;checks if ship is destroyed
	cmp dx,0
	je Destroyed4	;if destroyed go to next ship
	cmp dx,1
	je DrawEnemyShip4	;if not got hit draw regular ship
	dec dx	;show explosion for few cycles
	cmp dx, 1
	jne ExplodingShip4	;if dx is equal to 1 again, then the exploding cycles are done
	dec dx
ExplodingShip4:
	mov [Row4Enemies+si],dx	;save exploding cycles counter
	call EnemyExplosionShip	;drawing the enemy exploding
	cmp dx,0
	jne Destroyed4	;if ship finished cycles show null
	call NullEnemySpaceship
	jmp Destroyed4
DrawEnemyShip4:
	call EnemyShip	;drawing regular enemy ship
Destroyed4:
	add si,2 	;moving to next ship
	add bx,45	;between each enemy ships there is a space of 45 pixels
	loop NextEnemyShip4
	mov ax,[EnemyShipPositionL1]	;calculating the line for next time the ships are drawn,
	sub ax,60                   	;the space between row 1 to row 2 in line are 20 pixels
	mov [EnemyShipPositionL4],ax
	ret
endp Row4
proc RowJ
	mov bx, [JuggerPositionC]	;bx holding column of the leftmost jugger
	mov ax, [JuggerPositionL]	;ax holding the line of juggers
	mov cx,8	;in the jugger row there are 8 ships
	xor si,si
NextEnemyShipJ:
	mov dx,[RowJugger+si]	;checks if jugger is destroyed
	cmp dx,0
	je JuggerDestroyed	;if destroyed go to next jugger
	cmp dx,5	;if 5 life are left start drawing exploding jugger
	jg DrawJugger
	dec dx	;show explosion for few cycles
	mov [RowJugger+si],dx	;save exploding cycles counter
	call ExplodeJugger	;drawing the jugger exploding
	cmp dx,0
	jne JuggerDestroyed	;if the jugger finished cycles show null
	call NullJugger
	jmp JuggerDestroyed
DrawJugger:
	call Juggernut	;drawing regular jugger
JuggerDestroyed:
	add bx,40	;between each jugger ships there is a space of 40 pixels
	add si,2 	;moving to next jugger ship
	loop NextEnemyShipJ
	;jugger row move once per two cycles
	mov si,[JuggerPositionWait]
	cmp si,0
	jne NotDownYet
	mov dx, [JuggerPositionL]
	inc dx
	mov [JuggerPositionL],dx
	mov [JuggerPositionWait],1
	ret
	NotDownYet:
	dec [JuggerPositionWait]
	ret
endp RowJ
proc OutPostRow
	mov bx, [OutPostPositionC]	;bx holding column of the leftmost ship in row 1
	mov ax, [OutPostPositionL]	;ax holding the line of row 2
	xor si,si
	mov cx,3	;in out post row there are 3 ships
NextEnemyShipOP:
	mov dx,[RowOutPost+si]	;checks if the outpost is destroyed
	cmp dx,0
	je OutPostDestroyed	;if destroyed go to next ship
	cmp dx,5	;if 5 life are left start drawing exploding outpost
	jg ShowOutPost
	dec dx	;show explosion for few cycles
	mov [RowOutPost+si],dx	;save exploding cycles counter
	call ExplodeOutPost	;drawing the outpost exploding
	cmp dx,0
	jne OutPostDestroyed	;if the jugger finished cycles show null
	call OutPostNull
	jmp OutPostDestroyed
ShowOutPost:
	mov dx, [Delay1Allow]	;check if outpost is going to shoot
	cmp dx, 1
	je OutpostReg	;if ship is done charging shot draw regular outpost
	cmp [OutPostLazerShooting+si],1	;check if that specific outpost is going to shoot
	jne OutpostReg	;if not draw regular outpost
	call ChargingOutPost	;draw charging outpost
	jmp OutPostDestroyed
OutpostReg:
	call OutPost	;drawing regular outpost
OutPostDestroyed:
	add bx,100	;between each outpost there is a space of 100 pixels
	add si,2  	;moving to next outpost
	loop NextEnemyShipOP
	ret
endp OutPostRow
