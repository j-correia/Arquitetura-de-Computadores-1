	.data
	.text
	.globl main
main:	li $t0, 0x862A5C1B	# Instrução virtual
	sll $t2, $t0, 4		#
	srl $t3, $t0, 4		#
	sra $t4, $t0, 4		#
	jr $ra			# Fim do programa
