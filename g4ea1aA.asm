# Mapa de Registos
# $t0 -> p
# $t1 -> *p
# $t2 -> temp
	.data
str1:	.space 20
	.eqv read_string, 8		# $a0 == char; $a1 == length
	.eqv SIZE, 20			# SIZE array
	.eqv print_string, 4		# $a0 => address
str2:	.asciiz "Introduza uma string: "
	.text
	.globl main
main:	la $a0, str2			# print_string(str2)
	ori $v0, $0, print_string	# print_string(str2)
	syscall				# print_string(str2)

	la $a0, str1			# str1 = read_string()
	ori $a1, $0, SIZE		# str1 = read_string()
	ori $v0, $0, read_string	# str1 = read_string()
	syscall				# str1 = read_string()

	la $t0, str1			# p = str;
while:	lb $t1, 0($t0)			# $t1 = *p
	beq $t1, '\0', endw		# if( *p == '\0') goto endw
	blt $t1, 'a', keep		# if( *p == 'a') goto keep
	bgt $t1, 'z', keep		# if( *p == 'z') goto keep
	subiu $t1, $t1, 0x20		# *p = *p - 0x20 // 0x61-0x41
	sb $t1, 0($t0)			# *p = *p - 0x20 // 0x61-0x41
keep:	addi $t0, $t0, 1		# p++;
	j while				# }
endw:	la $a0, str1			# print_string(str1)
	ori $v0, $0, print_string	# print_string(str1)
	syscall				# print_string(str1)
	jr $ra
