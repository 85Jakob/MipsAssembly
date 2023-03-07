############################
# Jacob Doney              #
# 03-06-2023               #
#                          #
#File: fib.asm             #
############################

	.data
	.align 2
prompt: .asciiz "Enter number of Fibonacci numbers to generate: "
space: .asciiz " "
	.text
	.globl main
main:	
	la $a0, prompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	or $t1, $v0, $0 
	li $t2, 3
	li $t3, 0
	li $t4, 1
	li $t5, 0
	li $v0, 1
	or $a0, $t3, $0
	syscall
	la $a0, space
	li $v0, 4
	syscall
	li $v0, 1
	or $a0, $t4, $0
	syscall
loop:	
	add $t5, $t4, $0
	add $t4, $t4, $t3
	add $t3, $t5, $0
	la $a0, space
	li $v0, 4
	syscall
	li $v0, 1
	or $a0, $t4, $0
	syscall
	addi $t2, $t2, 1
	bge $t1, $t2, loop
	
	ori $v0,$0,10
	syscall
	
	jr $ra
