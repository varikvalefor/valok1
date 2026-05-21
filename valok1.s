.data:
memSize:	.word	4
heap:		.word	0x10040000

.text
# ni'o pruce fi zo'e poi la'oi .a1. judri lo krasi be lo'i ni'u lo sumji be li pa bei la'oi .a0. pe lo se pruce
# be'o be'o poi lo pa moi be ke'a be'o fa'u zo'e cu du lo nilzilcmi fa'o lo datni
valok:
	# a2 - judri
	# a3 - ni barda co judri
	# a1 - memSize
	lw	a2,	heap
valok_l:
	lw	a1,	memSize
	
	lw	a3,	(a2)
	beqz	a3,	valok_pilnoC
	
	mul	a3,	a3,	a1
	
	add	a3,	a3,	a1
	add	a2,	a2,	a3
	
	j valok_l

# ni'o pruce fi zo'e poi ke'a na srana lo se baitni be ko'a goi lo se judri be la'oi .a0.
valok_pilnoC:
	add	t0,	a2,	a1
	add	t1,	t0,	a0
valok_pilnoC_cipra:
	lw	t2,	(t0)
	bnez	t2,	valok_l
	add	t0,	t0,	a1	# judri ningau pe'a
	ble	t0,	t1,	valok_pilnoC_cipra
	
	sw	a0,	(a2)
	mv	a1,	a2
	
	ret

vfree:
	# a0 - cJudri
	# a1 - memSize
	# a2 - max
	lw	a1,	memSize
	lw	a2,	(a0)

	mul	a2,	a2,	a1
	add	a2,	a2,	a0
vfree_l:
	sw	x0,	(a0)
	add	a0,	a0,	a1
	ble	a0,	a2,	vfree_l
	
	ret
