
//
//  SJPieGraphView.m
//  week8
//
//  Created by 이상진 on 2014. 8. 28..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "SJPieGraphView.h"

#define radian(degree) degree*M_PI/180


@implementation SJPieGraphView

- (void)awakeFromNib{
    datas = nil;
    degrees = nil;
    total = 0;
}

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
    
    //그래프
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
    

    //라벨
    for (int i=0; i<[degrees count]; i++) {
        
        CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
        
        
        
        UILabel *label = [UILabel new];
        [label setTextAlignment:NSTextAlignmentCenter];
        
        [label setText:[datas[i] objectForKey:@"title"]];
        [label setFrame:CGRectMake(0, 0, center.x, 40)];
        [label setCenter:center];
        [label setTextColor:[UIColor whiteColor]];
        [label.layer setAnchorPoint:CGPointMake(0, 0.5)];
        
        [self addSubview:label];
        
        if (i==0) {
            lastDegree = [[degrees lastObject]floatValue];
            label.transform = CGAffineTransformMakeRotation(  ( radian(lastDegree)+radian(([degrees[i] floatValue]+lastDegree)) )/2  );
            
        }
        else if (i==[degrees count]-1) {
            
            label.transform = CGAffineTransformMakeRotation(  ( radian(0)+radian(([[degrees lastObject]floatValue])) )/2  );
        }
        else {
            
            lastDegree += [degrees[i-1] floatValue];
            
            label.transform = CGAffineTransformMakeRotation(  ( radian(lastDegree)+radian(([degrees[i] floatValue]+lastDegree)) )/2  );
            
        }
        
    }
    
    
    
    
}

@end
