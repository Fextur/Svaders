proc ProccessInput
	call Receiver ;receiving input from keyboard
	cmp al,61h	;'a' button pushed
	je CallLeft
	cmp ah,1Eh	;'A' button pushed
	je CallLeft
	cmp ah,4Bh	;left arrow button pushed
	je CallLeft
	cmp al,64h	;'d' button pushed
	je CallRight
	cmp ah,20h	;'D' button pushed
	je CallRight
	cmp ah,4Dh	;right arrow button pushed
	je CallRight
	cmp ah,11h	;'W' button pushed
	je CallFire
	cmp ah,77h	;'w' button pushed
	je CallFire
	cmp ah,48h	;up arrow button pushed
	je CallFire
	ret
CallFire:
	call StartFire ;shooting
	ret
CallRight:
	call moveRight	;move user ship right
	ret
CallLeft:
	call MoveLeft	;move user ship left
	ret
endp ProccessInput
proc Delay
	;0.1 seconds wait
	pusha
	mov ah, 86h 
	mov cx,1h
	mov dx,05500h
	int 15h
	popa
	ret
endp Delay
proc Receiver
	;read keyboard
	in al,60h
	mov ah, al
	and al, 07fh
	ret
endp Receiver
proc Pixel
	;enter colour index to specific index on the screen
	;screen position is given by ax - line, bx - column 
	pusha
	mov si, cx
    mov cx, 320
    mul cx               
    add ax, bx           
    mov di, ax
	mov cx, si
    mov [es:di], cl      
	popa
  	ret
endp Pixel

proc Pixel2
	;enter colour index to specific index on the screen
	;screen position is given by ax - line * line size, bx - column 
	pusha              
    add ax, bx           
    mov di, ax
	mov cl, [byte ptr si]
    mov [es:di], cl      
	popa
  	ret
endp Pixel2
	
proc CleaningLastRoundData 
	;restoring original data before starting a new stage
	mov cx,10
	xor si,si
	CleanningShots:
	mov [ShotsColumn+si],0
	mov [ShotsLine+si],0
	add si,2
	loop CleanningShots
	mov cx,6
	xor si,si
	CleanningOdds:
	mov [Row1Enemies+si],1
	mov [Row3Enemies+si],1
	add si,2
	loop CleanningOdds
	mov cx,5
	xor si,si
	CleanningEven:
	mov [Row2Enemies+si],1
	mov [Row4Enemies+si],1
	add si,2
	loop CleanningEven
	mov [EnemyShipPositionC1],30
	mov [EnemyShipPositionL1],20
	mov [EnemyShipPositionL2],0
	mov [EnemyShipPositionL3],0
	mov [EnemyShipPositionL4],0
	mov [EnemyShipDirection],1
	mov [RoundState],1
	mov [RoundIntroC],131
	mov [RoundIntroL],0
	mov [LastLineLose], 140
	mov [LeftBorder], 0
	mov [RightBorder], 318
	ret
endp CleaningLastRoundData

proc Borders
	pusha
	mov cx, 5 ;checking 5 ships at each row 
	xor si, si	;si representing each enemy ship in a row
	mov dx, -22 ;offset to move to left border
StartLeftBorder:
	mov ax,[Row1Enemies+si]	;check if specific enemy ship row 1 exist
	cmp ax,0
	jne CheckRightBorder	;if ship exist no need to move the border
	mov bx,[Rows3Inside]	;checking if row 3 is inside the round
	cmp bx,1
	jne ContLeftBorder1	;if row 3 isn't in the round there is no need to check it
	mov ax,[Row3Enemies+si]	;check if specific enemy ship row 3 exist
	cmp ax,0
	jne CheckRightBorder	;if ship exist no need to move the border
ContLeftBorder1:
	mov [LeftBorder],dx	;if the last ships in row 1 (and in row 3 if inside the level)
	sub dx, 23			; got destroyed then we need to add offset for the next column
	mov ax,[Row2Enemies+si]	;check if specific enemy ship row 2 exist
	cmp ax,0
	jne CheckRightBorder	;if ship exist no need to move the border
	mov bx,[Rows4Inside]	;checking if row 4 is inside the round
	cmp bx,1
	jne ContLeftBorder2	;if row 4 isn't in the round there is no need to check it
	mov ax,[Row4Enemies+si]	;check if specific enemy ship row 4 exist
	cmp ax,0
	jne CheckRightBorder	;if ship exist no need to move the border
