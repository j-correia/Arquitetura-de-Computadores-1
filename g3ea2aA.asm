# Mapa da registos:
# $t0 - res
# $t1 - i
# $t2 - mdor
# $t3 - mdo
	.data
str1:	.asciiz "Introduza dois numeros: "
str2:	.asciiz "Resultado: "
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_int10, 1
	.text
	.globl main
main:	ori $t0, $0, 0			# int res=0
	ori $t1, $0, 0			# int i = 0
	la $a0, str1			# print_string(str1)
	ori $v0, $0, print_string	# print_string(str1)
	syscall 			# print_string(str1)
	ori $v0, $0, read_int		# $v0 = read_int()
	syscall				# $v0 = read_int()
	andi $t2, $v0, 0x0F		# $t2 = read_int() & 0x0F
	ori $v0, $0, read_int		# $v0 = read_int()
	syscall				# $v0 = read_int()
	andi $t3, $v0, 0x0F		# $t3 = read_int() & 0x0F
while:	beq $t2, 0, endw		# while(mdor != 0)
	addi $t1, $t1, 1		# i++
	bge $t1, 4, endw		# while($t1 < 4)
	andi $t4, $t2, 0x00000001	# temp = mdor & 0x00000001
if:	beq $t4, $0, eif		# if( $t4 = 0) branch
	add $t0, $t0, $t3		# res = res + mdo
eif:	sll $t3, $t3, 1			# mdo = mdo << 1
	srl $t2, $t2, 1			# mdor = mdor >> 1
	j while
endw:	la $a0, str2			# print_string(Str2)
	ori $v0, $0, print_string	# print_string(Str2)
	syscall				# print_string(Str2)
	or $a0, $0, $t0			# print_int10(res)
	ori $v0, $0, print_int10	# print_int10(res)
	syscall				# print_int10(res)
	jr $ra 				# End Program Here
