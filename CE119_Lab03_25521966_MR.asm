.data
n_val:      .word 20
str_f1:     .asciiz "F("
str_f2:     .asciiz ") = "

.text
.globl main
main:
        la    $t0, n_val
        lw    $s0, 0($t0)
        move  $a0, $s0
        jal   fib_opt
        move  $s1, $v0

        li    $v0, 4
        la    $a0, str_f1
        syscall
        li    $v0, 1
        move  $a0, $s0
        syscall
        li    $v0, 4
        la    $a0, str_f2
        syscall
        li    $v0, 1
        move  $a0, $s1
        syscall

        li    $v0, 10
        syscall

fib_opt:
        slti  $t0, $a0, 2       
        beq   $t0, $zero, fo_rec
        move  $v0, $a0         
        jr    $ra

fo_rec:
        addi  $sp, $sp, -12    
        sw    $ra, 8($sp)
        sw    $s0, 4($sp)
        sw    $s1, 0($sp)

        move  $s0, $a0
        addi  $a0, $s0, -1
        jal   fib_opt
        move  $s1, $v0

        addi  $a0, $s0, -2
        jal   fib_opt
        add   $v0, $s1, $v0

        lw    $s1, 0($sp)
        lw    $s0, 4($sp)
        lw    $ra, 8($sp)
        addi  $sp, $sp, 12
        jr    $ra