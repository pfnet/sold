#include <stdio.h>
#include <cudnn.h>

int main(void)
{
    size_t version = cudnnGetVersion();

    printf("cuDNN version: %zu\n", version);
    printf("cuDNN version (major.minor.patch): %zu.%zu.%zu\n",
           version / 10000,
           (version % 10000) / 100,
           version % 100);

    return 0;
}
