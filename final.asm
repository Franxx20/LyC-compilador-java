include number.asm
include macros2.asm

include macros.asm

.MODEL LARGE
.386
.STACK 200h

MAXTEXTSIZE equ 50

.DATA
	_3	dd	3.0
	_mult_month	dd	100.0
	_21	dd	21.0
	_0_34	dd	0.34
	_mult_year	dd	10000.0
	date2	dd	?
	flo	dd	?
	stri	db	MAXTEXTSIZE dup (?), '$'
	_2025	dd	2025.0
	_stringConstant0	db	"asdfasdfa", '$', 50 dup (?)
	@month	dd	?
	@day	dd	?
	_08	dd	08.0
	@year	dd	?
	inter	dd	?
	@dateResult	dd	?
	@dateTemp	dd	?	; Temporal para conversión de fecha
	@dateStr	db	10 dup (?), '$'	; Buffer para fecha (8 dígitos + terminador)
.CODE

start:
	MOV AX,@DATA
	MOV DS,AX
	MOV ES,AX

	FLD	_21
	FSTP	@day
	FLD	_08
	FSTP	@month
	FLD	_2025
	FSTP	@year
	FLD	@year
	FLD	_mult_year
	FMUL
	FSTP @dateResult
	FLD	@month
	FLD	_mult_month
	FMUL
	FLD	@dateResult
	FADD
	FSTP @dateResult
	FLD	@dateResult
	FLD	@day
	FADD
	FSTP @dateResult
	FLD	@dateResult
	FSTP	date2
	; Convertir DateConverted a string
	fld	date2
	fistp	dword ptr @dateTemp	; Convertir a entero
	mov	eax, dword ptr @dateTemp
	lea	di, @dateStr	; Buffer para el string
	mov	cx, 8	; 8 dígitos YYYYMMDD
	mov	ebx, 10
	add	di, 7	; Empezar desde el final
@@convertLoop:
	xor	edx, edx
	div	ebx	; Dividir por 10
	add	dl, '0'	; Convertir a ASCII
	mov	[di], dl
	dec	di
	loop	@@convertLoop
	mov	byte ptr [di+9], '$'	; Terminador
	DisplayString	@dateStr
	newline 1
	FLD	_3
	FCHS
	FSTP inter
	FLD	_0_34
	FCHS
	FSTP flo
	MOV	SI,	OFFSET	_stringConstant0
	MOV	DI,	OFFSET	stri
	STRCPY
	DisplayFloat	inter	, 2
	newline 1
	DisplayFloat	flo	, 2
	newline 1
	DisplayString	stri
	newline 1
	MOV EAX, 4C00h
	INT 21h

	END start