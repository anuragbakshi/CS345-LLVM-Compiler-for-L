%{
/* Anurag Bakshi (anurag.bakshi@utexas.edu)
   Quang Duong (duongquang1@gmail.com) */
#include <utility>

#include "parser-defs.h"

int yylex();
extern int yy_scan_string(const char* c);
int yyerror(const char* p)
{
    if(parser_error_fn != NULL) {
        parser_error_fn("At line " + int_to_string(curr_lineno) + ": " + string(p));
    }
    return 1;
};

// template<typename V, typename U>
// V assert_cast(U u) {
//     assert(u->get_type() == std::declval<V>()->get_type());
//     return static_cast<V>(u);
// }


%}
/* BISON Declarations */
%token
TOKEN_READSTRING
TOKEN_READINT
TOKEN_PRINT
TOKEN_ISNIL
TOKEN_HD
TOKEN_TL
TOKEN_CONS
TOKEN_NIL
TOKEN_DOT
TOKEN_WITH
TOKEN_LET
TOKEN_PLUS
TOKEN_MINUS
TOKEN_IDENTIFIER
TOKEN_TIMES
TOKEN_DIVIDE
TOKEN_INT
TOKEN_LPAREN
TOKEN_RPAREN
TOKEN_AND
TOKEN_OR
TOKEN_EQ
TOKEN_NEQ
TOKEN_GT
TOKEN_GEQ
TOKEN_LT
TOKEN_LEQ
TOKEN_IF
TOKEN_THEN
TOKEN_ELSE
TOKEN_LAMBDA
TOKEN_FUN
TOKEN_COMMA
TOKEN_STRING
TOKEN_ERROR
TOKEN_IN



%nonassoc EXPR

// %left TOKEN_COMMA

%left TOKEN_PRINT

%left TOKEN_EQ TOKEN_NEQ TOKEN_LT TOKEN_GT TOKEN_LEQ TOKEN_GEQ
%left TOKEN_AND TOKEN_OR

%left TOKEN_PLUS TOKEN_MINUS
%left TOKEN_TIMES TOKEN_DIVIDE

%left TOKEN_ISNIL

%right TOKEN_CONS

%left TOKEN_HD TOKEN_TL

// %right TOKEN_LET TOKEN_FUN TOKEN_LAMBDA

%%

program: expression
{
    res_expr = $$;
}

