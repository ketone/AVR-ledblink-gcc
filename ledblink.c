#include <avr/io.h>
#include <util/delay.h>



int main(void)
{
   

    DDRD = 1 << PIND7; //define the pin as output
    while (1)
    {
        _delay_ms(1000);     //execute delay 1s
 
        PORTD ^= 1 << PIND7; // toggle the output pin

    }
}
