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
    int_1 { builder.getInt1Ty() },
    int_64 { builder.getInt64Ty() },

    // struct types
    struct_Func { llvm::StructType::create(context, "struct.Func") },
    struct_Object { llvm::StructType::create(context, "struct.Object") },

    // pointer types
    ptr_struct_Func { llvm::PointerType::get(struct_Func, 0) },
    ptr_struct_Object { llvm::PointerType::get(struct_Object, 0) },

    // function types
    functype_read_line { llvm::FunctionType::get(ptr_struct_Object, false) },
    functype_read_int { llvm::FunctionType::get(ptr_struct_Object, false) },

    functype_make_int { llvm::FunctionType::get(ptr_struct_Object, { int_64 }, false) },
    functype_make_string { llvm::FunctionType::get(ptr_struct_Object, { ptr_void }, false) },

    functype_assert_predicate { llvm::FunctionType::get(int_1, { ptr_struct_Object }, false) },

    functype_binop { llvm::FunctionType::get(ptr_struct_Object, { ptr_struct_Object, ptr_struct_Object }, false) },
    functype_unop { llvm::FunctionType::get(ptr_struct_Object, { ptr_struct_Object }, false) },
    functype_display_any { llvm::FunctionType::get(builder.getVoidTy(), { ptr_struct_Object }, false) },

    // functions
    func_read_line { llvm::Function::Create(functype_read_line, llvm::Function::ExternalLinkage, "read_line", module) },
    func_read_int { llvm::Function::Create(functype_read_int, llvm::Function::ExternalLinkage, "read_int", module) },

    func_make_int { llvm::Function::Create(functype_make_int, llvm::Function::ExternalLinkage, "make_int", module) },
    func_make_string { llvm::Function::Create(functype_make_string, llvm::Function::ExternalLinkage, "make_string", module) },

    func_assert_predicate { llvm::Function::Create(functype_assert_predicate, llvm::Function::ExternalLinkage, "assert_predicate", module) },

    func_plus_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "plus_any", module) },
    func_minus_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "minus_any", module) },
    func_times_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "times_any", module) },
    func_divide_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "divide_any", module) },
    func_and_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "and_any", module) },
    func_or_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "or_any", module) },
    func_eq_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "eq_any", module) },
    func_neq_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "neq_any", module) },
    func_lt_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "lt_any", module) },
    func_leq_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "leq_any", module) },
    func_gt_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "gt_any", module) },
    func_geq_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "geq_any", module) },
    func_cons_any { llvm::Function::Create(functype_binop, llvm::Function::ExternalLinkage, "cons_any", module) },
    func_hd_any { llvm::Function::Create(functype_unop, llvm::Function::ExternalLinkage, "hd_any", module) },
    func_tl_any { llvm::Function::Create(functype_unop, llvm::Function::ExternalLinkage, "tl_any", module) },
    func_isnil_any { llvm::Function::Create(functype_unop, llvm::Function::ExternalLinkage, "isnil_any", module) },
    func_print_any { llvm::Function::Create(functype_unop, llvm::Function::ExternalLinkage, "print_any", module) },

    func_display_any { llvm::Function::Create(functype_display_any, llvm::Function::ExternalLinkage, "display_any", module) }
{
    std::vector<llvm::Type *> struct_Func_fields { ptr_void, ptr_void };
    struct_Func->setBody(struct_Func_fields);

    std::vector<llvm::Type *> struct_Object_fields { int_64, int_64 };
    struct_Object->setBody(struct_Func_fields);
}

void Compiler::compile(Expression *root) {
    blocks.push(entry);

    builder.SetInsertPoint(entry);

    auto final_val = codegen_expression(root);

    llvm::CallInst::Create(func_display_any, { final_val }, "", blocks.top());
    llvm::ReturnInst::Create(context, llvm::ConstantInt::get(builder.getInt32Ty(), 0), blocks.top());

    module->dump();
}

llvm::Value *Compiler::codegen_error(Expression *e, char *s) {
    // TODO: implement
}

llvm::Value *Compiler::codegen_binop(AstBinOp *e) {
    // std::cout << "\033[1;31mTODO:\033[0m codegen_binop" << std::endl;
    auto gen_first = codegen_expression(e->get_first());
    auto gen_second = codegen_expression(e->get_second());

    return llvm::CallInst::Create(binop_funcs[e->get_binop_type()], { gen_first, gen_second }, "", blocks.top());
}

