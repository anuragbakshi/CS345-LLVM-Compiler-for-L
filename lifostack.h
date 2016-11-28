#ifndef __LIFOSTACK_H__
#define __LIFOSTACK_H__

#include "hashmap.h"

typedef any_t lifostack_t;

extern lifostack_t lifostack_new();
extern void lifostack_push(lifostack_t in, any_t value);
extern void lifostack_peek(lifostack_t in, any_t *arg);
extern void lifostack_pop(lifostack_t in);
extern void lifostack_free(lifostack_t in);
extern int lifostack_length(lifostack_t in);

#endif
