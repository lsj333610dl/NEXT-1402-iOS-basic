
//
//  SJPieGraphView.m
//  week8
//
//  Created by 이상진 on 2014. 8. 28..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "SJPieGraphView.h"

#define radian(degree) degree*M_PI/180
#define DEGREE_BY_PERCENTAGE 360.0f*([[datas[i-1] objectForKey:@"percentage"] floatValue]/100.0f)
#define DEGREE_BY_PERCENTAGE2 360.0f*([[datas[i] objectForKey:@"percentage"] floatValue]/100.0f)


NSArray *datas;
NSMutableArray *degrees;
double total;

@implementation SJPieGraphView


- (void)initWithArray:(NSArray*)array{
    datas = array;
    degrees = [[NSMutableArray alloc]initWithCapacity:[datas count]];
    
    for (NSDictionary *data in datas) {
        total += [[data objectForKey:@"percentage"] floatValue];
    }
    
    [self getDegrees];
}

- (void)getDegrees{
    for (NSDictionary *data in datas) {
        NSNumber *degree = [NSNumber numberWithFloat:
                            360.0f*([[data objectForKey:@"percentage"] floatValue]/total)];
        [degrees addObject:degree];
    }
}

- (void)drawRect:(CGRect)rect{

    double lastDegree = 0;
    
    
    for (int i=0; i<[degrees count]; i++) {

        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
        
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, center.x, center.y);
        
        CGContextSaveGState(context);
        
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor);
        
        
        if (i==0) {
            lastDegree = [[degrees lastObject]floatValue];
            
            CGContextAddArc(context, center.x, center.y, center.x, radian(lastDegree), radian(([degrees[i] floatValue]+lastDegree)), NO);
        }
        else if (i==[degrees count]-1) {
            CGContextAddArc(context, center.x, center.y, center.x, radian(0), radian(([[degrees lastObject]floatValue])), NO);
        }
        else {
            
            lastDegree += [degrees[i-1] floatValue];
            
            CGContextAddArc(context, center.x, center.y, center.x, radian(lastDegree), radian(([degrees[i] floatValue]+lastDegree)), NO);
        }
        
        
        
        
        CGContextDrawPath(context, kCGPathFill);
    }
    
}

@end
