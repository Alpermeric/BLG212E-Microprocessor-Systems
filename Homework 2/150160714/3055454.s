;Alper Meriç
;150160714
;Microprocessor Homework2
;recursive factorial function

Index		EQU		 6
Array_Size  EQU 	(Index+1)*4

			AREA     NEW_ARRAY,DATA, READWRITE		
				ALIGN
__Array_Start
Array_Mem       SPACE    Array_Size	 	; Allocate #Array_Size byte area from memory
__Array_End

			AREA alper, code, readonly
			ENTRY
			THUMB
			ALIGN 
__main		FUNCTION
			EXPORT __main
			MOVS r4,#Index				; n value for factorial operation
			MOVS r0,#0					; R1=i firstly i=0
			LDR  r5,=Array_Mem			; Load start address of allocated space for array
			MOVS R6, #0					; Get start adress
Loop1		CMP	 r0,r4					; check i<index state
			BGT  stop
			push {r0,LR}
			BL	factorial				; call factorial for n
			ADDS r0, r0, #1
			pop {r2}
			str r2,[r5,r6]
			adds r6,r6,#4
			B Loop1 
			
stop		B stop						; Infinite loop
			ENDFUNC


			ALIGN
factorial	FUNCTION
			POP{R1}			; R1=i
			MOV R3,LR		; r3 is return adress
			CMP R1,#1 		; if n>1 recursively call
			BLE LessEqual	; go to less equal
			SUBS R2,R1,#1	; otherwise, calculate factorial(n-1)
			PUSH {R3}		; store return adress
			PUSH {R1}		; push n 
			PUSH {R2}		; push n-1 (Parameter of Factorial)
			BL factorial	; call factorial function for n-1
			POP {R1}		; return value of Factorial(n-2)
			POP {R2}		; value of Factorial(n-1) 
			POP {R3}		;	return adress
			MULS r2, r1, r2	; Factorial(n) = N * fibonacci(n-1)
			b	return		; jump store operation 
LessEqual  	MOVS R2, #1		; if n<=2 then factorial(n) =2
return		PUSH {R2}		; store return value of factorial(n)
			BX	R3			; return
			ENDFUNC
			END