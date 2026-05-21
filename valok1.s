.data:
memSize:	.word	4
heap:		.word	0x10040000

.text
# ni'o pruce fi zo'e poi la'oi .a1. judri lo krasi be lo'i ni'u lo sumji be li pa bei la'oi .a0. pe lo se pruce
# be'o be'o poi lo pa moi be ke'a be'o fa'u zo'e cu du lo nilzilcmi fa'o lo datni
valok:
	# s1 - judri
	# s0 - ni barda co judri
	lw	s1,	heap
valok_l:
	lw	s2,	memSize
	
	lw	s0,	(s1)
	beqz	s0,	valok_pilnoC
	
	mul	s0,	s0,	s2
	
	add	s0,	s0,	s2
	add	s1,	s1,	s0
	
	j valok_l

# ni'o pruce fi zo'e poi ke'a na srana lo se baitni be ko'a goi lo se judri be la'oi .a0.
valok_pilnoC:
	add	t0,	s1,	s11
	add	t1,	t0,	a0
valok_pilnoC_cipra:
	lw	t2,	(t0)
	bnez	t2,	valok_l
	addi	t0,	t0,	4	# judri ningau pe'a
	ble	t0,	t1,	valok_pilnoC_cipra
	
	sw	a0,	(s1)
	mv	a1,	s1
	
	ret

vfree:
	# a0 - cJudri
	# s0 - memSize
	# s1 - max
	lw	s0,	memSize
	
	lw	s1,	(a0)
	mul	s1,	s1,	s0
	add	s1,	s1,	a0
vfree_l:
	sw	x0,	(a0)
	add	a0,	a0,	s0
	ble	a0,	s1,	vfree_l
	
	ret
