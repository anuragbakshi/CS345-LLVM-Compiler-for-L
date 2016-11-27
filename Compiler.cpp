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
    builder { context },

    functype_main { llvm::FunctionType::get(builder.getInt32Ty(), false) },
    func_main { llvm::Function::Create(functype_main, llvm::Function::ExternalLinkage, "main", module) },
    entry { llvm::BasicBlock::Create(context, "entrypoint", func_main) },

    ptr_void { llvm::PointerType::get(builder.getInt8Ty(), 0) },
    int_64 { builder.getInt64Ty() },

    struct_Func { llvm::StructType::create(context, "struct.Func") },
    struct_Object { llvm::StructType::create(context, "struct.Func") },

    ptr_struct_Func { llvm::PointerType::get(struct_Func, 0) },
    ptr_struct_Object { llvm::PointerType::get(struct_Object, 0) },

    functype_read_line { llvm::FunctionType::get(ptr_struct_Object, false) },
    functype_read_int { llvm::FunctionType::get(ptr_struct_Object, false) },
    functype_add_str { llvm::FunctionType::get(ptr_struct_Object, { ptr_struct_Object, ptr_struct_Object }, false) },
    functype_add_int { llvm::FunctionType::get(ptr_struct_Object, { ptr_struct_Object, ptr_struct_Object }, false) },
    functype_add_any { llvm::FunctionType::get(ptr_struct_Object, { ptr_struct_Object, ptr_struct_Object }, false) }
{
    builder.SetInsertPoint(entry);

    std::vector<llvm::Type *> struct_Func_fields { ptr_void, ptr_void };
    struct_Func->setBody(struct_Func_fields);

    std::vector<llvm::Type *> struct_Object_fields { int_64, int_64 };
    struct_Object->setBody(struct_Func_fields);
}

void Compiler::dump() {
    module->dump();
}

llvm::Value *Compiler::codegen_binop(AstBinOp *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_binop" << std::endl;
}

llvm::Value *Compiler::codegen_branch(AstBranch *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_branch" << std::endl;
}

llvm::Value *Compiler::codegen_expressionlist(AstExpressionList *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_expressionlist" << std::endl;
}

llvm::Value *Compiler::codegen_identifier(AstIdentifier *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_identifier" << std::endl;
}

llvm::Value *Compiler::codegen_identifierlist(AstIdentifierList *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_identifierlist" << std::endl;
}

llvm::Value *Compiler::codegen_int(AstInt *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_int" << std::endl;
}

llvm::Value *Compiler::codegen_lambda(AstLambda *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_lambda" << std::endl;
}

llvm::Value *Compiler::codegen_let(AstLet *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_let" << std::endl;
}

llvm::Value *Compiler::codegen_list(AstList *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_list" << std::endl;
}

llvm::Value *Compiler::codegen_nil(AstNil *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_nil" << std::endl;
}

llvm::Value *Compiler::codegen_read(AstRead *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_read" << std::endl;
}

llvm::Value *Compiler::codegen_string(AstString *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_string" << std::endl;
}

llvm::Value *Compiler::codegen_unop(AstUnOp *e) {
    std::cout << "TODO: codegen_unop" << std::endl;
}

llvm::Value *Compiler::codegen_expression(Expression *e) {
    switch (e->get_type()) {
    case AST_BINOP: {
        // res_exp = eval_binop(static_cast<AstBinOp *>(e));
        // break;

        return codegen_binop(static_cast<AstBinOp *>(e));
    }

    case AST_IDENTIFIER: {
    //     auto id = static_cast<AstIdentifier *>(e);
    //     res_exp = sym_tab.find(id);
    //     if (res_exp == NULL) {
    //         report_error(e, "Identifier " + id->get_id() +
    //                             " is not bound in current context");
    //     }
    //     break;

        return codegen_identifier(static_cast<AstIdentifier *>(e));
    }

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
