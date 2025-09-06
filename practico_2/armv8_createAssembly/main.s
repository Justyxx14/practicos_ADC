	.text
	.org 0x0000

// 2A)

/* 	add x2, x0, x0
	add x3, x0, x0
	add x30, x30, x30

loop1:
	cbz x30, end
	stur x3, [x2, #0]
	add x3, x3, x1
	sub x30, x30, x1
	add x2, x2, x8
	cbz x0, loop1

end: */



// 2B)

/*  	add x2, x0, x0
	add x3, x0, x0
	add x29, x30, x30

loop1:
	cbz x29, sum
	stur x3, [x2, #0]
	add x3, x3, x1
	sub x29, x29, x1
	add x2, x2, x8
	cbz x0, loop1

sum: 
	add x29, x30, x30
	add x2, x0, x0
	add x4, x0, x0

loop2:
	cbz x29, end
	ldur x3, [x2, #0]
	add x4, x4, x3
	sub x29, x29, x1
	add x2, x2, x8
	cbz x0, loop2

end:
	stur x4, [x2, #0] */
	
// 2C)

/* 	add x2, x0, x0

loop1:
	cbz x17, end
	add x2, x16, x2
	sub x17, x17, x1
	cbz xzr, loop1

end:
	stur x2, [x0, #0] */
