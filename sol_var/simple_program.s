	.file	"simple_program.c"
	.text
.Ltext0:
	.section	.text.unlikely,"ax",@progbits
.LCOLDB0:
	.text
.LHOTB0:
	.p2align 4,,15
	.section	.text.unlikely
.Ltext_cold0:
	.text
	.globl	add2
	.type	add2, @function
add2:
.LFB71:
	.file 1 "./simple_program.c"
	.loc 1 10 0
	.cfi_startproc
.LVL0:
	.loc 1 11 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000978b, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	cmpl	%esi, %edi
	jg	.L7

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x00001911, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	.loc 1 13 0
	jl	.L8

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x00001588, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	.loc 1 15 0
	je	.L9

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x000063c4, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	.loc 1 17 0
	rep ret
	.p2align 4,,10
	.p2align 3
.L8:
	.loc 1 14 0
	movl	%esi, %eax
	subl	%edi, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	.loc 1 12 0
	movl	%edi, %eax
	subl	%esi, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	.loc 1 16 0
	leal	2(%rdi,%rdi), %eax
	ret
	.cfi_endproc
.LFE71:
	.size	add2, .-add2
	.section	.text.unlikely
.LCOLDE0:
	.text
.LHOTE0:
	.section	.text.unlikely
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4,,15
	.globl	integer_overflow
	.type	integer_overflow, @function
integer_overflow:
.LFB72:
	.loc 1 20 0
	.cfi_startproc
.LVL1:
	.loc 1 21 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x00005814, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	cmpl	$101, %edi
	movl	$-2147483648, %eax
	cmovne	%edi, %eax
	.loc 1 26 0
	ret
	.cfi_endproc
.LFE72:
	.size	integer_overflow, .-integer_overflow
	.section	.text.unlikely
.LCOLDE1:
	.text
.LHOTE1:
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%d"
.LC3:
	.string	"val = %d\n"
.LC4:
	.string	"val < 10 and %d\n"
.LC5:
	.string	"val < 20 and %d\n"
.LC6:
	.string	"val < 30 and %d\n"
.LC7:
	.string	"Amazing grace"
.LC8:
	.string	"love is in the air"
	.section	.text.unlikely
.LCOLDB9:
	.section	.text.startup,"ax",@progbits
.LHOTB9:
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB73:
	.loc 1 28 0
	.cfi_startproc
.LVL2:

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x00003231, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 32 0
	movl	$.LC2, %edi
.LVL3:
	.loc 1 28 0
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	.loc 1 28 0
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	.loc 1 32 0
	leaq	4(%rsp), %rsi
.LVL4:
	call	__isoc99_scanf
.LVL5:
.LBB38:
.LBB39:
	.file 2 "/usr/include/x86_64-linux-gnu/bits/stdio2.h"
	.loc 2 104 0
	xorl	%eax, %eax
	movl	$7, %edx
	movl	$.LC3, %esi
	movl	$1, %edi
	call	__printf_chk
.LVL6:
.LBE39:
.LBE38:
	.loc 1 36 0
	movl	4(%rsp), %ecx
	cmpl	$9, %ecx
	jg	.L14

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000af83, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	.loc 1 38 0
	movl	%ecx, %eax
	movl	$2, %esi
	cltd
	idivl	%esi
	leal	1(%rax), %edi
.LVL7:
.LBB40:
.LBB41:
	.loc 1 11 0
	cmpl	%edi, %ecx
	jle	.L15

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000bdcd, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	.loc 1 12 0
	movl	%ecx, %ebx
	subl	%edi, %ebx
.LVL8:
.L16:
.LBE41:
.LBE40:
.LBB43:
.LBB44:
	.loc 2 104 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x00000f7c, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	movl	%ebx, %edx
	movl	$.LC4, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
.LVL9:
.LBE44:
.LBE43:
	.loc 1 39 0
	xorl	%eax, %eax
	jmp	.L18
.L14:
	.loc 1 42 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000978b, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	cmpl	$19, %ecx
	jg	.L19

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000e7b7, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

.LVL10:
.LBB45:
.LBB46:
	.loc 2 104 0
	movl	%ecx, %ebx
	movl	%ecx, %edx
	movl	$.LC5, %esi
	sarl	%ebx
	movl	$1, %edi
	xorl	%eax, %eax
	subl	%ebx, %edx
	call	__printf_chk
.LVL11:
.LBE46:
.LBE45:
	.loc 1 45 0
	movl	$1, %eax
.L18:
	.loc 1 68 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000e5fb, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	movq	8(%rsp), %rbx
	xorq	%fs:40, %rbx
	jne	.L24

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000bd00, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L19:
	.cfi_restore_state
	.loc 1 49 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000978b, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	cmpl	$29, %ecx
	jg	.L20

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000d5cb, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

