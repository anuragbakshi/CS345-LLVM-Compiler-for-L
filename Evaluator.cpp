#include "Evaluator.hpp"

#include <initializer_list>
#include <algorithm>

#include "ast/all.hpp"

/*
 * This skeleton currently only contains code to handle integer constants, print
 * and read.
 * It is your job to handle all of the rest of the L language.
 */

/*
 * Call this function to report any run-time errors
 * This will abort execution.
 */
void report_error(Expression *e, const string &s) {
    cout << "Run-time error in expression " << e->to_value() << endl;
    cout << s << endl;
    exit(1);
}

template <typename T>
bool is_one_of(T v, std::initializer_list<T> vals) {
    return std::find(vals.begin(), vals.end(), v) != vals.end();
}

template <typename T>
bool all_equal(std::initializer_list<T> vals) {
    return std::adjacent_find(vals.begin(), vals.end(), std::not_equal_to<int>()) == vals.end();
}

Evaluator::Evaluator() {
    sym_tab.push();
    c = 0;
}

Expression *Evaluator::eval_binop(AstBinOp *b) {
    auto eval_first = eval(b->get_first());
    auto eval_second = eval(b->get_second());

    if(b->get_binop_type() == CONS) {
        if(eval_second->get_type() == AST_NIL) {
            return eval_first;
        }

        return AstList::make(eval_first, eval_second);
    } else if(eval_first->get_type() == AST_LIST || eval_second->get_type() == AST_LIST) {
        report_error(b, "Binop @ is the only legal binop for lists");
    } else if(eval_first->get_type() == AST_NIL || eval_second->get_type() == AST_NIL) {
        report_error(b, "Nil can only be used with binop @");
    } else if (eval_first->get_type() != eval_second->get_type() || (
               eval_first->get_type() == eval_second->get_type() &&
               eval_first->get_type() != AST_INT &&
               eval_first->get_type() != AST_STRING)) {
        report_error(b, "Binop can only be applied to expressions of same type");
    }

    if(eval_first->get_type() == AST_STRING) {
        switch(b->get_binop_type()) {
        case PLUS:
            return AstString::make(
                static_cast<AstString *>(eval_first)->get_string() +
                static_cast<AstString *>(eval_second)->get_string()
            );
        case EQ:
            return AstInt::make(
                static_cast<AstString *>(eval_first)->get_string() ==
                static_cast<AstString *>(eval_second)->get_string()
            );
        case NEQ:
            return AstInt::make(
                static_cast<AstString *>(eval_first)->get_string() !=
                static_cast<AstString *>(eval_second)->get_string()
            );
        default:
            report_error(b, "Binop " + AstBinOp::binop_type_to_string(b->get_binop_type())  + " cannot be applied to strings");
        }
    }

    if(eval_first->get_type() == AST_INT) {
        auto int_first = static_cast<AstInt *>(eval_first)->get_int();
        auto int_second = static_cast<AstInt *>(eval_second)->get_int();

        switch(b->get_binop_type()) {
        case PLUS:
            return AstInt::make(int_first + int_second);
        case MINUS:
            return AstInt::make(int_first - int_second);
        case TIMES:
            return AstInt::make(int_first * int_second);
        case DIVIDE:
            return AstInt::make(int_first / int_second);
        case EQ:
            if(int_first == int_second) {
                return AstInt::make(1);
            } else {
                return AstInt::make(0);
            }
        case NEQ:
            if(int_first != int_second) {
                return AstInt::make(1);
            } else {
                return AstInt::make(0);
            }
        case LT:
            return AstInt::make(int_first < int_second);
        case LEQ:
            return AstInt::make(int_first <= int_second);
        case GT:
            return AstInt::make(int_first > int_second);
        case GEQ:
            return AstInt::make(int_first >= int_second);
        case AND:
            if(int_first != 0 && int_second != 0) {
                return AstInt::make(1);
            } else {
                return AstInt::make(0);
            }
        case OR:
            if(int_first == 0 && int_second == 0) {
                return AstInt::make(0);
            } else {
                return AstInt::make(1);
            }
        default:
            // Only CONS left and that is not reachable
            assert(false);
        }

    }
    assert(false);
}

