#ifndef _SYMBOLTABLE_H_
#define _SYMBOLTABLE_H_

// #include "hashmap.h"
#include "lifostack.h"
#include "operations.h"

// typedef any_t symboltable_t;
typedef lifostack_t *symboltable_t;
typedef Object **env_t;

extern symboltable_t symboltable_get();
extern void symboltable_new(uint64_t size);
extern void symboltable_push(uint64_t id, Object *o);
extern void symboltable_pop(uint64_t id);
extern Object *symboltable_find(uint64_t id);
extern void symboltable_free();
extern void symboltable_copy(env_t env);

#endif
