OS = $(shell uname)
USER = $(shell echo $$USER)
CXX = c++
ifeq ($(OS),Darwin)
CXXLIBS = -ll -I-. -I./ast -L/usr/local/Cellar/llvm/3.8.1/lib -Wl,-search_paths_first -Wl,-headerpad_max_install_names -lLLVMLTO -lLLVMObjCARCOpts -lLLVMSymbolize -lLLVMDebugInfoPDB -lLLVMDebugInfoDWARF -lLLVMMIRParser -lLLVMTableGen -lLLVMOrcJIT -lLLVMNVPTXCodeGen -lLLVMNVPTXDesc -lLLVMNVPTXInfo -lLLVMNVPTXAsmPrinter -lLLVMARMDisassembler -lLLVMARMCodeGen -lLLVMARMAsmParser -lLLVMARMDesc -lLLVMARMInfo -lLLVMARMAsmPrinter -lLLVMAMDGPUCodeGen -lLLVMAMDGPUAsmParser -lLLVMAMDGPUDesc -lLLVMAMDGPUUtils -lLLVMAMDGPUInfo -lLLVMAMDGPUAsmPrinter -lLLVMX86Disassembler -lLLVMX86AsmParser -lLLVMX86CodeGen -lLLVMSelectionDAG -lLLVMAsmPrinter -lLLVMX86Desc -lLLVMMCDisassembler -lLLVMX86Info -lLLVMX86AsmPrinter -lLLVMX86Utils -lLLVMMCJIT -lLLVMLibDriver -lLLVMOption -lLLVMLineEditor -lLLVMPasses -lLLVMipo -lLLVMVectorize -lLLVMLinker -lLLVMIRReader -lLLVMAsmParser -lLLVMDebugInfoCodeView -lLLVMInterpreter -lLLVMExecutionEngine -lLLVMRuntimeDyld -lLLVMCodeGen -lLLVMTarget -lLLVMScalarOpts -lLLVMInstCombine -lLLVMInstrumentation -lLLVMProfileData -lLLVMObject -lLLVMMCParser -lLLVMTransformUtils -lLLVMMC -lLLVMBitWriter -lLLVMBitReader -lLLVMAnalysis -lLLVMCore -lLLVMSupport -lcurses -lpthread -lz -lm
CXXFLAGS = -g -I/usr/local/Cellar/llvm/3.8.1/include  -stdlib=libc++ -fPIC -fvisibility-inlines-hidden -Wall -std=c++11 -DNDEBUG   -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS 
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
	/usr/local/Cellar/llvm/3.8.1/bin/lli <(./compiler 2>&1)

util: util.o
	$(CXX) $(CXXFLAGS) util.o -o util $(CXXLIBS)

clean:
	rm -f *.o ast/*.o parser.tab.* lex.yy.* parser.output llang *.ll
