# Função terminal
# *a:		$a0 -- *array
# n:		$a1 -- size
	.data
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv read_int, 5
str1:	.asciiz ", "
	.text
	.globl print_array
print_array:
	or $t0, $0, $a0
	sll $a1, $a1, 2		# $a1 = $a1 *4
	addu $t1, $t0, $a1	# p = a + n;
for:	bge $t0, $t1, efor
	lw $a0, 0($t0)
	ori $v0, $0, print_int10
	syscall
	la $a0, str1
	ori $v0, $0, print_string
	syscall
	addu $t0, $t0, 4
	j for
efor:	jr $ra
