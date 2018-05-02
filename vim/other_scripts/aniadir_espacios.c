#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    int num_espacios = 4;
    int ch;

    if (argc == 2)
    {
        num_espacios = atoi(argv[1]);
    }

    int anterior_fue_espacio = 1;
    while ((ch = getchar()) != EOF)
    {
        if (anterior_fue_espacio && ch != '\n')
        {
            printf("%*s", num_espacios, "");
            anterior_fue_espacio = 0;
        }

        putchar(ch);

        if (ch == '\n')
        {
            anterior_fue_espacio = 1;
        }

    }

    return EXIT_SUCCESS;
}
