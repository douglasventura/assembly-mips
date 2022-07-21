.data
	str: .asciiz "EntradA"

.text
	li $s0, 0   # i iterator
	li $t0, 'A'
	li $t1, 'Z'
	li $t2, 'a'
	li $t3, 'z'

loop1:
	lb $s1, str($s0)       # ch = str[i]
	beq $s1, $zero, exit1  # if ch == '\0': break
	
	sge $t4, $s1, $t0 # ch >= 'A'
	sle $t5, $s1, $t1 # ch <= 'Z'
	and $t4, $t4, $t5 # is ch uppercase?
	
	sge $t5, $s1, $t2 # ch >= 'a'
	sle $t6, $s1, $t3 # ch <= 'z'
	and $t5, $t5, $t6 # is ch lowercase?
	
	or $t6, $t4, $t5      # is ch a letter?
	beq $t6, $zero, error
	
	beq $t5, $zero, else1 # if ch is lowercase:
	addi $s1, $s1, -32     # ch -= 32
	sb $s1, str($s0)

else1:
	addi $s0, $s0, 1     # i++
	j loop1

error:
	li $v1, 1
	j exit3
	
exit1:
	li $s0, 1 # i iterator
	li $s4, 0 # any swaps in this pass?

loop2:
	lb $s1, str($s0)
	beq $s1, $zero, exit2 # ch1 = str[i]
	subi $s2, $s0, 1      # j = i - 1
	lb $s3, str($s2)      # ch2 = str[j]
	bge $s3, $s1, else2   # swap is not necessary if the pair is in non-increasing order
	ori $s4, $s4, 1       # at least one swap in this pass
	move $t0, $s1
	move $s1, $s3
	move $s3, $t0         # swapping $s1 and $s3
	sb $s1, str($s0)      # update str[i]
	sb $s3, str($s2)      # update str[j]
	
else2:
	addi $s0, $s0, 1     # i++
	j loop2
	
exit2:
	bne $s4, $zero, exit1 # already sorted if no swaps occured
	
exit3: