# i: $t0
# lista: $t1
# lista + i: $t2
	.data
	.eqv SIZE, 5
str1:	.asciiz "\nIntroduza um numero: "
	.align 2
lista: 	.space 20
	.eqv read_int, 5
	.eqv print_string, 4
	.text
	.globl main
main:	ori $t0, $0, 0			# i = 0;
while: 	bge $t0, SIZE, endw		# if(i => SIZE) goto endw
	la $a0, str1			# print_string(str1)
	ori $v0, $0, print_string	# print_string(str1)
	syscall				# print_string(str1)
	ori $v0, $0, read_int		# read_int()
	syscall				# read_int()
	la $t1, lista			# $t1 = lista
	sll $t2, $t0, 2
	addu $t2, $t1, $t2		# $t2 = $t1 + 4*i
	sw $v0, 0($t2)			# lista[i] = read_int();
	addi $t0, $t0, 1		# i++;
	j while				# }
endw:	jr $ra