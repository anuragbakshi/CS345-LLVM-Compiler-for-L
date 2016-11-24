#include "stdint.h"
#include "stdlib.h"
#include "string.h"
#include "stdio.h"
#define NEW(x) (x*) malloc(sizeof(x))
#define CHECK_INT(a, b) \
    if((a)->type != INT || (b)->type != INT) error("not int")
#define CHECK_LIST(a) \
    if((uint64_t)((a)->list_head) < 4) error("not list")

void error(char* msg) {
    printf("%s\n", msg);
    exit(-1);
}

typedef enum Type {
    NIL = 0,
    INT,
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

Object* makeInt(uint64_t int_val)
{
    Object* int_obj = NEW(Object);
    int_obj->type = INT;
    int_obj->int_val = int_val;
    return int_obj;
}

Object* makeString(char* str)
{
    Object* str_obj = NEW(Object);
    str_obj->str_ptr = str;
    str_obj->type = STRING;
    return str_obj;
}

Object* makeList(Object* hd, Object* tl) 
{
    Object* list_obj = NEW(Object);
    list_obj->list_head = hd;
    list_obj->list_tail = tl;
    return list_obj;
}

Object* readString()
{
    char* input;
    getline(&input, 0, stdin);
    return makeString(input);
}

Object* readInt() {
    char* input;
    getline(&input, 0, stdin);
    // TODO: check to make sure input is a number
    return makeInt(atoi(input));
}

Object* add_str(Object* a, Object* b) {
    char* new_str = (char*) malloc(strlen(a->str_ptr) + strlen(b->str_ptr) + 1);
    strcpy(new_str, a->str_ptr);
    strcat(new_str, b->str_ptr);
    return makeString(new_str);;
}

Object* add_int(Object* a, Object* b) {
    uint64_t new_val = a->int_val + b->int_val;
    return makeInt(new_val);
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

Object* eq_int(Object* a, Object* b)
{
    uint64_t new_val = a->int_val == b->int_val;
    return makeInt(new_val);
}

Object* eq_str(Object* a, Object* b)
{
    uint64_t new_val = strcmp(a->str_ptr, b->str_ptr);
    return makeInt(new_val);
}

Object* eq_any(Object* a, Object* b) {
    if(a->type == INT && b->type == INT) {
        return eq_int(a, b);
    } else if (a->type == STRING && b->type == STRING) {
        return eq_int(a, b);
    } else {
        error("Binop can only be applied to expressions of same type");
    }
    return NULL;
}

Object* neq_int(Object* a, Object* b)
{
    uint64_t new_val = a->int_val != b->int_val;
    return makeInt(new_val);
}

Object* neq_str(Object* a, Object* b)
{
    uint64_t new_val = !strcmp(a->str_ptr, b->str_ptr);
    return makeInt(new_val);
}

Object* neq_any(Object* a, Object* b) {
    if(a->type == INT && b->type == INT) {
        return neq_int(a, b);
    } else if (a->type == STRING && b->type == STRING) {
        return neq_int(a, b);
    } else {
        error("Binop can only be applied to expressions of same type");
    }
    return NULL;
}


Object* sub_int(Object* a, Object* b) {
    return makeInt(a->int_val - b->int_val);
}



Object* gt_int(Object* a, Object* b) {
    return makeInt(a->int_val > b->int_val);
}

Object* geq_int(Object* a, Object* b) {
    return makeInt(a->int_val >= b->int_val);
}

Object* lt_int(Object* a, Object* b) {
    return makeInt(a->int_val < b->int_val);
}

Object* leq_int(Object* a, Object* b) {
    return makeInt(a->int_val <= b->int_val);
}

Object* div_int(Object* a, Object* b) {
    return makeInt(a->int_val / b->int_val);
}

Object* mul_int(Object* a, Object* b) {
    return makeInt(a->int_val * b->int_val);
}

Object* and_int(Object* a, Object* b) {
    return makeInt(a->int_val & b->int_val);
}

Object* or_int(Object* a, Object* b) {
    return makeInt(a->int_val | b->int_val);
}

Object* sub_any(Object* a, Object* b) {
    CHECK_INT(a, b);
    return gt_int(a, b);
}



Object* gt_any(Object* a, Object* b) {
    CHECK_INT(a, b);
    return gt_int(a, b);
}

Object* geq_any(Object* a, Object* b) {
    CHECK_INT(a, b);
    return geq_int(a, b);
}


Object* lt_any(Object* a, Object* b) {
    CHECK_INT(a, b);
    return lt_int(a, b);
}

Object* leq_any(Object* a, Object* b) {
    CHECK_INT(a, b);
    return leq_int(a, b);
}

Object* div_any(Object* a, Object* b) {
    CHECK_INT(a, b);
    return div_int(a, b);
}

Object* mul_any(Object* a, Object* b) {
    CHECK_INT(a, b);
    return mul_int(a, b);
}

Object* and_any(Object* a, Object* b) {
    CHECK_INT(a, b);
    return and_int(a, b);
}

Object* or_any(Object* a, Object* b) {
    CHECK_INT(a, b);
    return or_int(a, b);
}

Object* cons_any(Object* a, Object* b) {
    return makeList(a, b);
}

Object* hd(Object* obj) {
    return obj->list_head;
}

Object* tl(Object* obj) {
    return obj->list_tail;
}

Object* hd_any(Object* obj) {
    CHECK_LIST(obj);
    return hd(obj);
}

Object* tl_any(Object* obj) {
    CHECK_LIST(obj);
    return tl(obj);
}

Object* is_nil(Object* obj) {
    return makeInt(obj->type == NIL);
}

Object* print_int(Object* obj) {
    printf("%lld\n", obj->int_val);
    return makeInt(0);
}

Object* print_str(Object* obj) {
    printf("%s\n", obj->str_ptr);
    return makeInt(0);
}

Object* print_any(Object* obj);

Object* print_list(Object* t) {
    printf("[");
    if(t != NULL) {
        free(print_any(t->list_head));
        free(print_list(t->list_tail));
        printf(", ");
    } else {
        printf("]\n");
    }
    return makeInt(0);
}

Object* print_any(Object* obj) {
    if(obj->type == NIL) {
        printf("Nil\n");
        return makeInt(0);
    } else if(obj->type == INT) {
        return print_int(obj);
    } else if(obj->type == STRING) {
        return print_str(obj);
    } else if(obj->type == FUNCTION) {
        printf("what the fuck\n");
        return makeInt(0);
    } else {
        return print_list(obj);
    }
}

int main() {
    printf("hi\n");
}
