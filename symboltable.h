#include <llvm/IR/IRBuilder.h>

#include "hashmap.h"
#include "lifostack.h"
#include "operations.h"

typedef any_t symboltable_t;

extern symboltable_t symboltable_new();
extern void push(symboltable_t in, char *id, Object *o);
extern void pop(symboltable_t in, char *id);
extern Object *find(symboltable_t in, char *id);
extern symboltable_t freeze(symboltable_t in);
extern void symboltable_free(symboltable_t in);
