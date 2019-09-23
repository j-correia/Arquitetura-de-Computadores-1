# Mapa de registos

	.data
str:	.asciiz "2016 e 2020 sao anos bissextos"
	.text
	.globl main
main:	subiu $sp, $sp, 4
	sw $ra, 0($sp)
	la $a0, str
	jal atoi
	or $a0, $0, $v0
	ori $v0, $0, 1
	syscall
	ori $v0, $0, 0
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
# res:		$v0
# s:		$a0
# *s:		$t0
# digit:	$t1
atoi:	ori $v0, $0, 0		# res = 0;
while:	lb $t0, 0($a0)		# while ( ( *s >= '0') && ( *s <= '9'))
	blt $t0, '0', endw
	bgt $t0, '9', endw
	sub $t1, $t0, '0'	# digit = *s - '0'
	addiu $a0, $a0, 1	# s++;
	mul $v0, $v0, 10	# res = 10*res;
	add $v0, $v0, $t1	# res = res + digit;
	j while			# }
endw:	jr $ra
	