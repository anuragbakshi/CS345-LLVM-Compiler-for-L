#include <stdio.h>
#include <stdlib.h>

#include "symboltable.h"

// typedef struct symboltable_entry {
//     char *name;
//     lifostack_t values;
// } symboltable_entry;

uint64_t symtable_size;
symboltable_t symtable;

symboltable_t symboltable_get() {
    return symtable;
}

void symboltable_new(uint64_t size) {
    // symtable = hashmap_new();

    symtable_size = size;

    symtable = calloc(symtable_size, sizeof(lifostack_t));
    for(uint64_t i = 0; i < symtable_size; ++i) {
        symtable[i] = lifostack_new();
    }
}

void symboltable_push(uint64_t id, Object *o) {
    // symboltable_entry *entry;
    //
    // if (hashmap_get(symtable, id, (any_t *) &entry) == MAP_MISSING) {
    //     entry = (symboltable_entry *) calloc(1, sizeof(symboltable_entry));
    //     entry->values = lifostack_new();
    //     entry->name = (char *) calloc(strlen(id) + 1, sizeof(char));
    //     strcpy(entry->name, id);
    //     hashmap_put(symtable, id, entry);
    // }
    //
    // lifostack_push(entry->values, o);

    lifostack_push(symtable[id], o);
}

void symboltable_pop(uint64_t id) {
    // symboltable_entry *entry;
    // hashmap_get(symtable, id, (any_t *) &entry);
    // lifostack_pop(entry->values);

    lifostack_pop(symtable[id]);
}

Object *symboltable_find(uint64_t id, char *name) {
    // symboltable_entry *entry;
    // Object *var_val;
    // int result = hashmap_get(symtable, id, (any_t *) &entry);
    //
    // if (result == MAP_MISSING
    //         || lifostack_length(entry->values) == 0) {
    //     printf("Identifier %s is not bound in current context\n", id);
    //     exit(1);
    // }
    //
    // lifostack_peek(entry->values, (any_t *) &var_val);
    //
    // return var_val;

    if(lifostack_length(symtable[id]) == 0) {
        // printf("Identifier %s is not bound in current context\n", id);
        // TODO: keep names in big array in compiled program
        // printf("Identifier %d is not bound in current context\n", id);
        printf("Identifier %s is not bound in current context\n", name);
        exit(1);
    }

    Object *var_val;
    lifostack_peek(symtable[id], (any_t *) &var_val);

    return var_val;
}

// int symboltable_copy_entry(any_t item, any_t first, any_t second) {
//     Object* val;
//     symboltable_entry *entry = (symboltable_entry*)second;
//     if(lifostack_length(entry->values) != 0) {
//         lifostack_peek(entry->values, (any_t *) &val);
//         hashmap_put((map_t)item, first, val);
//     }
//     return 0;
// }

// void symboltable_copy(map_t map) {
//     hashmap_iterate(symtable, symboltable_copy_entry, map);
// }

void symboltable_copy(env_t env) {
    for(uint64_t i = 0; i < symtable_size; ++i) {
        if(lifostack_length(symtable[i]) != 0) {
            Object *entry;
            lifostack_peek(symtable[i], (any_t *)&entry);
            push_to_env(env, i, entry); 
        }
    }
}

void symboltable_free() {
    // hashmap_free(symtable);
    for(uint64_t i = 0; i < symtable_size; ++i) {
        free(symtable[i]);
    }

    free(symtable);
}
