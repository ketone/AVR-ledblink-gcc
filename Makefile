#Main application file name
MAIN_APP = ledblink
TARGET	= avr

# The microcontroller
MCU = atmega328p
CLK = 16000000UL

# The name of the toolchain
CC	= avr-gcc
LINKER	= avr-gcc
OBJDUMP	= avr-objdump
OBJCOPY	= avr-objcopy
SIZE = avr-size

# optimisation
OPTI = -O

# parameters
CFLAGS = $(OPTI) -mmcu=$(MCU) -DF_CPU=$(CLK)

LFLAGS = $(CFLAGS) -Wl,-Map,$(MAIN_APP).map

HFLAGS = -j .text -j .data -O ihex

# Source files needed for building the application 
SRC = $(MAIN_APP).c


build: $(MAIN_APP).elf
	$(OBJCOPY) $(HFLAGS) $< $(MAIN_APP).hex
	$(OBJDUMP) -h -S $< > $(MAIN_APP).lst
	$(SIZE) $<

$(MAIN_APP).elf: $(MAIN_APP).o
	$(LINKER) $(LFLAGS)  -o $@ $<

$(MAIN_APP).o: $(SRC)
	$(CC) $(CFLAGS)  -c $< -o $@
		
rebuild: clean build

clean:
	rm *.o
	rm *.map
	rm *.elf	
	rm *.hex
	rm *.lst
