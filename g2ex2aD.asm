	.data
	.eqv bin, 0x5
	.text
	.globl main
main:	li $t0, bin		# Load do bin para $t0
	srl $t2, $t0, 1		# $t2 = $t1 >> 1
	xor $t1, $t2, $t0	# gray = $t0 ^ $t2
	jr $ra			# Termina o programa
