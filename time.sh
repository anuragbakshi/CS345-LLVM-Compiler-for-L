#!/usr/bin/env bash

make >/dev/null 2>&1 # Generate llang and util object files

cd benchmarks
rm * >/dev/null 2>&1
cd ..
mv benchmark.src benchmark.cpp
for LIMIT in 1 10 100 1000 10000; do
    g++ -std=c++1y -DLIMIT=$LIMIT benchmark.cpp -o benchmark
    cd benchmarks
    ../benchmark
    cd ..
done
mv benchmark.cpp benchmark.src
printf "%-24s %-10s %-10s %-10s\n" "TEST" "COMPILE" "RUN" "INTERPRET"
READ='read'
for BM in benchmarks/*.L; do
    FN=${BM/benchmarks\//}
    if [[ $BM =~ $READ ]]; then
        COMPILE=$({ time make -s ${BM/L/elf}; } 2>&1 | grep real | awk '{print $2}')
        RUN=$({ time yes | ${BM/L/elf}; } 2>&1 | grep real | awk '{print $2}')
        INTERPRET=$({ time yes | ./l-interpreter $BM; } 2>&1 | grep real | awk '{print $2}')
    else
        COMPILE=$({ time make -s ${BM/L/elf}; } 2>&1 | grep real | awk '{print $2}')
        RUN=$({ time ${BM/L/elf}; } 2>&1 | grep real | awk '{print $2}')
        INTERPRET=$({ time ./l-interpreter $BM; } 2>&1 | grep real | awk '{print $2}')
    fi
    printf "%-24s %-10s %-10s %-10s\n" ${FN/.L/} $COMPILE $RUN $INTERPRET
done
