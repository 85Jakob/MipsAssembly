############################
# Jacob Doney              #
# 03-07-2023               #
#                          #
#File: linearSum.asm       #
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
	li $t1, 6
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
	li $t0, 0
	li $t1, 0
	li $t2, 24
sum:
	lw $t3, myArray($t0)	
	add $t1, $t1, $t3
	addi $t0, $t0, 4
	ble $t0, $t2, sum
	
	li $v0, 1
	ori $a0, $t1, 0
	syscall 
			
	or $v0,$0,10
	syscall
	
	jr $ra
