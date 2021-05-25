#!/usr/bin/env bash                                                                         
objfile="$1"                                                                                
exefile="$2"                                                                                
opts="$3"                                                                                   
                                                                                            
set -x 
echo $objfile

$LLVMROOT/clang -O0 \
    -L "${glibc_install}/lib" \
    -I "${glibc_install}/include" \
    -Wl,--rpath="${glibc_install}/lib" \
    -Wl,--dynamic-linker="${glibc_install}/lib/ld-linux-x86-64.so.2" \
    -std=c11 \
    -o $exefile \
    -v \
    aes.o aes_h.o $objfile \
    -pthread $opts \
    ;                                                                                       

