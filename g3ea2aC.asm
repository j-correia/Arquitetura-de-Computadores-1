# Mapa da registos:
# $t0 - res
# $t1 - i
# $t2 - mdor
# $t3 - mdo
# $t4 - temp
	.data
str1:	.asciiz "Introduza dois numeros: "
str2:	.asciiz "Resultado: "
	.eqv print_string,4
	.eqv read_int,5
	.eqv print_int10,1
	.text
	.globl main
main:	ori $t0, $0, 0			# unsigned int res = 0
	ori $t1, $0, 0			# unsigned int i = 0
	la $a0, str1			# print_string(str1)
	ori $v0, $0, print_string	# print_string(str1)
	syscall				# print_string(str1)
	ori $v0, $0, read_int		# mdor = read_int()
	syscall				# mdor = read_int()
	andi $t2, $v0, 0xFFFF		# mdor = $v0 & 0x0F
	ori $v0, $0, read_int		# mdo = read_int()
	syscall				# mdo = read_int()
	andi $t3, $v0, 0xFFFF		# mdo = $v0 & 0x0F
while:	beq $t2, 0, endw		# if( mdor == 0)-> endw
	bge $t1, 16, endw		# if( i >= 4)-> endw
	addi $t1, $t1, 1		# i++
if:	andi $t4, $t2, 0x00000001	# (mdor & 0x00000001)
	beq $t4, 0, eif			# if(temp = 0)-> eif
	add $t0, $t0, $t3		# res = res + mdo
eif:	sll $t3, $t3, 1			# mdo = mdo << 1 
	srl $t2, $t2, 1			# mdor = mdor >> 1
	j while				# }
endw:	addi $t1, $t1, 1		# i++
	la $a0, str2			# print_string(str2)
	ori $v0, $0, print_string	# print_string(str2)
	syscall				# print_string(str2)
	ori $v0, $0, print_int10	# print_int10(res)
	or $a0, $0, $t0			# print_int10(res)
	syscall				# print_int10(res)
	jr $ra				# End Program Here