.LVL12:
.LBB47:
.LBB48:
	.loc 2 104 0
	movl	%ecx, %eax
	movl	$.LC6, %esi
	movl	$1, %edi
	sarl	%eax
	subl	%eax, %ecx
	xorl	%eax, %eax
	movl	%ecx, %edx
	call	__printf_chk
.LVL13:
.LBE48:
.LBE47:
	.loc 1 53 0
	movl	$2, %eax
	jmp	.L18
.LVL14:
.L15:
.LBB49:
.LBB42:
	.loc 1 13 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x00001b7c, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	jge	.L17

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x00001e89, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	.loc 1 14 0
	movl	%edi, %ebx
	subl	%ecx, %ebx
	jmp	.L16
.L17:
	.loc 1 15 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x00008f17, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	jne	.L16

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x00001e9e, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	.loc 1 16 0
	addl	%ecx, %ecx
.LVL15:
	subl	%eax, %ecx
	leal	(%rcx,%rcx), %ebx
	jmp	.L16
.LVL16:
.L20:
.LBE42:
.LBE49:
	.loc 1 56 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000978b, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	cmpl	$39, %ecx
	jg	.L21

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x000046e2, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

.LVL17:
.LBB50:
.LBB51:
.LBB52:
	.loc 2 104 0
	movl	$.LC7, %edi
	call	puts
.LVL18:
.LBE52:
.LBE51:
	.loc 1 62 0
	movl	$3, %eax
	jmp	.L18
.LVL19:
.L21:
.LBE50:
.LBB53:
.LBB54:
	.loc 2 104 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000beac, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	movl	$.LC8, %edi
	call	puts
.LVL20:
.LBE54:
.LBE53:
	.loc 1 67 0
	xorl	%eax, %eax
	jmp	.L18
.L24:
	.loc 1 68 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x0000ccf1, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	call	__stack_chk_fail
.LVL21:
	.cfi_endproc
.LFE73:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE9:
	.section	.text.startup
.LHOTE9:
	.section	.rodata.str1.1
.LC10:
	.string	"Hello, Dabe"
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.p2align 4,,15
	.globl	teste
	.type	teste, @function
teste:
.LFB74:
	.loc 1 70 0
	.cfi_startproc
.LVL22:
.LBB55:
.LBB56:
	.loc 2 104 0

/* --- AFL TRAMPOLINE (64-BIT) --- */

.align 4

leaq -(128+24)(%rsp), %rsp
movq %rdx,  0(%rsp)
movq %rcx,  8(%rsp)
movq %rax, 16(%rsp)
movq %rsi, 24(%rsp)
movq $0x00001717, %rcx
call __afl_maybe_log
movq 16(%rsp), %rax
movq  8(%rsp), %rcx
movq  0(%rsp), %rdx
leaq (128+24)(%rsp), %rsp

/* --- END --- */

	movl	$.LC10, %esi
	movl	$1, %edi
.LVL23:
	xorl	%eax, %eax
	jmp	__printf_chk
.LVL24:
.LBE56:
.LBE55:
	.cfi_endproc
.LFE74:
	.size	teste, .-teste
	.section	.text.unlikely
.LCOLDE11:
	.text
.LHOTE11:
	.globl	MAX_LINE
	.data
	.align 4
	.type	MAX_LINE, @object
	.size	MAX_LINE, 4
MAX_LINE:
	.long	150
	.text
.Letext0:
	.section	.text.unlikely
