.data 
	message1: .asciiz "Digite um numero a: "
  	message2: .asciiz "Digite outro numero b: "	

.text
__start:	
	li $v0, 4
	la $a0, message1
	syscall
	
	li $v0, 5
	syscall
  	move $a2, $v0

	li $v0, 4
	la $a0, message2
	syscall
	
	li $v0, 5
	syscall
  	move $a3, $v0
  	
  	jal sum
  	li, $v0, 1
  	move $a0, $v1
  	syscall
  	
  	li, $v0, 10
  	syscall
  	
sum:	addi $sp, $sp, -4
  	sw $ra, 0($sp)
  	
  	slt $t0, $a3, $a2
	bne $t0, $zero, a_bg_b
	
	beq $a2, $a3, a_eq_b
	
	add $t1, $t1, $a3
	addi $a3, $a3, -1
	jal sum
	
	j cleanup
  	
a_bg_b:	li $t1, 1
	j finish
	
a_eq_b: add $t1, $t1, $a3
	j finish
	
finish: move $v1, $t1
	j cleanup
	
cleanup:lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra