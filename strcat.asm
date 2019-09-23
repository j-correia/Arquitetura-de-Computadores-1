#	Entrada de ponteiro *dst
#	Entrada de ponteiro *srcc
#	Devolve char dst
strcat:	subiu $sp, $sp, 16		# Inicializar espaço na stack
	sw $ra, 0($sp)			# Salvaguardar na stack
	sw $s0, 4($sp)			# Salvaguardar na stack
	sw $s1, 8($sp)			# Salvaguardar na stack
	sw $s2, 12($sp)			# Salvaguardar na stack
while:	lb $t0, 0($a0)			# if( *p == '\0') goto endw
	beq $t0, '\0', endw		# if( *p == '\0') goto endw
	addiu $a0, $a0, 1		# p++
	j while				# }
endw:	or $a0, $0, $a0			# Passagem de parâmetros para strcpy
	or $a1, $0, $a1v		# Passagem de parâmetros para strcpy
	jal strcpy			# Chamada de strcpy
	lw $ra, 0($sp)			# Restauro de contexto
	lw $s0, 4($sp)			# Restauro de contexto
	lw $s1, 8($sp)			# Restauro de contexto
	lw $s2, 12($sp)			# Restauro de contexto
	jr $ra				# Repor stack pointer
