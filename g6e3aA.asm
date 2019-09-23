	.data
str1:	.asciiz "I serodatupmoC ed arutetiuqrA"
	.align 2
str2:	.space 31
str3:	.asciiz "String too long: "
str4:	.asciiz "\n"
	.eqv STR_MAX_SIZE, 30
	.eqv print_int10, 1
	.eqv print_str, 4
	.text
	.globl main
main:	subiu $sp, $sp, 4		# Inicializar a stack
	sw $ra, 0($sp)			# Salvaguardar $ra na stack
if:	la $a0, str1			# Passagem de parâmetros a strlen
	jal strlen			# Chamada de strlen
	or $t0, $0, $v0
	bgt $t0, STR_MAX_SIZE, else	# if(strlen(str1) > STR_MAX_SIZE) goto eif
	la $a0, str2			# Passagem de parâmetros a strcpy
	la $a1, str1			# Passagem de parâmetros a strcpy
	jal strcpy			# Chamada de strcpy
	la $a0, str2			# print_str(str2)
	ori $v0, $0, print_str		# print_str(str2)
	syscall				# print_str(str2)
	la $a0, str4			# print_str(str4)
	syscall				# print_str(str4)
	la $a0, str2			# Passagem de parâmetros a strrev
	jal strrev			# Chamada de strrev
	or $a0, $0, $v0			# print_str(strrev(str2))
	ori $v0, $0, print_str		# print_str(strrev(str2))
	syscall				# print_str(strrev(str2))
	ori $s0, $s0, 0			# exit_value = 0;
	j eelse
else:	la $a0, str3			# print_str(str3)
	ori $v0, $0, print_str		# print_str(str3)
	syscall				# print_str(str3)
	la $a0, str1			# Passagem de parâmetrosa strlen
	jal strlen			# Chamada de strlen
	or $a0, $0, $v0			# print_int10(strlen(str1))
	ori $v0, $0, print_int10	# print_int10(strlen(str1))
	syscall				# print_int10(strlen(str1))
	ori $s0, $s0, -1		# exit_value = -1
eelse:
	lw $ra, 0($sp)			# Restaurar $ra
	addiu $sp, $sp, 4		# Atualizar Stack Pointer
	jr $ra				# Terminar programa
#	Entrada de endereço de String a ser invertida
#	Saída de endereço de String invertida	
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
#	Entrada de ponteiro para valor
#	Entrada de ponteiro para valor
#	Void
exchange: 
	lb $t0, 0($a0)			# *c1 = 0($a0)
	lb $t1, 0($a1)			# *c2 = 0($a1)
	sb $t0, 0($a1)			# 
	sb $t1, 0($a0)			#
	jr $ra				# retorno da sub-rotina
#	Entrada de endereço de String a ser copiada
#	Entrada de endereço de String copiada
#	Void 
strcpy:	
do:	lb $t1, 0($a1)
	sb $t1, 0($a0)
	addu $a0, $a0, 1
	addu $a1, $a1, 1
	lb $t2, 0($a1)
	bne $t2, '\0', do
	or $v0, $0, $a0
	jr $ra
#	Entrada de endereço de string
#	Saída de int com comprinto de respetiva string
strlen: ori $t1, $0, 0		# len = 0
while:	lb $t0, 0($a0)		# while(*s++ != '\0')
	addiu $a0, $a0, 1
	beq $t0, '\0', endw
	addi $t1, $t1, 1	# len++
	j while
endw:	or $v0, $0, $t1		# return len;
	jr $ra			# é terminal, logo não salvaguardo $ra
