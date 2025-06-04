# Introduction
This repo documents my practice of both verilog and using an FPGA. For this purpose I'm using Verilog HDL and implementing my setup on the SiSpeed Tang Nano 9.

# The FPGA
## Basics
The Tang Nano 9k is a pretty well documented, basic FPGA board that I was able to find for pretty cheap. The complete specs are available at https://wiki.sipeed.com/hardware/en/tang/Tang-Nano-9K/Nano-9K.html, but overall it ends up being a pretty neat little peice of hardware for dev.

## The Programmer
I'm using the bundled GoWin programmer. The site seems a bit sketchy but the software unpacks and seems clean. Set up on windows it runs smoothly, but the process to compile and flash a file to the FPGA is a little long. Grug Huler has an excellent video series on YouTube that I'm going to be referencing for setup.

The software uses Verilog HDL directly, so there's no need to learn a new HDL language, but given that this is my first time using a HDL at all, I began with the basics using HDLBits. Surprisingly worked well, and once you get the hang of wires, assignments and registers you're pretty much good to go.

One thing to look out for though is the module definition and everything else. Sometimes a module may not be detected if incorrectly designed. 

## Projects
### The LED Counter
I used the 6 onboard LEDs (connected to pins 10, 11, 13, 14, 15 and 16) to create a running pattern. This was pretty much my first experience using the GoWin programmer as well as using a HDL at all.  
