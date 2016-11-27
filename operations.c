#include "operations.h"

Object *read_line() {
    char *input;
    getline(&input, 0, stdin);
    Object *str_obj = NEW(Object);
    str_obj->type = STRING;
    str_obj->str_ptr = input;
    return str_obj;
}

Object *read_int() {
    char *input;
    getline(&input, 0, stdin);
    Object *int_obj = NEW(Object);
    int_obj->type = INT;
    // TODO: check to make sure input is a number
    int_obj->int_val = atoi(input);
    return int_obj;
}

Object *make_int(int64_t i) {
    Object *int_obj = NEW(Object);
    int_obj->type = INT;
    int_obj->int_val = i;

    return int_obj;
}

Object *plus_str(Object *a, Object *b) {
    Object *concat = NEW(Object);
    concat->type = STRING;
    concat->str_ptr = (char *) malloc(strlen(a->str_ptr) + strlen(b->str_ptr) + 1);

    strcpy(concat->str_ptr, a->str_ptr);
    strcat(concat->str_ptr, b->str_ptr);

    return concat;
}

Object *plus_int(Object *a, Object *b) {
    Object *sum = NEW(Object);

    sum->type = INT;
    sum->int_val = a->int_val + b->int_val;

    return sum;
}

Object *plus_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return plus_int(a, b);
    } else if(a->type == STRING && b->type == STRING) {
        return plus_str(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *minus_any(Object *a, Object *b) {
}

Object *times_any(Object *a, Object *b) {
}

Object *divide_any(Object *a, Object *b) {
}

Object *and_any(Object *a, Object *b) {
}

Object *or_any(Object *a, Object *b) {
}

Object *eq_any(Object *a, Object *b) {
}

Object *neq_any(Object *a, Object *b) {
}

Object *lt_any(Object *a, Object *b) {
}

Object *leq_any(Object *a, Object *b) {
}

Object *gt_any(Object *a, Object *b) {
}

Object *geq_any(Object *a, Object *b) {
}

Object *cons_any(Object *a, Object *b) {
}

Object *hd_any(Object *o) {
}

Object *tl_any(Object *o) {
}

Object *isnil_any(Object *o) {
}

void print_int(Object *o) {
    printf("%lld\n", o->int_val);
}

void print_str(Object *o) {
    printf("\"%s\"\n", o->str_ptr);
}

void print_any(Object *o) {
    if(o->type == INT) {
        return print_int(o);
    } else if(o->type == STRING) {
        return print_str(o);
    } else {
        error("Binop can only be applied to expressions of same type");
    }
}

void error(char *s) {
    // cout << "Run-time error in expression " << e->to_value() << endl;
    // cout << s << endl;
    printf("%s\n", s);
    exit(1);
}
