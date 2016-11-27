

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
    llvm::BasicBlock *entry;

    llvm::FunctionType *functype_main;
    llvm::Function *func_main;
    llvm::BasicBlock *entry_point;

    llvm::PointerType *ptr_void;

    llvm::IntegerType *int_64;

    llvm::StructType *struct_Func;
    llvm::StructType *struct_Object;

    llvm::PointerType *ptr_struct_Func;
    llvm::PointerType *ptr_struct_Object;

    llvm::FunctionType *functype_read_line;
    llvm::FunctionType *functype_read_int;
    llvm::FunctionType *functype_add_str;
    llvm::FunctionType *functype_add_int;
    llvm::FunctionType *functype_add_any;

  public:
    Compiler();
    void dump();

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
