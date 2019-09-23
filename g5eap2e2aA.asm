# Mapa de Registos
# array:	$t0
# p:		$t1
# *p:		$t2
# pultimo:	$t3
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
main:	la $t1, array
	ori $t3, $0, size
	sll $t3, $t3, 2
	addu $t3, $t1, $t3
for:	bge $t1, $t3, efor
	lw $a0, 0($t1)
	ori $v0, $0, print_string
	syscall
	or $a0, $0, '\n'
	ori $v0, $0, print_char
	syscall
	addu $t1, $t1, 4
	j for
efor:	jr $ra