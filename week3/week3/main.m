//
//  main.m
//  week3
//
//  Created by 이상진 on 2014. 7. 24..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Puzzle.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Puzzle *puzzle = [Puzzle new];
        [puzzle makeBoardWithNumber:[NSNumber numberWithInteger:3]];
        [puzzle randBoard];
        [puzzle printBoard];
        
        char input;
        scanf("%c", &input);
        
        
        [puzzle moveLeft];
        
        
        [puzzle release];
    }
    return 0;
}