expression:
TOKEN_LET TOKEN_IDENTIFIER TOKEN_EQ expression TOKEN_IN expression %prec EXPR {
    string id_lexeme = GET_LEXEME($2);
    $$ = AstLet::make(AstIdentifier::make(id_lexeme), $4, $6);
}
| TOKEN_FUN TOKEN_IDENTIFIER TOKEN_WITH id_list TOKEN_EQ expression TOKEN_IN expression %prec EXPR {
    string id_lexeme = GET_LEXEME($2);

    assert($4->get_type() == AST_IDENTIFIER_LIST);
    auto formals = static_cast<AstIdentifierList *>($4);

    auto lambda_expr = AstLambda::make(formals, $6);
    auto let_expr = AstLet::make(AstIdentifier::make(id_lexeme), lambda_expr, $8);

    $$ = let_expr;
}
| TOKEN_LAMBDA id_list TOKEN_DOT expression %prec EXPR {
    assert($2->get_type() == AST_IDENTIFIER_LIST);
    auto formals = static_cast<AstIdentifierList *>($2);

    $$ = AstLambda::make(formals, $4);
}
| TOKEN_IF expression TOKEN_THEN expression TOKEN_ELSE expression %prec EXPR {
    $$ = AstBranch::make($2, $4, $6);
}
| expression TOKEN_PLUS expression {
	$$ = AstBinOp::make(PLUS, $1, $3);
}
| expression TOKEN_AND expression {
	$$ = AstBinOp::make(AND, $1, $3);
}
| expression TOKEN_OR expression {
	$$ = AstBinOp::make(OR, $1, $3);
}
| expression TOKEN_MINUS expression {
	$$ = AstBinOp::make(MINUS, $1, $3);
}
| expression TOKEN_TIMES expression {
	$$ = AstBinOp::make(TIMES, $1, $3);
}
| expression TOKEN_DIVIDE expression {
	$$ = AstBinOp::make(DIVIDE, $1, $3);
}
| expression TOKEN_EQ expression {
	$$ = AstBinOp::make(EQ, $1, $3);
}
| expression TOKEN_NEQ expression {
	$$ = AstBinOp::make(NEQ, $1, $3);
}
| expression TOKEN_LT expression {
	$$ = AstBinOp::make(LT, $1, $3);
}
| expression TOKEN_LEQ expression {
	$$ = AstBinOp::make(LEQ, $1, $3);
}
| expression TOKEN_GT expression {
	$$ = AstBinOp::make(GT, $1, $3);
}
| expression TOKEN_GEQ expression {
	$$ = AstBinOp::make(GEQ, $1, $3);
}
| TOKEN_INT {
  	string lexeme = GET_LEXEME($1);
  	long int val = string_to_int(lexeme);
  	Expression* e = AstInt::make(val);
  	$$ = e;
}
| TOKEN_STRING {
	string lexeme = GET_LEXEME($1);
  	Expression* e = AstString::make(lexeme);
  	$$ = e;
}
| TOKEN_LPAREN expr TOKEN_RPAREN {
	$$ = $2;
}
| TOKEN_PRINT expression {
    $$ = AstUnOp::make(PRINT, $2);
}
| TOKEN_READINT {
    $$ = AstRead::make(true);
}
| TOKEN_READSTRING {
    $$ = AstRead::make(false);
}
| TOKEN_HD expression {
    $$ = AstUnOp::make(HD, $2);
}
| TOKEN_TL expression {
    $$ = AstUnOp::make(TL, $2);
}
| expression TOKEN_CONS expression {
    $$ = AstBinOp::make(CONS, $1, $3);
}
| TOKEN_NIL {
    $$ = AstNil::make();
}
| TOKEN_ISNIL expression {
    $$ = AstUnOp::make(ISNIL, $2);
}
| TOKEN_IDENTIFIER {
	string lexeme = GET_LEXEME($1);
  	$$ =  AstIdentifier::make(lexeme);
}
| TOKEN_ERROR
{
    // do not change the error rule
    string lexeme = GET_LEXEME($1);
    string error = "Lexing error: ";
    if(lexeme != "") error += lexeme;
    yyerror(error.c_str());
    YYERROR;
}

id_list:
TOKEN_IDENTIFIER {
    string id_lexeme = GET_LEXEME($1);
    $$ = AstIdentifierList::make(AstIdentifier::make(id_lexeme));
}
| id_list TOKEN_COMMA TOKEN_IDENTIFIER {
    string id_lexeme = GET_LEXEME($3);

    assert($1->get_type() == AST_IDENTIFIER_LIST);
    $$ = static_cast<AstIdentifierList *>($1)->append_id(AstIdentifier::make(id_lexeme));
}


// expression_application: expression expression
// {
// 	AstExpressionList *l = AstExpressionList::make($1);
// 	l = l->append_exp($2);
// 	$$ = l;
// }
// |
// expression_application expression
// {
// 	Expression* _l = $1;
// 	assert(_l->get_type() == AST_EXPRESSION_LIST);
// 	AstExpressionList* l = static_cast<AstExpressionList*>(_l);
// 	$$ = l->append_exp($2);
// }

expr:
expression {
    $$ = $1;
}
| expr_list expression {
    assert($1->get_type() == AST_EXPRESSION_LIST);
    $$ = static_cast<AstExpressionList *>($1)->append_exp($2);
}

expr_list:
expression {
    $$ = AstExpressionList::make($1);
}
| expr_list expression {
    // $$ = assert_cast<AstExpressionList>($1)->append_exp($2);
    assert($1->get_type() == AST_EXPRESSION_LIST);
    $$ = static_cast<AstExpressionList *>($1)->append_exp($2);
}
