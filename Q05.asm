.data
	msg1: .asciiz "Digite o primeiro lado do triangulo: "
	msg2: .asciiz "Digite o segundo lado do triangulo: "
	msg3: .asciiz "Digite o terceiro lado do triangulo: "
	
	notTri: .asciiz "not"
	eq: .asciiz "eq"
	iso: .asciiz "iso"
	esc: .asciiz "esc"
		
.text 	
	# input 1st number 
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0 		# save input in $s0
	
	# input 2nd number
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 5
	syscall
	
	move $s1, $v0 		# save input in $s1
	
	# input 3th number
	li $v0, 4
	la $a0, msg3
	syscall
	
	li $v0, 5
	syscall
	
	move $s2, $v0 		# save input in $s2
	
	add $t0, $s0, $s1 	# a + b
	add $t1, $s0, $s2 	# a + c
	add $t2, $s1, $s2 	# b + c
	
	bge $s2, $t0 Not 	# c >= a + b
	bge $s1, $t1 Not 	# b >= a + c
	bge $s0, $t2 Not 	# a >= b + c
	
	beq $s0, $s1, Eq	# if a == b
	beq $s1, $s2, Iso	# if b == c
	beq $s0, $s2, Iso	# if a == c
	
	Esc:	la $s3, esc	# store string 'esc' in $s3
		j Print
	
	Eq: 	bne $s1, $s2, Iso
		la $s3, eq	# store string 'eq' in $s3
		j Print
	
	Iso: 	la $s3, iso	# store string 'iso' in $s3
		j Print
	
	Not: 	la $s3, notTri	# store string 'not' in $s3
	
	Print:	li $v0, 4
		move $a0, $s3
		syscall
	
	exit:	li $v0, 10
		syscall