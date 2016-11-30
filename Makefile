OS = $(shell uname)
USER = $(shell echo $$USER)
CXX = c++

ifeq ($(USER),ryan)
LLC = /usr/local/Cellar/llvm/3.8.1/bin/llc
LLINC = -I/usr/local/Cellar/llvm/3.8.1/include
LLLIB = -L/usr/local/Cellar/llvm/3.8.1/lib
else
LLC = /usr/local/Cellar/llvm38/3.8.1/lib/llvm-3.8/bin/llc
LLINC = -I/usr/local/Cellar/llvm38/3.8.1/lib/llvm-3.8/include
LLLIB = -L/usr/local/Cellar/llvm38/3.8.1/lib/llvm-3.8/lib
endif

ifeq ($(OS),Darwin)
CXXLIBS = -ll -I-. -I./ast $(LLLIB) -Wl,-search_paths_first -Wl,-headerpad_max_install_names -lLLVMLTO -lLLVMObjCARCOpts -lLLVMSymbolize -lLLVMDebugInfoPDB -lLLVMDebugInfoDWARF -lLLVMMIRParser -lLLVMLibDriver -lLLVMOption -lLLVMTableGen -lLLVMOrcJIT -lLLVMPasses -lLLVMipo -lLLVMVectorize -lLLVMLinker -lLLVMIRReader -lLLVMAsmParser -lLLVMX86Disassembler -lLLVMX86AsmParser -lLLVMX86CodeGen -lLLVMSelectionDAG -lLLVMAsmPrinter -lLLVMX86Desc -lLLVMMCDisassembler -lLLVMX86Info -lLLVMX86AsmPrinter -lLLVMX86Utils -lLLVMMCJIT -lLLVMLineEditor -lLLVMDebugInfoCodeView -lLLVMInterpreter -lLLVMExecutionEngine -lLLVMRuntimeDyld -lLLVMCodeGen -lLLVMTarget -lLLVMScalarOpts -lLLVMInstCombine -lLLVMInstrumentation -lLLVMProfileData -lLLVMObject -lLLVMMCParser -lLLVMTransformUtils -lLLVMMC -lLLVMBitWriter -lLLVMBitReader -lLLVMAnalysis -lLLVMCore -lLLVMSupport -lz -lpthread -lffi -ledit -lcurses -lm
CXXFLAGS = -g $(LLINC) -stdlib=libc++ -fPIC -fvisibility-inlines-hidden -Wall -std=c++11 -DNDEBUG   -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS
else ifeq ($(USER),quang)
LLVMFLAGS = `llvm-config --cppflags --ldflags --system-libs`
LIBS = `llvm-config --libs $(LLVM_MODULES)`
CXXLIBS = -I-. -I./ast /mnt/share/flex-2.5.35/libfl.a $(LIBS)
CXXFLAGS = -g -Wall -std=c++1y $(LLVMFLAGS)
LLC = llc
else
CXXLIBS = -lfl -I-. -I./ast
CXXFLAGS = -g -Wall -std=c++1y
endif


CPPFILES = $(shell find . -name "*.cpp")
OFILES = $(patsubst %.cpp, %.o, $(CPPFILES))

llang: parser.tab.o lex.yy.o $(OFILES)
	$(CXX) $(CXXFLAGS) $(OFILES) parser.tab.o lex.yy.o -o llang $(CXXLIBS)

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
TESTLL = $(patsubst %.L, %.ll, $(TESTL))
TESTO = $(patsubst %.L, %.o, $(TESTL))
TESTELF = $(patsubst %.L, %.elf, $(TESTL))

$(TESTLL) : %.ll : llang %.L
	./llang $*.L 2> $*.ll || true

$(TESTO) : %.o : %.ll
	$(LLC) -march=x86-64 -filetype=obj $*.ll -O3 || true

$(TESTELF) : %.elf : %.o $(UTILO)
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
	rm -f *.o ast/*.o parser.tab.* lex.yy.* parser.output llang *.ll util/*.o tests/*.ll tests/*.o tests/*.elf tests/*.out tests/*.result tests/*.diff
