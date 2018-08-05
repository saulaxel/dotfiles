#include <stdio.h>

int main(int n, char *vec_args[n])
{
    for (int i = 0; i < n; ++i) {
        printf("%d. %s\n", i + 1, vec_args[i]);
    }
}
