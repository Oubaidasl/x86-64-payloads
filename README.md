# x86-64 Shellcode Development

A collection of x86-64 assembly shellcode payloads for educational and penetration testing purposes. This project demonstrates advanced exploit development techniques including null-byte elimination, position-independent code, and direct syscall invocation.

## ⚠️ Disclaimer

This repository is for **educational and authorized security testing purposes only**. Unauthorized use of these tools against systems you don't own or have explicit permission to test is illegal.

## 🎯 Features

- **Null-byte free** - Compatible with string operations and buffer overflow exploits
- **Position-independent code (PIC)** - Works across different memory layouts using RIP-relative addressing
- **Direct syscall invocation** - No libc dependencies for stealth and reliability
- **Network byte-order handling** - Proper endianness conversion for reliability

## 📦 Payloads

### Bind Shell
Creates a listening TCP socket on port 4444 and spawns `/bin/sh` when a connection is received.

**Features:**
- Port: 4444 (configurable)
- Null-byte free
- Size: ~90 bytes

### Reverse Shell
Connects back to a remote host and spawns `/bin/sh`.

**Features:**
- Configurable IP and port
- Null-byte free
- Size: ~85 bytes

## 🛠️ Building & Testing

### Prerequisites
- NASM (Netwide Assembler)
- Linux x86-64 system
- GCC/LD for linking

### Compile Instructions

Assemble
nasm -f elf64 bind_shell.nasm -o bind_shell.o

Link
ld bind_shell.o -o bind_shell

Run
./bind_shell

### Testing Bind Shell
Terminal 1: Run the bind shell
./bind_shell

Terminal 2: Connect to it
nc localhost 4444

### Testing Reverse Shell
Terminal 1: Start listener
nc -lvnp 4444

Terminal 2: Run reverse shell (after configuring IP)
./reverse_shell


## 🔍 Technical Details

### Syscalls Used
- `socket()` - Create socket endpoint
- `bind()` - Bind socket to address (bind shell)
- `listen()` - Listen for connections (bind shell)
- `accept()` - Accept incoming connection (bind shell)
- `connect()` - Connect to remote host (reverse shell)
- `dup2()` - Duplicate file descriptors
- `execve()` - Execute `/bin/sh`

### Null-Byte Elimination Techniques
- XOR register clearing instead of MOV with zero
- Bit manipulation for small constants
- Register size manipulation (AL, AX, EAX, RAX)

### Position-Independent Code
- RIP-relative addressing for data access
- Stack-based string storage
- No hardcoded memory addresses

## 📚 Resources

- [Linux Syscall Reference](https://filippo.io/linux-syscall-table/)
- [x86-64 Calling Convention](https://en.wikipedia.org/wiki/X86_calling_conventions)
- [NASM Documentation](https://www.nasm.us/doc/)

## 👤 Author

**AbuUbaida**
- Certifications: eCPPT, eJPT, Google Cybersecurity Professional


---

**Educational Purpose**: This project is part of my cybersecurity research and penetration testing studies at ENSA Tétouan.
