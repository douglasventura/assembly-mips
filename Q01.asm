.data 
	message: .asciiz "Digite um numero: "	

.text 
	# print message to user
	li $v0, 4
	la $a0, message
	syscall
	
	# getting user input
	li $v0, 5
	syscall
	
	bne $v0, 42, ElseIf 		# check if regs $v0(input) is not equal 42 
	li $s0, 1 			# write 1 on regs $s0
	j PrintAnswer 			# jump to PrintAnswer
		
	ElseIf: bgt $v0, 42, Else 	# check if regs $v0(input) if greater than 42
		li $s0, 2		# write 2 on regs $s0
		j PrintAnswer		# jump to PrintAnswer
		
	Else: li $s0, 3 		# write 3 on regs $s0
		
	PrintAnswer:
		li $v0, 1
		add $a0, $zero, $s0
		syscall
	
	# exit	
	li $v0, 10
	syscall
