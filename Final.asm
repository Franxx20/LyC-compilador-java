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
	_5	dd	5.0
	b	dd	?
	@reOrderX2	dd	?
	_4	dd	4.0
	a	dd	?
	@reOrderX1	dd	?
	_3	dd	3.0
	_2	dd	2.0
	_1	dd	1.0
	_0	dd	0.0
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
	_9	dd	9.0
	f	dd	?
	@reOrderX6	dd	?
	e	dd	?
	@reOrderX5	dd	?
	d	dd	?
.CODE

start:
	MOV AX,@DATA
	MOV DS,AX
	MOV ES,AX

	FLD	_1
	FSTP	a
	FLD	_1
	FLD	_4
	FADD
	FSTP	b
	FLD	_2
	FLD	_5
	FMUL
	FLD	b
	FADD
	FSTP	c
	FLD	a
	FLD	c
	FADD
	FSTP	d
	DisplayFloat	a	, 2
	newline 1
	DisplayFloat	b	, 2
	newline 1
	DisplayFloat	c	, 2
	newline 1
	DisplayFloat	d	, 2
	newline 1
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
	FLD	a
	FLD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	THEN35
	JMP	END_IF37
THEN35:
	DisplayString	_stringConstant2
	newline 1
END_IF37:
	FLD	a
	FLD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	LAZY_AND47
	FLD	c
	FLD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	LAZY_AND47
	JMP	THEN49
LAZY_AND47:
	JMP	END_IF51
THEN49:
	DisplayString	_stringConstant3
	newline 1
END_IF51:
	FLD	a
	FLD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	OR57
	JMP	THEN62
OR57:
	FLD	c
	FLD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	END_IF64
THEN62:
	DisplayString	_stringConstant4
	newline 1
END_IF64:
	FLD	a
	FLD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	IF_ELSE70
	DisplayString	_stringConstant5
	newline 1
IF_ELSE70:
	JMP	END_IF73
	DisplayString	_stringConstant6
	newline 1
END_IF73:
	GetFloat	a
	GetFloat	b
	GetFloat	c
WHILE77:
	FLD	a
	FLD	b
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JBE	END_WHILE88
	DisplayString	_stringConstant7
	newline 1
	FLD	a
	FLD	_1
	FSUB
	FSTP	a
	JMP	WHILE77
END_WHILE88:
	MOV	SI,	OFFSET	_stringConstant8
	MOV	SI,	OFFSET	var
	STRCPY
	MOV	SI,	OFFSET	var
	MOV	SI,	OFFSET	foo
	STRCPY
	FLD	a
	FLD	_3
	FADD
	FSTP	@reOrderX1
	FLD	_1
	FLD	_1
	FADD
	FSTP	@reOrderX2
	FLD	_9
	FLD	b
	FSUB
	FSTP	@reOrderX3
	DisplayFloat	@reOrderX3	, 2
	newLine 1
	DisplayFloat	@reOrderX2	, 2
	newLine 1
	DisplayFloat	@reOrderX1	, 2
	newLine 1
	FLD	a
	FLD	b
	FMUL
	FLD	_2
	FSUB
	FSTP	@reOrderX4
	FLD	c
	FLD	_3
	FADD
	FSTP	@reOrderX5
	FLD	_1
	FLD	_1
	FADD
	FSTP	@reOrderX6
	FLD	_9
	FLD	d
	FSUB
	FSTP	@reOrderX7
	DisplayFloat	@reOrderX4	, 2
	newLine 1
	DisplayFloat	@reOrderX5	, 2
	newLine 1
	DisplayFloat	@reOrderX7	, 2
	newLine 1
	DisplayFloat	@reOrderX6	, 2
	newLine 1
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
	JAE	NEG_FUNC_END_IF148
	FLD	@count
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE140
	FLD	_1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF142
NEG_FUNC_ELSE140:
	FLD	_0
	FSTP	@parBit
NEG_FUNC_END_IF142:
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
NEG_FUNC_END_IF148:
	FLD	_2_3
	FSTP	@elem
	FLD	@elem
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JAE	NEG_FUNC_END_IF165
	FLD	@count
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE158
	FLD	_1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF159
	FLD	_0
	FSTP	@parBit
NEG_FUNC_ELSE158:
NEG_FUNC_END_IF159:
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
NEG_FUNC_END_IF165:
	FLD	f
	FSTP	@elem
	FLD	@elem
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JAE	NEG_FUNC_END_IF182
	FLD	@count
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE175
	FLD	_1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF176
	FLD	_0
	FSTP	@parBit
NEG_FUNC_ELSE175:
NEG_FUNC_END_IF176:
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
NEG_FUNC_END_IF182:
	FLD	_5_6
	FSTP	@elem
	FLD	@elem
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JAE	NEG_FUNC_END_IF199
	FLD	@count
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE192
	FLD	_1
	FSTP	@parBit
	JMP	NEG_FUNC_END_IF193
	FLD	_0
	FSTP	@parBit
NEG_FUNC_ELSE192:
NEG_FUNC_END_IF193:
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
NEG_FUNC_END_IF199:
	FLD	@count
	FLDZ
	FXCH
	FCOMP
	FSTSW	AX
	SAHF
	FFREE
	JNE	NEG_FUNC_ELSE204
	FLD	@sum
	FSTP	@total
	JMP	NEG_FUNC_END_IF206
NEG_FUNC_ELSE204:
	FLD	@mult
	FSTP	@total
NEG_FUNC_END_IF206:
	FLD	@total
	FSTP	g
	MOV EAX, 4C00h
	INT 21h

	END start