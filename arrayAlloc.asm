############################
# Jacob Doney              #
# 04-18-2023               #
#                          #
# File: arrayAlloc.asm     #
############################

         .data
         .align 2
space: 	.asciiz " "
x:       .space 4
n:       .word 6
stackn:  .word 6
ARR1:	   .word 1, 2, 3, 4, 5, 6	# creating a static array
         .text
         .globl main

##################### HEAP ###########################################	
main:
	li $t1, 0		# value of x set to 0 in $t1
	la $t2, n               # saving n = 6 into $t1
	lw $t2, 0($t2) 
	sll $a0, $t2, 2         # arrguemnt to make array of 6 words
	li $v0, 9
	syscall		        # create arr2
	move $s0,  $v0		# save pointer to start of arr2
	move $s1, $v0	        # save pointer to start of arr2
	la $t3, ARR1	        # put pointer to ARR1 into $t3 

L1:	
   	bge $t1, $t2, E1	# Exit when x > n
	lw $t4, 0($t3)	        # load element of ARR1 into $t4
	sw $t4, 0($s1)	        # save element in $t4 into ARR2
	addi $t3, $t3, 4	# move to next index in ARR1
	addi $s1, $s1, 4	# move to next index in ARR2
	addi $t1, $t1, 1	# add 1 to increment	
	j L1		        # loop back to L1
E1:	
   	li $t1, 0		# reset value of x to 0 in $t1
	or $s1, $s0, $0	        # store starting address for ARR2 into $s1

#################### STACK ##########################################	
   	la $t3, ARR1	        # put pointer to ARR1 into $t3
   	la $t5, stackn          # saving stackn = 6 into $t5
   	lw $t5, 0($t5)
   	sll $s3, $t5, 2
   	sub $sp, $sp, $s3
   	ori $s4, $sp, 0         # placing stack pointer into $s4
   	add $s4, $s4, $s3       # moving $s4 to top of stack
   	li $t1, 0
   	la $t2, stackn
   	lw $t2, 0($t2) 

STACK:
   	beq $s4, $sp, E3        # Branch when point is equal to pointer at end of array.
   	lw $t4, 0($t3)
   	addi $s4, $s4, -4
   	sw $t4, 0($s4)
   	addi $t3, $t3, 4
   	b STACK 
E3:
   	li $t1, 0		# reset value of x to 0 in $t1
   	add $s4, $s4, $s3       # moving $s4 to top of stack

################ PRINT ARRAY ON STACK ##############################################
PRINT2:	
   	beq $s4, $sp, E4        # Branch when point is equal to pointer at end of array.
   	addi $s4, $s4, -4	# move to next index in Stack
	lw $t0, 0($s4) 	      	# store element in array into $t0
	li $v0, 1
	or $a0, $t0, $0	
	syscall
	li $v0, 4
	la $a0, space
	syscall
	j PRINT2

################ PRINT ARRAY ON HEAP ##############################################
E4:
   	li $t1, 0		# reset value of x to 0 in $t1
	or $s1, $s0, $0	      	# store starting address for ARR2 into $s1

PRINT:	
   	bge $t1, $t2, E2
	lw $t0, 0($s1) 	      	# store element in array into $t0
	li $v0, 1
	or $a0, $t0, $0	
	syscall
	li $v0, 4
	la $a0, space
	syscall
	addi $s1, $s1, 4	# move to next index in ARR2
	addi $t1, $t1, 1	# add 1 to increment	
	j PRINT
E2:
	ori $v0, $0, 10
	syscall
	jr $ra
