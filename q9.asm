.data
input: .word 5 # input da torre

.text
lw $s2, input #input carregado em $s2
jal Hanoi
j printAndEnd #jump pra funçao printAndEnd que printa e finaliza

Hanoi:
addi $sp, $sp, -8 #separando dois espaços na pilha para salvar o endereco da chamada e nosso registrador $s2
sw $ra, 4($sp)
sw $s2, 0($sp)

beq $s2, 1, stackMp		        #beq para ver se entra no caso base

addi $s2, $s2, -1			#subtrai 1 do que está em s1
jal Hanoi                               #volta para funçao Hanoi
				  
lw $s2, 0($sp)				#carrega o endereço de chamada em s2
lw $ra, 4($sp)
addi $sp, $sp, 8
				  
sll  $v1, $v1, 1			#2 * f(n-1)+1			
addi $v1, $v1, 1			
jr $ra					#retornando ao ultimo endereco de chamada
stackMp:
addi $sp, $sp, 8
add $v1, $v1, $s2 #adiciona 1 no $v1
jr $ra

printAndEnd: #printa o valor de $v1 e finaliza
add $s1, $v1, $zero
li $v0, 1
move $a0, $s1
syscall
li $v0, 10
syscall
