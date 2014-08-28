
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

    
    
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
//
//    
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, center.x, center.y);
//
//    CGContextSaveGState(context);
//    
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor);
//    
//    CGContextAddArc(context, center.x, center.y, center.x, radian((360*([[datas[3] objectForKey:@"percentage"] floatValue]/100))), radian((360*([[datas[2] objectForKey:@"percentage"] floatValue]/100))), NO);
//    
//    
//    CGContextDrawPath(context, kCGPathFill);
    
    double lastDegree = 0.0;
    
    for (int i=1; i<[degrees count]; i++) {

        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
        
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, center.x, center.y);
        
        CGContextSaveGState(context);
        
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor);
        
        
        lastDegree += [degrees[i-1] floatValue];
        
        CGContextAddArc(context, center.x, center.y, center.x, radian(lastDegree), radian([degrees[i] floatValue]), NO);
        
        CGContextDrawPath(context, kCGPathFill);
    }
    
//    NSLog(@"%lf",total);
//    for (int i=0; i<[datas count]; i++) {
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
//        
//        
//        CGContextBeginPath(context);
//        CGContextMoveToPoint(context, center.x, center.y);
//        
//        CGContextSaveGState(context);
//        
//        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor);
//        
//        CGContextAddArc(context, center.x, center.y, center.x, radian(-[[datas[i] objectForKey:@"percentage"] floatValue]/100*360), radian(-[[datas[i+1] objectForKey:@"percentage"] floatValue]/100*360), YES);
//        
//        CGContextDrawPath(context, kCGPathFill);
//        
//    }
    
    
//    CGContextAddArc(context, center.x, center.y, center.x, 0*M_PI/180, radian(180), YES);
    
//    CGContextAddArc(context, center.x, center.y, 100, 0.0, 45.0, YES);
    
}

@end
