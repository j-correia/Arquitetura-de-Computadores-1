# char toascii(char v)
# sub-rotina terminal
	.globl toascii
toascii:addu $a0, $a0, '0'		# v += '0';
	bge $a0, '9', endif		# if( v <= '9') goto endif
	addu $a0, $a0, 7		# v += 7;
endif:	or $v0, $0, $a0	
	jr $ra