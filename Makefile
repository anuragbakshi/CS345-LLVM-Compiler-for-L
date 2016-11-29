OS = $(shell uname)
USER = $(shell echo $$USER)
CXX = c++
ifeq ($(OS),Darwin)
CXXLIBS = -ll -I-. -I./ast -L/usr/local/Cellar/llvm38/3.8.1/lib/llvm-3.8/lib -Wl,-search_paths_first -Wl,-headerpad_max_install_names -lLLVMLTO -lLLVMObjCARCOpts -lLLVMSymbolize -lLLVMDebugInfoPDB -lLLVMDebugInfoDWARF -lLLVMMIRParser -lLLVMLibDriver -lLLVMOption -lLLVMTableGen -lLLVMOrcJIT -lLLVMPasses -lLLVMipo -lLLVMVectorize -lLLVMLinker -lLLVMIRReader -lLLVMAsmParser -lLLVMX86Disassembler -lLLVMX86AsmParser -lLLVMX86CodeGen -lLLVMSelectionDAG -lLLVMAsmPrinter -lLLVMX86Desc -lLLVMMCDisassembler -lLLVMX86Info -lLLVMX86AsmPrinter -lLLVMX86Utils -lLLVMMCJIT -lLLVMLineEditor -lLLVMDebugInfoCodeView -lLLVMInterpreter -lLLVMExecutionEngine -lLLVMRuntimeDyld -lLLVMCodeGen -lLLVMTarget -lLLVMScalarOpts -lLLVMInstCombine -lLLVMInstrumentation -lLLVMProfileData -lLLVMObject -lLLVMMCParser -lLLVMTransformUtils -lLLVMMC -lLLVMBitWriter -lLLVMBitReader -lLLVMAnalysis -lLLVMCore -lLLVMSupport -lz -lpthread -lffi -ledit -lcurses -lm
CXXFLAGS = -g -I/usr/local/Cellar/llvm38/3.8.1/lib/llvm-3.8/include  -stdlib=libc++ -fPIC -fvisibility-inlines-hidden -Wall -std=c++11 -DNDEBUG   -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS
else ifeq ($(USER),quang)
LLVMFLAGS = `llvm-config --cppflags --ldflags --system-libs`
LIBS = `llvm-config --libs $(LLVM_MODULES)`
CXXLIBS = -I-. -I./ast /mnt/share/flex-2.5.35/libfl.a $(LIBS)
CXXFLAGS = -g -Wall -std=c++1y $(LLVMFLAGS)
else
CXXLIBS = -lfl -I-. -I./ast
CXXFLAGS = -g -Wall -std=c++1y
endif

CPPFILES = $(shell find . -name "*.c" -o -name "*.cpp")
OFILES = $(patsubst %.cpp, %.o, $(CPPFILES))

llang: parser.tab.o lex.yy.o $(OFILES)
	$(CXX) $(CXXFLAGS) $(OFILES) -o llang $(CXXLIBS)

lex.yy.c: lexer.l parser-defs.h
	flex -i lexer.l

parser.tab.c: parser.y parser-defs.h
	bison -dv parser.y

ast/%.o: ast/%.cpp
	$(CXX) $(CXXFLAGS) -c ast/$*.cpp -o ast/$*.o

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $*.cpp -o $*.o

%.o: %.c
	$(CXX) $(CXXFLAGS) -c $*.c -o $*.o

compiler: compiler.o
	$(CXX) $(CXXFLAGS) compiler.o -o compiler $(CXXLIBS)

util: clean util.o
	$(CXX) $(CXXFLAGS) util.o -o util $(CXXLIBS)

run: compiler
	/usr/local/Cellar/llvm38/3.8.1/lib/llvm-3.8/bin/lli <(./compiler 2>&1)

%.elf: llang %.L
	./llang $*.L 2> $*.ll
	# /usr/local/Cellar/llvm38/3.8.1/lib/llvm-3.8/bin/llc -march=x86-64 -filetype=obj $*.ll -O3
	# gcc -flto -c operations.c -o operations.o -O3
	# gcc -flto $*.o operations.o -o $* -O3
	/usr/local/Cellar/llvm38/3.8.1/lib/llvm-3.8/bin/llc -march=x86-64 -filetype=obj $*.ll
	gcc -c operations.c -o operations.o
	gcc -c hashmap.c -o hashmap.o
	gcc -c symboltable.c -o symboltable.o
	gcc -c lifostack.c -o lifostack.o
	gcc -c debug.c -o debug.o
	gcc $*.o hashmap.o symboltable.o lifostack.o debug.o operations.o -o $*

clean:
	rm -f *.o ast/*.o parser.tab.* lex.yy.* parser.output llang *.ll
