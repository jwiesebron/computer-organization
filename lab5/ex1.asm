#---------------------------------
# Lab 6: Pixel Conversion
#
# Name: <YOUR-NAME-HERE>
#
# --------------------------------
# Below is the expected output.
# 
# Converting pixels to grayscale:
# 0
# 1
# 2
# 34
# 5
# 67
# 89
# Finished.
# -- program is finished running --
#---------------------------------

.data 0x0
	startString:	.asciiz	"Converting pixels to grayscale:\n"
	finishString:	.asciiz	"Finished."
	newline:	.asciiz	"\n"
	pixels:		.word 	0x00010000,	0x010101,	0x6,		0x3333, 
				0x030c,		0x700853,	0x294999,       -1

.text 0x3000

main:
	ori $v0, $0, 4				#System call code 4 for printing a string
	ori $a0, $0, 0x0   	 		#address of startString is in $a0
	syscall						#print the string


#------- INSERT YOUR CODE HERE -------

     sw    $0, 0($0)
     lw    $9, 0($0)
     
outer:
     lw    $8, 0($0)
     lw    $11, 0($0)

inner:
     add   $12, $9, $11
     lb    $10, pixels($12)
     beq   $10, -1, exit
     lbu   $10, pixels($12)
     add   $8, $8, $10
     addi  $11, $11, 1
     slti  $10, $11, 3
     bne   $10, $0, inner
     div   $8, $11
     mflo  $8
     ori   $v0, $0, 1
     ori   $a0, $8, 0x0
     syscall
     ori   $v0, $0, 4
     ori   $a0, $0, 43
     syscall
     addi  $9, $9, 4
     j     outer

#------------ END CODE ---------------


exit:

	ori $v0, $0, 4				# System call code 4 for printing a string
	ori $a0, $0, 33  			# address of finishString is in $a0; we computed this
								# simply by counting the number of chars in startString,
								# including the \n and the terminating \0

	syscall						#print the string

	ori $v0, $0, 10				#System call code 10 for exit
	syscall						#exit the program
