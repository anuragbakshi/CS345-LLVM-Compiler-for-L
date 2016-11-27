

#ifndef COMPILER_H_
#define COMPILER_H_

// class Expression;
// class AstBinOp;
// class AstUnOp;
// class AstExpressionList;

#include "ast/all.hpp"

#include <llvm/IR/IRBuilder.h>

// #include "SymbolTable.hpp"

class Compiler {
  private:
    // SymbolTable sym_tab;
    // int c;

    llvm::LLVMContext& context;
    llvm::Module *module;
    llvm::IRBuilder<> builder;

    llvm::FunctionType *functype_main;
    llvm::Function *func_main;
    llvm::BasicBlock *entry;

    llvm::PointerType *ptr_void;

    llvm::IntegerType *int_64;

    // struct types
    llvm::StructType *struct_Func;
    llvm::StructType *struct_Object;

    // pointer types
    llvm::PointerType *ptr_struct_Func;
    llvm::PointerType *ptr_struct_Object;

    // function types
    llvm::FunctionType *functype_read_line;
    llvm::FunctionType *functype_read_int;

    llvm::FunctionType *functype_make_int;

    // llvm::FunctionType *functype_add_str;
    // llvm::FunctionType *functype_add_int;
    llvm::FunctionType *functype_add_any;
    llvm::FunctionType *functype_print_any;

    // functions
    llvm::Function *func_read_line;
    llvm::Function *func_read_int;

    llvm::Function *func_make_int;

    // llvm::Function *func_add_str;
    // llvm::Function *func_add_int;
    llvm::Function *func_add_any;
    llvm::Function *func_print_any;

  public:
    Compiler();
    // void dump();
    void compile(Expression *root);

    llvm::Value *codegen_binop(AstBinOp *e);
    llvm::Value *codegen_branch(AstBranch *e);
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
};

#endif /* COMPILER_H_ */
