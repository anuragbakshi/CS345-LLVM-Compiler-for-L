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

Object *make_nil() {
    Object *nil_obj = NEW(Object);
    nil_obj->type = NIL;
    nil_obj->int_val = NIL;
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
    return make_int(a->int_val + b->int_val);
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

Object *minus_int(Object *a, Object *b) {
    return make_int(a->int_val - b->int_val);
}

Object *minus_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return minus_int(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *times_int(Object *a, Object *b) {
    return make_int(a->int_val * b->int_val);
}

Object *times_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return times_int(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *divide_int(Object *a, Object *b) {
    return make_int(a->int_val / b->int_val);
}

Object *divide_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return divide_int(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *and_int(Object *a, Object *b) {
    if(a->int_val != 0 && b->int_val != 0) {
        return make_int(1);
    }
    return make_int(0);
}

Object *and_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return and_int(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *or_int(Object *a, Object *b) {
    if(a->int_val == 0 && b->int_val == 0) {
        return make_int(0);
    }
    return make_int(1);
}

Object *or_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return or_int(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *eq_int(Object *a, Object *b) {
    if(a->int_val == b->int_val) {
        return make_int(1);
    }
    return make_int(0);
}

Object *eq_str(Object *a, Object *b) {
    if(strcmp(a->str_ptr, b->str_ptr) == 0) {
        return make_int(1);
    }
    return make_int(0);
}

Object *eq_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return eq_int(a, b);
    } else if(a->type == STRING && b->type == STRING) {
        return eq_str(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *neq_int(Object *a, Object *b) {
    if(a->int_val != b->int_val) {
        return make_int(1);
    }
    return make_int(0);
}

Object *neq_str(Object *a, Object *b) {
    if(strcmp(a->str_ptr, b->str_ptr) != 0) {
        return make_int(1);
    }
    return make_int(0);
}

Object *neq_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return neq_int(a, b);
    } else if(a->type == STRING && b->type == STRING) {
        return neq_str(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *lt_int(Object *a, Object *b) {
    if(a->int_val < b->int_val) {
        return make_int(1);
    }
    return make_int(0);
}

Object *lt_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return lt_int(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *leq_int(Object *a, Object *b) {
    if(a->int_val <= b->int_val) {
        return make_int(1);
    }
    return make_int(0);
}

Object *leq_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return leq_int(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *gt_int(Object *a, Object *b) {
    if(a->int_val > b->int_val) {
        return make_int(1);
    }
    return make_int(0);
}

Object *gt_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return gt_int(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *geq_int(Object *a, Object *b) {
    if(a->int_val >= b->int_val) {
        return make_int(1);
    }
    return make_int(0);
}

Object *geq_any(Object *a, Object *b) {
    if(a->type == INT && b->type == INT) {
        return geq_int(a, b);
    } else {
        // error("Binop can only be applied to expressions of same type");
    }

    return NULL;
}

Object *cons(Object *a, Object *b) {
    Object *o = NEW(Object);
    o->list_head = a;
    o->list_tail = b;
    return o;
}

Object *cons_any(Object *a, Object *b) {
    if(b->type != NIL) {
        return cons(a,b);
    } else {
        return a;
    }

    return NULL;
}

Object *hd_any(Object *o) {
    if(o->type > 3) { // Is List
        return o->list_head;
    } else {
        return o;
    }

    return NULL;
}

Object *tl_any(Object *o) {
    if(o->type > 3) { // Is List
        return o->list_tail;
    } else {
        return make_nil();
    }

    return NULL;
}

Object *isnil_any(Object *o) {
    return o->type == NIL && o->nil_type == NIL ? make_int(1) : make_int(0);
}

Object *print_any(Object *o) {
    // TODO: fill
    return make_int(0);
}

void display_int(Object *o) {
    printf("%lld\n", o->int_val);
}

void display_str(Object *o) {
    printf("\"%s\"\n", o->str_ptr);
}

void display_any(Object *o) {
    if(o->type == INT) {
        return display_int(o);
    } else if(o->type == STRING) {
        return display_str(o);
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
