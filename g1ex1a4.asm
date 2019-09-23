	.data
	#.eqv val_x, -12
	.text
	.globl main
main:	ori $t0, $0, 3	# $t0=x
	ori $t2, $0, 8		# $t2=8
	add $t1, $t0, $t0	# $t1=$t0+$t0
	add $t1, $t1, $t2	#T $t1=$t1+$t2
	
	jr $ra