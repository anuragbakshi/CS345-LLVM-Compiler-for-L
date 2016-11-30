#ifndef _SYMBOLTABLE_H_
#define _SYMBOLTABLE_H_

#include "hashmap.h"
#include "lifostack.h"
#include "operations.h"

typedef any_t symboltable_t;

extern symboltable_t symboltable_get();
extern void symboltable_new();
extern void symboltable_push(char *id, Object *o);
extern void symboltable_pop(char *id);
extern Object *symboltable_find(char *id);
extern void symboltable_free();
extern void symboltable_copy(map_t map);

#endif
