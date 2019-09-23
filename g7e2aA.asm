# Mapa de registos
# n:		$a0 -> $s0
# b:		$a1 -> $s1
# s:		$a2 -> $s2
# p:		$s3
# digit:	$t0
# Sub-rotina intermédia, callee-saved
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
# char toascii(char v)
# sub-rotina terminal
toascii:addu $a0, $a0, '0'		# v += '0';
	bge $a0, '9', endif		# if( v <= '9') goto endif
	addu $a0, $a0, 7		# v += 7;
endif:	or $v0, $0, $a0	
	jr $ra
# *char strrev( char *)
# sub-rotina intermédia
# callee-saved
strrev: subu $sp,$sp,16 		# reserva espaço na stack
	sw $ra,0($sp)			# guarda endereço de retorno
	sw $s0,4($sp)			# guarda valor dos registos
	sw $s1,8($sp)			# $s0, $s1 e $s2
	sw $s2,12($sp)			#
	move $s0,$a0			# registo "callee-saved"
	move $s1,$a0			# p1 = str
	move $s2,$a0			# p2 = str
while1:	lb $t0, 0($s1)			# while( *p2 != '\0' ) {
	beq $t0, '\0', endW1
	addiu $s1, $s1, 1		# p2++;
	j while1			# }
endW1:	subiu $s1, $s1, 1		# p2--;
while2:	bge $s0, $s1, endW2		# while(p1 < p2) {
	move $a0, $s0			#
	move $a1,$s1			#
	jal exchange			# exchange(p1,p2)
	addiu $s0, $s0, 1
	subiu $s1, $s1, 1
	j while2			# }
endW2:	move $v0,$s0			# return str
	lw $ra, 0($sp)			# repõe endereço de retorno
	lw $s0, 4($sp)			# repõe o valor dos registos
	lw $s1, 8($sp)			# $s0, $s1 e $s2
	lw $s2, 12($sp)			#
	addiu $sp, $sp, 16		# liberta espaço da stack
	jr $ra				# termina a sub-rotina 
exchange:	lb $t0, 0($a0)
	lb $t1, 0($a1)
	sb $t1, 0($a0)
	sb $t0, 0($a1)
	jr $ra
	
	