#Bubble sort 

.data
			
array: .word 20, 19, 18, 17, 16, 15, 1, -1, 0, 100
size: .word 10
space: .asciiz " "			
	.text

main:	

    lw $t7, size          
    li $t0, 0              

# Sor outer-loop
sort:
    li $t1, 0               

    li $t2, 0              
    li $t4, 0      
            
## Scan inner-loop
scan:
    la $t3, array          
    add $t3, $t3, $t4       
    lw $a0, 0($t3)          
    lw $a1, 4($t3)          
    jal compare             
    bne $v0, 1, less        
    jal swap                
    sw $a0, 0($t3)          
    sw $a1, 4($t3)          

#Exit if no swaps happend, else go back to scan
less:
    beq $t1, 0, exit        
    addi $t2, $t2, 1        
    sub $t6, $t7, $t0      
    sub $t6, $t6, 1        
    addi $t4, $t4, 4        
    blt $t2, $t6, scan      
    addi $t0, $t0, 1        
    blt $t0, $t7, sort     
    j exit                 

compare:
    li $v0, 0               
    sgt $v0, $a0, $a1       
                           
    jr $ra

swap:
    add  $s0, $0, $a0      
    add  $a0, $0, $a1       
    add  $a1, $0, $s0       
    li $t1, 1              
    jr $ra

# See sorted array
print:
    li $v0, 1               
    lw $a0, array($a2)     
    syscall

    li $v0, 4             
    la $a0, space           
    syscall

    addi $a2, $a2, 4       
    addi $a3, $a3, 1        
    blt $a3, $t7, print    
    jr $ra

exit:
    li $a2, 0              
    li $a3, 0              
    jal print               

addi  $2,  $0,  10             
syscall                        