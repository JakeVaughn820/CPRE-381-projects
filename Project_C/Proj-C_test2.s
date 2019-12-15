#Bubble sort With NOP's 
#Nickolas Mitchell
#Jackob Vaughn  

.data
			
array: .word 20, 19, 18, 17, 16, 15, 1, -1, 0, 100
size: .word 10
space: .asciiz " "			
	.text

main:	
    #lw $t7, size
    lui $1, 0x00001001
    sll $0, $0, 0
    sll $0, $0, 0
    sll $0, $0, 0
    lw $15, 0x00000028($1)
    #li $t0, 0
    addiu $8, $0, 0x00000000              


# Sort outer-loop
sort:
    #li $t1, 0
    addiu $9, $0, 0x00000000               
    #li $t2, 0
    addiu $10, $0, 0x00000000              
    #li $t4, 0
    addiu $12, $0, 0x00000000
          
            
# Scan inner-loop
scan:
    #la $t3, array
    lui $1, 0x00001001
    sll $0, $0, 0
    sll $0, $0, 0
    sll $0, $0, 0 
    ori $11, $1, 0x00000000 
    sll $0, $0, 0
    sll $0, $0, 0
    sll $0, $0, 0         
    add $t3, $t3, $t4
    sll $0, $0, 0
    sll $0, $0, 0
    sll $0, $0, 0        
    lw $a0, 0($t3)
    sll $0, $0, 0
    sll $0, $0, 0
    sll $0, $0, 0           
    lw $a1, 4($t3)
    sll $0, $0, 0                        
    jal compare             
    #bne $v0, 1, less
    addi $1, $0, 0x00000001
    sll $0, $0, 0  
    bne $1, $2, less
    sll $0, $0, 0          
    jal swap                   
    sw $a0, 0($t3)
    sll $0, $0, 0
    sll $0, $0, 0  
    sll $0, $0, 0           
    sw $a1, 4($t3)      

#Exit if no swaps happend, else go back to scan
less:
    #beq $t1, 0, exit
    addi $1, $0, 0x00000000 
    sll $0, $0, 0
    beq $1, $9, exit 
    sll $0, $0, 0
    sll $0, $0, 0  
    sll $0, $0, 0        
    addi $t2, $t2, 1        
    sub $t6, $t7, $t0      
    #sub $t6, $t6, 1
    addi $1, $0, 0x00000001
    sub  $14, $14, $1
    sll $0, $0, 0
    sll $0, $0, 0  
    sll $0, $0, 0        
    addi $t4, $t4, 4
    sll $0, $0, 0          
    #blt $t2, $t6, scan
    slt $1, $10, $14 
    sll $0, $0, 0 
    bne $1, $0, scan 
    sll $0, $0, 0
    sll $0, $0, 0  
    sll $0, $0, 0       
    addi $8, $8, 1
    sll $0, $0, 0          
    #blt $t0, $t7, sort
    slt $1, $8, $15  
    sll $0, $0, 0 
    bne $1, $0, sort 
    sll $0, $0, 0       
    j exit                 

compare:
    #li $v0, 0
    addiu $2, $0, 0x00000000
    sll $0, $0, 0
    sll $0, $0, 0  
    sll $0, $0, 0                 
    #sgt $v0, $a0, $a1
    slt $2, $5, $4
    sll $0, $0, 0                            
    jr $ra

swap:
    add  $s0, $0, $a0
    sll $0, $0, 0
    sll $0, $0, 0  
    sll $0, $0, 0       
    add  $a0, $0, $a1
    sll $0, $0, 0
    sll $0, $0, 0  
    sll $0, $0, 0        
    add  $a1, $0, $s0       
    #li $t1, 1
    addiu $9, $0, 0x00000001  
    sll $0, $0, 0                
    jr $ra

# See sorted array
print:
    #li $v0, 1
    addiu $2, $0, 0x00000001                 
    #lw $a0, array($a2)
    lui $1, 0x00001001
    sll $0, $0, 0
    sll $0, $0, 0  
    sll $0, $0, 0 
    addu $1, $1, $6
    sll $0, $0, 0
    sll $0, $0, 0  
    sll $0, $0, 0 
    lw $4, 0x00000000($1)     
    syscall

    #li $v0, 4
    addiu $2, $0, 0x00000004             
    #la $a0, space
    lui $1, 0x00001001
    sll $0, $0, 0
    sll $0, $0, 0  
    sll $0, $0, 0 
    ori $4, $1, 0x0000002c          
    syscall

    addi $a2, $a2, 4       
    addi $a3, $a3, 1        
    #blt $a3, $t7, print
    slt $1, $7, $15
    sll $0, $0, 0 
    bne $1, $0, print 
    sll $0, $0, 0     
    jr $ra

exit:
    #li $a2, 0
    addiu $6, $0, 0x00000000              
    #li $a3, 0
    addiu $7, $0, 0x00000000
    sll $0, $0, 0              
    jal print               

addi  $2,  $0,  10             
syscall                        
