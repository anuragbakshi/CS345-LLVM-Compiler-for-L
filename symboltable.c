#include "symboltable.h"

typedef struct symboltable_entry {
    char *name;
    lifostack_t values;
} symboltable_entry;

symboltable_t symboltable_new() {
    return hashmap_new();
}

void push(symboltable_t in, char *id, Object *o) {
    symboltable_entry *entry;

    if(hashmap_get(in, id, (any_t *) &entry) == MAP_MISSING) {
        entry = (symboltable_entry *) calloc(1, sizeof(symboltable_entry));
        hashmap_put(in, id, entry);
    }

    lifostack_push(entry->values, o);
}

void pop(symboltable_t in, char *id) {
    symboltable_entry *entry;

    hashmap_get(in, id, (any_t *) &entry);
    lifostack_pop(entry->values);
}

Object *find(symboltable_t in, char *id) {
    symboltable_entry *entry;
    Object *var_val;

    hashmap_get(in, id, (any_t *) &entry);
    lifostack_peek(entry->values, (any_t *) &var_val);

    return var_val;
}

int copy_entry(symboltable_t out, any_t in) {
    symboltable_entry *entry = (symboltable_entry *) in;

}

symboltable_t freeze(symboltable_t in) {
    symboltable_t frozen = symboltable_new();

    hashmap_iterate()
}

void symboltable_free(symboltable_t in) {
    hashmap_free(in);
}
