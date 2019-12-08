#include <stdlib.h>
#include <stdio.h>

// gcd returns the greatest common denominator
// of two integers
int
gcd(int a, int b)
{
    if (b == 0)
        return a;
    else
        return gcd(b, a % b);
}

// rotation of array values
// using the juggling algorithm
void
left_rotate(int arr[], int arr_size, int rot_size)
{
    int j, k, temp;
    int g_c_d = gcd(rot_size, arr_size);
    for (int i = 0; i < g_c_d; i++)
    {
        temp = arr[i]; // store the front temporarily
        j = i;
        while (1)
        {
            k = j + rot_size;
            if (k >= arr_size)
                k -= arr_size;
            if (k == i)
                break;
            arr[j] = arr[k];
            j = k;
        }
        arr[j] = temp;
    }
}
