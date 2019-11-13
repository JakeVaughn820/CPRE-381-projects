.data
	temp1: .word 88
	temp2: .word 66
	arr1: .word 0 : 31

.text
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	addu $t4, $zero, $zero
	addu $t5, $zero, $zero
	addu $t6, $zero, $zero
	addu $t7, $zero, $zero
	addi $zero, $zero, 15
	
	add $t8, $zero, $zero
	add $t9, $zero, $zero
	
	addi $s0, $zero, 0
	addi $s1, $zero, 0
	addi $s2, $zero, 0
	addi $s3, $zero, 0
	addiu $s4, $zero, 0
	addiu $s5, $zero, 0
	addiu $s6, $zero, 0
	addiu $s7, $zero, 0
	
	addi $t0, $t0, 50
	addi $t1, $t1, 70
	
	la $t0, temp1
	la $t1, temp2
	la $s0, arr1
	
	#sll
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	addi $t4, $zero, 2
	sll $t2, $t3, 10
	sllv $t2, $t2, $t4
	sw $t2, 48($s0)
	sw $t2, 52($s0)
	
	#and
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	and $t2, $t3, $t3
	andi $t2, $t2, 66
	sw $t2, 0($s0)
	sw $t2, 4($s0)
	
	#or
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	or $t2, $t3, $t3
	ori $t2, $t2, 66
	sw $t2, 8($s0)
	sw $t2, 12($s0)
	
	#xor
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	xor $t2, $t3, $t3
	xori $t2, $t2, 66
	sw $t2, 16($s0)
	sw $t2, 20($s0)
	
	#nor
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	nor $t2, $t3, $t3
	sw $t2, 24($s0)
	sw $t2, 28($s0)
	
	#slt
	lui $t2, 200
	or $t2, 17
	slt $t2, $t3, $t3
	slti $t2, $t2, 66
	sw $t2, 32($s0)
	sw $t2, 36($s0)
	
	#sltu
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	sltu $t2, $t3, $t3
	sltiu $t2, $t2, 66
	sw $t2, 40($s0)
	sw $t2, 44($s0)
	
	#srl
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	addi $t4, $zero, 2
	srl $t2, $t3, 10
	srlv $t2, $t2, $t4
	sw $t2, 56($s0)
	sw $t2, 60($s0)
	
	#sra
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	addi $t4, $zero, 2
	sra $t2, $t3, 10
	srav $t2, $t2, $t4
	sw $t2, 64($s0)
	sw $t2, 68($s0)
	  
	#sub
	lw $t2, 0($t0)
	lw $t3, 0($t1)
	addi $t4, $zero, 2
	sub $t2, $t3, $t2
	subu $t3, $t3, $t2
	sw $t2, 72($s0)
	sw $t2, 76($s0)
	
#tests from our other test file


	addi  $1,  $0,  1 		# Place â€œ1â€? in $1
	addi  $2,  $0,  -2		# Place â€œ2â€? in $2
	addi  $3,  $0,  3		# Place â€œ3â€? in $3
	addi  $4,  $0,  -4		# Place â€œ4â€? in $4
	addi  $5,  $0,  5		# Place â€œ5â€? in $5
	addi  $6,  $0,  -6		# Place â€œ6â€? in $6
	addi  $7,  $0,  7		# Place â€œ7â€? in $7
	addi  $8,  $0,  -8		# Place â€œ8â€? in $8
	addi  $9,  $0,  9		# Place â€œ9â€? in $9
	addi  $10, $0,  -10		# Place â€œ10â€? in $10
	
	la $t0, temp1
	la $t1, temp2
	la $s0, arr1
	
	add $11, $0, $1 
	add $11, $3, $2
	add $11, $9, $10 
	
	addiu $12, $0, 5 
	addiu $12, $0, -5
	addiu $12, $8, 9
	
	addu $3, $1, $2 
	addu $3, $2, $1
	addu $3, $0, $8 
	
	and $14, $1, $4 
	and $14, $7, $3 
	and $14, $8, $9 
	
	andi $15, $1, 1 
	andi $15, $5, 105
	andi $15, $6, -40
	
	lui $16, 0x40 
	lui $16, 0x39 
	lui $16, 0xF4 
	
	sw $0, 0($t0) 
	sw $0, 0($t1) 
	
	nor $18, $1, $3  
	nor $18, $2, $5  
	nor $18, $4, $8
	
	xor $19, $2, $4 
	xor $19, $1, $3 
	xor $19, $5, $10 
	
	xori $20, $2, 10 
	xori $20, $1, -11
	xori $20, $0, 17 
	
	or $21, $1, $3 
	or $21, $2, $4 
	or $21, $1, $8 
	
	ori $22, $3, 10 
	ori $22, $4, 10 
	ori $22, $3, -10 
	
	slt $23, $2, $5 
	slt $23, $2, $6 
	slt $23, $1, $7
	
	slti $24, $2, 3 
	slti $24, $1, 8
	slti $24, $7, -16 
	
	sltiu $25, $2, 3 
	sltiu $25, $5, 3 
	sltiu $25, $9, -47 
	
	sltu $26, $1, $5 
	sltu $26, $2, $8
	sltu $26, $2, $9
	
	sll $27, $7, 10 
	sll $1, $1, 1 
	sll $1, $2, 18
	
	srl $28, $7, 10 
	srl $28, $3, 4
	srl $28, $4, 5 
	
	sra $29, $4, 10 
	sra $29, $7, 20 
	sra $29, $10, 17 
	
	sllv $30, $7, $10 
	sllv $30, $3, $4
	sllv $30, $8, $2
	
	srlv $31, $3, $14 
	srlv $31, $6, $10 
	srlv $31, $9, $1 
	
	srav $10, $7, $10 
	srav $10, $4, $8
	srav $10, $1, $9
	
	lw $17, 0($t0) 
	lw $18, 0($t1) 
	
	sub $20, $0, $1 
	sub $20, $7, $2
	sub $20, $7, $4
	
	subu $30, $0, $1 
	subu $30, $2, $8
	subu $30, $1, $5
	
	addi $10, $0,  -10		
	addi $10, $4,  10	
	addi $10, $3,  10	
	
	srl $28, $10, 10 
	srl $28, $5, 1
	srl $28, $8, 18 
	
	sra $29, $8, 10 
	sra $29, $9, 20 
	sra $29, $3, 10 
	
	sltiu $25, $5, -6 
	sltiu $25, $5, -3 
	sltiu $25, $5, 6 
	sltiu $25, $5, 3 
	
	addi $v0, $zero, 10
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	