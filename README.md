# Sensitive Data Encryption
================================

1. We need [binutils](https://www.gnu.org/software/binutils/) in order to do LTO for Whole Program Analysis. The instructions to set it up correctly is [here](https://llvm.org/docs/GoldPlugin.html).

2. We also need the custom Glibc from [here](https://github.com/taptipalit/glibc-without-avx-support).

3. Then compile LLVM

   1. `cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=<Debug/Release> -DLLVM_TARGETS_TO_BUILD="X86" -DCMAKE_INSTALL_PREFIX=<YOUR_CUSTOM_INSTALL_DIR> -DLLVM_BINUTILS_INCDIR=<BINUTILS_DIR>/include ../`
       
       Choose Debug/Release build and set up the directories correctly. 

   2. `make -jN` (N = number of cores) 

4. The sample script to run a simple test program is at `data-only-attack-mitigation/test/Datarand/run.sh`. In that script, update the environment variables according to your system. These are `$LLVMSRC`, `$LLVMROOT`, and `$glibc_install`.

5. The input to the script is the name of the combined bitcode for the application (without the .bc). So to run the `test.c` program is 

   `./run.sh test`
   
   
## Other applications

The steps for running this for multi-file applications, is application-specific. These are the general steps that must be done.

1. For more complex applications, we need to use LTO so that the bitcodes of the different files are linked together and our analyses and transformations can apply on the unified bitcode. The simplest way to do that is to set up the _Makefiles_ with the clang toolchain. Depending on the application, the Makefile would have variables like `CC`, `CPP`, `AR`, `RANLIB` etc. Change these to point to the corresponding tools `clang`, `clang++`, `llvm-ar`, `llvm-ranlib` from your installation. 

2. Update `CFLAGS` and `LDFLAGS` to include `-flto -O0`. Our analysis needs the unoptimized IR. You can always optimize it _after_ running our analysis and transformation.

3. Run `make` the usual way. You should get a bitcode that contains the code from the whole program. 

4. Use the `run.sh` script to harden the bitcode.

   `./run.sh <APP>`

