		.data
legajo:	.hword	2960
dni:	.hword	6247
neg:	.hword	0b10101110
pos:	.hword	0xB5C9
res1a:	.hword	0x0
res2a:	.hword	0x0
res1b:	.hword	0x0
res2b:	.hword	0x0
		.code
		lh r1, legajo(r0)
		lh r2, dni(r0)
		lh r5, neg(r0)
		lh r6, pos(r0)
ope:	dsubi r3, r1, 6247
		sh r3, res1a(r0)
		andi r4, r3, 0x80000000
neg1:	beqz r4, pos1
		xnorr r7, r3, r5
		sh r7, res1b(r0)
		jmp opf
pos1:	xnorr r7, r3, r6
		sh r7, res1b(r0)
opf:	dsubi r3, r2, 2960
		sh r3, res2a(r0)
		andi r4, r3, 0x80000000
neg2:	beqz r4, pos2
		xnorr r8, r3, r5
		sh r8, res2b(r0)
		jmp fin
pos2:	xnorr r8, r3, r6
		sh r8, res2b(r0)
fin:	halt
    halt