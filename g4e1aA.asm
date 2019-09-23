# Mapa de Registos
# $t0 -> num
# $t1 -> i
# $t2 -> endereço inicial string	str
# $t3 -> endereço posição i string	str+i
# $t4 -> conteúdo posição i string	str[i]
	.data
str:	.space 20
	.eqv read_string, 8		# $a0 == char; $a1 == length
	.eqv SIZE, 20			# SIZE array
	.eqv print_int10, 1		#
	.text
	.globl main
main:	la $a0, str			# endereço inicial
	ori $a1, $0, SIZE		# tamanho alocado
	ori $v0, $0, read_string	# read_string()
	syscall				# read_string()
	ori $t0, $0, 0			# int num = 0;
	ori $t1, $0, 0			# int i = 0;
while:	la $t2, str			# $t2 = endereço inicial
	add $t3, $t2, $t1		# $t3 = $t2 + $t1
	lb $t4, 0($t3)			# $t4 = str[$t3]
	beq $t4, '\0', endw		# if($t4 = '\0') goto endw
if:	blt $t4, '0', endi		# if($t4 < '0' goto endi
	bgt $t4, '9', endi		# if($t4 > '9' goto endi
	addi $t0, $t0, 1		# num++;
endi:	addi $t1, $t1, 1		# i++;
	j while				# }
endw:	ori $v0, $0, print_int10	# print_int10(num)
	or $a0, $0, $t0			# print_int10(num)
	syscall				# print_int10(num)
	jr $ra
