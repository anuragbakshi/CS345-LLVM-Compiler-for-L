#include "symboltable.h"

symboltable *symboltable_new() {
    symboltable *st = (symboltable *) malloc(sizeof(symboltable));

    st->next = NULL;
    st->env = hashmap_new();

    return st;
}

void push(symboltable *st) {
}

void pop(symboltable *st) {
}

void add(symboltable *st, char *id, llvm::Value *e) {
}

llvm::Value *find(symboltable *st, char *id) {
}
