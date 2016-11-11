%{
/* Anurag Bakshi (anurag.bakshi@utexas.edu)
   Quang Duong (duongquang1@gmail.com) */
#include "parser-defs.h"
#include "parser.tab.h"

/*
 * You may want to use this string to assemble the lexeme
 * of string constants by adding the current matched character from yytext to it.
 * You can do this as buffer += yytext;
 */
string buffer;


/*
 * You may want to track the comment desting depth with this variable.
 */
int comment_depth = 0;

%}


%option noyywrap

WHITESPACE [ \t\f\r\v]+
NEWLINE [\n]

READSTRING "readString"
READINT "readInt"
PRINT "print"
ISNIL "isNil"
HD "!"
TL "#"
CONS "@"
NIL "Nil"
DOT "."
WITH "with"
LET "let"
PLUS "+"
MINUS "-"
IDENTIFIER [[:alpha:]_][[:alnum:]_]*
TIMES "*"
DIVIDE "/"
INT [[:digit:]]+
LPAREN "("
RPAREN ")"
AND "&"
OR "|"
EQ "="
NEQ "<>"
GT ">"
GEQ ">="
LT "<"
LEQ "<="
IF "if"
THEN "then"
ELSE "else"
LAMBDA "lambda"
FUN "fun"
COMMA ","
STRING \"[^\"]*\"
ERROR .
IN "in"
COMMENT_START "(*"
COMMENT_END "*)"


%x STRING
%x COMMENT

%%

{COMMENT_START} {
    comment_depth++;
}

{COMMENT_END} {
    comment_depth--;
    if(comment_depth < 0) {
        return TOKEN_ERROR;
    }
}

{WHITESPACE} {
    /* Do nothing */
}

{NEWLINE} {
/* Do nothing, but increment line numbers */
    curr_lineno++;
}

{READSTRING} {
    if(comment_depth == 0) {
        return TOKEN_READSTRING;
    }
}

{READINT} {
    if(comment_depth == 0) {
        return TOKEN_READINT;
    }
}

{PRINT} {
   if(comment_depth == 0) {
        return TOKEN_PRINT;
    }
}

{ISNIL} {
    if(comment_depth == 0) {
        return TOKEN_ISNIL;
    }
}

{IN} {
    if(comment_depth == 0) {
        return TOKEN_IN;
    }
}

{NIL} {
    if(comment_depth == 0) {
        return TOKEN_NIL;
    }
}

{WITH} {
    if(comment_depth == 0) {
        return TOKEN_WITH;
    }
}

{LET} {
    if(comment_depth == 0) {
        return TOKEN_LET;
    }
}

{IF} {
    if(comment_depth == 0) {
        return TOKEN_IF;
    }
}

{THEN} {
    if(comment_depth == 0) {
        return TOKEN_THEN;
    }
}

{ELSE} {
    if(comment_depth == 0) {
        return TOKEN_ELSE;
    }
}

{LAMBDA} {
    if(comment_depth == 0) {
        return TOKEN_LAMBDA;
    }
}

{FUN} {
    if(comment_depth == 0) {
        return TOKEN_FUN;
    }
}

{COMMA} {
    if(comment_depth == 0) {
        return TOKEN_COMMA;
    }
}

{HD} {
    if(comment_depth == 0) {
        return TOKEN_HD;
    }
}

{TL} {
    if(comment_depth == 0) {
        return TOKEN_TL;
    }
}

{CONS} {
    if(comment_depth == 0) {
        return TOKEN_CONS;
    }
}

{DOT} {
    if(comment_depth == 0) {
        return TOKEN_DOT;
    }
}

{PLUS} {
    if(comment_depth == 0) {
        return TOKEN_PLUS;
    }
}

{MINUS} {
    if(comment_depth == 0) {
        return TOKEN_MINUS;
    }
}

{TIMES} {
    if(comment_depth == 0) {
        return TOKEN_TIMES;
    }
}

{DIVIDE} {
    if(comment_depth == 0) {
        return TOKEN_DIVIDE;
    }
}

{AND} {
    if(comment_depth == 0) {
        return TOKEN_AND;
    }
}

{OR} {
    if(comment_depth == 0) {
        return TOKEN_OR;
    }
}

{EQ} {
    if(comment_depth == 0) {
        return TOKEN_EQ;
    }
}

{NEQ} {
    if(comment_depth == 0) {
        return TOKEN_NEQ;
    }
}

{GT} {
    if(comment_depth == 0) {
        return TOKEN_GT;
    }
}

{GEQ} {
    if(comment_depth == 0) {
        return TOKEN_GEQ;
    }
}

{LT} {
    if(comment_depth == 0) {
        return TOKEN_LT;
    }
}

{LEQ} {
    if(comment_depth == 0) {
        return TOKEN_LEQ;
    }
}

{LPAREN} {
    if(comment_depth == 0) {
        return TOKEN_LPAREN;
    }
}

{RPAREN} {
    if(comment_depth == 0) {
        return TOKEN_RPAREN;
    }
}

{INT} {
    if(comment_depth == 0) {
        SET_LEXEME(yytext);
        return TOKEN_INT;
    }
}

{IDENTIFIER} {
    if(comment_depth == 0) {
        SET_LEXEME(yytext);
        return TOKEN_IDENTIFIER;
    }
}

{STRING} {
    if(comment_depth == 0) {
        for(int i = 0; i < yyleng; i++) {
            if(yytext[i] == '\n') {
                curr_lineno++;
            }
        }
        char* str = yytext + 1;
        str[yyleng - 2] = '\0';
        SET_LEXEME(str);
        return TOKEN_STRING;
    }
}

. {
    if(comment_depth <= 0) {
        /* Leave this rule at the end of our lexer to "eat up" all illegal strings */
        SET_LEXEME("Unexpected character in input");
        return TOKEN_ERROR;
    }

}

<<EOF>> {
    if(comment_depth != 0) {
        return TOKEN_ERROR;
    }

    yyterminate();
}
