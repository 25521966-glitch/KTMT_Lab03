
.data
t1:         .asciiz "kien truc may tinh"
t2:         .asciiz "mips"
t3:         .asciiz ""
t4:         .asciiz "a bc def"
t5:         .asciiz "de quy can ngan xep de nho trang thai"
bar:        .asciiz "|"
nl:         .asciiz "\n"

.text
.globl main
main:
        la    $a0, t1
        jal   run_test
        la    $a0, t2
        jal   run_test
        la    $a0, t3
        jal   run_test
        la    $a0, t4
        jal   run_test
        la    $a0, t5
        jal   run_test
        li    $v0, 10
        syscall

run_test:
        addi  $sp, $sp, -8
        sw    $ra, 4($sp)
        sw    $s0, 0($sp)

        move  $s0, $a0
        jal   reverse_words

        li    $v0, 4
        la    $a0, bar
        syscall
        move  $a0, $s0
        syscall
        la    $a0, bar
        syscall
        la    $a0, nl
        syscall

        lw    $s0, 0($sp)
        lw    $ra, 4($sp)
        addi  $sp, $sp, 8
        jr    $ra

strlen:
        move  $t0, $a0
        move  $v0, $zero
sl_loop:
        lbu   $t1, 0($t0)
        beq   $t1, $zero, sl_done
        addiu $v0, $v0, 1
        addiu $t0, $t0, 1
        j     sl_loop
sl_done:
        jr    $ra

rev_range:
rr_loop:
        sltu  $t0, $a0, $a1     
        beq   $t0, $zero, rr_done
        lbu   $t0, 0($a0)
        lbu   $t1, 0($a1)
        sb    $t1, 0($a0)
        sb    $t0, 0($a1)
        addiu $a0, $a0, 1
        addiu $a1, $a1, -1
        j     rr_loop
rr_done:
        jr    $ra

reverse_words:
        addi  $sp, $sp, -20     
        sw    $ra, 16($sp)
        sw    $s0, 12($sp)
        sw    $s1, 8($sp)
        sw    $s2, 4($sp)
        sw    $s3, 0($sp)

        move  $s0, $a0          
        jal   strlen            
        beq   $v0, $zero, rw_done

        addu  $s1, $s0, $v0
        addiu $s1, $s1, -1      

        move  $a0, $s0
        move  $a1, $s1
        jal   rev_range

        move  $s2, $s0          
        move  $s3, $s0         

rw_scan:
        sltu  $t0, $s1, $s3     
        bne   $t0, $zero, rw_last_word

        lbu   $t1, 0($s3)
        li    $t2, 32           
        beq   $t1, $t2, rw_found_space

        addiu $s3, $s3, 1
        j     rw_scan

rw_found_space:
        move  $a0, $s2
        addiu $a1, $s3, -1      
        jal   rev_range

        addiu $s3, $s3, 1       
        move  $s2, $s3         
        j     rw_scan

rw_last_word:
        move  $a0, $s2
        move  $a1, $s1          
        jal   rev_range

rw_done:
        lw    $s3, 0($sp)      
        lw    $s2, 4($sp)
        lw    $s1, 8($sp)
        lw    $s0, 12($sp)
        lw    $ra, 16($sp)
        addi  $sp, $sp, 20      
        jr    $ra