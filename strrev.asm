# Mapa de Registos:
# str:	$a0 -> $s0 (argumento passado em $a0
# p1:	$s1 (callee-saved)
# p2:	$s2 (callee-saved)
#
strrev:	subiu $sp, $sp, 16		# reservar espaço de stack (4 posições)
	sw $ra, 0($sp)			# save $ra
	sw $s0, 4($sp)			# save $s0
	sw $s1, 8($sp)			# save $s1
	sw $s2, 12($sp)			# save $s2
	or $s0, $0, $a0			# salvaguarda argumento - callee-saved
	or $s1, $0, $a0			# p1 = str
	or $s2, $0, $a0			# p2 = str
while1:	lb $t0, 0($s2)			# if($s2 == '\0') goto endw1
	beq $t0, '\0', endw1		# if($s2 == '\0') goto endw1
	addiu $s2, $s2, 1		# p2++;
	j while1			# }
endw1:	subiu $s2, $s2, 1		# p2--
while2:	bge $s1, $s2, endw2		# if( p1 => p2) goto endw2
	or $a0, $0, $s1			# exchange(p1,p2)
	or $a1, $0, $s2			# exchange(p1,p2)
	jal exchange			# exchange(p1,p2)
	addiu $s1, $s1, 1		# p1++
	subiu $s2, $s2, 1		# p2--
	j while2			# }
endw2:	or $v0, $0, $s0			# $v0, $0, $s0
	lw $ra, 0($sp)			# reposição de $ra
	lw $s0, 4($sp)			# reposição de $s0
	lw $s1, 8($sp)			# reposição de $s1
	lw $s2, 12($sp)			# reposição de $s2
	addiu $sp, $sp, 16		# repor stack pointer
	jr $ra				# retorno da sub-rotina	
	
exchange: 
	lb $t0, 0($a0)			# *c1 = 0($a0)
	lb $t1, 0($a1)			# *c2 = 0($a1)
	sb $t0, 0($a1)			# 
	sb $t1, 0($a0)			#
	jr $ra				# retorno da sub-rotina

