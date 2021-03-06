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
    
    answer = [board copy];
    
    
}

- (void)printBoard{
    NSMutableString *boardString = [[NSMutableString alloc]initWithString:@"\n\n"];
    int count = (int)[board count];
    for (int i=0; i<count; i++) {
        for (int j=0; j<count; j++) {
            [boardString appendString:[NSString stringWithFormat:@"%4d",[(NSNumber*)board[i][j] intValue]]];
        }
        [boardString appendString:@"\n\n"];
    }
    NSLog(@"%@",boardString);
    
    [boardString release];
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
    
    [self printBoard];
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
    
    int count = (int)[board count];
    
    NSArray *allArray = [self getAllobj];
    NSMutableArray *result = [NSMutableArray arrayWithArray:allArray];

    int index = (int)[result indexOfObject:[NSNumber numberWithInteger:0]];

    int row = index/count;
    int col = index%count;
    
    if (!col) {
        [self makeBoardWithArray:result];
        return;
    }
    
    NSNumber *temp = board[row][col-1];
    
    [result replaceObjectAtIndex:index-1 withObject:board[row][col]];
    [result replaceObjectAtIndex:index withObject:temp];
    [self makeBoardWithArray:result];
}

- (void)moveRight{
    int count = (int)[board count];
    
    NSArray *allArray = [self getAllobj];
    NSMutableArray *result = [NSMutableArray arrayWithArray:allArray];
    
    int index = (int)[result indexOfObject:[NSNumber numberWithInteger:0]];
    
    int row = index/count;
    int col = index%count;
    
    if (col>=count-1) {
        [self makeBoardWithArray:result];
        return;
    }
    
    NSNumber *temp = board[row][col+1];
    
    [result replaceObjectAtIndex:index+1 withObject:board[row][col]];
    [result replaceObjectAtIndex:index withObject:temp];
    
    [self makeBoardWithArray:result];
}

- (void)moveUp{
    
    int count = (int)[board count];
    
    NSArray *allArray = [self getAllobj];
    NSMutableArray *result = [NSMutableArray arrayWithArray:allArray];
    
    int index = (int)[result indexOfObject:[NSNumber numberWithInteger:0]];
    
    int row = index/count;
    int col = index%count;
    
    if (!row) {
        [self makeBoardWithArray:result];
        return;
    }
    
    NSNumber *temp = board[row-1][col];
    
    [result replaceObjectAtIndex:index-count withObject:board[row][col]];
    [result replaceObjectAtIndex:index withObject:temp];
    [self makeBoardWithArray:result];
    
}

- (void)moveDown{
    int count = (int)[board count];
    
    NSArray *allArray = [self getAllobj];
    NSMutableArray *result = [NSMutableArray arrayWithArray:allArray];
    
    int index = (int)[result indexOfObject:[NSNumber numberWithInteger:0]];
    
    int row = index/count;
    int col = index%count;
    
    if (row>=count-1) {
        [self makeBoardWithArray:result];
        return;
    }
    
    NSNumber *temp = board[row+1][col];
    
    [result replaceObjectAtIndex:index+count withObject:board[row][col]];
    [result replaceObjectAtIndex:index withObject:temp];
    [self makeBoardWithArray:result];
}

- (BOOL)isAnswer{
    return [board isEqualToArray:answer];
}

@end
