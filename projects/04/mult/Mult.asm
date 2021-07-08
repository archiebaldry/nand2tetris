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

// Load R1 into temp
@R1
D=M // Data <- R1
@temp
M=D // temp <- Data (R1)

// if R1 > R0 ___ if (R1 - R0) > 0 then
//     set R1 to R0
//     set R0 to temp (R1)
@R0
D=D-M // Data <- Data (R1) - R0
@SWAP
D;JGT // Goto SWAP if Data > 0

(LOOP)
    @i
    D=M // Data <- i
    @R1
    D=M-D // Data <- R1 (count) - Data (i)
    @END
    D;JEQ // Goto END if Data = 0 ___ Goto END if i = count

    @R0
    D=M // Data <- R0 (inc)
    @R2
    M=M+D // R2 <- R2 + Data (inc)

    @i
    M=M+1 // i <- i + 1

    @LOOP
    0;JMP // Goto LOOP

(SWAP)
    @R0
    D=M // Data <- R0
    @R1
    M=D // R1 <- Data (R0)
    @temp
    D=M // Data <- temp
    @R0
    M=D // R0 <- Data (temp)
    @LOOP
    0;JMP // Goto LOOP

(END)
    @END
    0;JMP
