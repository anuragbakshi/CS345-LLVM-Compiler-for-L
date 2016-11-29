#include "hashmap.h"
#include "lifostack.h"
#include "operations.h"

typedef any_t symboltable_t;

extern symboltable_t symboltable_new();
extern void symboltable_push(symboltable_t in, char *id, Object *o);
extern void symboltable_pop(symboltable_t in, char *id);
extern Object *symboltable_find(symboltable_t in, char *id);
extern symboltable_t symboltable_freeze(symboltable_t in);
extern void symboltable_free(symboltable_t in);