.Letext_cold0:
	.file 3 "/usr/lib/gcc/x86_64-linux-gnu/5/include/stddef.h"
	.file 4 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 5 "/usr/include/libio.h"
	.file 6 "/usr/include/stdio.h"
	.file 7 "<built-in>"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x6c6
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF62
	.byte	0xc
	.long	.LASF63
	.long	.LASF64
	.long	.Ldebug_ranges0+0x30
	.quad	0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF7
	.byte	0x3
	.byte	0xd8
	.long	0x34
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF0
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF1
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF2
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x2
	.long	.LASF8
	.byte	0x4
	.byte	0x83
	.long	0x65
	.uleb128 0x2
	.long	.LASF9
	.byte	0x4
	.byte	0x84
	.long	0x65
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF10
	.uleb128 0x5
	.byte	0x8
	.uleb128 0x6
	.byte	0x8
	.long	0x91
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF11
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF12
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF13
	.uleb128 0x6
	.byte	0x8
	.long	0xac
	.uleb128 0x7
	.long	0x91
	.uleb128 0x8
	.long	.LASF43
	.byte	0xd8
	.byte	0x5
	.byte	0xf1
	.long	0x22e
	.uleb128 0x9
	.long	.LASF14
	.byte	0x5
	.byte	0xf2
	.long	0x3b
	.byte	0
	.uleb128 0x9
	.long	.LASF15
	.byte	0x5
	.byte	0xf7
	.long	0x8b
	.byte	0x8
	.uleb128 0x9
	.long	.LASF16
	.byte	0x5
	.byte	0xf8
	.long	0x8b
	.byte	0x10
	.uleb128 0x9
	.long	.LASF17
	.byte	0x5
	.byte	0xf9
	.long	0x8b
	.byte	0x18
	.uleb128 0x9
	.long	.LASF18
	.byte	0x5
	.byte	0xfa
	.long	0x8b
	.byte	0x20
	.uleb128 0x9
	.long	.LASF19
	.byte	0x5
	.byte	0xfb
	.long	0x8b
	.byte	0x28
	.uleb128 0x9
	.long	.LASF20
	.byte	0x5
	.byte	0xfc
	.long	0x8b
	.byte	0x30
	.uleb128 0x9
	.long	.LASF21
	.byte	0x5
	.byte	0xfd
	.long	0x8b
	.byte	0x38
	.uleb128 0x9
	.long	.LASF22
	.byte	0x5
	.byte	0xfe
	.long	0x8b
	.byte	0x40
	.uleb128 0xa
	.long	.LASF23
	.byte	0x5
	.value	0x100
	.long	0x8b
	.byte	0x48
	.uleb128 0xa
	.long	.LASF24
	.byte	0x5
	.value	0x101
	.long	0x8b
	.byte	0x50
	.uleb128 0xa
	.long	.LASF25
	.byte	0x5
	.value	0x102
	.long	0x8b
	.byte	0x58
	.uleb128 0xa
	.long	.LASF26
	.byte	0x5
	.value	0x104
	.long	0x266
	.byte	0x60
	.uleb128 0xa
	.long	.LASF27
	.byte	0x5
	.value	0x106
	.long	0x26c
	.byte	0x68
	.uleb128 0xa
	.long	.LASF28
	.byte	0x5
	.value	0x108
	.long	0x3b
	.byte	0x70
	.uleb128 0xa
	.long	.LASF29
	.byte	0x5
	.value	0x10c
	.long	0x3b
	.byte	0x74
	.uleb128 0xa
	.long	.LASF30
	.byte	0x5
	.value	0x10e
	.long	0x6c
	.byte	0x78
	.uleb128 0xa
	.long	.LASF31
	.byte	0x5
	.value	0x112
	.long	0x50
	.byte	0x80
	.uleb128 0xa
	.long	.LASF32
	.byte	0x5
	.value	0x113
	.long	0x57
	.byte	0x82
	.uleb128 0xa
	.long	.LASF33
	.byte	0x5
	.value	0x114
	.long	0x272
	.byte	0x83
	.uleb128 0xa
	.long	.LASF34
	.byte	0x5
	.value	0x118
	.long	0x282
	.byte	0x88
	.uleb128 0xa
	.long	.LASF35
	.byte	0x5
	.value	0x121
	.long	0x77
	.byte	0x90
	.uleb128 0xa
	.long	.LASF36
	.byte	0x5
	.value	0x129
	.long	0x89
	.byte	0x98
	.uleb128 0xa
	.long	.LASF37
	.byte	0x5
	.value	0x12a
	.long	0x89
	.byte	0xa0
	.uleb128 0xa
	.long	.LASF38
	.byte	0x5
	.value	0x12b
	.long	0x89
	.byte	0xa8
	.uleb128 0xa
	.long	.LASF39
	.byte	0x5
	.value	0x12c
	.long	0x89
	.byte	0xb0
	.uleb128 0xa
	.long	.LASF40
	.byte	0x5
	.value	0x12e
	.long	0x29
	.byte	0xb8
	.uleb128 0xa
	.long	.LASF41
	.byte	0x5
	.value	0x12f
	.long	0x3b
	.byte	0xc0
	.uleb128 0xa
	.long	.LASF42
	.byte	0x5
	.value	0x131
	.long	0x288
	.byte	0xc4
	.byte	0
	.uleb128 0xb
	.long	.LASF65
	.byte	0x5
	.byte	0x96
	.uleb128 0x8
	.long	.LASF44
	.byte	0x18
	.byte	0x5
	.byte	0x9c
	.long	0x266
	.uleb128 0x9
	.long	.LASF45
	.byte	0x5
	.byte	0x9d
	.long	0x266
	.byte	0
	.uleb128 0x9
	.long	.LASF46
	.byte	0x5
	.byte	0x9e
	.long	0x26c
	.byte	0x8
	.uleb128 0x9
	.long	.LASF47
	.byte	0x5
	.byte	0xa2
	.long	0x3b
	.byte	0x10
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x235
	.uleb128 0x6
	.byte	0x8
	.long	0xb1
	.uleb128 0xc
	.long	0x91
	.long	0x282
	.uleb128 0xd
	.long	0x82
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x22e
	.uleb128 0xc
	.long	0x91
	.long	0x298
	.uleb128 0xd
	.long	0x82
	.byte	0x13
	.byte	0
	.uleb128 0xe
	.long	.LASF66
	.byte	0x2
	.byte	0x66
	.long	0x3b
	.byte	0x3
	.long	0x2b5
	.uleb128 0xf
	.long	.LASF48
	.byte	0x2
	.byte	0x66
	.long	0x2b5
	.uleb128 0x10
	.byte	0
	.uleb128 0x11
	.long	0xa6
	.uleb128 0x12
	.long	.LASF51
	.byte	0x1
	.byte	0xa
	.long	0x3b
	.byte	0x1
	.long	0x2e1
	.uleb128 0xf
	.long	.LASF49
	.byte	0x1
	.byte	0xa
	.long	0x3b
	.uleb128 0xf
	.long	.LASF50
	.byte	0x1
	.byte	0xa
	.long	0x3b
	.byte	0
	.uleb128 0x12
	.long	.LASF52
	.byte	0x1
	.byte	0x13
	.long	0x3b
	.byte	0x1
	.long	0x2fb
	.uleb128 0x13
	.string	"a"
	.byte	0x1
	.byte	0x13
	.long	0x3b
	.byte	0
	.uleb128 0x14
	.long	0x2ba
	.quad	.LFB71
	.quad	.LFE71-.LFB71
	.uleb128 0x1
	.byte	0x9c
	.long	0x325
	.uleb128 0x15
	.long	0x2ca
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x15
	.long	0x2d5
	.uleb128 0x1
	.byte	0x54
	.byte	0
	.uleb128 0x14
	.long	0x2e1
	.quad	.LFB72
	.quad	.LFE72-.LFB72
	.uleb128 0x1
	.byte	0x9c
	.long	0x348
	.uleb128 0x15
	.long	0x2f1
	.uleb128 0x1
	.byte	0x55
	.byte	0
	.uleb128 0x16
	.long	.LASF67
	.byte	0x1
	.byte	0x1c
	.long	0x3b
	.quad	.LFB73
	.quad	.LFE73-.LFB73
	.uleb128 0x1
	.byte	0x9c
	.long	0x5c7
	.uleb128 0x17
	.long	.LASF53
	.byte	0x1
	.byte	0x1c
	.long	0x3b
	.long	.LLST0
	.uleb128 0x17
	.long	.LASF54
	.byte	0x1
	.byte	0x1c
	.long	0x5c7
	.long	.LLST1
	.uleb128 0x18
	.string	"val"
	.byte	0x1
	.byte	0x1e
	.long	0x3b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x19
	.string	"a"
	.byte	0x1
	.byte	0x21
	.long	0x3b
	.byte	0x7
	.uleb128 0x1a
	.long	0x298
	.quad	.LBB38
	.quad	.LBE38-.LBB38
	.byte	0x1
	.byte	0x22
	.long	0x3e9
	.uleb128 0x1b
	.long	0x2a8
	.long	.LLST2
	.uleb128 0x1c
	.quad	.LVL6
	.long	0x66b
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC3
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x37
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	0x2ba
	.quad	.LBB40
	.long	.Ldebug_ranges0+0
	.byte	0x1
	.byte	0x26
	.long	0x413
	.uleb128 0x1b
	.long	0x2d5
	.long	.LLST3
	.uleb128 0x1b
	.long	0x2ca
	.long	.LLST4
	.byte	0
	.uleb128 0x1a
	.long	0x298
	.quad	.LBB43
	.quad	.LBE43-.LBB43
	.byte	0x1
	.byte	0x26
	.long	0x45e
	.uleb128 0x1b
	.long	0x2a8
	.long	.LLST5
	.uleb128 0x1c
	.quad	.LVL9
	.long	0x66b
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC4
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x298
	.quad	.LBB45
	.quad	.LBE45-.LBB45
	.byte	0x1
	.byte	0x2c
	.long	0x4a3
	.uleb128 0x1b
	.long	0x2a8
	.long	.LLST6
	.uleb128 0x1c
	.quad	.LVL11
	.long	0x66b
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC5
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x298
	.quad	.LBB47
	.quad	.LBE47-.LBB47
	.byte	0x1
	.byte	0x33
	.long	0x4e8
	.uleb128 0x1b
	.long	0x2a8
	.long	.LLST7
	.uleb128 0x1c
	.quad	.LVL13
	.long	0x66b
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
	.byte	0
	.byte	0
	.uleb128 0x1f
	.quad	.LBB50
	.quad	.LBE50-.LBB50
	.long	0x554
	.uleb128 0x20
	.string	"i"
	.byte	0x1
	.byte	0x3b
	.long	0x3b
	.long	.LLST8
	.uleb128 0x20
	.string	"b"
	.byte	0x1
	.byte	0x3c
	.long	0x5e
	.long	.LLST9
	.uleb128 0x21
	.long	0x298
	.quad	.LBB51
	.quad	.LBE51-.LBB51
	.byte	0x1
	.byte	0x3d
	.uleb128 0x1b
	.long	0x2a8
	.long	.LLST10
	.uleb128 0x1c
	.quad	.LVL18
	.long	0x689
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC7
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x298
	.quad	.LBB53
	.quad	.LBE53-.LBB53
	.byte	0x1
	.byte	0x41
	.long	0x594
	.uleb128 0x1b
	.long	0x2a8
	.long	.LLST11
	.uleb128 0x1c
	.quad	.LVL20
	.long	0x689
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC8
	.byte	0
	.byte	0
	.uleb128 0x22
	.quad	.LVL5
	.long	0x6b0
	.long	0x5b9
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.byte	0
	.uleb128 0x23
	.quad	.LVL21
	.long	0x6c0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x8b
	.uleb128 0x24
	.long	.LASF68
	.byte	0x1
	.byte	0x46
	.quad	.LFB74
	.quad	.LFE74-.LFB74
	.uleb128 0x1
	.byte	0x9c
	.long	0x640
	.uleb128 0x25
	.string	"i"
	.byte	0x1
	.byte	0x46
	.long	0x3b
	.long	.LLST12
	.uleb128 0x21
	.long	0x298
	.quad	.LBB55
	.quad	.LBE55-.LBB55
	.byte	0x1
	.byte	0x46
	.uleb128 0x15
	.long	0x2a8
	.uleb128 0xa
	.byte	0x3
	.quad	.LC10
	.byte	0x9f
	.uleb128 0x26
	.quad	.LVL24
	.long	0x66b
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x1d
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC10
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x27
	.long	.LASF55
	.byte	0x6
	.byte	0xa8
	.long	0x26c
	.uleb128 0x27
	.long	.LASF56
	.byte	0x6
	.byte	0xa9
	.long	0x26c
	.uleb128 0x28
	.long	.LASF57
	.byte	0x1
	.byte	0x7
	.long	0x3b
	.uleb128 0x9
	.byte	0x3
	.quad	MAX_LINE
	.uleb128 0x29
	.long	.LASF69
	.long	.LASF69
	.byte	0x2
	.byte	0x57
	.uleb128 0x2a
	.uleb128 0x11
	.byte	0x9e
	.uleb128 0xf
	.byte	0x41
	.byte	0x6d
	.byte	0x61
	.byte	0x7a
	.byte	0x69
	.byte	0x6e
	.byte	0x67
	.byte	0x20
	.byte	0x67
	.byte	0x72
	.byte	0x61
	.byte	0x63
	.byte	0x65
	.byte	0xa
	.byte	0
	.uleb128 0x2b
	.long	.LASF58
	.long	.LASF60
	.byte	0x7
	.byte	0
	.long	.LASF58
	.uleb128 0x2a
	.uleb128 0x16
	.byte	0x9e
	.uleb128 0x14
	.byte	0x6c
	.byte	0x6f
	.byte	0x76
	.byte	0x65
	.byte	0x20
	.byte	0x69
	.byte	0x73
	.byte	0x20
	.byte	0x69
	.byte	0x6e
	.byte	0x20
	.byte	0x74
	.byte	0x68
	.byte	0x65
	.byte	0x20
	.byte	0x61
	.byte	0x69
	.byte	0x72
	.byte	0xa
	.byte	0
	.uleb128 0x2c
	.long	.LASF59
	.long	.LASF61
	.byte	0x6
	.value	0x1be
	.long	.LASF59
	.uleb128 0x2d
	.long	.LASF70
	.long	.LASF70
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x410a
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x2111
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x4109
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x4109
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x2115
	.uleb128 0x19
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x36
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x6e
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.quad	.LVL2
	.quad	.LVL3
	.value	0x1
	.byte	0x55
	.quad	.LVL3
	.quad	.LFE73
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
.LLST1:
	.quad	.LVL2
	.quad	.LVL4
	.value	0x1
	.byte	0x54
	.quad	.LVL4
	.quad	.LFE73
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.quad	0
	.quad	0
