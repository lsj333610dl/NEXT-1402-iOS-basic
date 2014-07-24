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
        
        [row release];
    }

    [[board lastObject] removeLastObject];
    [[board lastObject] addObject:[NSNumber numberWithInt:0]];
    
    
    
}

- (void)printBoard{
    NSMutableString *boardString = [[NSMutableString alloc]initWithString:@"\n"];
    int count = (int)[board count];
    for (int i=0; i<count; i++) {
        for (int j=0; j<count; j++) {
            [boardString appendString:[(NSNumber*)board[i][j] stringValue] ];
        }
        [boardString appendString:@"\n"];
    }
    NSLog(@"%@",boardString);
}

- (void)randBoard{
    
    NSMutableArray *allObj = [NSMutableArray arrayWithArray:[self getAllobj]];
    
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
        [row release];
    }
    
}

- (NSArray*)getAllobj{
    NSMutableArray *result = [[NSMutableArray new] autorelease];
    
    for (int i=0; i<[board count]; i++) {
        for (int j=0; j<[board count]; j++) {
            [result addObject:[[board objectAtIndex:i] objectAtIndex:j]];
        }
    }
    
    return result;
}


#pragma mark - 이동
- (void)moveLeft{
    
//    NSLog(@"%@",board[1][1]);
    
    int count = (int)[board count];
    
    NSArray *allArray = [self getAllobj];
    NSMutableArray *result = [NSMutableArray arrayWithArray:allArray];

    int index = (int)[result indexOfObject:[NSNumber numberWithInteger:0]];

    int row = index/count;
    NSLog(@"%d",row);
    [result exchangeObjectAtIndex:index withObjectAtIndex:index-1];

    NSLog(@"%@",result);

    [self makeBoardWithArray:result];
    
}

- (void)moveRight{
    
}

- (void)moveTop{
    
}

- (void)moveBottom{
    
}

@end
