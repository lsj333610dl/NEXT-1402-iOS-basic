//
//  Puzzle.h
//  week3
//
//  Created by 이상진 on 2014. 7. 24..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Puzzle : NSObject{
    NSMutableArray* board;
    NSArray* answer;
}

- (void)makeBoardWithNumber:(NSNumber*)number;
- (void)printBoard;
- (void)randBoard;

- (void)moveLeft;
- (void)moveRight;
- (void)moveUp;
- (void)moveDown;

- (BOOL)isAnswer;
@end
