# Mapa de Registos
# array:		$t0
# i:			$t1
# array + i:		$t2
# array[i]:		$t3
	.data
array:	.word	str1,str2,str3
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv size, 3
	.text
	.globl main
main:	la $t0, array		# $t0 = &(array[0]);
	ori $t1, $0, 0		# int i = 0;
for:	bge $t1, size, efor	# if ($t1 => size) goto efor
	sll $t2, $t1, 2		# +*4
	addu $t2, $t2, $t0	# $t2 = i*4 + &(array[0])
	lw $a0, 0($t2)
	ori $v0, $0, print_string
	syscall
	or $a0, $0, '\n'
	ori $v0, $0, print_char
	syscall
	addu $t1, $t1, 1	# i++;
	j for
efor:	jr $ra