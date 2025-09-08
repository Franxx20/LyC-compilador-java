include number.asm
include macros2.asm

.MODEL LARGE
.386
.STACK 200h

MAXTEXTSIZE equ 50

.DATA
	_21	dd	21.0
	_2025	dd	2025.0
	_menosUno	dd	-1.0
	_100	dd	100.0
	@month	dd	?
	_10000	dd	10000.0
	@day	dd	?
	_08	dd	08.0
	@year	dd	?
	dateC	dd	?
.CODE

start:
	MOV AX,@DATA
	MOV DS,AX
	MOV ES,AX

	MOV	SI,	OFFSET	_21
	MOV	SI,	OFFSET	@day
	STRCPY
	MOV	SI,	OFFSET	_08
	MOV	SI,	OFFSET	@month
	STRCPY
	MOV	SI,	OFFSET	_2025
	MOV	SI,	OFFSET	@year
	STRCPY
	FLD	@year
	FLD	_menosUno
	FLD	_10000
	FMUL
	FMUL
	FSTP	@dateResult
	FLD	@month
	FLD	_menosUno
	FLD	_100
	FMUL
	FMUL
	FLD	@dateResult
	FADD
	FSTP	@dateResult
	FLD	@dateResult
	FLD	@day
	FADD
	FSTP	@dateResult
	FLD	@dateResult
	FSTP	dateC
	MOV EAX, 4C00h
	INT 21h

	END start