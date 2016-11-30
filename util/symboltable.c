#include <stdio.h>
#include <stdlib.h>

#include "symboltable.h"

typedef struct symboltable_entry {
    char *name;
    lifostack_t values;
} symboltable_entry;

static symboltable_t symtable;

symboltable_t symboltable_get() {
    return symtable;
}

void symboltable_new() {
    symtable = hashmap_new();
}

void symboltable_push(char *id, Object *o) {
    symboltable_entry *entry;

    if (hashmap_get(symtable, id, (any_t *) &entry) == MAP_MISSING) {
        entry = (symboltable_entry *) calloc(1, sizeof(symboltable_entry));
        entry->values = lifostack_new();
        entry->name = (char *) calloc(strlen(id) + 1, sizeof(char));
        strcpy(entry->name, id);
        hashmap_put(symtable, id, entry);
    }

    lifostack_push(entry->values, o);
}

void symboltable_pop(char *id) {
    symboltable_entry *entry;
    hashmap_get(symtable, id, (any_t *) &entry);
    lifostack_pop(entry->values);
}

Object *symboltable_find(char *id) {
    symboltable_entry *entry;
    Object *var_val;
    int result = hashmap_get(symtable, id, (any_t *) &entry);

    if (result == MAP_MISSING
            || lifostack_length(entry->values) == 0) {
        printf("Identifier %s is not bound in current context\n", id);
        exit(1);
    }

    lifostack_peek(entry->values, (any_t *) &var_val);

    return var_val;
}

int symboltable_copy_entry(any_t item, any_t first, any_t second) {
    Object* val;
    symboltable_entry *entry = (symboltable_entry*)second;
    if(lifostack_length(entry->values) != 0) { 
        lifostack_peek(entry->values, (any_t *) &val);
        hashmap_put((map_t)item, first, val);
    }
    return 0;
}

void symboltable_copy(map_t map) {
    hashmap_iterate(symtable, symboltable_copy_entry, map); 
}

void symboltable_free() {
    hashmap_free(symtable);
}
