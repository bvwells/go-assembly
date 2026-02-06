go build -o main.exe
go tool objdump -s main.main main.exe > main.asm

go build -ldflags '-s -w' -o main-no-symbols.exe
go tool objdump -s main.main main-no-symbols.exe > main-no-symbols.asm

export GARBLE_EXPERIMENTAL_CONTROLFLOW=1 && garble -tiny -literals build -o main-garble.exe
go tool objdump -s main.main main-garble.exe > main-garble.asm