.LLST2:
	.quad	.LVL5
	.quad	.LVL6
	.value	0xa
	.byte	0x3
	.quad	.LC3
	.byte	0x9f
	.quad	0
	.quad	0
.LLST3:
	.quad	.LVL7
	.quad	.LVL8
	.value	0x1
	.byte	0x55
	.quad	.LVL14
	.quad	.LVL16
	.value	0x1
	.byte	0x55
	.quad	0
	.quad	0
.LLST4:
	.quad	.LVL7
	.quad	.LVL8
	.value	0x1
	.byte	0x52
	.quad	.LVL14
	.quad	.LVL15
	.value	0x1
	.byte	0x52
	.quad	.LVL15
	.quad	.LVL16
	.value	0x2
	.byte	0x91
	.sleb128 -28
	.quad	0
	.quad	0
.LLST5:
	.quad	.LVL8
	.quad	.LVL9
	.value	0xa
	.byte	0x3
	.quad	.LC4
	.byte	0x9f
	.quad	0
	.quad	0
.LLST6:
	.quad	.LVL10
	.quad	.LVL11
	.value	0xa
	.byte	0x3
	.quad	.LC5
	.byte	0x9f
	.quad	0
	.quad	0
.LLST7:
	.quad	.LVL12
	.quad	.LVL13
	.value	0xa
	.byte	0x3
	.quad	.LC6
	.byte	0x9f
	.quad	0
	.quad	0
