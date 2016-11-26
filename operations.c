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

Object *add_str(Object *a, Object *b) {
    Object *concat = NEW(Object);
    concat->type = STRING;
    concat->str_ptr = (char *) malloc(strlen(a->str_ptr) + strlen(b->str_ptr) + 1);

    strcpy(concat->str_ptr, a->str_ptr);
    strcat(concat->str_ptr, b->str_ptr);

    return concat;
}

Object *add_int(Object *a, Object *b) {
    Object *sum = NEW(Object);

    sum->type = INT;
    sum->int_val = a->int_val + b->int_val;

    return sum;
}

Object *add_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return add_int(a, b);
    } else if(a->type == STRING && b->type == STRING) {
        return add_str(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}
