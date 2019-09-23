# Função strcpy
strcpy:	ori $t0, $0, 0
do:	lw $t1, 0($a1)
	sw $t1, 0($a0)
	addu $a0, $a0, 1
	addu $a1, $a1, 1
	lw $t2, 0($a1)
	bne $t2, '\n', do
	jr $ra