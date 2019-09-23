	.data
str1: 	.asciiz "Introduza 2 numeros\n"
str2:	.asciiz "A soma dos dois numeros é: "
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_int10, 1
	.text
	.globl main
main: 	la $a0, str1
	ori $v0, $0, print_string
	syscall
	ori $v0, $0, read_int
	syscall
	or $t0, $v0, $0
	ori $v0, $0, read_int
	syscall
	or $t1, $v0, $0
	add $t2, $t0, $t1
	ori $v0, $0, print_string
	la $a0, str2
	syscall
	ori $v0, $0, print_int10
	or $a0, $0, $t2
	syscall
	jr $ra
