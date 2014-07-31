//
//  SJModel.m
//  week4
//
//  Created by 이상진 on 2014. 7. 31..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "SJModel.h"


#define 가위 0
#define 바위 1
#define 보 2

@implementation SJModel

@synthesize rps;

-(void)randomize{
    switch (arc4random()%3) {
        case 가위:
            self.rps = @"s";
            break;
            
        case 바위:
            self.rps = @"r";
            break;
            
        case 보:
            self.rps = @"p";
            break;
            
        default:
            break;
    }
}


+(void)randomize{
    
    NSDictionary *notiDict = nil;
    
    switch (arc4random()%3) {
        case 가위:
            notiDict = [[NSDictionary alloc]initWithObjectsAndKeys:@"s",@"randRps", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"randRps" object:nil userInfo:notiDict];
            break;
            
        case 바위:
            notiDict = [[NSDictionary alloc]initWithObjectsAndKeys:@"r",@"randRps", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"randRps" object:nil userInfo:notiDict];
            break;
            
        case 보:
            notiDict = [[NSDictionary alloc]initWithObjectsAndKeys:@"p",@"randRps", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"randRps" object:nil userInfo:notiDict];
            break;
            
        default:
            break;
    }
    
}

@end
