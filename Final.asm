include number.asm
include macros2.asm

.MODEL LARGE
.386
.STACK 200h

MAXTEXTSIZE equ 50

.DATA
	@reOrderX4	dd	?
	c	dd	?
	@reOrderX3	dd	?
	_5	dd	5
	b	dd	?
	@reOrderX2	dd	?
	_4	dd	4
	a	dd	?
	@reOrderX1	dd	?
	_3	dd	3
	_2	dd	2
	_1	dd	1
	_0	dd	0
	@total	dd	?
	_2_3	dd	2.3
	_99_	dd	99.
	__9999	dd	.9999
	_5_6	dd	5.6
	_stringConstant8	db	"El perro tiene sueño", '$', 28 dup (?)
	_menosUno	dd	-1.0
	@sum	dd	?
	_stringConstant7	db	"a es mas grande que b", '$', 27 dup (?)
	_stringConstant6	db	"a es mas chico o igual a b", '$', 22 dup (?)
	foo	db	MAXTEXTSIZE dup (?), '$'
	_stringConstant5	db	"a es mas grande que b", '$', 27 dup (?)
	_stringConstant4	db	"a es mas grande que b o c es mas grande que b", '$', 3 dup (?)
	_stringConstant3	db	"a es mas grande que b y c es mas grande que b", '$', 3 dup (?)
	_stringConstant2	db	"a no es mas grande que b", '$', 24 dup (?)
	_stringConstant1	db	"sorrentinos", '$', 37 dup (?)
	_stringConstant0	db	"hola buen dia", '$', 35 dup (?)
	@mult	dd	?
	@elem	dd	?
	var	db	MAXTEXTSIZE dup (?), '$'
	_99999_99	dd	99999.99
	_4_0	dd	4.0
	@parBit	dd	?
	@count	dd	?
	g	dd	?
	@reOrderX7	dd	?
	_9	dd	9
	f	dd	?
	@reOrderX6	dd	?
	e	dd	?
	@reOrderX5	dd	?
	d	dd	?
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
	FLD	_menosUno
	FLD	_99999_99
	FMUL
	FSTP	e
	FLD	_99_
	FSTP	f
	FLD	__9999
	FSTP	g
	MOV	SI,	OFFSET	_stringConstant0
	MOV	SI,	OFFSET	var
	STRCPY
	MOV	SI,	OFFSET	var
	MOV	SI,	OFFSET	foo
	STRCPY
	MOV	SI,	OFFSET	_stringConstant1
	MOV	SI,	OFFSET	var
	STRCPY
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
	GetInteger	a
	GetInteger	b
	GetInteger	c
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
	MOV	SI,	OFFSET	_stringConstant8
	MOV	SI,	OFFSET	var
	STRCPY
	MOV	SI,	OFFSET	var
	MOV	SI,	OFFSET	foo
	STRCPY
	FILD	a
	FILD	_3
	FADD
	FSTP	@reOrderX1
	FILD	_1
	FILD	_1
	FADD
	FSTP	@reOrderX2
	FILD	_9
	FILD	b
	FSUB
	FSTP	@reOrderX3
	DisplayFloat	@reOrderX3	, 2
	DisplayFloat	@reOrderX2	, 2
	DisplayFloat	@reOrderX1	, 2
	FILD	a
	FILD	b
	FMUL
	FILD	_2
	FSUB
	FSTP	@reOrderX4
	FILD	c
	FILD	_3
	FADD
	FSTP	@reOrderX5
	FILD	_1
	FILD	_1
	FADD
	FSTP	@reOrderX6
	FILD	_9
	FILD	d
	FSUB
	FSTP	@reOrderX7
	DisplayFloat	@reOrderX4	, 2
	DisplayFloat	@reOrderX5	, 2
	DisplayFloat	@reOrderX7	, 2
	DisplayFloat	@reOrderX6	, 2
	FLD	_0
	FSTP	@count
	FLD	_0
	FSTP	@sum
	FLD	_0
	FSTP	@mult
	FLD	_menosUno
	FLD	_4_0
	FMUL
	FSTP	@elem
	FLD	@elem
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JAE	NEG_FUNC_END_IF144
	FLD	@count
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE136
	FLD	_1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF138
NEG_FUNC_ELSE136:
	FLD	_0
	FSTP	@parBit
NEG_FUNC_END_IF138:
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
NEG_FUNC_END_IF144:
	FLD	_2_3
	FSTP	@elem
	FLD	@elem
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JAE	NEG_FUNC_END_IF161
	FLD	@count
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE154
	FLD	_1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF155
	FLD	_0
	FSTP	@parBit
NEG_FUNC_ELSE154:
NEG_FUNC_END_IF155:
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
NEG_FUNC_END_IF161:
	FLD	f
	FSTP	@elem
	FLD	@elem
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JAE	NEG_FUNC_END_IF178
	FLD	@count
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE171
	FLD	_1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF172
	FLD	_0
	FSTP	@parBit
NEG_FUNC_ELSE171:
NEG_FUNC_END_IF172:
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
NEG_FUNC_END_IF178:
	FLD	_5_6
	FSTP	@elem
	FLD	@elem
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JAE	NEG_FUNC_END_IF195
	FLD	@count
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE188
	FLD	_1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF189
	FLD	_0
	FSTP	@parBit
NEG_FUNC_ELSE188:
NEG_FUNC_END_IF189:
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
NEG_FUNC_END_IF195:
	FLD	@count
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE200
	FLD	@sum
	FSTP	@total
	JMP	NEG_FUNC_END_IF202
NEG_FUNC_ELSE200:
	FLD	@mult
	FSTP	@total
NEG_FUNC_END_IF202:
	FLD	@total
	FSTP	g
	MOV EAX, 4C00h
	INT 21h

	END start