Expression *Evaluator::eval_unop(AstUnOp *b) {
    Expression *e = b->get_expression();
    Expression *eval_e = eval(e);

    if(b->get_unop_type() == PRINT) {
        if(eval_e->get_type() == AST_STRING) {
            AstString *s = static_cast<AstString *>(eval_e);
            cout << s->get_string() << endl;
        } else {
            cout << eval_e->to_value() << endl;
        }

        return AstInt::make(0);
    }

    if(b->get_unop_type() == HD) {
        if(eval_e->get_type() == AST_LIST) {
            return (static_cast<AstList *>(eval_e))->get_hd();
        } else {
            return eval_e;
        }
    }

    if(b->get_unop_type() == TL) {
        if(eval_e->get_type() == AST_LIST) {
            return (static_cast<AstList *>(eval_e))->get_tl();
        } else {
            return AstNil::make();
        }
    }

    if(b->get_unop_type() == ISNIL) {
        if(eval_e->get_type() == AST_NIL) {
            return AstInt::make(1);
        } else {
            return AstInt::make(0);
        }
    }

    // add code to deal with all the other unops
    assert(false);
}

Expression *Evaluator::eval(Expression *e) {
    Expression *res_exp = NULL;
    switch(e->get_type()) {
        case AST_BINOP: {
            res_exp = eval_binop(static_cast<AstBinOp *>(e));
            break;
        }

        case AST_IDENTIFIER: {
            auto id = static_cast<AstIdentifier *>(e);
            res_exp = sym_tab.find(id);
            if(res_exp == NULL) {
                report_error(e, "Identifier " + id->get_id() + " is not bound in current context");
            }
            break;
        }

        case AST_INT: {
            res_exp = e;
            break;
        }

        case AST_LAMBDA: {
            res_exp = e;
            break;
        }

        case AST_LET: {
            auto let = static_cast<AstLet *>(e);
            auto id = let->get_id();
            sym_tab.push();
            sym_tab.add(id, eval(let->get_val()));
            res_exp = eval(let->get_body());
            sym_tab.pop();
            break;
        }

        case AST_STRING: {
            res_exp = e;
            break;
        }

        case AST_IDENTIFIER_LIST: {
            break;
        }

        case AST_EXPRESSION_LIST: {
            auto expr_list = static_cast<AstExpressionList *>(e);
            auto list = expr_list->get_expressions();
            auto lambda = eval(list[0]);
            for(unsigned long i = 1; i < list.size(); i++) {
                if(lambda->get_type() != AST_LAMBDA) {
                    report_error(e, "Only lambda expressions can be applied to other expressions");
                }
                lambda = static_cast<AstLambda *>(lambda)->get_body()->substitute(static_cast<AstLambda *>(lambda)->get_formal(), list[i]);
                lambda = eval(lambda);
            }
            res_exp = lambda;
            break;
        }

        case AST_BRANCH: {
            auto branch_e = static_cast<AstBranch *>(e);
            auto eval_pred = eval(branch_e->get_pred());
            if(eval_pred->get_type() == AST_INT) {
                auto bool_pred = static_cast<AstInt *>(eval_pred)->get_int() != 0;
                res_exp = bool_pred ? eval(branch_e->get_then_exp()) : eval(branch_e->get_else_exp());
            } else {
                report_error(e, "Predicate in conditional must be an integer");
            }
            break;
        }

        case AST_NIL: {
            res_exp = e;
            break;
        }

        case AST_LIST: {
            res_exp = e;
            break;
        }

        case AST_UNOP: {
            res_exp = eval_unop(static_cast<AstUnOp *>(e));
            break;
        }

        case AST_READ: {
            AstRead *r = static_cast<AstRead *>(e);
            string input;
            getline(cin, input);
            if(r->read_integer()) {
                return AstInt::make(string_to_int(input));
            }

            res_exp = AstString::make(input);

            break;
        }

        // ADD CASES FOR ALL EXPRESSIONS!!
        default:
            assert(false);
    }

    if(e == NULL) {
        report_error(e, "resulted in null expr");
    }
    // assert(res_exp);

    return res_exp;
}
