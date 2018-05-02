#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

static int num_esp = 0;

int siguiente(void)
{
    char c = getchar();

    if (c == EOF) { exit(num_esp); }

    return c;
}

int main(void)
{
    int c;

    while ((isspace)(c = siguiente( )))
        { num_esp++; }
    putchar(c);

    while ((c = siguiente()) != '\n')
        { putchar(c); }
    putchar(c);

    int n = 1;
    while (1)
    {
        c = siguiente();

        if (n > num_esp || c == '\n') {
            putchar(c);
        }

        if (c == '\n') {
            n = 0;
        }
        n++;
    }
}
