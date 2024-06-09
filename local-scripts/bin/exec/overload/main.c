#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void fillMemory(int sizeInMB) {
    long long bytesToAllocate = (long long)sizeInMB * 1024 * 1024;
    char *memoryBlock = (char *)malloc(bytesToAllocate);

    if (memoryBlock == NULL) {
        fprintf(stderr, "Failed to allocate memory\n");
        exit(EXIT_FAILURE);
    }

    memset(memoryBlock, 1, bytesToAllocate);  // Filling the allocated memory with data

    printf("Allocated %d MB of memory\n", sizeInMB);

    // Keep the program running and the memory allocated until interrupted
    while (1) {
        // Do nothing and keep the program running
    }
}

// Function to perform a computation to keep the CPU busy
void useCPU(int durationInSeconds) {
    printf("Using CPU for %d seconds...\n", durationInSeconds);

    // Perform computations for the specified duration
    time_t startTime = time(NULL);
    while ((time(NULL) - startTime) < durationInSeconds) {
        for (int i = 0; i < 1000000; ++i) {
            double result = i * i;
            result += i;
        }
    }
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        if (strcmp(argv[1], "cpu") == 0) {
            if (argc == 3) {
                int durationInSeconds = atoi(argv[2]);
                if (durationInSeconds <= 0) {
                    printf("Invalid duration\n");
                    return 1;
                }
                useCPU(durationInSeconds);
            } else {
                printf("Using CPU indefinitely...\n");
                useCPU(0); // 0 indicates using CPU indefinitely
            }
        } else {
            int sizeInMB = atoi(argv[1]);
            fillMemory(sizeInMB);
        }
    } else {
        // If no argument is provided, fill the memory until it's 90% full
        int targetPercentage = 90;
        long long totalMemory = (long long)get_phys_pages() * (long long)getpagesize();
        long long availableMemory = (long long)get_avphys_pages() * (long long)getpagesize();
        int sizeInMB = (int)(((totalMemory - availableMemory) * targetPercentage) / (100 * 1024 * 1024));

        fillMemory(sizeInMB);
    }

    return 0;
}
