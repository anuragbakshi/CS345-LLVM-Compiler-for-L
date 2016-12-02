CXX = c++
LLVMFLAGS = `llvm-config --cppflags --ldflags --system-libs`
LIBS = `llvm-config --libs $(LLVM_MODULES)`
CXXLIBS = -I-. -I./ast -lfl $(LIBS)
CXXFLAGS = -g -Wall -std=c++1y $(LLVMFLAGS)
LLC = llc


CPPFILES = $(shell find . -name "*.cpp")
OFILES = $(patsubst %.cpp, %.o, $(CPPFILES))

llang: parser.tab.o lex.yy.o $(OFILES)
	$(CXX) $(OFILES) parser.tab.o lex.yy.o -o llang $(CXXLIBS) $(CXXFLAGS)

lex.yy.o: lex.yy.c
	$(CXX) $(CXXFLAGS) -c lex.yy.c -o lex.yy.o

parser.tab.o: parser.tab.c
	$(CXX) $(CXXFLAGS) -c parser.tab.c -o parser.tab.o

lex.yy.c: lexer.l parser-defs.h
	flex -i lexer.l

parser.tab.c: parser.y parser-defs.h
	bison -dv parser.y

$(OFILES) : %.o : %.cpp
	$(CXX) $(CXXFLAGS) -c $*.cpp -o $*.o -g

UTILC = $(wildcard util/*.c)
UTILO = $(patsubst %.c, %.o, $(UTILC))

$(UTILO) : %.o : %.c
	gcc -c $*.c -o $*.o -g

TESTL = $(wildcard tests/*.L)

%.ll : llang %.L
	./llang $*.L 2> $*.ll || true

%.o : %.ll
	$(LLC) -march=x86-64 -filetype=obj $*.ll -O3 || true

%.elf : %.o $(UTILO)
	gcc $*.o $(UTILO) -o $*.elf -O3 -g || true


OUTS = $(patsubst %.L, %.out, $(TESTL))
DIFFS = $(patsubst %.L, %.diff, $(TESTL))
RESULTS = $(patsubst %.L, %.result, $(TESTL))

.FORCE:

$(OUTS) : %.out : .FORCE %.elf
	@if [ -f $*.in ] ; \
	then \
		./$*.elf < $*.in > $*.out || true; \
	else \
		./$*.elf > $*.out || true; \
	fi ;

$(DIFFS) : %.diff : .FORCE %.ok %.out
	@diff $*.ok $*.out > $*.diff 2>&1 || true

$(RESULTS) : %.result : .FORCE %.diff
	@printf '%s' "--- $(notdir $*) ... "
	@(test -s $*.diff && (printf '%s\n' "fail ---"; printf '%s\n' "--- expected ---"; cat $*.ok; printf '%s\n' "--- found ---"; cat $*.out)) || (printf '%s\n' "pass ---")

test: $(RESULTS)

clean:
	rm -f *.o ast/*.o parser.tab.* lex.yy.* parser.output llang *.ll util/*.o tests/*.ll tests/*.o tests/*.elf tests/*.out tests/*.result tests/*.diff benchmarks/*.ll benchmarks/*.elf benchmarks/*.o
