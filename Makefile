OS = $(shell uname)
CXX = c++
ifeq ($(OS),Darwin)
CXXLIBS = -ll -I-. -I./ast
CXXFLAGS = -g -Wall -std=c++1y -I/usr/local/Cellar/llvm/3.8.1/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS
else
CXXLIBS = -lfl -I-. -I./ast
CXXFLAGS = -g -Wall -std=c++1y 
endif

CPPFILES = $(shell find . -name '*.c*')
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

clean:
	rm -f *.o ast/*.o parser.tab.* lex.yy.* parser.output llang