ContLeftBorder2:
	mov [LeftBorder],dx	;update left border
	add si, 2	;go to next column
	sub dx, 22	;set offset lower for next column
	loop StartLeftBorder
	mov ax,[Row1Enemies+si]	;checking the sixth ship in row 1 (for left border)
	cmp ax,0
	jne CheckRightBorder	;if ship exist no need to move the border
	mov bx,[Rows3Inside]	;checking if row 3 is inside the round
	cmp bx,1
	jne ContLeftBorder3	;if row 3 isn't in the round there is no need to check it
	mov ax,[Row3Enemies+si]	;checking the sixth ship in row 3
	cmp ax,0
	jne CheckRightBorder	;if ship exist no need to move the border
ContLeftBorder3:
	mov [LeftBorder],dx	;update left border
CheckRightBorder:
	mov si, 10	;checking the sixth ship in row 1 (for right border)
	mov dx, 340	;the right border if the rightmost ships got destroyed
	mov ax,[Row1Enemies+si]	;check if specific enemy ship row 1 exist
	cmp ax,0                  
	jne FinishCheck	;if ship exist no need to move the border
	mov bx,[Rows3Inside]	;checking if row 3 is inside the round
	cmp bx,1
	jne ContRightBorder1	;if row 3 isn't in the round there is no need to check it
	mov ax,[Row3Enemies+si]	;check if specific enemy ship row 3 exist
	cmp ax,0
	jne FinishCheck	;if ship exist no need to move the border
ContRightBorder1:
	mov [RightBorder],dx	;update right border 
	mov cx, 5	;checking 5 ships at each row 
	sub si, 2	;checking the next column
	add dx, 23	;set offset higher for next column
StartRightBorder:
	mov ax,[Row2Enemies+si]	;check if specific enemy ship row 2 exist
	cmp ax,0               
	jne FinishCheck        ;if ship exist no need to move the border
	mov bx,[Rows4Inside]   ;checking if row 4 is inside the round
	cmp bx,1
	jne ContRightBorder2	;if row 4 isn't in the round there is no need to check it
	mov ax,[Row4Enemies+si]	;check if specific enemy ship row 4 exist
	cmp ax,0                
	jne FinishCheck	;if ship exist no need to move the border
ContRightBorder2:
	mov [RightBorder],dx	;update right border
	add dx, 22	;set offset higher for next column
	mov ax,[Row1Enemies+si]	;check if specific enemy ship row 1 exist
	cmp ax,0
	jne FinishCheck	;if ship exist no need to move the border
	mov bx,[Rows3Inside]   ;checking if row 3 is inside the round
	cmp bx,1               
	jne ContRightBorder3   ;if row 3 isn't in the round there is no need to check it
	mov ax,[Row3Enemies+si]	;check if specific enemy ship row 3 exist
	cmp ax,0
	jne FinishCheck	;if ship exist no need to move the border
ContRightBorder3:
	mov [RightBorder],dx	;update right border
	sub si, 2	;checking the next column
	add dx, 23	;set offset higher for next column
	loop StartRightBorder
FinishCheck:
	popa
	ret
endp Borders

proc GetRandom
	; Random number is based on looking at current time
	; Number of milliseconds of current time is our random number
	; This random number is cut according to upper limit given in bx (power of 2 minus 1)
	call ReadClock
	xor dx, dx
	mov dl, [TimeNowMSeconds]
	and dx, bx
	mov [RandomResult], dx
endp GetRandom

proc ReadClock
	;reads the current time and save all it's components in data
	pusha
	mov ax, 2c00h
	int 21h
	mov [TimeNowHours], ch
	mov [TimeNowMinutes], cl
	mov [TimeNowSeconds], dh
	mov [TimeNowMSeconds], dl
	popa
	ret
endp ReadClock

