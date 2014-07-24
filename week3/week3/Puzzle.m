//
//  Puzzle.m
//  week3
//
//  Created by 이상진 on 2014. 7. 24..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "Puzzle.h"

@implementation Puzzle

- (void)makeBoardWithNumber:(NSNumber*)number{
    
    board = [NSMutableArray new];
    
    int count=0;
    
    for (int i=0; i<[number intValue]; i++) {
        
        
        NSMutableArray *row = [NSMutableArray new];
        
        for (int j=0; j<[number intValue]; j++) {
            
            NSNumber *n = [NSNumber numberWithInt:count+1];
            [row addObject:n];
            count++;
        }
        
        [board addObject:row];
        
    }

    [[board lastObject] removeLastObject];
    [[board lastObject] addObject:[NSNumber numberWithInt:0]];
    
    
    
}

- (void)printBoard{
    NSLog(@"%@",board);
}

- (void)randBoard{
    
    NSMutableArray *allObj = [NSMutableArray new];
    
    for (int i=0; i<[board count]; i++) {
        for (int j=0; j<[board count]; j++) {
           [allObj addObject:[[board objectAtIndex:i] objectAtIndex:j]];
        }
    }

    
    int count = (int)[allObj count];
    for (int i = 0; i < count; ++i) {
        
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        [allObj exchangeObjectAtIndex:i withObjectAtIndex:n];
    
    }
    
    [self makeBoardWithArray:allObj];
}

- (void)makeBoardWithArray:(NSArray*)array{
    
    board = [NSMutableArray new];
    
    int index=0;
    
    for (int i=0; i<sqrt([array count]); i++) {
        
        
        NSMutableArray *row = [NSMutableArray new];
        
        for (int j=0; j<sqrt([array count]); j++) {
        
            [row addObject:[array objectAtIndex:index]];
            index++;
        
        }
        
        [board addObject:row];
        
    }
    
}

@end