.LLST8:
	.quad	.LVL17
	.quad	.LVL19
	.value	0x3
	.byte	0x8
	.byte	0x65
	.byte	0x9f
	.quad	0
	.quad	0
.LLST9:
	.quad	.LVL17
	.quad	.LVL19
	.value	0x2
	.byte	0x30
	.byte	0x9f
	.quad	0
	.quad	0
.LLST10:
	.quad	.LVL17
	.quad	.LVL18
	.value	0x6
	.byte	0xf2
	.long	.Ldebug_info0+1654
	.sleb128 0
	.quad	0
	.quad	0
.LLST11:
	.quad	.LVL19
	.quad	.LVL20
	.value	0x6
	.byte	0xf2
	.long	.Ldebug_info0+1688
	.sleb128 0
	.quad	0
	.quad	0
.LLST12:
	.quad	.LVL22
	.quad	.LVL23
	.value	0x1
	.byte	0x55
	.quad	.LVL23
	.quad	.LFE74
	.value	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.quad	0
	.quad	0
	.section	.debug_aranges,"",@progbits
	.long	0x3c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	.LFB73
	.quad	.LFE73-.LFB73
	.quad	0
	.quad	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.LBB40
	.quad	.LBE40
	.quad	.LBB49
	.quad	.LBE49
	.quad	0
	.quad	0
	.quad	.Ltext0
	.quad	.Letext0
	.quad	.LFB73
	.quad	.LFE73
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF60:
	.string	"__builtin_puts"