llvm::Value *Compiler::codegen_branch(AstBranch *e) {
    auto gen_pred = codegen_expression(e->get_pred());

    // if (eval_pred->get_type() == AST_INT) {
    //     auto bool_pred = static_cast<AstInt *>(eval_pred)->get_int() != 0;
    //     res_exp = bool_pred ? eval(branch_e->get_then_exp())
    //                         : eval(branch_e->get_else_exp());
    // } else {
    //     codegen_error(e, "Predicate in conditional must be an integer");
    // }

    auto pred_val = llvm::CallInst::Create(func_assert_predicate, { gen_pred }, "", blocks.top());

    auto if_block = llvm::BasicBlock::Create(context, "if", blocks.top()->getParent(), 0);
    auto else_block = llvm::BasicBlock::Create(context, "else", blocks.top()->getParent(), 0);
    auto after_block = llvm::BasicBlock::Create(context, "after", blocks.top()->getParent(), 0);

    llvm::BranchInst::Create(if_block, else_block, pred_val, blocks.top());

    blocks.push(if_block);
    auto gen_if = codegen_expression(e->get_then_exp());
    llvm::BranchInst::Create(after_block, blocks.top());
    blocks.pop();

    blocks.push(else_block);
    auto gen_else = codegen_expression(e->get_else_exp());
    llvm::BranchInst::Create(after_block, blocks.top());
    blocks.pop();

    blocks.push(after_block);

    auto phi = llvm::PHINode::Create(ptr_struct_Object, 2, "", blocks.top());
    phi->addIncoming(gen_if, if_block);
    phi->addIncoming(gen_else, else_block);

    return phi;
}

llvm::Value *Compiler::codegen_expressionlist(AstExpressionList *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_expressionlist" << std::endl;
    return nullptr;
}

llvm::Value *Compiler::codegen_identifier(AstIdentifier *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_identifier" << std::endl;
    return nullptr;
}

llvm::Value *Compiler::codegen_identifierlist(AstIdentifierList *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_identifierlist" << std::endl;
    return nullptr;
}

llvm::Value *Compiler::codegen_int(AstInt *e) {
    auto int_val = llvm::ConstantInt::get(builder.getInt64Ty(), e->get_int(), true);

    return llvm::CallInst::Create(func_make_int, { int_val }, "", blocks.top());
}

llvm::Value *Compiler::codegen_lambda(AstLambda *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_lambda" << std::endl;
    return nullptr;
}

llvm::Value *Compiler::codegen_let(AstLet *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_let" << std::endl;
    return nullptr;
}

llvm::Value *Compiler::codegen_list(AstList *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_list" << std::endl;
    return nullptr;
}

llvm::Value *Compiler::codegen_nil(AstNil *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_nil" << std::endl;
    return nullptr;
}

llvm::Value *Compiler::codegen_read(AstRead *e) {
    std::cout << "\033[1;31mTODO:\033[0m codegen_read" << std::endl;
    return nullptr;
}

llvm::Value *Compiler::codegen_string(AstString *e) {
    llvm::Value *str_val = builder.CreateGlobalStringPtr(e->get_string());

    return llvm::CallInst::Create(func_make_string, { str_val }, "", blocks.top());
}

llvm::Value *Compiler::codegen_unop(AstUnOp *e) {
    auto gen_e = codegen_expression(e->get_expression());

    return llvm::CallInst::Create(unop_funcs[e->get_unop_type()], { gen_e }, "", blocks.top());
}

llvm::Value *Compiler::codegen_expression(Expression *e) {
    switch (e->get_type()) {
    case AST_BINOP: {
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

    case AST_INT: {
        return codegen_int(static_cast<AstInt *>(e));
    }

    case AST_LAMBDA: {
        return codegen_lambda(static_cast<AstLambda *>(e));
    }

    // case AST_LET: {
    //     auto let = static_cast<AstLet *>(e);
    //     auto id = let->get_id();
    //     sym_tab.push();
    //     sym_tab.plus(id, eval(let->get_val()));
    //     res_exp = eval(let->get_body());
    //     sym_tab.pop();
    //     break;
    // }

    case AST_STRING: {
        return codegen_string(static_cast<AstString *>(e));
    }

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

    case AST_BRANCH: {
        // auto branch_e = static_cast<AstBranch *>(e);
        // auto eval_pred = eval(branch_e->get_pred());
        // if (eval_pred->get_type() == AST_INT) {
        //     auto bool_pred = static_cast<AstInt *>(eval_pred)->get_int() != 0;
        //     res_exp = bool_pred ? eval(branch_e->get_then_exp())
        //                         : eval(branch_e->get_else_exp());
        // } else {
        //     report_error(e, "Predicate in conditional must be an integer");
        // }
        // break;

        return codegen_branch(static_cast<AstBranch *>(e));
    }

    case AST_NIL: {
        return codegen_nil(static_cast<AstNil *>(e));
    }

    // TODO: should never happen
    case AST_LIST: {
        return codegen_list(static_cast<AstList *>(e));
    }

    case AST_UNOP: {
        return codegen_unop(static_cast<AstUnOp *>(e));
    }

    case AST_READ: {
        // AstRead *r = static_cast<AstRead *>(e);
        // string input;
        // getline(cin, input);
        // if (r->read_integer()) {
        //     return AstInt::make(string_to_int(input));
        // }
        //
        // res_exp = AstString::make(input);
        //
        // break;

        return codegen_read(static_cast<AstRead *>(e));
    }

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
