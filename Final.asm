include number.asm
include macros2.asm

.MODEL LARGE
.386
.STACK 200h

MAXTEXTSIZE equ 50

.DATA
	c	dd	?
	_5	dd	5
	b	dd	?
	_4	dd	4
	a	dd	?
	_3	dd	3
	_2	dd	2
	_1	dd	1
	_0	dd	0
	_4.0	dd	4.0
	_stringConstant8	db	"El perro tiene sueño", '$', 28 dup (?)
	_stringConstant7	db	"a es mas grande que b", '$', 27 dup (?)
	_stringConstant6	db	"a es mas chico o igual a b", '$', 22 dup (?)
	foo	db	MAXTEXTSIZE dup (?), '$'
	_stringConstant5	db	"a es mas grande que b", '$', 27 dup (?)
	_2.3	dd	2.3
	_stringConstant4	db	"a es mas grande que b o c es mas grande que b", '$', 3 dup (?)
	_stringConstant3	db	"a es mas grande que b y c es mas grande que b", '$', 3 dup (?)
	_stringConstant2	db	"a no es mas grande que b", '$', 24 dup (?)
	_stringConstant1	db	"sorrentinos", '$', 37 dup (?)
	_stringConstant0	db	"hola buen dia", '$', 35 dup (?)
	_5.6	dd	5.6
	_.9999	dd	.9999
	_99.	dd	99.
	_99999.99	dd	99999.99
	var	db	MAXTEXTSIZE dup (?), '$'
	g	dd	?
	_9	dd	9
	f	dd	?
	e	dd	?
	d	dd	?
	@elem	dd	?
	@count	dd	?
	@sum	dd	?
	@mult	dd	?
	@parBit	dd	?
	@total	dd	?
.CODE

start:
	MOV EAX,@DATA
	MOV DS,EAX
	MOV ES,EAX

	FILD	_1
	FSTP	a
	FILD	_1
	FILD	_4
	FADD
	FSTP	b
	FILD	_2
	FILD	_5
	FMUL
	FILD	b
	FADD
	FSTP	c
	FILD	a
	FILD	c
	FADD
	FSTP	d
	FLD	-1
	FLD	_99999.99
	FMUL
	FSTP	e
	FLD	_99.
	FSTP	f
	FLD	_.9999
	FSTP	g
	FLD	var
	FSTP	foo
	FILD	a
	FILD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	THEN31
	JMP	END_IF33
THEN31:
	DisplayString	_stringConstant2
	newline 1
END_IF33:
	FILD	a
	FILD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	LAZY_AND43
	FILD	c
	FILD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	LAZY_AND43
	JMP	THEN45
LAZY_AND43:
	JMP	END_IF47
THEN45:
	DisplayString	_stringConstant3
	newline 1
END_IF47:
	FILD	a
	FILD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	OR53
	JMP	THEN58
OR53:
	FILD	c
	FILD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	END_IF60
THEN58:
	DisplayString	_stringConstant4
	newline 1
END_IF60:
	FILD	a
	FILD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	IF_ELSE66
	DisplayString	_stringConstant5
	newline 1
IF_ELSE66:
	JMP	END_IF69
	DisplayString	_stringConstant6
	newline 1
END_IF69:
	GetInt	a
	GetInt	b
	GetInt	c
WHILE73:
	FILD	a
	FILD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	END_WHILE84
	DisplayString	_stringConstant7
	newline 1
	FILD	a
	FILD	_1
	FADD
	FSTP	a
	JMP	WHILE73
END_WHILE84:
	FLD	var
	FSTP	foo
REORDER_BEGIN88:
	FILD	a
	FILD	_3
	FADD
	FILD	_1
	FILD	_1
	FADD
	FILD	_9
	FILD	b
	FSUB
REORDER_PROCESSING98:
REORDER_END102:
REORDER_BEGIN103:
	FILD	a
	FILD	b
	FMUL
	FILD	_2
	FSUB
	FILD	c
	FILD	_3
	FADD
	FILD	_1
	FILD	_1
	FADD
	FILD	_9
	FILD	d
	FSUB
REORDER_PROCESSING118:
REORDER_END123:
	FLD	0
	FSTP	@count
	FLD	0
	FSTP	@sum
	FLD	0
	FSTP	@mult
	FLD	-1
	FLD	_4.0
	FMUL
	FSTP	@elem
	FLD	@elem
	FLD	0
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JAE	NEG_FUNC_END_IF143
	FLD	@count
	FLD	0
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE135
	FLD	1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF137
NEG_FUNC_ELSE135:
	FLD	0
	FSTP	@parBit
NEG_FUNC_END_IF137:
	FLD	@parBit
	FSTP	@count
	FLD	@sum
	FLD	@elem
	FADD
	FSTP	@sum
	FLD	@mult
	FLD	@elem
	FMUL
	FSTP	@mult
NEG_FUNC_END_IF143:
	FLD	_2.3
	FSTP	@elem
	FLD	@elem
	FLD	0
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JAE	NEG_FUNC_END_IF160
	FLD	@count
	FLD	0
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE153
	FLD	1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF154
	FLD	0
	FSTP	@parBit
NEG_FUNC_ELSE153:
NEG_FUNC_END_IF154:
	FLD	@parBit
	FSTP	@count
	FLD	@sum
	FLD	@elem
	FADD
	FSTP	@sum
	FLD	@mult
	FLD	@elem
	FMUL
	FSTP	@mult
NEG_FUNC_END_IF160:
	FLD	f
	FSTP	@elem
	FLD	@elem
	FLD	0
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JAE	NEG_FUNC_END_IF177
	FLD	@count
	FLD	0
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE170
	FLD	1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF171
	FLD	0
	FSTP	@parBit
NEG_FUNC_ELSE170:
NEG_FUNC_END_IF171:
	FLD	@parBit
	FSTP	@count
	FLD	@sum
	FLD	@elem
	FADD
	FSTP	@sum
	FLD	@mult
	FLD	@elem
	FMUL
	FSTP	@mult
NEG_FUNC_END_IF177:
	FLD	_5.6
	FSTP	@elem
	FLD	@elem
	FLD	0
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JAE	NEG_FUNC_END_IF194
	FLD	@count
	FLD	0
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE187
	FLD	1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF188
	FLD	0
	FSTP	@parBit
NEG_FUNC_ELSE187:
NEG_FUNC_END_IF188:
	FLD	@parBit
	FSTP	@count
	FLD	@sum
	FLD	@elem
	FADD
	FSTP	@sum
	FLD	@mult
	FLD	@elem
	FMUL
	FSTP	@mult
NEG_FUNC_END_IF194:
	FLD	@count
	FLD	0
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE199
	FLD	@sum
	FSTP	@total
	JMP	NEG_FUNC_END_IF201
NEG_FUNC_ELSE199:
	FLD	@mult
	FSTP	@total
NEG_FUNC_END_IF201:
	FLD	@total
	FSTP	g
	MOV EAX, 4C00h
	INT 21h

	END start