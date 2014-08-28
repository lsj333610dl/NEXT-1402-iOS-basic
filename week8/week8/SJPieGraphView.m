
//
//  SJPieGraphView.m
//  week8
//
//  Created by 이상진 on 2014. 8. 28..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "SJPieGraphView.h"

#define radian(degree) degree*M_PI/180

NSArray *datas;

@implementation SJPieGraphView


- (void)initWithArray:(NSArray*)array{
    datas = array;
}


- (void)drawRect:(CGRect)rect{

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, center.x, center.y);
    
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor);
    
    CGContextAddArc(context, center.x, center.y, center.x, radian(-(360*([[datas[0] objectForKey:@"percentage"] floatValue]/100))), radian(-(360*([[datas[1] objectForKey:@"percentage"] floatValue]/100))), YES);
    
    CGContextDrawPath(context, kCGPathFill);
    
//    for (int i=1; i<[datas count]-1; i++) {
//
//        NSLog(@"%lf",360*([[datas[i] objectForKey:@"percentage"] floatValue]/100) );
//        
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
//        CGContextAddArc(context, center.x, center.y, center.x, radian(-(360*([[datas[i] objectForKey:@"percentage"] floatValue]/100))), radian(-(360*([[datas[i+1] objectForKey:@"percentage"] floatValue]/100))), YES);
//        
//        CGContextDrawPath(context, kCGPathFill);
//    }
    

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
