// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

// product <- R2
// inc <- R0
// count <- R1
// 
// # SWAP INC & COUNT
// # if R1 > R0:
// #    inc <- R1
// #    count <- R0
//
// for i in count:
//     product <- product + inc

@R2
M=0 // R2 <- 0

@i
M=0 // i <- 0

(LOOP)
    @i
    D=M // Data <- i
    @R1
    D=M-D // Data <- R1 (count) - Data (i)
    @END
    D;JEQ // Goto END if Data = 0 (Goto END if i = count)

    @R0
    D=M // Data <- R0 (inc)
    @R2
    M=M+D // R2 <- R2 + Data (inc)

    @i
    M=M+1 // i <- i + 1

    @LOOP
    0;JMP // Goto LOOP

(END)
    @END
    0;JMP
