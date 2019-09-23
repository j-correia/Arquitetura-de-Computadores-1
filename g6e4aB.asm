#	Entrada de ponteiro *dst
#	Entrada de ponteiro *srcc
#	Devolve char dst
	.data
str1:	.asciiz "Arquitetura de "
	.align 2
str2:	.space 50
str3:	.asciiz "\n"
str4:	.asciiz "Computadores I"
	.eqv print_int10, 1
	.eqv print_str, 4
	.text
	.globl main
main:	subiu $sp, $sp, 4
	sw $ra, 0($sp)
	la $a0, str2
	la $a1, str1
	jal strcpy
	or $a0, $0, $v0
	ori $v0, $0, print_str
	syscall
	la $a0, str3
	syscall
	la $a0, str2
	la $a1, str4
	jal strcat
	or $a0, $0, $v0
	ori $v0, $0, print_str
	syscall	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
strcat:	subiu $sp, $sp, 16		# Inicializar espaço na stack
	sw $ra, 0($sp)			# Salvaguardar na stack
	sw $s0, 4($sp)			# Salvaguardar na stack
	sw $s1, 8($sp)			# Salvaguardar na stack
	sw $s2, 12($sp)			# Salvaguardar na stack
	or $s0, $0, $a0
	or $s1, $0, $a1
while:	lb $t0, 0($a0)			# if( *p == '\0') goto endw
	beq $t0, '\0', endw		# if( *p == '\0') goto endw
	addiu $a0, $a0, 1		# p++
	j while				# }
endw:	or $a1, $0, $a0			# Passagem de parâmetros para strcpy
	or $a1, $0, $s1			# Passagem de parâmetros para strcpy
	jal strcpy			# Chamada de strcpy
	or $v0, $0, $v0
	lw $ra, 0($sp)			# Restauro de contexto
	lw $s0, 4($sp)			# Restauro de contexto
	lw $s1, 8($sp)			# Restauro de contexto
	lw $s2, 12($sp)			# Restauro de contexto
	addiu $sp, $sp, 16
	jr $ra				# Repor stack pointer
#	Entrada de endereço de String a ser copiada
#	Entrada de endereço de String copiada
#	Void
strcpy:	or $t0, $0, $a0
do:	
	lb $t1, 0($a1)
	sb $t1, 0($a0)
	addu $a0, $a0, 1
	addu $a1, $a1, 1
	lb $t2, 0($a1)
	bne $t2, '\0', do
	or $v0, $0, $t0
	jr $ra
