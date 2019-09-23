# Mapa de Registos
# p:		$t0
# size-1	$t1
# lista+SIZE:	$t2
# aux:		$t3
# houve_troca:	$t4
# i:		$t5
# lista:	$t6
# lista+i:	$t7
# lista[i+1]:	$t8
# lista[i]:	$t9
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
eread:	la $t6, lista			# $t6 = lista
do:					# do{
	ori $t4, $0, false		# houve_troca = false
	ori $t5, $0, 0			# i = 0
	la $t6, lista			# $t6 = lista
while: 	bge $t5, 9, endw		# if( $t5 => $t1) goto endw {
if:	sll $t7, $t5, 2			# $t7 = 4*i{
	addu $t7, $t7, $t6		# $t7 = &lista[i]
	lw $t8, 0($t7)			# $t8 = lista[i]
	lw $t9, 4($t7)			# $t9 = lista[i]
	ble $t8, $t9, eif		# if( $t8 <= $t9) goto eif
	sw $t8, 4($t7)			# lista[i+1] = $t8
	sw $t9, 0($t7)			# lista[i] = $t9
	ori $t4, $0, true		# houve_troca = true
eif:					# }
	addi $t5, $t5, 1		# i++; 
	j while
endw:					# }
	beq $t4, true, do		# } if( $t4 == true) goto do
edo:	jr $ra
