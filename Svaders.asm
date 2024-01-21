.286
IDEAL
MODEL small
STACK 100h

include "datall.asm"
CODESEG

include "Ships.asm"
include "Misc.asm"
include "UserShip.asm"
include "Shotting.asm"
include "Stage1.asm"
include "Stage2.asm"
include "ERows.asm"
include "Stage3.asm"
include "Stage4.asm"
include "Stage5.asm"
start:
	mov ax, @data ;set data segment pointer
	mov ds, ax
	mov ax, 013h	;set graphic mode,clears the screen and restore standard colour table        
	int 010h
	mov ax, 0A000h ;set screen buffer position
	mov es, ax
	call StartScreen ;drawing the start screen
	WaitStart:
	mov ah, 1 ;waiting for the player to press a button to proceed
	int 16h
	jz WaitStart
	call GameRun ;starts the game

exit:
	mov cx,010h
	mov ah,0ch	;cleans the keyboard buffer
	mov al,0
	int 21h
	ThisISTheEnd:
	mov ah, 1	;waiting for the player to press a button to proceed
	int 16h
	jz ThisISTheEnd
	srslyExit:
	mov ax, 03h	;back to text mode before exit
	int 010h
	mov ax, 4c00h	;exit
	int 21h
proc GameRun
	mov ax, 013h	;set graphic mode,clears the screen and restore standard colour table                   
	int 010h
	call Stage1Intro	;shows stage 1 intro
	call CleaningLastRoundData	;restoring original data before next stage
	mov ax, 013h 	;set graphic mode,clears the screen and restore standard colour table                 
	int 010h
	call Stage1 ;play stage 1
	mov ax, [RoundState]	;check lose\win
	cmp ax, 0
	jne ShowLooseMiddle
	call CleaningLastRoundData	;restoring original data before next stage
	mov ax, 013h  	;set graphic mode,clears the screen and restore standard colour table                
	int 010h
	call Stage2Intro	;shows stage 2 intro
	call CleaningLastRoundData	;restoring original data before next stage
	mov ax, 013h 	;set graphic mode,clears the screen and restore standard colour table                 
	int 010h
	call Stage2	;play stage 2
	mov ax, [RoundState]	;check lose\win
	cmp ax, 0
	jne ShowLooseMiddle
	call CleaningLastRoundData	;restoring original data before next stage
	mov ax, 013h 	;set graphic mode,clears the screen and restore standard colour table                 
	int 010h
	call Stage3Intro	;shows stage 3 intro
	call CleaningLastRoundData	;restoring original data before next stage
	mov ax, 013h 	;set graphic mode,clears the screen and restore standard colour table                 
	int 010h
	call Stage3	;play stage 3
	mov ax, [RoundState]	;check lose\win
	cmp ax, 0
ShowLooseMiddle:	;help for too far jumps	
	jne ShowLoose
	call CleaningLastRoundData	;restoring original data before next stage
	mov ax, 013h  	;set graphic mode,clears the screen and restore standard colour table                
	int 010h
	call Stage4Intro	;shows stage 4 intro
	call CleaningLastRoundData	;restoring original data before next stage
	mov ax, 013h  	;set graphic mode,clears the screen and restore standard colour table                
	int 010h
	call Stage4	;play stage 4
	mov ax, [RoundState]	;check lose\win
	cmp ax, 0
	jne ShowLoose
	call CleaningLastRoundData	;restoring original data before next stage
	mov ax, 013h 	;set graphic mode,clears the screen and restore standard colour table                 
	int 010h
	call Stage5Intro	;shows stage 5 intro
	call CleaningLastRoundData	;restoring original data before next stage
	mov ax, 013h 	;set graphic mode,clears the screen and restore standard colour table                 
	int 010h
	call Stage5	;play stage 5
	mov ax, [RoundState]	;check lose\win
	cmp ax, 0
	jne ShowLoose
	call CleaningLastRoundData	;restoring original data before next stage
	mov ax, 013h  	;set graphic mode,clears the screen and restore standard colour table                
	int 010h
	mov ah,0ch	;cleans the keyboard buffer
	mov al,0	
	int 21h
	call WinScreen	;shows win screen
WaitWin:
	mov ah, 1	;waiting for the player to press a button to proceed
	int 16h
	jz WaitWin
	mov ax, 013h 	;set graphic mode,clears the screen and restore standard colour table                 
	int 010h
	call EndCredit	;shows credits
	jmp srslyExit	;exit the game
ShowLoose:	
	mov ax, 013h  	;set graphic mode,clears the screen and restore standard colour table                
	int 010h
	call GameOverSkeleton	;shows game over skeleton (PlayerCollision screen)
	ret
endp GameRun
END start

