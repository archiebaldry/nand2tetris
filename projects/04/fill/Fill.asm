// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

@last
M=0 // last = 0

(INPUT)
    @SCREEN
    D=A // Data = 16384
    @i
    M=D // i = Data
    @KBD
    D=M // Data = Keyboard
    @PRECLEAR
    D;JEQ // Jump to PRECLEAR if Data == 0
    @KBD
    D=M // Data = Keyboard
    @last
    M=D // last = Data
    @FILL
    0;JMP // Jump to FILL

(PRECLEAR)
    @last
    D=M // Data = last
    @KBD
    D=D+M // Data += Keyboard
    @INPUT
    D;JEQ // Jump to INPUT if Data == 0
    @CLEAR
    0;JMP // Jump to CLEAR

(CLEAR)
    @i
    A=M // Address = i
    M=0 // @i = 0000000000000000 (2's complement)
    @i
    M=M+1 // i += 1
    D=M // Data = i
    @KBD
    D=D-A // Data -= 24576 
    @INPUT
    D;JEQ // Jump to INPUT if Data == 0
    @CLEAR
    0;JMP // Jump to CLEAR

(FILL)
    @i
    A=M // Address = i
    M=-1 // @i = 1111111111111111 (2's complement)
    @i
    M=M+1 // i += 1
    D=M // Data = i
    @KBD
    D=D-A // Data -= 24576 
    @INPUT
    D;JEQ // Jump to INPUT if Data == 0
    @FILL
    0;JMP // Jump to FILL
