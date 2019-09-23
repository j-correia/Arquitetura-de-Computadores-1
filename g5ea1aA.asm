# Mapa de Registos
# i:		$t0
# j:		$t1
# lista:	$t2
# lista[i]:	$t3
# lista[j]:	$t4
# aux:		$t5
# v_i:		$t6
# size:		$t7
# size - 1:	$t8
# v_j:		$t9

	.data
	.eqv size, 10
	.align 2
lista:	.space 40
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv print_int10, 1
str1:	.asciiz "\nInsira um número: "
str2:	.asciiz "; "
str3:	.asciiz "\n"
	.text
	.globl main
main:	ori $t0, $0, 0			# int i = 0;
	ori $t7, $0, size		# size
	sll $t7, $t7, 2			# 4*size
	addi $t8, $t7, -4		# 4*(size - 1)
	la $t2, lista			# $t2 = lista
read:	bge $t0, $t7, eread		# if( i => size-1) goto eread
	addu $t3, $t2, $t0		# lista[i] = lista + i
	la $a0, str1			# print_string(str1)
	ori $v0, $0, print_string	# print_string(str1)
	syscall				# print_string(str1)
	ori $v0, $0, read_int		# read_int()
	syscall				# read_int()
	sw $v0, 0($t3)			# lista[i] = read_int()
	addu $t0, $t0, 4		# i++;	
	j read				# }
eread:	ori $t0, $0, 0			# i = 0;
	la $a0, str3			# print_string(str3)
	ori $v0, $0, print_string	# print_string(str3)
	syscall				# print_string(str3)
	la $t2, lista			# $t2 = lista
for1:	bge $t0, $t8, efor1		# if (i => (size-1)) goto efor1
	addi $t1, $t0, 4		# j = i + 1
for2:	bge $t1, $t7, efor2		# if (j => size) goto efor2
	addu $t3, $t2, $t0		# lista[i] = lista + i
	addu $t4, $t2, $t1		# lista[j] = lista + j
	lw $t6, 0($t3)			# $t6 = lista[i]
	lw $t9, 0($t4)			# $t9 = lista[j]
if:	ble $t6, $t9, eif		# if( $t6 <= $t9) goto eif
	lw $t5,	0($t3)			# 
	sw $t9, 0($t3)			# 
	sw $t5, 0($t4)			#
eif:	addu $t1, $t1, 4		# j++;
	j for2				# }
efor2:	addu $t0, $t0, 4		# i++:
	j for1				# }
efor1:	ori $t0, $0, 0			# int i = 0;
	ori $t7, $0, size		# size
	sll $t7, $t7, 2			# 4*size
	addi $t8, $t7, -4		# 4*(size - 1)
	la $t2, lista			# $t2 = lista
print:	bge $t0, $t7, eprint		# if (i => size-1) goto eprint
	addu $t3, $t2, $t0		# lista[i] = lista + i
	la $a0, str2			# print_str(str2)
	ori $v0, $0, print_string	# print_str(str2)
	syscall				# print_string(str2)
	lw $a0, 0($t3)			# print_int10( lista[i])
	ori $v0, $0, print_int10	# print_int10( lista[i])
	syscall				# print_int10( lista[i])
	addu $t0, $t0, 4		# i++:
	j print				# }
eprint:

	jr $ra