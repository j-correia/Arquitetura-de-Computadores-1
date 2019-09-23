# Mapa de Registos

# size-1	$t1
# *p:		$t2
# *(p + 1):	$t3
# houve_troca:	$t4
# aux:		$t5
# p:		$t6
# pUltimo:	$t7
# lista: 	$
	.data
	.eqv false, 0
	.eqv true, 1
	.eqv size, 10
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv print_int10, 1
str1:	.asciiz "\nInsira um número: "
str2:	.asciiz "; "
	.align 4
lista:	.space 40			# SIZE*4
	.text
	.globl main
main:	ori $t1, $0, size		# int size;
	sll $t1, $t1, 2			# size = size*4
	la $t6, lista			# addr 1º elemento lista
	add $t2, $t1, $t6		# lista+size
	ori $t1, $0, size		# int size;
	sll $t1, $t1, 2			# size = size*4
	addi $t1, $t1, -4		# size = size-1
read:	bge $t6, $t2, eread
	add $t6, $t6, $t5		# addr = 1º elemento + i
	la $a0, str1			# print_string(str1)
	ori $v0, $0, print_string	# print_string(str1)
	syscall 			# print_string(str1)
	ori $v0, $0, read_int		# read_int()
	syscall				# read_int()
	sw $v0, 0($t6)			# 0(addr) = read_int()
	addi $t6, $t6, 4		# addr = addr+4		
	j read
eread:
# Mapa Revisto
# $t0:		p
# $t1:		pUltimo
# $t2:		*p
# $t3:		*(p + 1)
# $t4:		houve_troca
# $t5:		aux
# $t6:		size
# $t7:		size-1
	ori $t6, $0, size		# size
	addi $t7, $t6, -1		# (size-1) *4
	sll $t7, $t7, 2
	la $t0, lista			# p = lista
	add $t1, $t0, $t7		# pUltimo = lista + ( size - 1)
do:	ori $t4, $0, false		# houve_troca = false
	la $t0, lista			# p = lista
for:	bgeu $t0, $t1, efor		# if ($t0 => $t1) goto efor
if:	lw $t2, 0($t0)
	lw $t3, 4($t0)
	bleu $t2, $t3, eif
	sw $t2, 4($t0)
	sw $t3, 0($t0)
	ori $t4, $0, true
eif:	addi $t0, $t0, 4
	j for				# }
efor:					# 
edo:	beq $t4, true, do
	jr $ra
