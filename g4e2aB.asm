# TESTAR COM A STRING "AC1-2017"
# Mapa de Registos
# $t0 -> num
# $t1 -> p
# $t2 -> *p
	.data
str:	.space 20
	.eqv read_string, 8		# $a0 == char; $a1 == length
	.eqv SIZE, 20			# SIZE array
	.eqv print_int10, 1		#
	.text
	.globl main
main:	la $a0, str			# read_string()
	ori $a1, $0, SIZE		# read_string()
	ori $v0, $0, read_string	# read_string()
	syscall				# read_int()
	ori $t0, $0, 0			# int num = 0;
	la $t1, str			# $t1 = str;
while:	lb $t2, 0($t1)			# $t2 = *p;
	beq $t2, '\0', endw		# if( $t2 == '\0') goto endw
if:	blt $t2, '0', endi		# if( $t2 < 0) goto endi
	bgt $t2, '9', endi		# if( $t2 > 9) goto endi
	addi $t0, $t0, 1		# num++;
endi:	addiu $t1, $t1, 1		# p++;
	j while				# }
endw:	ori $v0, $0, print_int10	# print_int10(num)
	or $a0, $0, $t0			# print_int10(num)
	syscall				# print_int10(num
	jr $ra