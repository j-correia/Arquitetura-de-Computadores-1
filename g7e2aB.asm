# Mapa de Registos
# str:		$s0
# val:		$s1
# main é intermédia
	.data
	.align 2
str:	.space 33
	.eqv STR_MAX_SIZE, 33
	.eqv read_int, 5
	.eqv print_str, 4
	.text
	.globl main
main:	subu $sp, $sp, 12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
do:				# do{
	ori $v0, $0, read_int	# $s1 = read_int();
	syscall			# $s1 = read_int();
	or $s1, $0, $v0		# $s1 = read_int();
	or $a0, $0, $s1		# itoa(val, 2, str);
	ori $a1, $0, 2		# itoa(val, 2, str);
	la $a2, str		# itoa(val, 2, str);
	jal itoa		# itoa(val, 2, str);
	or $a0, $0, $v0		# print_str( itoa(val, 2, str));
	ori $v0, $0, print_str	# print_str( itoa(val, 2, str));
	syscall			# print_str( itoa(val, 2, str));
	or $a0, $0, $s1		# itoa(val, 8, str);
	ori $a1, $0, 8		# itoa(val, 8, str);
	la $a2, str		# itoa(val, 8, str);
	jal itoa		# itoa(val, 8, str);
	or $a0, $0, $v0		# print_str( itoa(val, 8, str));
	ori $v0, $0, print_str	# print_str( itoa(val, 8, str));
	syscall			# print_str( itoa(val, 8, str));
	or $a0, $0, $s1		# itoa(val, 16, str);
	ori $a1, $0, 16		# itoa(val, 16, str);
	la $a2, str		# itoa(val, 16, str);
	jal itoa		# itoa(val, 16, str);
	or $a0, $0, $v0		# print_str( itoa(val, 16, str));
	ori $v0, $0, print_str	# print_str( itoa(val, 16, str));
	syscall			# print_str( itoa(val, 16, str));
	bne $s1, '0', do	# } while( n != 0
	ori $v0, $0, 0		# return 0;
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addu $sp, $sp, 12