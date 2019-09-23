	.data
str:	.asciiz "Arquitetura de Computadores I"
	.eqv print_int10, 1
	.text
	.globl main
main:	sw $ra, 0($sp)
	la $a0, str
	jal strlen
	or $a0, $0, $v0
	ori $v0, $0, print_int10
	syscall
	lw $ra, 0($sp)
	jr $ra
	
	
strlen: ori $t1, $0, 0		# len = 0
while:	lb $t0, 0($a0)		# while(*s++ != '\0')
	addiu $a0, $a0, 1
	beq $t0, '\0', endw
	addi $t1, $t1, 1	# len++
	j while
endw:	or $v0, $0, $t1		# return len;
	jr $ra			# é terminal, logo não salvaguardo $ra
