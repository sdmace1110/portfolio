; File name: Lab1.asm
; Course name: CSCI3160
; Author: Shawn Mace
; Date: January 17, 2019
; Read two integers from user and display the sum
; input: two integers
; output: sum of the two integers

; Assembler directives
.586 				;accept instructions for 586
.MODEL FLAT 		;generate code for flat memory
INCLUDE io.h 		;header file for input/output
.STACK  4096 		;reserve 4096-byte stack 

.DATA 			; Data section begins here: reserve storage for data
prompt 			BYTE    	"N","u","m","b","e","r","?", 0 	; Prompts string to be input to a message box
asciiInNum		BYTE    	20 DUP (?)						; ACSII input for an integer
outMsgLabel		BYTE  		"The sum is", 0					; String to be displayed in ouput message box
asciiOutSum    	BYTE    	11 DUP (?), 0					; ASCII code/bytes for sum to be displayed
int1 			DWORD   	?								; first 32-bit integer
int2 			DWORD   	?								; second 32-bit integer
sum				DWORD		?								; 32 bit integer sum

.CODE			; Code section begins here 
_MainProc		PROC										; main procedure starts here
        		;read ASCII input for first number, convert to 2's comp, and store in memory
				input   	prompt, asciiInNum, 20			; Prompt for, read, and stor ASCII characters
        		atod    	asciiInNum 						; Converts ASCII to 2's compliment and store in EAX
        		mov     	int1, eax    					; store 2's compliment into memory

        		;read ASCII input for second number, convert to 2's comp, and store in memory
        		input   	prompt, asciiInNum, 20			; Prompt for, read, and store ASCII characters
        		atod    	asciiInNum        				; Convert ASCII to 2's comp and store in EAX
				mov     	int2, eax						; Stores 2's comp in memory
				
				;add the two integers and store sum (2's comp) in memory   
        		mov     	eax, int1    					; Copy first integer to EAX
        		add     	eax, int2    					; Add second integer
        		mov			sum, eax						; Store sum (2's comp) in memory
				
				;convert 2's comp to ASCII and display result
				dtoa    	asciiOutSum, sum       			; Converts 2's Comp to ASCII and store in memory
        		output  	outMsgLabel, asciiOutSum		; Output label string and sum string

        		mov     	eax, 0  						; exit with return code 0
        		ret
_MainProc 		ENDP										; end of main procedure
				END                             			; end of source code
