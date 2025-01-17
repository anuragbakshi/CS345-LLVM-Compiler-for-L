

#ifndef COMPILER_H_
#define COMPILER_H_

// class Expression;
// class AstBinOp;
// class AstUnOp;
// class AstExpressionList;

#include "ast/all.hpp"

#include <llvm/IR/IRBuilder.h>

#include <stack>
#include <vector>
#include <unordered_map>

// #include "SymbolTable.hpp"

class Compiler {
  private:
    // SymbolTable sym_tab;
    // int c;

    std::stack<llvm::BasicBlock *> blocks;

    llvm::LLVMContext &context;
    llvm::Module *module;
    llvm::IRBuilder<> builder;

    llvm::FunctionType *functype_main;
    llvm::Function *func_main;
    llvm::BasicBlock *entry;

    llvm::Type *t_void;

    llvm::PointerType *ptr_void;

    llvm::IntegerType *int_1;
    llvm::IntegerType *int_64;

    // struct types
    llvm::StructType *struct_Func;
    llvm::StructType *struct_Object;

    // pointer types
    llvm::PointerType *ptr_struct_Func;
    llvm::PointerType *ptr_struct_Object;

    // function types
    llvm::FunctionType *functype_read_string;
    llvm::FunctionType *functype_read_int;

    llvm::FunctionType *functype_make_int;
    llvm::FunctionType *functype_make_string;
    llvm::FunctionType *functype_make_nil;

    llvm::FunctionType *functype_assert_predicate;

    llvm::FunctionType *functype_binop;
    llvm::FunctionType *functype_unop;

    llvm::FunctionType *functype_display_any;

    llvm::FunctionType *functype_symtable_get;
    llvm::FunctionType *functype_symtable_new;
    llvm::FunctionType *functype_symtable_push;
    llvm::FunctionType *functype_symtable_pop;
    llvm::FunctionType *functype_symtable_find;
    llvm::FunctionType *functype_symtable_free;

    llvm::FunctionType *functype_make_func;
    llvm::FunctionType *functype_make_func_obj;
    llvm::FunctionType *functype_custom;
    llvm::FunctionType *functype_apply;
    llvm::FunctionType *functype_eval_identifier;

    llvm::FunctionType *functype_debug;

    // functions
    llvm::Function *func_read_string;
    llvm::Function *func_read_int;

    llvm::Function *func_make_int;
    llvm::Function *func_make_string;
    llvm::Function *func_make_nil;

    llvm::Function *func_assert_predicate;

    llvm::Function *func_plus_any;
    llvm::Function *func_minus_any;
    llvm::Function *func_times_any;
    llvm::Function *func_divide_any;
    llvm::Function *func_and_any;
    llvm::Function *func_or_any;
    llvm::Function *func_eq_any;
    llvm::Function *func_neq_any;
    llvm::Function *func_lt_any;
    llvm::Function *func_leq_any;
    llvm::Function *func_gt_any;
    llvm::Function *func_geq_any;
    llvm::Function *func_cons_any;
    llvm::Function *func_hd_any;
    llvm::Function *func_tl_any;
    llvm::Function *func_isnil_any;
    llvm::Function *func_print_any;

    llvm::Function *func_display_any;

    llvm::Function *func_symtable_get;
    llvm::Function *func_symtable_new;
    llvm::Function *func_symtable_push;
    llvm::Function *func_symtable_pop;
    llvm::Function *func_symtable_find;
    llvm::Function *func_symtable_free;

    llvm::Function *func_make_func;
    llvm::Function *func_make_func_obj;
    llvm::Function *func_apply;
    llvm::Function *func_eval_identifier;

    llvm::Function *func_debug;

    // helper lookup tables
    llvm::Function *binop_funcs[13] { func_plus_any, func_minus_any, func_times_any, func_divide_any, func_and_any, func_or_any, func_eq_any, func_neq_any, func_lt_any, func_leq_any, func_gt_any, func_geq_any, func_cons_any };
    llvm::Function *unop_funcs[4] { func_hd_any, func_tl_any, func_isnil_any, func_print_any };

    // name/id lookup tables
    std::vector<llvm::Value *> id_to_name_val;
    std::unordered_map<std::string, uint64_t> name_to_id;

    llvm::Value *get_name_val_for_id(uint64_t id);
    uint64_t get_id_for_name(std::string name);

    llvm::Value *codegen_error(Expression *e, char *s);

    llvm::Value *codegen_symtable();
    llvm::Value *codegen_wrap(Expression *e);

    llvm::Value *codegen_binop(AstBinOp *e);
    llvm::Value *codegen_branch(AstBranch *e);
    llvm::Value *codegen_application(llvm::Value *func, const vector<Expression *> &e, int i);
    llvm::Value *codegen_expressionlist(AstExpressionList *e);
    llvm::Value *codegen_identifier(AstIdentifier *e);
    llvm::Value *codegen_identifierlist(AstIdentifierList *e);
    llvm::Value *codegen_int(AstInt *e);
    llvm::Value *codegen_lambda(AstLambda *e);
    llvm::Value *codegen_let(AstLet *e);
    llvm::Value *codegen_list(AstList *e);
    llvm::Value *codegen_nil(AstNil *e);
    llvm::Value *codegen_read(AstRead *e);
    llvm::Value *codegen_string(AstString *e);
    llvm::Value *codegen_unop(AstUnOp *e);
    llvm::Value *codegen_expression(Expression *e);

  public:
    Compiler();
    void compile(Expression *root);
};

#endif /* COMPILER_H_ */
