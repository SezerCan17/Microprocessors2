bic.b #00001000b, &P1DIR ; make P1.3 input
bis.b #00000001b, &P2DIR ; make P2.0 output
bic.b #00001000b, &P1SEL ; make P1.3 Digital I/O
bic.b #00001000b, &P1SEL2 ; make P1.3 Digital I/O
bic.b #00000001b, &P2SEL ; make P2.0 Digital I/O
bic.b #00000001b, &P2SEL2 ; make P2.0 Digital I/O
bis.b #00001000b, &P1REN ; enable pull-up resistor for P1.3
bis.b #00001000b, &P1OUT ; enable pull-up resistor for P1.3
bis.w #GIE, SR ; enable interrupts
bis.b #00001000b, &P1IES ; p1.3 interrupts from H to L
bis.b #00001000b, &P1IE ; enable p1.3 interrupt
mloop:
add.w #3,r5 ; does not have any duties
jmp mloop ;go mloop
but_ISR:
xor.b #00000001b, &P2OUT ; if button pressed, switch P2.0 LED
bic.b #00001000b, &P1IFG ; clear IF for next interrupt
reti ; return from interrupt
bic.b #10000010b, &P1SEL ; make P1.1 and P1.7 Digital I/O
bic.b #10000010b, &P1SEL2 ; make P1.1 and P1.7Digital I/O
bic.b #10000000b, &P1DIR ; Make P1.7 input
bic.b #10000000b, &P1REN ; enable pull-up resistor for P1.7
bis.b #00000010b, &P1DIR ; make P1.1 output
bis.b #00000010b, &P1OUT ; make P1.1 high
mloop:
bit.b #10000000b, &P1IN ; bit test P1.7
jne turnoff
jmp on
turnoff:
bic.b #00000010b, &P1OUT ; turn off led
jmp mloop ;go mloop
on:
bis.b #00000010b, &P1OUT ; turn on led
jmp mloop ;go mloop