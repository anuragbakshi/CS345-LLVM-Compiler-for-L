#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "hashmap.h"

#define NEW(type) (type *) malloc(sizeof(type))

typedef enum Type {
    INT = 1,
    STRING,
    FUNCTION
} Type;

typedef struct Func {
    map_t env;
    void *f;
} Func;

typedef struct Object {
    union {
        Type type;
        struct Object *list_head;
    };
    union {
        int64_t int_val;
        char *str_ptr;
        struct Object *list_tail;
        Func *func_ptr;
    };
} Object;

Object *read_line();
Object *read_int();

Object *make_int(int64_t i);

Object *add_str(Object *a, Object *b);
Object *add_int(Object *a, Object *b);
Object *add_any(Object *a, Object *b);

void print_int(Object *o);
void print_str(Object *o);
void print_any(Object *o);

void __force_gen_llvm_use__(void *_, ...) {}

void __force_gen_llvm__() {
    Type t;
    Func f;
    Object o;

    __force_gen_llvm_use__(0, t, f, o);
    __force_gen_llvm_use__(0, read_line, read_int, add_str, add_int, add_any);
}
