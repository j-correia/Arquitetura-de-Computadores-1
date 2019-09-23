# Mapa da Registos
# $t0 -> soma
# $t1 -> i
# $t2 -> array[pos+i]
# $t3 -> pos
# $t4 -> pos+i
	.data
array:	.word 7692,23,5,234
	.eqv print_int10, 1
	.eqv SIZE, 4
	.text
	.globl main
main:	ori $t0, $0, 0			# int soma = 0;
	ori $t1, $0, 0			# int i = 0;
	la $t3, array			# pos
while:	bgt $t1, 3, endw		# if( i >= 3) goto endw
	sll $t4, $t1, 2			# i*4
	add $t4, $t3, $t4		# pos+i
	lw $t2, 0($t4)			# array[pos+i]
	add $t0, $t0, $t2		# soma = soma + array[pos+i]
	addi $t1, $t1, 1		# i++
	j while
endw:	ori $v0, $0, print_int10	# print_int10(soma)
	or $a0, $0, $t2			# print_int10(soma)
	syscall				# print_int10(soma)
	jr $ra   