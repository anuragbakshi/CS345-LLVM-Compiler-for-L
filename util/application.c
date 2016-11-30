#include "operations.h"
#include "symboltable.h"
#include "hashmap.h"
#include "util.h"

#include <stdio.h>
#include <stdlib.h>


int push_to_symtable(any_t nothing, any_t key, any_t value) {
    symboltable_push(key, value);
    return 0;
}

int pop_from_symtable(any_t nothing, any_t key, any_t value) {
    symboltable_pop(key);
    return 0;
}

Object *apply(Object *func, Object *arg) {
    if (func->type != FUNCTION || func->func_ptr->formal == NULL) {
        printf("Only lambda expressions can be applied to other expressions\n");
        exit(1);
    }

    Func *real_func = func->func_ptr;
    hashmap_put(real_func->env, real_func->formal, (any_t*) arg);
    hashmap_iterate(real_func->env, push_to_symtable, NULL);  
    Object *(*ptr)(void) = (Object *(*)(void)) real_func->f;
    Object *ret = ptr();
    hashmap_iterate(real_func->env, pop_from_symtable, NULL);  

    return ret;
}

Object *eval_identifier(char *id) {
    Object *obj = symboltable_find(id);
    if (obj->type == FUNCTION && obj->func_ptr->formal == NULL) {
        // lazy argument, so evaluate it
        Func *func = obj->func_ptr;
        Object *(*ptr)(void) = (Object *(*)(void)) func->f;
        return ptr();
    } else {
        return obj;
    }
}
