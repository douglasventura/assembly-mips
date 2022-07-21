li $s0, 2

li $v0, 5
syscall

li $v1, 1

li $s2, 1

add $s1, $v0, $zero

INICIO: beqz $s1, FIM
sll $v1, $v1, 1
sub $s1, $s1, $s2
j INICIO

FIM: li $v0, 17
syscall