# Mapa da Registos
# $t0 -> v
# $t1 -> i
# $t2 -> soma
# $t3 -> temp
# $t4 -> pos
	.data
array:	.word 7692,23,5,234
	.eqv print_int10, 1
	.eqv SIZE, 4
	.text
	.globl main
main:	ori $t1, $0, 0			# int i = 0;
	ori $t2, $0, 0
while:	bge $t1, 4, endw
	sll $t4, $t1, 2			# temp = i*4
	la $t3, array
	add $t4, $t3, $t4	
	lw $t0, 0($t4)
	add $t2, $t2, $t0
	addi $t1, $t1, 1
	j while
endw:	ori $v0, $0, print_int10	# print_int10(soma)
	or $a0, $0, $t2			# print_int10(soma)
	syscall				# print_int10(soma)
	jr $ra
