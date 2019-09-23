# Mapa de registos
# p: 		$t0
# *p:		$t1
# lista+SIZE:	$t2
	.data
str1: 	.asciiz "\nConteudo do array:\n"
str2:	.asciiz "; "
lista:	.word	8,-4,3,5,123,-15,87,0,27,15
	.align 	2
	.eqv 	print_int10, 1
	.eqv 	print_string, 4
	.eqv	SIZE, 10		# define SIZE 10
	.text
	.globl main
main:	la $a0, str1			# print_string(str1)
	ori $v0, $0, print_string	# print_string(str1)
	syscall				# print_string(str1)
	la $t0, lista			# p = lista
	ori $t2, $0, SIZE		# $t2 = lista + SIZE;
	sll $t2, $t2, 2			# $t2 = lista + SIZE;
	addu $t2, $t2, $t0		# $t2 = lista + SIZE;
while:	bgeu $t0, $t2, endw		# if($t0 => $t2) goto endw
	lw $t1, 0($t0)			# $t1 = *p
	or $a0, $0, $t1			# print_int10( *p);
	ori $v0, $0, print_int10	# print_int10( *p);
	syscall				# print_int10( *p);
	la $a0, str2			# print_string(str2);
	ori $v0, $0, print_string	# print_string(str2);
	syscall
	addu $t0, $t0, 4		# p++;
	j while
endw:	jr $ra