.LASF69:
	.string	"__printf_chk"
.LASF43:
	.string	"_IO_FILE"
.LASF61:
	.string	"scanf"
.LASF25:
	.string	"_IO_save_end"
.LASF5:
	.string	"short int"
.LASF7:
	.string	"size_t"
.LASF10:
	.string	"sizetype"
.LASF59:
	.string	"__isoc99_scanf"
.LASF35:
	.string	"_offset"
.LASF52:
	.string	"integer_overflow"
.LASF51:
	.string	"add2"
.LASF19:
	.string	"_IO_write_ptr"
.LASF14:
	.string	"_flags"
.LASF21:
	.string	"_IO_buf_base"
.LASF26:
	.string	"_markers"
.LASF16:
	.string	"_IO_read_end"
.LASF63:
	.string	"./simple_program.c"
.LASF44:
	.string	"_IO_marker"
.LASF12:
	.string	"long long int"
.LASF62:
	.string	"GNU C11 5.4.0 20160609 -mtune=generic -march=x86-64 -g -O3 -funroll-loops -fstack-protector-strong"
.LASF34:
	.string	"_lock"
.LASF6:
	.string	"long int"
.LASF66:
	.string	"printf"
.LASF31:
	.string	"_cur_column"
.LASF64:
	.string	"/home/francis/Documents/work/git/sol_var"
.LASF47:
	.string	"_pos"
.LASF54:
	.string	"argv"
.LASF46:
	.string	"_sbuf"
.LASF30:
	.string	"_old_offset"
.LASF68:
	.string	"teste"
.LASF2:
	.string	"unsigned char"
.LASF53:
	.string	"argc"
.LASF4:
	.string	"signed char"
.LASF13:
	.string	"long long unsigned int"
.LASF1:
	.string	"unsigned int"
.LASF49:
	.string	"val1"
.LASF33:
	.string	"_shortbuf"
.LASF58:
	.string	"puts"
.LASF18:
	.string	"_IO_write_base"
.LASF42:
	.string	"_unused2"
.LASF15:
	.string	"_IO_read_ptr"
.LASF22:
	.string	"_IO_buf_end"
