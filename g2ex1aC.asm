	.data
	.eqv val_1, 0xE543
	.text
	.globl main
main:	ori $t0, $0, val_1	# 
	nor $t1, $t0, $0	# $t1 = !$t0
	jr $ra			# Termina o programa
