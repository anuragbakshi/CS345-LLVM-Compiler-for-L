#include "operations.h"
#include "symboltable.h"
#include "hashmap.h"
#include "util.h"

#include <stdio.h>
#include <stdlib.h>

extern uint64_t symtable_size;
extern symboltable_t symtable;

// int push_to_symtable(any_t nothing, any_t key, any_t value) {
//     symboltable_push(key, value);
//     return 0;
// }
// int push_to_symtable(uint64_t key, Object *value) {
//     symboltable_push(key, value);
//     return 0;
// }
//
// // int pop_from_symtable(any_t nothing, any_t key, any_t value) {
// //     symboltable_pop(key);
// //     return 0;
// // }
// int pop_from_symtable(uint64_t key) {
//     symboltable_pop(key);
//     return 0;
// }

void push_func_env(Func* real_func) {
    if(real_func->env != NULL) {
        // hashmap_iterate(real_func->env, push_to_symtable, NULL);
        for(uint64_t i = 0; i < symtable_size; ++i) {
            if(real_func->env[i] != NULL) {
                symboltable_push(i, real_func->env[i]);
            }
        }
    }
}

void pop_func_env(Func* real_func) {
    if(real_func->env != NULL) {
        // hashmap_iterate(real_func->env, pop_from_symtable, NULL);
        for(uint64_t i = 0; i < symtable_size; ++i) {
            if(real_func->env[i] != NULL) {
                symboltable_pop(i);
            }
        }
    }
}

Object *apply(Object *func, Object *arg) {
    if (func->type != FUNCTION || func->func_ptr->formal == 0) {
        printf("Only lambda expressions can be applied to other expressions\n");
        exit(1);
    }

    Func *real_func = func->func_ptr;
    // hashmap_put(real_func->env, real_func->formal, (any_t*) arg);
    real_func->env[real_func->formal] = arg;
    push_func_env(real_func);
    Object *(*ptr)(void) = (Object *(*)(void)) real_func->f;
    Object *ret = ptr();
    pop_func_env(real_func);

    return ret;
}


Object *eval_identifier(uint64_t id) {
    Object *obj = symboltable_find(id);
    if (obj->type == FUNCTION && obj->func_ptr->formal == 0) {
        // lazy argument, so evaluate it
        Func *func = obj->func_ptr;
        Object *(*ptr)(void) = (Object *(*)(void)) func->f;
        push_func_env(func);
        Object* res = ptr();
        pop_func_env(func);
        return res;
    } else {
        return obj;
    }
}