.LASF11:
	.string	"char"
.LASF67:
	.string	"main"
.LASF45:
	.string	"_next"
.LASF36:
	.string	"__pad1"
.LASF37:
	.string	"__pad2"
.LASF38:
	.string	"__pad3"
.LASF39:
	.string	"__pad4"
.LASF40:
	.string	"__pad5"
.LASF3:
	.string	"short unsigned int"
.LASF48:
	.string	"__fmt"
.LASF0:
	.string	"long unsigned int"
.LASF20:
	.string	"_IO_write_end"
.LASF9:
	.string	"__off64_t"
.LASF28:
	.string	"_fileno"
.LASF27:
	.string	"_chain"
.LASF8:
	.string	"__off_t"
.LASF24:
	.string	"_IO_backup_base"
.LASF55:
	.string	"stdin"
.LASF29:
	.string	"_flags2"
.LASF41:
	.string	"_mode"
.LASF17:
	.string	"_IO_read_base"
.LASF32:
	.string	"_vtable_offset"
.LASF23:
	.string	"_IO_save_base"
.LASF70:
	.string	"__stack_chk_fail"
.LASF50:
	.string	"val2"
.LASF57:
	.string	"MAX_LINE"
.LASF56:
	.string	"stdout"
.LASF65:
	.string	"_IO_lock_t"
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits

/* --- AFL MAIN PAYLOAD (64-BIT) --- */

.text
.att_syntax
.code64
.align 8

__afl_maybe_log:

  lahf
  seto  %al

  /* Check if SHM region is already mapped. */

  movq  __afl_area_ptr(%rip), %rdx
  testq %rdx, %rdx
  je    __afl_setup

__afl_store:

  /* Calculate and store hit for the code location specified in rcx. */

  xorq __afl_prev_loc(%rip), %rcx
  xorq %rcx, __afl_prev_loc(%rip)
  shrq $1, __afl_prev_loc(%rip)

  incb (%rdx, %rcx, 1)

__afl_return:

  addb $127, %al
  sahf
  ret

.align 8

__afl_setup:

  /* Do not retry setup if we had previous failures. */

  cmpb $0, __afl_setup_failure(%rip)
  jne __afl_return

  /* Check out if we have a global pointer on file. */

  movq  __afl_global_area_ptr@GOTPCREL(%rip), %rdx
  movq  (%rdx), %rdx
  testq %rdx, %rdx
  je    __afl_setup_first

  movq %rdx, __afl_area_ptr(%rip)
  jmp  __afl_store

__afl_setup_first:

  /* Save everything that is not yet saved and that may be touched by
     getenv() and several other libcalls we'll be relying on. */

  leaq -352(%rsp), %rsp

  movq %rax,   0(%rsp)
  movq %rcx,   8(%rsp)
  movq %rdi,  16(%rsp)
  movq %rsi,  32(%rsp)
  movq %r8,   40(%rsp)
  movq %r9,   48(%rsp)
  movq %r10,  56(%rsp)
  movq %r11,  64(%rsp)

  movq %xmm0,  96(%rsp)
  movq %xmm1,  112(%rsp)
  movq %xmm2,  128(%rsp)
  movq %xmm3,  144(%rsp)
  movq %xmm4,  160(%rsp)
  movq %xmm5,  176(%rsp)
  movq %xmm6,  192(%rsp)
  movq %xmm7,  208(%rsp)
  movq %xmm8,  224(%rsp)
  movq %xmm9,  240(%rsp)
  movq %xmm10, 256(%rsp)
  movq %xmm11, 272(%rsp)
  movq %xmm12, 288(%rsp)
  movq %xmm13, 304(%rsp)
  movq %xmm14, 320(%rsp)
  movq %xmm15, 336(%rsp)

  /* Map SHM, jumping to __afl_setup_abort if something goes wrong. */

  /* The 64-bit ABI requires 16-byte stack alignment. We'll keep the
     original stack ptr in the callee-saved r12. */

  pushq %r12
  movq  %rsp, %r12
  subq  $16, %rsp
  andq  $0xfffffffffffffff0, %rsp

  leaq .AFL_SHM_ENV(%rip), %rdi
call getenv@PLT

  testq %rax, %rax
  je    __afl_setup_abort

  movq  %rax, %rdi
call atoi@PLT

  xorq %rdx, %rdx   /* shmat flags    */
  xorq %rsi, %rsi   /* requested addr */
  movq %rax, %rdi   /* SHM ID         */
call shmat@PLT

  cmpq $-1, %rax
  je   __afl_setup_abort

  /* Store the address of the SHM region. */

  movq %rax, %rdx
  movq %rax, __afl_area_ptr(%rip)

  movq __afl_global_area_ptr@GOTPCREL(%rip), %rdx
  movq %rax, (%rdx)
  movq %rax, %rdx


