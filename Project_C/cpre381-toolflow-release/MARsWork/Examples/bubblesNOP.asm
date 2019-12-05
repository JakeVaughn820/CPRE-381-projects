#Bubble sort with NOP's  

.data
			
array: .word 20, 19, 18, 17, 16, 15, 1, -1, 0, 100
size: .word 10
space: .asciiz " "			
	.text

main:	
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
    lw $t7, size          
    #li $t0, 0 
	lui $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	ori $t0, $at, 0
	sll $0, $0, $0
	sll $0, $0, $0	

# Sor outer-loop
sort:
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
   # li $t1, 0
	lui $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	ori $t1, $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	
   # li $t2, 0
	lui $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	ori $t3, $at, 0
	sll $0, $0, $0
	sll $0, $0, $0	
	
   # li $t4, 0
	lui $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	ori $t4, $at, 0    
            
## Scan inner-loop
scan:
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
    #la $t3, array
	lui $t3, 4097(0x1001)
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	ori $t3, $t3, size
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
    add $t3, $t3, $t4       
    lw $a0, 0($t3)
    sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0	
    lw $a1, 4($t3)          
    jal compare             
    bne $v0, 1, less        
    jal swap                
    sw $a0, 0($t3)          
    sw $a1, 4($t3)          

#Exit if no swaps happend, else go back to scan
less:
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
    beq $t1, 0, exit        
    addi $t2, $t2, 1        
    sub $t6, $t7, $t0 
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0	
    sub $t6, $t6, 1        
    addi $t4, $t4, 4 
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0	
    blt $t2, $t6, scan      
    addi $t0, $t0, 1 
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
    slt $t9, $t0, $t7 
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	bne $t9, $0, sort 
    #blt $t0, $t7, sort     
    j exit                 

compare:
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
    #li $v0, 0 
	lui $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	ori $v0, $at, 0
	ori $v0, $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
    sgt $v0, $a0, $a1                            
    jr $ra

swap:
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
    add  $s0, $0, $a0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0	
    add  $a0, $0, $a1 
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0	
    add  $a1, $0, $s0       
    li $t1, 1              
    jr $ra

# See sorted array
print:
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
    #li $v0, 1    
	lui $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	ori $v0, $at, 1
	sll $0, $0, $0
	sll $0, $0, $0	
    lw $a0, array($a2)     
    syscall

    #li $v0, 4 
	lui $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	ori $v0, $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0	
    #la $a0, space
	lui $at, 4097(0x1001)
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	ori $a0, $at, 0 
	sll $0, $0, $0
	sll $0, $0, $0	
    syscall

    addi $a2, $a2, 4
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0	
    addi $a3, $a3, 1
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0	
    #blt $a3, $t7, print 
	slt $t9, $a3, $t7 
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	bne $t9, $0, print 
    jr $ra

exit:
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
    #li $a2, 0 
    lui $at, 0	
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	ori $a2, $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	
    #li $a3, 0
    lui $at, 0	
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0
	ori $a3, $at, 0
	sll $0, $0, $0
	sll $0, $0, $0
	sll $0, $0, $0	
    jal print               

addi  $2,  $0,  10             
syscall                        