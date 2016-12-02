#ifndef __LIFOSTACK_H__
#define __LIFOSTACK_H__

typedef void *lifostack_t;

extern lifostack_t lifostack_new();
extern void lifostack_push(lifostack_t in, lifostack_t value);
extern void lifostack_peek(lifostack_t in, lifostack_t *arg);
extern void lifostack_pop(lifostack_t in);
extern void lifostack_free(lifostack_t in);
extern int lifostack_length(lifostack_t in);

#endif
