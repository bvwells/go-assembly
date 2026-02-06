TEXT main.main(SB) /home/bwells/git/github.com/bvwells/go-assembly/main.go
  main.go:6		0x49a940		493b6610		CMPQ SP, 0x10(R14)			
  main.go:6		0x49a944		7657			JBE 0x49a99d				
  main.go:6		0x49a946		55			PUSHQ BP				
  main.go:6		0x49a947		4889e5			MOVQ SP, BP				
  main.go:6		0x49a94a		4883ec38		SUBQ $0x38, SP				
  main.go:7		0x49a94e		90			NOPL					
  main.go:12		0x49a94f		440f117c2428		MOVUPS X15, 0x28(SP)			
  main.go:12		0x49a955		488d05af450200		LEAQ go:string.*+659(SB), AX		
  main.go:12		0x49a95c		bb06000000		MOVL $0x6, BX				
  main.go:12		0x49a961		e8dab7fcff		CALL runtime.convTstring(SB)		
  main.go:12		0x49a966		488d0d73a70000		LEAQ type:*+41184(SB), CX		
  main.go:12		0x49a96d		48894c2428		MOVQ CX, 0x28(SP)			
  main.go:12		0x49a972		4889442430		MOVQ AX, 0x30(SP)			
  print.go:314		0x49a977		488b1d8a580d00		MOVQ os.Stdout(SB), BX			
  print.go:314		0x49a97e		488d05abba0400		LEAQ go:itab.*os.File,io.Writer(SB), AX	
  print.go:314		0x49a985		488d4c2428		LEAQ 0x28(SP), CX			
  print.go:314		0x49a98a		bf01000000		MOVL $0x1, DI				
  print.go:314		0x49a98f		4889fe			MOVQ DI, SI				
  print.go:314		0x49a992		e8a9afffff		CALL fmt.Fprintln(SB)			
  main.go:8		0x49a997		4883c438		ADDQ $0x38, SP				
  main.go:8		0x49a99b		5d			POPQ BP					
  main.go:8		0x49a99c		c3			RET					
  main.go:6		0x49a99d		0f1f00			NOPL 0(AX)				
  main.go:6		0x49a9a0		e8db18fdff		CALL runtime.morestack_noctxt.abi0(SB)	
  main.go:6		0x49a9a5		eb99			JMP main.main(SB)			
  :-1			0x49a9a7		cc			INT $0x3				
  :-1			0x49a9a8		cc			INT $0x3				
  :-1			0x49a9a9		cc			INT $0x3				
  :-1			0x49a9aa		cc			INT $0x3				
  :-1			0x49a9ab		cc			INT $0x3				
  :-1			0x49a9ac		cc			INT $0x3				
  :-1			0x49a9ad		cc			INT $0x3				
  :-1			0x49a9ae		cc			INT $0x3				
  :-1			0x49a9af		cc			INT $0x3				
  :-1			0x49a9b0		cc			INT $0x3				
  :-1			0x49a9b1		cc			INT $0x3				
  :-1			0x49a9b2		cc			INT $0x3				
  :-1			0x49a9b3		cc			INT $0x3				
  :-1			0x49a9b4		cc			INT $0x3				
  :-1			0x49a9b5		cc			INT $0x3				
  :-1			0x49a9b6		cc			INT $0x3				
  :-1			0x49a9b7		cc			INT $0x3				
  :-1			0x49a9b8		cc			INT $0x3				
  :-1			0x49a9b9		cc			INT $0x3				
  :-1			0x49a9ba		cc			INT $0x3				
  :-1			0x49a9bb		cc			INT $0x3				
  :-1			0x49a9bc		cc			INT $0x3				
  :-1			0x49a9bd		cc			INT $0x3				
  :-1			0x49a9be		cc			INT $0x3				
  :-1			0x49a9bf		cc			INT $0x3				
