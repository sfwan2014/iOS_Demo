//
//  main.c
//  NumTest
//
//  Created by sfwan on 14-8-19.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#include <stdio.h>

int main(int argc, const char * argv[])
{

    // insert code here...
    printf("Hello, World!\n");
    
    int p[] = {1,-1,-2,1,1,-1,-2,-1,-1,-1,-2,1,1,-1,2,1, -1,-2};
    
    static int negCount = 0;
    int neg = 0;
    int count = sizeof(p)/sizeof(int);
    for (int i = 0; i < count; i++) {
        int z = p[i];
        if (z < 0) {
            neg = 1;
        } else {
            if (neg) {
                negCount++;
                neg = 0;
            }
        }
        if (i == count - 1 && z < 0) {
            negCount ++;
        }
    }
    
    printf("%d\n", negCount);
    
    return 0;
}

