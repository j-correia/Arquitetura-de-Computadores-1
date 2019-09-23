# argumento passado em $a0
# resultado devolvido em $v0
# sub~rotina terminal: não se usam $sX
	#.data
	#.text
	#.globl strlen
strlen: ori $t1, $0, 0		# len = 0
while:	lb $t0, 0($a0)		# while(*s++ != '\0')
	addiu $a0, $a0, 1
	beq $t0, '\0', endw
	addi $t1, $t1, 1	# len++
	j while
endw:	or $v0, $0, $t1		# return len;
	jr $ra			# é terminal, logo não salvaguardo $ra
