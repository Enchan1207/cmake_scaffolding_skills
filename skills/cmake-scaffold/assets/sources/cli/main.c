#include <stdio.h>
#include <stdlib.h>

#include "<project_name>/<project_name>.h"

int main(int argc, char const *argv[]) {
    if (argc < 2) {
        puts("Usage: <project_name>_cli [n]");
        return 1;
    }

    int n = atoi(argv[1]);
    if (n < 0) {
        puts("Error: n must be greater than or equal to 0");
        return 1;
    }

    unsigned int result = factorial((unsigned int)n);
    printf("factorial(%d) = %u\n", n, result);
    return 0;
}
