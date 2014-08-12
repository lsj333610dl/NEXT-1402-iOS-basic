//
//  Model.m
//  midTerm
//
//  Created by 이상진 on 2014. 8. 12..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "Model.h"

@implementation Model

@synthesize dataArray;

-(void)initWithJSON:(NSArray*)JSON{
    
    dataArray = JSON;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"initModel" object:nil userInfo:nil];
}

-(void)sortByDate{
    
    _sortedArray = [[NSMutableArray alloc]initWithArray:dataArray];
    
    NSSortDescriptor *dateSort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSMutableArray *sortArr = [NSMutableArray arrayWithObject:dateSort];
    [_sortedArray sortUsingDescriptors:sortArr];

    NSLog(@"%@",_sortedArray);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sortByDate" object:nil userInfo:nil];
    
    
}

@end
