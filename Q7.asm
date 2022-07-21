.data
	input_array:
		.align 2
		.space 20
		
	output_array:
		.align 2
		.space 20
	
	is_prime:
		.align 0
		.space 101

.text
	## input_array = [2, 4, 7, 17, 25]
	
	# input_array[0] = 2
	li $t0, 2
	li $t1, 0
	sw $t0, input_array($t1)
	
	# input_array[1] = 4
	li $t0, 4
	addi $t1, $t1, 4
	sw $t0, input_array($t1)
	
	# input_array[2] = 7
	li $t0, 7
	addi $t1, $t1, 4
	sw $t0, input_array($t1)
	
	# input_array[3] = 17
	li $t0, 17
	addi $t1, $t1, 4
	sw $t0, input_array($t1)
	
	# input_array[4] = 25
	li $t0, 25
	addi $t1, $t1, 4
	sw $t0, input_array($t1)
	
	## Sieve of Eratosthenes Algorithm
	li $t0, 1
	sb $zero, is_prime($t0) # is_prime[1] = False
	
	li $s0, 2    # i = 2
	li $s1, 100  # n = 100
	
loop1:
	bgt $s0, $s1, exit1   # while (i <= n)
	sb $t0, is_prime($s0) # is_prime[i] = True
	addi $s0, $s0, 1      # i++
	j loop1
	
exit1:
	li $s0, 2    # i = 2 (until n)
	
loop2:
	bgt $s0, $s1, exit2   # while (i <= n)
	lb $t0, is_prime($s0)
	beq $t0, $zero, exit3 # if (is_prime[i])
	mul $s2, $s0, $s0     # j = i*i
	
loop3:
	bgt $s2, $s1, exit3     # while (j <= n)
	sb $zero, is_prime($s2) # is_prime[j] = False
	add $s2, $s2, $s0       # j += i
	j loop3

exit3:
	addi $s0, $s0, 1 # i++
	j loop2
	
exit2:
	li $s0, 0  # i = 0 (input_array iterator)
	li $s1, 20 # n = 5 (input_array size in bytes)
	li $s2, 0  # j = 0 (output_array iterator)
	
loop4:
	bge $s0, $s1, exit4       # while (i < n)
	lw $s3, input_array($s0)  # x = input_array[i] 
	lb $t0, is_prime($s3)
	beq $t0, $zero, else      # if (is_prime[x])
	sw $s3, output_array($s2) # output_array[j] = x
	addi $s2, $s2, 4          # j++
	
else:
	addi $s0, $s0, 4 # i++
	j loop4

exit4: