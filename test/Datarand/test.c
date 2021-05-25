#include <stdio.h>
#include <string.h>
#define SENSITIVE __attribute__((annotate("sensitive")))

int main(void) {
    SENSITIVE int arr1[100]; 
    SENSITIVE int arr2[100]; 
    for (int i = 0; i < 100; i++) {
        arr1[i] = i;
    }
    for (int i = 0; i < 100; i++) {
        arr2[i] = i*2;
    }
    for (int i = 0; i < 100; i++) {
        printf("%d ", arr1[i]);
    }
    printf("\n");
    for (int i = 0; i < 100; i++) {
        printf("%d ", arr2[i]);
    }
    return 0;
}
