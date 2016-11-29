#include <stdio.h>
#include <stdlib.h>

#include "symboltable.h"

typedef struct symboltable_entry {
    char *name;
    lifostack_t values;
} symboltable_entry;

symboltable_t symboltable_new() {
    return hashmap_new();
}

void symboltable_push(symboltable_t in, char *id, Object *o) {
    symboltable_entry *entry;

    if(hashmap_get(in, id, (any_t *) &entry) == MAP_MISSING) {
        entry = (symboltable_entry *) calloc(1, sizeof(symboltable_entry));
        entry->values = lifostack_new();
        hashmap_put(in, id, entry);
    }

    lifostack_push(entry->values, o);
}

void symboltable_pop(symboltable_t in, char *id) {
    symboltable_entry *entry;

    hashmap_get(in, id, (any_t *) &entry);
    lifostack_pop(entry->values);
}

Object *symboltable_find(symboltable_t in, char *id) {
    symboltable_entry *entry;
    Object *var_val;

    if (hashmap_get(in, id, (any_t *) &entry) == MAP_MISSING || lifostack_length(entry->values) == 0) {
        printf("Identifier %s is not bound in current context\n", id);
        exit(1);
    }

    lifostack_peek(entry->values, (any_t *) &var_val);

    return var_val;
}

int symboltable_copy_entry(symboltable_t out, any_t in) {
    symboltable_entry *entry = (symboltable_entry *) in;

}

symboltable_t symboltable_freeze(symboltable_t in) {
    symboltable_t frozen = symboltable_new();

    // hashmap_iterate()
}

void symboltable_free(symboltable_t in) {
    hashmap_free(in);
}
