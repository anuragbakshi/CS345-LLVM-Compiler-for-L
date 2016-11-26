#include <llvm/ADT/ArrayRef.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/IRBuilder.h>
#include <vector>
#include <string>
#include <iostream>

#include "Compiler.hpp"

Compiler::Compiler() :
   context { llvm::getGlobalContext() },
   module { new llvm::Module("top", context) },
   builder { context } {
}

llvm::Value *Compiler::codegen_binop(AstBinOp *e) {
}

llvm::Value *Compiler::codegen_branch(AstBranch *e) {
}

llvm::Value *Compiler::codegen_expressionlist(AstExpressionList *e) {
}

llvm::Value *Compiler::codegen_identifier(AstIdentifier *e) {
}

llvm::Value *Compiler::codegen_identifierlist(AstIdentifierList *e) {
}

llvm::Value *Compiler::codegen_int(AstInt *e) {
}

llvm::Value *Compiler::codegen_lambda(AstLambda *e) {
}

llvm::Value *Compiler::codegen_let(AstLet *e) {
}

llvm::Value *Compiler::codegen_list(AstList *e) {
}

llvm::Value *Compiler::codegen_nil(AstNil *e) {
}

llvm::Value *Compiler::codegen_read(AstRead *e) {
}

llvm::Value *Compiler::codegen_string(AstString *e) {
}

llvm::Value *Compiler::codegen_unop(AstUnOp *e) {
}

llvm::Value *Compiler::codegen_expression(Expression *e) {
    switch (e->get_type()) {
    case AST_BINOP: {
        // res_exp = eval_binop(static_cast<AstBinOp *>(e));
        // break;

        
    }

    // case AST_IDENTIFIER: {
    //     auto id = static_cast<AstIdentifier *>(e);
    //     res_exp = sym_tab.find(id);
    //     if (res_exp == NULL) {
    //         report_error(e, "Identifier " + id->get_id() +
    //                             " is not bound in current context");
    //     }
    //     break;
    // }
    //
    // case AST_INT: {
    //     res_exp = e;
    //     break;
    // }
    //
    // case AST_LAMBDA: {
    //     res_exp = e;
    //     break;
    // }
    //
    // case AST_LET: {
    //     auto let = static_cast<AstLet *>(e);
    //     auto id = let->get_id();
    //     sym_tab.push();
    //     sym_tab.add(id, eval(let->get_val()));
    //     res_exp = eval(let->get_body());
    //     sym_tab.pop();
    //     break;
    // }
    //
    // case AST_STRING: {
    //     res_exp = e;
    //     break;
    // }
    //
    // case AST_IDENTIFIER_LIST: {
    //     break;
    // }
    //
    // case AST_EXPRESSION_LIST: {
    //     auto expr_list = static_cast<AstExpressionList *>(e);
    //     auto list = expr_list->get_expressions();
    //     auto lambda = eval(list[0]);
    //     for (unsigned long i = 1; i < list.size(); i++) {
    //         if (lambda->get_type() != AST_LAMBDA) {
    //             report_error(e, "Only lambda expressions can be applied to "
    //                             "other expressions");
    //         }
    //         lambda = static_cast<AstLambda *>(lambda)->get_body()->substitute(
    //             static_cast<AstLambda *>(lambda)->get_formal(), list[i]);
    //         lambda = eval(lambda);
    //     }
    //     res_exp = lambda;
    //     break;
    // }
    //
    // case AST_BRANCH: {
    //     auto branch_e = static_cast<AstBranch *>(e);
    //     auto eval_pred = eval(branch_e->get_pred());
    //     if (eval_pred->get_type() == AST_INT) {
    //         auto bool_pred = static_cast<AstInt *>(eval_pred)->get_int() != 0;
    //         res_exp = bool_pred ? eval(branch_e->get_then_exp())
    //                             : eval(branch_e->get_else_exp());
    //     } else {
    //         report_error(e, "Predicate in conditional must be an integer");
    //     }
    //     break;
    // }
    //
    // case AST_NIL: {
    //     res_exp = e;
    //     break;
    // }
    //
    // case AST_LIST: {
    //     res_exp = e;
    //     break;
    // }
    //
    // case AST_UNOP: {
    //     res_exp = eval_unop(static_cast<AstUnOp *>(e));
    //     break;
    // }
    //
    // case AST_READ: {
    //     AstRead *r = static_cast<AstRead *>(e);
    //     string input;
    //     getline(cin, input);
    //     if (r->read_integer()) {
    //         return AstInt::make(string_to_int(input));
    //     }
    //
    //     res_exp = AstString::make(input);
    //
    //     break;
    // }
    default:
        std::cout << "TODO: " << e->get_type() << std::endl;
    }
}

// int main()
// {
//   llvm::LLVMContext& context = llvm::getGlobalContext();
//   llvm::Module *module = new llvm::Module("top", context);
//   llvm::IRBuilder<> builder(context);
//
//   llvm::FunctionType *funcType =
//       llvm::FunctionType::get(builder.getInt32Ty(), false);
//   llvm::Function *mainFunc =
//       llvm::Function::Create(funcType, llvm::Function::ExternalLinkage, "main", module);
//
//
//   llvm::BasicBlock *entry = llvm::BasicBlock::Create(context, "entrypoint", mainFunc);
//   builder.SetInsertPoint(entry);
//
//   llvm::Value *helloWorld = builder.CreateGlobalStringPtr("hello world!\n");
//   std::vector<llvm::Type *> putsArgs;
//   putsArgs.push_back(builder.getInt8Ty()->getPointerTo());
//   llvm::ArrayRef<llvm::Type*>  argsRef(putsArgs);
//
//   llvm::FunctionType *putsType =
//     llvm::FunctionType::get(builder.getInt32Ty(), argsRef, false);
//   llvm::Constant *putsFunc = module->getOrInsertFunction("puts", putsType);
//
//   llvm::Value *retVal = llvm::ConstantInt::get(builder.getInt32Ty(), 0);
//
//
//   builder.CreateCall(putsFunc, helloWorld);
//   builder.CreateRet(retVal);
//
//   module->dump( );
// }
