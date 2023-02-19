OBJ := $(subst src/, bin/, $(patsubst %.s, %.o, $(wildcard src/*.s)))

.PHONY: all clean run

all: bin/main

clean:
	rm $(OBJ)

run: bin/main
	qemu-aarch64 bin/main

debug: bin/main
	qemu-aarch64 -g 12345 bin/main &
	aarch64-linux-gnu-gdb -iex "target remote localhost:12345"

bin/main: $(OBJ)
	aarch64-linux-gnu-ld -o bin/main $^

bin/%.o: src/%.s
	aarch64-linux-gnu-as -o $@ $<
