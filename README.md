# Go Assembly

## Prerequisites

- Go
- Garble
- Radare2

### Install Go

Install go from https://go.dev/

### Install Garble

Install Garble from https://github.com/burrowers/garble with the command:

```bash
go install mvdan.cc/garble@latest
```

### Install Radare2

Install radare2 from https://github.com/radareorg/radare2/releases/tag/6.0.8
with the command:

```bash
curl -Ls https://github.com/radareorg/radare2/releases/download/6.0.8/radare2-6.0.8.tar.xz | tar xJv
radare2-6.0.8/sys/install.sh
```

## Build

1. Build the three variants of the executable:

- Go (no build flags)
- Go (-ldflags '-s -w')
- Garble (-tiny -literals)

Run the command:

```bash
build.sh
```

2. Find the string 'thingy' in the binary

```bash
strings -t x main.exe | grep thingy

 bdeb6  max=scav  ptr ] = (usageinit  ms, fault tab= top=[...], fp:ntohsGreeksse41sse42ssse3thingyStringFormat[]bytestring390625uint16uint32uint64structchan<-<-chan ValueGetACPsysmontimersefenceselect, not object next= jobs= goid sweep  B -> % util alloc free  span= prev= list=, i =  code= addr= m->p= p->m=SCHED  curg= ctxt: min=  max= bad ts(...)
```

That `bdeb6` is the file offset (hex), not virtual address.

3. Verify where it’s referenced

```bash
go tool objdump -s main.main main.exe


  main.go:12		0x49a955		488d05af450200		LEAQ go:string.*+659(SB), AX		
  main.go:12		0x49a95c		bb06000000		MOVL $0x6, BX				
```

This confirms:
- The string is referenced indirectly.
- We only need to change the bytes, not code.

4. Patch "thingy" → "xxxxxx"

Important constraint is that "thingy" and "xxxxxx" are same length so safe patch
as no metadata changes needed. Both six bytes.

Launch radare2 with command:

```bash
r2 -w main.exe
```

Useful commands:

```bash
Basic commands:

* s [addr] - seek to a different address
* px, pd  - print hexadecimal, disassembly (pdf/pdr the whole function)
* wx, wa  - write hexpairs, write assembly (w - write string)
* aaa, af - analyze the whole program or function
* /, /x   - search for strings or hexadecimal patterns
* f~...   - search for strings or hexadecimal patterns
* q       - quit (alias for ^D or exit)
```

Seek address `0x49a955`

```bash
s 0x49a955
```

Analyse the function:

```bash
aaa

INFO: Analyze all flags starting with sym. and entry0 (aa)
INFO: Analyze imports (af@@@i)
INFO: Analyze entrypoint (af@ entry0)
INFO: Analyze symbols (af@@@s)
INFO: Analyze all functions arguments/locals (afva@@F)
INFO: Find function and symbol names from golang binaries (aang)
ERROR: Could not find .gopclntab section
INFO: Analyze all flags starting with sym.go. (aF @@f:sym.go.*)
INFO: Analyze function calls (aac)
INFO: Analyze len bytes of instructions for references (aar)
INFO: Finding and parsing C++ vtables (avrr)
INFO: Analyzing methods (af @@ method.*)
INFO: Recovering local variables (afva@@@F)
INFO: Type matching analysis for all functions (aaft)
INFO: Propagate noreturn information (aanr)
INFO: Use -AA or aaaa to perform additional experimental analysis
```

Print the disassembly:

```bash
[0x0049a955]> pdf
            ; CODE XREF from sym.main.main @ 0x49a9a5(x)
┌ 103: sym.main.main ();
│ afv: vars(2:sp[0x38..0x40])
│       ┌─> 0x0049a940      493b6610       cmp rsp, qword [r14 + 0x10]
│      ┌──< 0x0049a944      7657           jbe 0x49a99d
│      │╎   0x0049a946      55             push rbp
│      │╎   0x0049a947      4889e5         mov rbp, rsp
│      │╎   0x0049a94a      4883ec38       sub rsp, 0x38
│      │╎   0x0049a94e      90             nop
│      │╎   0x0049a94f      440f117c2428   movups xmmword [var_28h], xmm15
│      │╎   ;-- rip:
│      │╎   0x0049a955      488d05af45..   lea rax, [0x004bef0b]       ; "thingyStringFormat[]bytestring390625uint16uint32uint64structchan<-<-chan ValueGetACPsysmontimersefenceselect, not object next= "
│      │╎   0x0049a95c      bb06000000     mov ebx, 6
│      │╎   0x0049a961      e8dab7fcff     call sym.runtime.convTstring
│      │╎   0x0049a966      488d0d73a7..   lea rcx, [0x004a50e0]
│      │╎   0x0049a96d      48894c2428     mov qword [var_28h], rcx
│      │╎   0x0049a972      4889442430     mov qword [var_30h], rax
│      │╎   0x0049a977      488b1dca57..   mov rbx, qword [0x00570148] ; [0x570148:8]=0
│      │╎   0x0049a97e      488d05abba..   lea rax, [0x004e6430]
│      │╎   0x0049a985      488d4c2428     lea rcx, [var_28h]          ; int64_t arg1
│      │╎   0x0049a98a      bf01000000     mov edi, 1
│      │╎   0x0049a98f      4889fe         mov rsi, rdi
│      │╎   0x0049a992      e8a9afffff     call sym.fmt.Fprintln
│      │╎   0x0049a997      4883c438       add rsp, 0x38
│      │╎   0x0049a99b      5d             pop rbp
│      │╎   0x0049a99c      c3             ret
│      │╎   ; CODE XREF from sym.main.main @ 0x49a944(x)
│      └──> 0x0049a99d      0f1f00         nop dword [rax]
│       ╎   0x0049a9a0      e8db18fdff     call sym.runtime.morestack_noctxt.abi0
└       └─< 0x0049a9a5      eb99           jmp sym.main.main
```

Identify the address of 'thingy', i.e. `0x004bef0b`. Seek that address:

```bash
[0x0049a955]> s 0x004bef0b
```

Print address:

```bash
[0x004bef0b]> px 6
- offset -   B C  D E  F10 1112 1314 1516 1718 191A  BCDEF0123456789A
0x004bef0b  7468 696e 6779                           thingy
```

Overwrite the address:

```bash
[0x004c2f80]> wx 78 78 78 78 78 78
```

Note: 'xxxxxx' is 787878787878 in hex

```bash
echo -n xxxxxx | xxd -p
787878787878
```

Exit and run the application:


```bash
run main.exe

xxxxxx
```