proc Check4SecDelay
	pusha
	call ReadClock ;reading the current time
	mov [Time4SecResult], 0
	mov ch, [TimeNowMinutes]	;loading the current minutes
	mov cl, [Time4SecMinutes]	;loading when the delay should end in minutes
	mov bh, [TimeNowSeconds]	;loading the current seconds
	mov bl, [Time4SecSeconds]	;loading when the delay should end in seconds
	cmp bh, bl	;checking if the delay is over in seconds
	jl Not4SecDelay
	cmp ch, cl	;checking if the delay is over in minutes
	jne Not4SecDelay
	mov [Time4SecResult], 1	;if the delay is over, raise the flag
	mov [Delay4Allow], 1	;if the delay is over, reset the delay usability
Not4SecDelay:
	popa
	ret
endp Check4SecDelay

proc Set4SecDelay
	pusha
	call ReadClock	;reading the current time
	mov bh, [TimeNowHours]	;loading the current hours
	mov [Time4SecHours], bh	;saving it for delay check
	mov bh, [TimeNowMinutes]	;loading the current minutes
	mov [Time4SecMinutes], bh   ;saving it for delay check
	mov bh, [TimeNowSeconds]	;loading the current minutes
	add bh, 4	;add 4 seconds for when the delay will be over
	cmp bh, 60	;checking if it will be in the next minute (bigger then 60)
	jl Save4SecDelay1	;jump if less then 60
	;if the time is over a minutes (for example 62 seconds),
	;update it to increase the minute and change the seconds as well
	sub bh, 60	
	mov bl, [Time4SecMinutes]
	inc bl
	cmp bl, 60	;checking if it will be in the next hour (bigger then 60)
	jl Save4SecDelay2	;jump if less then 60
	;if the time is over a minutes (for example 60 minutes),
	;update it to increase the minute and change the seconds as well
	sub bl, 60
	mov ah, [Time4SecHours]
	inc ah
	mov [Time4SecHours], ah		;update the hour in which the delay will be over
Save4SecDelay2:
	mov [Time4SecMinutes], bl	;update the minute in which the delay will be over
Save4SecDelay1:
	mov [Time4SecSeconds], bh	;update the seconds in which the delay will be over
	mov [Delay4Allow], 0	;set the delay is being used
	popa
	ret
endp Set4SecDelay

proc Check1SecDelay
	pusha
	call ReadClock ;reading the current time
	mov [Time1SecResult], 0
	mov ch, [TimeNowMinutes]	;loading the current minutes
	mov cl, [Time1SecMinutes]	;loading when the delay should end in minutes
	mov bh, [TimeNowSeconds]	;loading the current seconds
	mov bl, [Time1SecSeconds]	;loading when the delay should end in seconds
	cmp bh, bl	;checking if the delay is over in seconds
	jl Not1SecDelay
	cmp ch, cl	;checking if the delay is over in minutes
	jne Not1SecDelay
	mov [Time1SecResult], 1	;if the delay is over, raise the flag
	mov [Delay1Allow], 1	;if the delay is over, reset the delay usability
Not1SecDelay:
	popa
	ret
endp Check1SecDelay

proc Set1SecDelay
	pusha
	call ReadClock	;reading the current time
	mov bh, [TimeNowHours]		;loading the current hours
	mov [Time1SecHours], bh		;saving it for delay check
	mov bh, [TimeNowMinutes]	;loading the current minutes
	mov [Time1SecMinutes], bh	;saving it for delay check
	mov bh, [TimeNowSeconds]  	;loading the current minutes
	add bh, 1	;add 1 seconds for when the delay will be over
	cmp bh, 60	;checking if it will be in the next minute (bigger then 60)
	jl Save1SecDelay1	;jump if less then 60
	;if the time is over a minutes (for example 62 seconds),
	;update it to increase the minute and change the seconds as well
	sub bh, 60
	mov bl, [Time1SecMinutes]
	inc bl
	cmp bl, 60	;checking if it will be in the next hour (bigger then 60)
	jl Save1SecDelay2	;jump if less then 60
	;if the time is over a minutes (for example 60 minutes),
	;update it to increase the minute and change the seconds as well
	sub bl, 60
	mov ah, [Time1SecHours]
	inc ah
	mov [Time1SecHours], ah		;update the hour in which the delay will be over
