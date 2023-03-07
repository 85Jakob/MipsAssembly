############################
# Jacob Doney              #
# 03-07-2023               #
#                          #
#File: reverseArray.asm    #
############################
	
	.data

prompt: .asciiz "Enter 6 numbers to put into array: "
space: .asciiz " "
newline: .asciiz "\n"

	.align 2
myArray: .space 24 #20 bytes for 6 integers
	.text
	.globl main
main:
	la $a0, prompt
	li $v0, 4
	syscall
	li $t0, 0
	li $t1, 6		# counter variable for loop
	li $t7, 1

inputloop:
	li $v0, 5
	syscall
	sw $v0, myArray($t0)	# load input into MM	
	addi $t0, $t0, 4 	# increment the index by 4
	addi $t1, $t1, -1	# decrement counter
	bgtz $t1, inputloop
	
	li $t0, 0
	li $t1, 5
print:
	lw $t6, myArray($t0)
	li $v0, 1
	ori $a0, $t6, 0 
	syscall
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	li $v0, 4
	la $a0, space
	syscall
	bgtz $t1, print	
	
	la $a0, newline
	syscall
	li $t0, 0		# setting variable low
	li $t1, 20		# setting variable high
	beqz $t7, exit
	
reverseArray:
	lw $t3, myArray($t0)	
	lw $t4, myArray($t1)
	sw $t3, myArray($t1)
	sw $t4, myArray($t0)
	
	addi $t0, $t0, 4
	addi $t1, $t1, -4
	bge $t1, $t0, reverseArray
	
	li $t0, 0
	li $t1, 5
	li $t7, 0
	beqz $0, print
	
exit:		
	ori $v0,$0,10
	syscall
	
	jr $ra
