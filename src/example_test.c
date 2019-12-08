#include <stdio.h>
#include <stdlib.h>

#include "example.c"

// testing macros
#define FAIL() printf("\nFAILURE in %s %s:%d \n", __FILE__, __func__, __LINE__)
#define _assert(test) do { if (!(test)) { FAIL(); return 1; } } while(0)
#define _verify(test) do { int r=test(); tests_run++; if(r) return r; } while(0)

int static tests_run = 0;

int
test_gcd()
{
    _assert(gcd(1, 0) == 1);
    _assert(gcd(1, 1) == 1);
    _assert(gcd(12, 4) == 4);
    _assert(gcd(121, 11) == 11);

    return EXIT_SUCCESS;
}

int
test_left_rotate()
{
    int a[] = {1, 2, 3, 4};
    int arr_size = 4;
    int expected[] = {3, 4, 1, 2};

    left_rotate(a, arr_size, 2);

    for (int i = 0; i < arr_size; i++)
    {
        _assert(a[i] == expected[i]);
    }

    return EXIT_SUCCESS;
}

int
tests()
{
    _verify(test_gcd);
    _verify(test_left_rotate);

    printf("SUCCESS in %s: ran %d tests\n", __FILE__, tests_run);

    return EXIT_SUCCESS;
}

int
main()
{
    int result = tests();
    if (result)
        return EXIT_FAILURE;

    printf("PASSED\n");

    return EXIT_SUCCESS;
}
