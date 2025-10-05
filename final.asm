include number.asm
include macros2.asm

include macros.asm

.MODEL LARGE
.386
.STACK 200h

MAXTEXTSIZE equ 50

.DATA
	_mult_month	dd	100.0
	_21	dd	21.0
	_mult_year	dd	10000.0
	date2	dd	?
	_2025	dd	2025.0
	@month	dd	?
	@day	dd	?
	_08	dd	08.0
	@year	dd	?
	@dateResult	dd	?
.CODE

start:
	MOV AX,@DATA
	MOV DS,AX
	MOV ES,AX

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
	DisplayFloat	date2	, 2
	newline 1
	MOV EAX, 4C00h
	INT 21h

	END start