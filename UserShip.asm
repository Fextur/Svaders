proc MoveRight
	mov bx,[SpaceshipPosition]	;loading current spaceship position in bx
	cmp bx,(320-35)	;checking if the spaceship is not at the rightmost of the screen
	je MaximumRight
	add bx,5	;increasing by 5 to move 5 pixels to the right
	MaximumRight:
	mov [SpaceshipPosition],bx	;updating the spaceship position 
	ret
endp MoveRight
proc MoveLeft
	mov bx,[SpaceshipPosition]	;loading current spaceship position in bx
	cmp bx,0	;checking if the spaceship is not at the leftmost of the screen
	je MaximumLeft
	sub bx,5	;decreasing by 5 to move 5 pixels to the left
	MaximumLeft:
	mov [SpaceshipPosition],bx	;updating the spaceship position 
	ret
endp MoveLeft
proc StartFire
	pusha
	mov bx, [SpaceshipPosition]	;loading current spaceship position in bx
	mov ax, [CannonShotting]	;loading which cannon is shooting (0-left cannon, 1-right cannon)
	mov cx,10
	xor si,si
	cmp ax,0	;checking which cannon is shooting
	jne ShootRight
	add bx,7	;the left cannon is 7 pixels from the leftmost of the user spaceship
	mov [CannonShotting],1	;changing for next time the other cannon
	jmp FindingShot
ShootRight:
	add bx,27	;the left cannon is 27 pixels from the leftmost of the user spaceship
	mov [CannonShotting],0	;changing for next time the other cannon
FindingShot:
	mov ax, [ShotsLine+si]	;checking if shot exist
	cmp ax,0
	je ShotFound
	add si, 2	;if the shot exist then moving to the next shot to find a shot that doesn't exist
	loop FindingShot
	popa
	ret
	ShotFound:
	mov [ShotsColumn+si],bx	;moving to the shot the Coordinates from where to shot
	mov [ShotsLine+si], 161	;all shots are starting from the line 161
	popa
	ret
endp StartFire