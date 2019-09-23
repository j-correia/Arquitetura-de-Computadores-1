# Mapa de Registos
# array:	$t0
# p:		$t1
# *p:		$t2
# pultimo:	$t3
	.data
array:	.word	str1,str2,str3
str1:	.ascii "Array"
	.ascii "de"
	.asciiz "ponteiros"
str2:	.asciiz "\nString #"
str3:	.asciiz ": "
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv size, 3
	.text
	.globl main
main: 	
	jr $ra