.extern numbers

.data

fizz: .ascii "Fizz"
buzz: .ascii "Buzz"
line: .byte 0x0a

.text

.globl _start
_start:
    mov x19, 1
_loop:
    mov w20, 0

    mov w1, 3
    udiv w0, w19, w1
    msub w0, w0, w1, w19
    cbnz w0, _skip_fizz

    ldr x1, =fizz
    mov x2, 4
    mov x0, 1
    mov w8, 64
    svc 0

    mov w20, 1
_skip_fizz:
    mov w1, 5
    udiv w0, w19, w1
    msub w0, w0, w1, w19
    cbnz w0, _skip_buzz

    ldr x1, =buzz
    mov x2, 4
    mov x0, 1
    mov w8, 64
    svc 0

    mov w20, 1
_skip_buzz:
    cbnz w20, _skip_num

    mov x3, 3
    mul x2, x19, x3
    ldr x3, =numbers
    add x1, x2, x3
    mov x2, 3
    mov x0, 1
    mov w8, 64
    svc 0
_skip_num:
    ldr x1, =line
    mov x2, 1
    mov x0, 1
    mov w8, 64
    svc 0

    add w19, w19, 1
    cmp w19, 100
    b.ls _loop
_end:
    mov x0, 0
    mov w8, 93
    svc 0
