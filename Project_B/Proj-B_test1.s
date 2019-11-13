# Phase 1 tests

# data selection
.data
	temp1: .word 16
	temp2: .word 3
	arr1: .word 0 : 31

# instructions
.text 

	la $t0, temp1
	la $t1, temp2
	la $s0, arr1

# Setup
addi $1, $0, 11		# Place "11" in reg1
addi $2, $0, 5		# Place "5" in reg2

# Using reg3 for adding 
add $3, $1, $2 		# reg3 = reg1 + reg2
addiu $3, $1, 11	# reg3 = reg1 + "11"
addu $3, $1, $2		# reg3 = reg1 + reg2

# Using reg4 for anding 
and $4, $1, $2 		#reg4 = reg1 & reg2
andi $4, $1, 11		#reg4 = reg1 & 11

# Using reg5 for loadword 
lui $5, 7		# Place "7" into reg5
lw $22, 0($t0)		# Set reg5, to reg2
lw $23, 0($t1)

# Nor, Xor, Or use reg6
nor $6, $2, $1		# reg6 = reg2 nor reg1
xor $6, $2, $1		# reg6 = reg2 xor reg1
xori $6, $2, 3		# reg6 = 2 xor 3
or $6, $2, $1		# reg6 = reg2 or reg1
ori $6, $2, 3		# reg6 = reg2 or 3 

# Uing reg7 for set less than
slt $7, $2, $1 	
slti $7, $2, 3
sltiu $7, $2, 3
sltu $7, $2, $1

# Using reg8 for shifting left and rigth  
sll $8, $2, 4
srl $8, $2, 4
sra $8, $2, 4
sllv $8, $2, $1
srlv $8, $2, $1
srav $8, $2, $1

# Using  reg21 for store word
sw $9, 4($s0)

# Using reg10 for subing 
sub $21, $2, $1
subu $21, $2, 3


#addi $2, $0, 0		# Clear reg2
addi $2, $0, 10 	# Cause the halt 
syscall 		# Halt 