__afl_forkserver:

  /* Enter the fork server mode to avoid the overhead of execve() calls. We
     push rdx (area ptr) twice to keep stack alignment neat. */

  pushq %rdx
  pushq %rdx

/*   Save the important information first  */
  movl $198, __fsrv_read(%rip)
  movl $199, __fsrv_write(%rip)
  /* Phone home and tell the parent that we're OK. (Note that signals with
     no SA_RESTART will mess it up). If this fails, assume that the fd is
     closed because we were execve()d from an instrumented binary, or because
     the parent doesn't want to use the fork server. */

  movq $4, %rdx               /* length    */
  leaq __afl_temp(%rip), %rsi /* data      */
  movq __fsrv_write(%rip), %rdi       /* file desc */
call write@PLT

  cmpq $4, %rax
  jne  __afl_fork_resume

__afl_fork_wait_loop:

  /* Wait for parent by reading from the pipe. Abort if read fails. */

  movq $4, %rdx               /* length    */
  leaq __afl_temp(%rip), %rsi /* data      */
  movq __fsrv_read(%rip), %rdi /* file desc */
call read@PLT
  cmpq $4, %rax
  jne  __afl_die

  /* Once woken up, create a clone of our process. This is an excellent use
     case for syscall(__NR_clone, 0, CLONE_PARENT), but glibc boneheadedly
     caches getpid() results and offers no way to update the value, breaking
     abort(), raise(), and a bunch of other things :-( */

call fork@PLT
  cmpq $0, %rax
  jl   __afl_die
  je   __afl_fork_resume

  /* In parent process: write PID to pipe, then wait for child. */

  movl %eax, __afl_fork_pid(%rip)

  movq $4, %rdx                   /* length    */
  leaq __afl_fork_pid(%rip), %rsi /* data      */
  movq __fsrv_write(%rip), %rdi /* file desc */
call write@PLT

  movq $0, %rdx                   /* no flags  */
  leaq __afl_temp(%rip), %rsi     /* status    */
  movq __afl_fork_pid(%rip), %rdi /* PID       */
call waitpid@PLT
  cmpq $0, %rax
  jle  __afl_die

  /* Relay wait status to pipe, then loop back. */

  movq $4, %rdx               /* length    */
  leaq __afl_temp(%rip), %rsi /* data      */
  movq __fsrv_write(%rip), %rdi /* file desc */
call write@PLT

  jmp  __afl_fork_wait_loop

__afl_fork_resume:

  /* In child process: close fds, resume execution. */

  movq $198, %rdi
call close@PLT

  movq $(198 + 1), %rdi
call close@PLT

  popq %rdx
  popq %rdx

  movq %r12, %rsp
  popq %r12

  movq  0(%rsp), %rax
  movq  8(%rsp), %rcx
  movq 16(%rsp), %rdi
  movq 32(%rsp), %rsi
  movq 40(%rsp), %r8
  movq 48(%rsp), %r9
  movq 56(%rsp), %r10
  movq 64(%rsp), %r11

  movq  96(%rsp), %xmm0
  movq 112(%rsp), %xmm1
  movq 128(%rsp), %xmm2
  movq 144(%rsp), %xmm3
  movq 160(%rsp), %xmm4
  movq 176(%rsp), %xmm5
  movq 192(%rsp), %xmm6
  movq 208(%rsp), %xmm7
  movq 224(%rsp), %xmm8
  movq 240(%rsp), %xmm9
  movq 256(%rsp), %xmm10
  movq 272(%rsp), %xmm11
  movq 288(%rsp), %xmm12
  movq 304(%rsp), %xmm13
  movq 320(%rsp), %xmm14
  movq 336(%rsp), %xmm15

  leaq 352(%rsp), %rsp

  jmp  __afl_store

__afl_die:

  xorq %rax, %rax
call _exit@PLT

__afl_setup_abort:

  /* Record setup failure so that we don't keep calling
     shmget() / shmat() over and over again. */

  incb __afl_setup_failure(%rip)

  movq %r12, %rsp
  popq %r12

  movq  0(%rsp), %rax
  movq  8(%rsp), %rcx
  movq 16(%rsp), %rdi
  movq 32(%rsp), %rsi
  movq 40(%rsp), %r8
  movq 48(%rsp), %r9
  movq 56(%rsp), %r10
  movq 64(%rsp), %r11

  movq  96(%rsp), %xmm0
  movq 112(%rsp), %xmm1
  movq 128(%rsp), %xmm2
  movq 144(%rsp), %xmm3
  movq 160(%rsp), %xmm4
  movq 176(%rsp), %xmm5
  movq 192(%rsp), %xmm6
  m