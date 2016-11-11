CXX = c++
CXXFLAGS = -g -Wall -std=c++1y
CXXLIBS = -lfl -I-. -I./ast

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
