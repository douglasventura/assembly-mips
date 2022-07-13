.data
	prompt: .asciiz "Valor de a (inteiro):"
	result_perfect_square: .word -1
	result_not_perfect: .word -1
.text
	# prompt no terminal
	li $v0, 4
	la $a0, prompt
	syscall
	
	# lendo o valor de a como inteiro da entrada
	li $v0, 5
	syscall
	move $s1, $v0 # salvando a constante a no registrador $s1
	
	li $s2, 100 # constante 100 no registrador s2
	li $s3, 10  # constante 10 no registrador s3
	li $t1, 0   # valor de b no registrador t1 (inicializado com 0)
	
	# checando 0 <= a && a <= 100
	blt $s1, $zero, Exit
	bgt $s1, $s2, Exit
	
	li $t2, 0 # valor de i no registrador t2 (inicializado com 0)
	
For:
	# condição
	beq $t2, $s3, ForExit
	# passo
	mult $t2, $t2
	mflo $t3 # registrador $t3 recebe i*i
	bne $t3, $s1, ForIncrement
	li $t1, 1 # b = 1
	sw $s1, result_perfect_square
	j ForExit
ForIncrement:
	addi $t2, $t2, 1
	j For
ForExit:
	bne $t1, $zero, Exit
	sw $s1, result_not_perfect
Exit:
	li $v0, 10
	syscall