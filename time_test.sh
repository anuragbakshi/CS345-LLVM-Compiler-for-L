#!/usr/bin/env bash

make >/dev/null 2>&1 # Generate llang and util object files

printf "%-24s %-10s %-10s %-10s\n" "TEST" "COMPILE" "RUN" "INTERPRET"
for BM in tests/*.L; do
    FN=${BM/tests\//}
    COMPILE=$({ time make -s ${BM/L/elf}; } 2>&1 | grep real | awk '{print $2}')
    RUN=$({ time ${BM/L/elf}; } 2>&1 | grep real | awk '{print $2}')
    INTERPRET=$({ time ./l-interpreter $BM; } 2>&1 | grep real | awk '{print $2}')
    printf "%-24s %-10s %-10s %-10s\n" ${FN/.L/} $COMPILE $RUN $INTERPRET
done