Save1SecDelay2:                 
	mov [Time1SecMinutes], bl   ;update the minute in which the delay will be over
Save1SecDelay1:                 
	mov [Time1SecSeconds], bh   ;update the seconds in which the delay will be over
	mov [Delay1Allow], 0	;set the delay is being used
	popa
	ret
endp Set1SecDelay
proc Check2SecDelay
	pusha
	call ReadClock ;reading the current time
	mov [Time2SecResult], 0
	mov ch, [TimeNowMinutes]  ;loading the current minutes
	mov cl, [Time2SecMinutes] ;loading when the delay should end in minutes
	mov bh, [TimeNowSeconds]  ;loading the current seconds
	mov bl, [Time2SecSeconds] ;loading when the delay should end in seconds
	cmp bh, bl	;checking if the delay is over in seconds
	jl Not2SecDelay
	cmp ch, cl	;checking if the delay is over in minutes
	jne Not2SecDelay
	mov [Time2SecResult], 1	;if the delay is over, raise the flag
	mov [Delay2Allow], 1	;if the delay is over, reset the delay usability
Not2SecDelay:
	popa
	ret
endp Check2SecDelay

proc Set2SecDelay
	pusha
	call ReadClock	;reading the current time
	mov bh, [TimeNowHours]		;loading the current hours
	mov [Time2SecHours], bh	    ;saving it for delay check
	mov bh, [TimeNowMinutes]    ;loading the current minutes
	mov [Time2SecMinutes], bh   ;saving it for delay check
	mov bh, [TimeNowSeconds]	;loading the current minutes
	add bh, 2	;add 2 seconds for when the delay will be over
	cmp bh, 60  ;checking if it will be in the next minute (bigger then 60)
	jl Save2SecDelay1	;jump if less then 60
	;if the time is over a minutes (for example 62 seconds),
	;update it to increase the minute and change the seconds as well
	sub bh, 60
	mov bl, [Time2SecMinutes]
	inc bl
	cmp bl, 60	;checking if it will be in the next hour (bigger then 60)
	jl Save2SecDelay2	;jump if less then 60
	;if the time is over a minutes (for example 60 minutes),
	;update it to increase the minute and change the seconds as well
	sub bl, 60
	mov ah, [Time2SecHours]
	inc ah
	mov [Time2SecHours], ah		;update the hour in which the delay will be over
Save2SecDelay2:                 
	mov [Time2SecMinutes], bl   ;update the minute in which the delay will be over
Save2SecDelay1:                 
	mov [Time2SecSeconds], bh   ;update the seconds in which the delay will be over
	mov [Delay2Allow], 0	;set the delay is being used
	popa
	ret
endp Set2SecDelay

proc LoadFile
	;dx points at the name of the file to be opened
	pusha
	mov     ax,3d00h	;open the file
	int     21h
	jc      LoadFinish	;if couldn't open the file, exiting the proc

	mov     bx, ax
	lea     dx, [BufferTransfer]	;where to load the file   
	mov     ah,3fh
	mov     cx,0FFFFh	;set max buffer to read    
	int     21h			;load the file
	
	mov     ah,3eh	;close the file
	int     21h           
	
	cld
LoadFinish:
    popa
    ret
endp LoadFile

proc SetColorTable
	;set colour table to format RRRGGGBB
	mov cx, 8
	xor bx, bx
	xor bp, bp
	xor ax, ax
	mov dx, 3c8h
	out dx, al
	inc dx
loopR:
	push cx
	mov cx, 8
	xor bp, bp
loopG:
	push cx
	mov cx, 4
	xor si, si
loopB:
	mov ax, bx
	out dx, al
	mov ax, bp
	out dx, al
	mov ax, si
	out dx, al
	add si, 21
	loop loopB
	pop cx
	add bp, 9
	loop loopG
	pop cx
	add bx, 9
	loop loopR
	mov ax, 255
	mov dx, 3c8h
	out dx, al
	inc dx
	mov ax, 63
	out dx, al
	out dx, al
	out dx, al
	ret
endp SetColorTable
