#include "operations.h"
#include "symboltable.h"

#include <stdio.h>
#include <stdlib.h>

Object *apply(Object *func, Object *arg) {
    if (func->type != FUNCTION || func->func_ptr->formal == NULL) {
        printf("Only lambda expressions can be applied to other expressions\n");
        exit(1);
    }

    Func *real_func = func->func_ptr;
    symboltable_push(real_func->formal, arg);
    Object *(*ptr)(void) = (Object *(*)(void)) real_func->f;
    Object *ret = ptr();
    symboltable_pop(real_func->formal);

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
