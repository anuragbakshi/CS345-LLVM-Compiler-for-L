#include "stdint.h"
#include "stdlib.h"
#include "string.h"
#include "stdio.h"
#define NEW(x) (x*) malloc(sizeof(x))

void error(char* msg) {
    printf(msg);
    exit(-1);
}

typedef enum Type {
    INT = 1,
    STRING,
    FUNCTION 
} Type;

typedef struct Func {
    void* env;
    void* f;
} Func;

typedef struct Object {
    union {
        Type type;
        struct Object* list_head;
    };
    union {
        uint64_t int_val;
        char* str_ptr;
        struct Object* list_tail;
        Func* func_ptr;
    };
} Object;

Object* readLine()
{
    char* input;
    getline(&input, 0, stdin);
    Object* str_obj = NEW(Object);
    str_obj->type = STRING;
    str_obj->str_ptr = input;
    return str_obj;
}

Object* readInt() {
    char* input;
    getline(&input, 0, stdin);
    Object* int_obj = NEW(Object);
    int_obj->type = INT;
    // TODO: check to make sure input is a number
    int_obj->int_val = atoi(input);
    return int_obj;
}

Object* add_str(Object* a, Object* b) {
    char* new_str = (char*) malloc(strlen(a->str_ptr) + strlen(b->str_ptr) + 1);
    strcpy(new_str, a->str_ptr);
    strcat(new_str, b->str_ptr);
    Object* sum = NEW(Object);
    sum->type = STRING;
    sum->str_ptr = new_str;
    return sum;
}
Object* add_int(Object* a, Object* b) {
    uint64_t new_val = a->int_val + b->int_val;
    Object* sum = NEW(Object);
    sum->type = INT;
    sum->int_val = new_val;
    return sum;
}

Object* add_any(Object* a, Object* b) {
    if(a->type == INT && b->type == INT) {
        return add_int(a, b);
    } else if (a->type == STRING && b->type == STRING) {
        return add_str(a, b);
    } else {
        error("Binop can only be applied to expressions of same type");
    }
    return NULL;
}
