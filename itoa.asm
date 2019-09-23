# Mapa de registos
# n:		$a0 -> $s0
# b:		$a1 -> $s1
# s:		$a2 -> $s2
# p:		$s3
# digit:	$t0
# Sub-rotina intermédia, callee-saved
	.globl itoa
itoa:	subu $sp, $sp, 20	# reserva espaço na stack
	sw $ra, 0($sp)		# salvaguarda de registos $ra e $sX
	sw $s0, 4($sp)		# salvaguarda de registos $ra e $sX
	sw $s1, 8($sp)		# salvaguarda de registos $ra e $sX
	sw $s2, 12($sp)		# salvaguarda de registos $ra e $sX
	sw $s3, 16($sp)		# salvaguarda de registos $ra e $sX
	or $s0, $0, $a0		# cópia de n
	or $s1, $0, $a1		# cópia de b
	or $s2, $0, $a2		# cópia de s
	or $s3, $0, $a2		# sópia de p
do:				# do{
	remu $t0, $s0, $s1	# digit = n % b;
	divu $s0, $s0, $s1	# n = n / b
	ori $a0, $0, $t0	# toascii(digit);
	jal toascii		# toascii(digit)
	sb $v0, 0($s3)		# *p = toascii(digit)
	addiu $s3, $s3, 1	# *p++
	ble $s0, 0, do		# } if( n <= 0) goto do
 	sb $0, 0($s3)		# *p = '\0';
	or $a0, $0, $s2		# strrev(s);
	jal strrev		# strrev(s);
	or $v0, $0, $v0		# return s;
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addiu $sp, $sp, 20
	jr $ra