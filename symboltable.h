#include <llvm/IR/IRBuilder.h>

#include "hashmap.h"

typedef struct symboltable {
    struct symboltable *next;
    map_t env;
} symboltable;

extern symboltable *symboltable_new();

extern void push(symboltable *st);
extern void pop(symboltable *st);
extern void add(symboltable *st, char *id, llvm::Value *e);
extern llvm::Value *find(symboltable *st, char *id);
