#include <stdio.h>

static int debug_cnt = 0;

void debug_print() {
    printf("Debug %d\n", debug_cnt++);
}
