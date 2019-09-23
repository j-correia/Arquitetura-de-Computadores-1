# Mapa da registos:
# $t0 - value
# $t1 - bit
# $t2 - i
# $t3 - flag
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binário é: "
	.eqv print_string, 4
	.eqv print_int, 1
	.eqv print_char, 11
	.eqv read_int, 5
	.text
	.globl main
main:	la $a0, str1		# print_string(str1)
	li $v0, print_string
	syscall
	li $v0, read_int	# value=read_int()
	syscall
	or $t0, $v0, $zero
	la $a0, str2		# print_string(str2)
	li $v0, print_string
	syscall
	li $t2, 0		# int i = 0;
do:	
rem:	rem $t4, $t2, 4		# if((i%4) == 0)
	bnez $t4, erem
	beqz $t2, erem
	beqz $t3, erem
	li $a0, ' '		# print_char(' ')
	li $v0, print_char
	syscall
erem:	andi $t1, $t0, 0x80000000 # virtual
	srl $t1, $t1, 31
	addi $t4, $t1, 0x30
if1:	beq $t4, 0x31, eif1
	beqz $t3, eif2
eif1:	li $t3, 1
	or $a0, $0, $t4
	li $v0, print_char
	syscall 
eif2:	sll $t0, $t0, 1		# value = value << 1
	addi $t2, $t2, 1	# i++	
while:	blt $t2, 32, do		# while(i<32)
	jr $ra
