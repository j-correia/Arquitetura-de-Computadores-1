# Mapa da Registos
# $t0 -> p
# $t1 -> pultimo
# $t2 -> *p
# $t3 -> soma
# $ta -> temp
	.data
array:	.word 7692,23,5,234
	.eqv print_int10, 1
	.eqv SIZE, 4
	.text
	.globl main
main:	ori $t3, $0, 0			# int soma = 0;
	ori $t4, $0, SIZE		# $t4 = SIZE
	sub $t4, $t4, 1			# SIZE--
	sll $t4, $t4, 2			# multiplicar por 4
	la $t0, array			# $t0 = endereço array
	addu $t1, $t0, $t4		# pultimo = array + size - 1
while:	bgtu $t0, $t1, endw		# if( p > pultimo) goto endw
	lw $t2, 0($t0)			# $t2 = endereço 0 de $t0
	add $t3, $t3, $t2		# soma = soma + *p
	addu $t0, $t0, 4		# p++
	j while				# }
endw:	ori $v0, $0, print_int10	# print_int10(soma)
	or $a0, $0, $t3			# print_int10(soma)
	syscall				# print_int10(soma)
	jr $ra
