# Mapa de registos
# $t0 - soma
# $t1 - value
# $t2 - i
	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "Valor ignorado\n"
str3:	.asciiz "A soma dos positivos é: "
	.eqv print_str, 4
	.eqv read_int, 5
	.eqv print_int, 1
	.text
	.globl main
main:	li $t0, 0		# soma = 0;
	li $t2, 0		# i = 0;
for:	bge $t2, 5, endfor	# while(i < 5){
	la $a0, str1		# print_string
	li $v0, print_str	
	syscall
	li $v0, read_int	# value = read_int()
	syscall			
	or $t1, $v0, $zero	# value = read_int()
if1:	blez $t1, else
	add $t0, $t0, $t1	# soma += value;
	j endif1		
else:	la $a0, str2		# print_str
	li $v0, print_str
	syscall
endif1:	addi $t2, $t2, 1	# i++;
	j for			# }
endfor:	la $a0, str3
	li $v0, print_str
	syscall
	or $a0, $t0, $zero
	li $v0, print_int
	syscall
	jr $ra