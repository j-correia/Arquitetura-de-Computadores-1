	.data
	.eqv gray, 0x7
	.text
	.globl main
main:	li $t0, gray		# Load do bin para $t0
	
	srl $t3, $t0, 4 	# Shift temporário
	xor $t1, $t0, $t3	
	
	srl $t3, $t1, 2
	xor $t1, $t1, $t3

	srl $t3, $t1, 1
	xor $t2, $t1, $t3	

	jr $ra			# Termina o programa
