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

Object *plus_str(Object *a, Object *b);
Object *plus_int(Object *a, Object *b);
Object *plus_any(Object *a, Object *b);

Object *minus_any(Object *a, Object *b);
Object *times_any(Object *a, Object *b);
Object *divide_any(Object *a, Object *b);
Object *and_any(Object *a, Object *b);
Object *or_any(Object *a, Object *b);
Object *eq_any(Object *a, Object *b);
Object *neq_any(Object *a, Object *b);
Object *lt_any(Object *a, Object *b);
Object *leq_any(Object *a, Object *b);
Object *gt_any(Object *a, Object *b);
Object *geq_any(Object *a, Object *b);
Object *cons_any(Object *a, Object *b);

Object *hd_any(Object *o);
Object *tl_any(Object *o);
Object *isnil_any(Object *o);

void print_int(Object *o);
void print_str(Object *o);
void print_any(Object *o);

void error(char *s);

void __force_gen_llvm_use__(void *_, ...) {}

void __force_gen_llvm__() {
    Type t;
    Func f;
    Object o;

    __force_gen_llvm_use__(0, t, f, o);
    __force_gen_llvm_use__(0, read_line, read_int, plus_str, plus_int, plus_any);
}
