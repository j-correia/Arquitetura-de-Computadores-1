	.data
	.text
	.globl main
main:	ori $v0, $0, 5		# Identificar Syscall #5
	syscall			# Chamar syscall read_int()

	or $t0, $0, $v0		# Copiar return para $t0
	ori $t2, $0, 8		# $t2 = 8
	add $t1, $t0, $t0	# $t1 = 2x
	sub $t1, $t1, $t2	# $t1 = $t1 - 8

	or $a0, $0, $t1		# Entrega à Syscall de $t1
	ori $v0, $0, 1		# Identificar Syscall #1
	syscall			# Chamar Syscall print_int10()

	or $a0, $0, '\n'	# Entrega à Syscall de '\n'
	ori $v0, $0, 11		# Identificar Syscall #11
	syscall			# Chamar Syscall print_char()

	or $a0, $0, $t1		# Entrega à Syscall de $t1
	ori $v0, $0, 34		# Identificar Syscall #34
	syscall			# Chamar Syscall print_int16()

	or $a0, $0, '\n'	# Entrega à Syscall de '\n'
	ori $v0, $0, 11		# Identificar Syscall #11
	syscall			# Chamar Syscall print_char()

	or $a0, $0, $t1		# Entrega à Syscall de $t1
	ori $v0, $0, 36		# Identificar Syscall #36
	syscall			# Chamar Syscall print_intu10()

	jr $ra
