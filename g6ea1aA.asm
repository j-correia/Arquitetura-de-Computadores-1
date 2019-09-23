	.data
str1:	.asciiz ", "
	.align 2
str2:	.space 40
	.eqv size, 10
	.eqv print_int10, 1
	.eqv print_string, 4
	.text
	.globl main
main:	subu $sp, $sp, 4
	sw $ra, 0($sp)
	la $a0, str2
	ori $a1, $0, 66
	ori $a2, $0, 0
	ori $a3, $0, size
	jal insert
	or $a0, $0, $v0
	ori $v0, $0, print_int10
	syscall
	ori $a0, $0, '\n'
	ori $v0, $0, 11
	syscall
	la $a0, str2
	ori $a1, $0, size
	jal print_array
	lw $ra, 0($sp)
	addu $sp, $sp, 4
	jr $ra
	
# Função terminal
# *array:	$a0
# value:	$a1
# pos:		$a2
# size:		$a3
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

# Função terminal
# *a:		$a0 -- *array
# n:		$a1 -- size
print_array:
	or $t0, $0, $a0
	sll $a1, $a1, 2		# $a1 = $a1 *4
	addu $t1, $t0, $a1	# p = a + n;
for2:	bge $t0, $t1, efor2
	lw $a0, 0($t0)
	ori $v0, $0, print_int10
	syscall
	la $a0, str1
	ori $v0, $0, print_string
	syscall
	addu $t0, $t0, 4
	j for2
efor2:	jr $ra
