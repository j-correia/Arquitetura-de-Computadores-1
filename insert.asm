# Função terminal
# *array:	$a0
# value:	$a1
# pos:		$a2
# size:		$a3
	.data
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv read_int, 5
	.text
	.globl insert
insert:	sll $a2, $a2, 2		# $a2 = $a2 *4
	sll $a3, $a3, 2		# $a3 = $a2 *4
if:	ble $a2, $a3, else	# if( pos <= size ) goto else
	ori $v0, $0, 1		# return 1;
	j efor
else:	addu $t0, $a3, -4	# i = size-1
	addu $t0, $a0, $t0
	addu $t1, $t0, 4	# i+1;
	addu $a2, $a2, $a0
for:	blt $t0, $a2, efor
	lw $t2, 0($t0)
	sw $t2, 0($t1)
	addi $t0, $t0, -4	# i--
	j for
efor:	sw $a1, 0($a2)
	ori $v0, $0, 0		# return 0;
	jr $ra
