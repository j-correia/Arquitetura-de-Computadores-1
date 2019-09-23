# Mapa de registos
# p:		$t0
# size-1	$t1
# lista+SIZE:	$t2
# aux:		$t3
# houve_troca:	$t4
# i:		$t5
# lista:	$t6
# lista+i:	$t7
# lista[i+1]:	$t8
# lista[i]:	$t9
	.data
	.eqv false,0
	.eqv true,1
	.eqv SIZE,10
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv print_int10, 1
str1:	.asciiz "\nInsira um número: "
str2:	.asciiz "; "
	.align 2
lista:	.space 40			# SIZE*4
	.align 2
	.text
	.globl main
main:	ori $t3, $0, 0
	la $t0, lista
	ori $t2, $0, SIZE		# $t2 = $t0 + size*4
	sll $t2, $t2, 2			# $t2 = $t0 + size*4
	addu $t2, $t0, $t2		# $t2 = $t0 + size*4
read:	bgeu $t0, $t2, endr		# if($t0 => $t2) goto endr
	la $a0, str1			# print_string(str1);
	ori $v0, $0, print_string	# print_string(str1);
	syscall
	ori $v0, $0, read_int		# $v0 = read_int();
	syscall				# $v0 = read_int();
	sw $v0, 0($t0)			# lista[i] = $v0;
	addu $t0, $t0, 4		# p++;
	j read				# }
endr:	la $t0, lista
do:	ori $t4, $0, false			# houve_Troca = FALSE;
	ori $t5, $0, 0			# int i = 0;
while:	ori $t1, $0, SIZE		# SIZE-1
	subi $t1, $t1, 1		# SIZE-1
	bge $t5, $t1, endw		# if($t5 => SIZE-1) goto endw
if:	sll $t7, $t5, 2			# $t7 = i*4;
	addu $t7, $t7, $t0		# &lista[i]
	lw $t8, 0($t7)			# $t8 = lista[i]
	lw $t9, 4($t7)			# $t9 = lista[i+1]
	bltu $t8, $t9, eif		# if( $t8 => $t9) goto eif
	sw $t8, 4($t7)			# lista[i+1] = $t8
	sw $t9, 0($t7)			# lista[i]   = $t9
	ori $t4, $0, true		#
eif:	addi $t5, $t5, 1		# i++;	
	j while				# }
endw:	beq $t4, 1, do			# while( houve_Troca == TRUE);
	la $t0, lista
	ori $t2, $0, SIZE		# $t2 = $t0 + size*4
	sll $t2, $t2, 2			# $t2 = $t0 + size*4
	addu $t2, $t0, $t2		# $t2 = $t0 + size*4
prt:	bgeu $t0, $t2, eprt		# if($t0 => $t2) goto endr
	lw $a0, 0($t0)			# print_int10(*p);
	ori $v0, $0, print_int10	# print_int10(*p);
	syscall				# print_int10(*p);
	la $a0, str2			# print_string(str2);
	ori $v0, $0, print_string	# print_string(str2);
	syscall				# print_string(str2);
	addu $t0, $t0, 4		# p++;
	j prt	
eprt:
	jr $ra
