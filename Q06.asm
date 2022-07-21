.data
	dividendo: .word -5
	divisor: .word -2
	result: .word 0
	remainder: .word 0

.text
	# carrega os valores de dividendo em $s0 e de divisor em $s1
	la $t0, dividendo
	lw $s0, 0($t0)
	la $t0, divisor
	lw $s1, 0($t0)
	bltz $s0, DivLess # caso o dividendo seja negativo vai direto para onde será feita a divisão com dividendo negativo
DivGreater: # divisão com dividendo positivos
	bltz $s1, DivGreaterL # caso o divisor for negativo vai para a divisão com divisor negativo, porém dividendo positivo
	sub $s0, $s0, $s1
	addi $s2, $s2, 1
	bgtz $s0, DivGreater # caso ainda seja possivel subtrair o divisor do dividendo ele volta para subtrair novamente
	subi $s2, $s2, 1
	add $s3, $s0, $s1
	j Save 
DivGreaterL: # divisão com dividendo positivos, porém divisor negativo
	add $s0, $s0, $s1
	subi $s2, $s2, 1
	bgtz $s0, DivGreaterL
	addi $s2, $s2, 1
	sub $s3, $s0, $s1
	j Save
DivLess: # divisão com dividendo negativo
	bltz $s1, DivLessL # caso o divisor for negativo vai para a divisão com dividendo e divisor negativo
	add $s0, $s0, $s1
	subi $s2, $s2, 1
	bltz $s0, DivLessL
	addi $s2, $s2, 1
	sub $s3, $s0, $s1
DivLessL: # divisão com dividendo e divisor negativos
	sub $s0, $s0, $s1
	addi $s2, $s2, 1
	bltz $s0, DivLessL
	subi $s2, $s2, 1
	add $s3, $s0, $s1
Save: # salva na memória
	la $t0, result
	sw $s2, 0($t0)
	la $t0, remainder
	sw $s3, 0($t0)