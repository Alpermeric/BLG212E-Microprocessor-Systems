;Alper Meriç
;150160714
;Microprocessor Homework2
;iterative factorial function

Index		EQU		 6
Array_Size  EQU 	(Index+1)*4

			AREA     NEW_ARRAY,DATA, READWRITE		
			ALIGN
__Array_Start
Array_Mem       SPACE    Array_Size	 	; Allocate #Array_Size byte area from memory
__Array_End

			AREA alper, code,  readonly
			ENTRY
			THUMB
			ALIGN 
__main		FUNCTION
			EXPORT __main
			ldr r5,=Array_Mem							; Load Array[0]
			movs r0,#Index								; n
			push {r5,r0,LR}								; push (Array, n , return_adress)
			bl factorial								; call fib factorial
stop		B stop										; Infinite loop
			ENDFUNC

			ALIGN 
factorial 	FUNCTION
			pop {r3,r4}  								; r3= Array, r4= n
			movs r1,#0									; for if counter=1,result 1
start_fac	cmp r1,#1									; if i<=1  then go to LessEQ 
			BLE LessEQ									; Otherwise continue			
			adds r7, r4, #-4 							; R7 use to get before data. We cannot use negative value for LDRH 
			LDRH r6, [r7,#0] 							; r6= Array[i-1]
			MULS r6, r1, r6								; r2 = i* Array[i-1]
			MOVS r2,r6
			B	NotLessEQ								; Skip LessEQ part
LessEQ		movs r2, #1									; if i<=1 then Array[i]=1			
NotLessEQ	STRH r2, [r4,#0] 								; Store calculated value
			ADDS r4, r4, #4 							; Address increase
			ADDS r1, r1, #1 							; Index increase
			CMP r1,r3									; if i<=n
			BLE start_fac								; then continue
			BX	LR										; return main function
			ENDFUNC

			END
			