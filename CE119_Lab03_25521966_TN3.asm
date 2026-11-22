
.data
n_val:      .word 20            # Thay doi gia tri n tai day de do (10, 15, 17, 19, 20)
str_f1:     .asciiz "F("
str_f2:     .asciiz ") = "

.text
.globl main
main:
        la    $t0, n_val
        lw    $s0, 0($t0)       
        move  $a0, $s0
        jal   fib_rec           
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


fib_rec:
        addi  $sp, $sp, -12     
        sw    $ra, 8($sp)
        sw    $s0, 4($sp)
        sw    $s1, 0($sp)

        slti  $t0, $a0, 2       
        beq   $t0, $zero, fr_rec
        move  $v0, $a0          
        j     fr_done

fr_rec:
        move  $s0, $a0        
        addi  $a0, $s0, -1
        jal   fib_rec
        move  $s1, $v0          

        addi  $a0, $s0, -2
        jal   fib_rec           
        add   $v0, $s1, $v0     

fr_done:
        lw    $s1, 0($sp)       
        lw    $s0, 4($sp)
        lw    $ra, 8($sp)
        addi  $sp, $sp, 12      
        jr    $ra

fib_iter:
        move  $v0, $zero        
        li    $t0, 1            
        move  $t1, $zero        
fi_loop:
        slt   $t2, $t1, $a0
        beq   $t2, $zero, fi_done
        addu  $t3, $v0, $t0   
        move  $v0, $t0
        move  $t0, $t3
        addiu $t1, $t1, 1
        j     fi_loop
fi_done:
        jr    $ra