# Mapa da registos:
# $t0 - value
# $t1 - bit
# $t2 - i
# $t3 - temp
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
for1:	bge $t2, 32, efor1	# while(i<32){
rem:	rem $t3, $t2, 4		# if((i%4) == 0)
	bnez $t3, erem
	beqz $t2, erem
	li $a0, ' '		# print_char(' ')
	li $v0, print_char
	syscall
erem:	andi $t1, $t0, 0x80000000 # virtual
	srl $t1, $t1, 31	# bit = bit >> 31
	addi $t3, $t1, 0x30	# temp = bit + 0x30
	or $a0, $0, $t3		# print_char(temp)
	li $v0, print_char
	syscall 
	sll $t0, $t0, 1		# value = value << 1
	addi $t2, $t2, 1	# i++
	j for1			# }	
efor1:	jr $ra
