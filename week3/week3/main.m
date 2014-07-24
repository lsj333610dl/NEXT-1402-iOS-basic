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
        
        [puzzle makeBoardWithNumber:[NSNumber numberWithInteger:5]];
        [puzzle randBoard];
        
        char input[2];
        char *exit = "x";
        
        char *up = "w";
        char *down = "s";
        char *left = "a";
        char *right = "d";
        
        do {
            NSLog(@"\n----------------------------------------\n w: 위로 a: 좌로, s: 아래로, d: 우로, x: 종료 \n----------------------------------------");
            printf("키를 입력하세요 : ");
            scanf("%s",input);
            
            if (input[0] == *up){
                [puzzle moveUp];
            }
            else if (input[0] == *down)
                [puzzle moveDown];
            else if (input[0] == *left)
                [puzzle moveLeft];
            else if (input[0] == *right)
                [puzzle moveRight];
            else
                NSLog(@"\n없는 커맨드입니다. 다시 입력하세요.");
            
            if ([puzzle isAnswer]) {
                NSLog(@"\n정답입니다!");
                [puzzle release];
                return 0;
            }
            
        } while (input[0] != *exit);
        
        
        [puzzle release];
    }
    return 0;
}

