#include "lifostack.h"

#include <stdio.h>
#include <stdlib.h>

typedef struct lifostack_node {
    any_t data;
    struct lifostack_node *next;
} lifostack_node;

typedef struct lifostack {
    int size;
    lifostack_node *items;
} lifostack;

lifostack_t lifostack_new() {
    lifostack *s = (lifostack *) calloc(1, sizeof(lifostack));
    s->size = 0;
    s->items = NULL;

    return s;
}

void lifostack_push(lifostack_t in, any_t value) {
    lifostack *s = (lifostack *) in;

    lifostack_node *node = (lifostack_node *) calloc(1, sizeof(lifostack_node));
    node->data = value;
    node->next = s->items;

    ++s->size;
    s->items = node;
}

// TODO: assumes stack is not empty
void lifostack_peek(lifostack_t in, any_t *arg) {
    lifostack *s = (lifostack *) in;

    *arg = s->items->data;
}

// TODO: assumes stack is not empty
void lifostack_pop(lifostack_t in) {
    lifostack *s = (lifostack *) in;

    lifostack_node *old_node = s->items;

    --s->size;
    s->items = s->items->next;

    free(old_node);
}

void lifostack_free(lifostack_t in) {
    lifostack *s = (lifostack *) in;

    // TODO: make more efficient
    while(lifostack_length(in) > 0) {
        lifostack_pop(in);
    }

    free(s);
}

int lifostack_length(lifostack_t in) {
    lifostack *s = (lifostack *) in;

    return s->size;
}
