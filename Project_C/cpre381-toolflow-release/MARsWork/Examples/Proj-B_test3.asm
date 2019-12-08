# bubble sort

    .data
Arr:        .word       3,3,1,2,5
    .text
    .globl  main
main:
    li      $t1,5                   # get total number of array elements

Outer_loop:
    subi    $a1,$t1,1               
    blez    $a1,done           

    la      $a0,Arr                 
    li      $t2,0                   

    jal     inner_loop               

    beqz    $t2,done  

    subi    $t1,$t1,1              
    b       Outer_loop

done:
    j       end        

#   a0 -- address of array
#   a1 -- number of loops to perform
inner_loop:
    lw      $s1,0($a0)           
    lw      $s2,4($a0)           
    bgt     $s1,$s2,swap       

next:
    addiu   $a0,$a0,4             
    subiu   $a1,$a1,1             
    bgtz    $a1,inner_loop         
    jr      $ra                    

swap:
    sw      $s1,4($a0)             
    sw      $s2,0($a0)             
    li      $t2,1                  
    j       next

# End the program
end:
    li      $v0,10
    syscall