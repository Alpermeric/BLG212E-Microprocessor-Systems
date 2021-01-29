;Alper Meriç
;150160714
;Microprocessor Homework2
;Sieve of Eratosthenes Algorithm

Limit			EQU		 120
Array_Size  	EQU 	(Limit+1)*4
	
				AREA     NEW_ARRAY,DATA, READWRITE		
				ALIGN
__Array_Start
primeNumbers    SPACE    Array_Size	 	; Allocate #Array_Size byte area from memory
isPrimeNumber   SPACE    Array_Size	 	; Allocate #Array_Size byte area from memory
__Array_End

						AREA alper, code,  readonly
						ENTRY
						THUMB
						ALIGN 
__main					FUNCTION
						EXPORT __main
						movs r0,#Limit									; Limit Value
						ldr r5,=primeNumbers							; Load primeNumbers[0]
						ldr r6,=isPrimeNumber							; Load isPrimeNumber[0]
						push{r0,r5,r6}
						bl sieveOfEratosthenes							; call sieveOfEratosthenes factorial
						ENDFUNC

						ALIGN
sieveOfEratosthenes		FUNCTION
						pop{r2,r3,r4}									;r4=isPrimeNumber  r3=primeNumbers r2=limit
						movs r7,#0										; for 0 value
						movs r0,#1										; for true
						movs r1,#0										; i=0
firstLoop				cmp  r1,r2										;check i<limit
						bgt secondLoop
						strh r7, [r3]
						strh r0, [r4]
						ADDS r4, r4, #4 								; Address increase
						ADDS r3, r3, #4 								; Address increase
						ADDS r1, r1, #1 								; Index increase
						b   firstLoop
secondLoop						
						BX	LR										; return main function
						ENDFUNC

						END
			