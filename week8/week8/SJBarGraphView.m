//
//  SJBarGraphView.m
//  week8
//
//  Created by 이상진 on 2014. 8. 28..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "SJBarGraphView.h"

NSUInteger maxValue;
NSArray *datas;

@implementation SJBarGraphView

- (void)initWithArray:(NSArray*)array{
    datas = array;
    
    //최대값
    maxValue = 0;
    
    for (NSDictionary *dict in array) {
        if (maxValue < [[dict objectForKey:@"value"] integerValue]) {
            maxValue = [[dict objectForKey:@"value"] integerValue];
        }
    }
    
//    maxValue *= 1.1;
    
//    [self setBackgroundColor:[UIColor whiteColor]];
    
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int i=0 ; i<[datas count] ; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50*i+20, 90, 50)];
        [label setTextAlignment:NSTextAlignmentRight];
        [label setText:[datas[i] objectForKey:@"title"]];
        [self addSubview:label];
        
        CGPoint startPoint = CGPointMake(100, 50*i+50);
        [path moveToPoint:startPoint];
        
        CGPoint nextPoint = CGPointMake(100+220*([[datas[i] objectForKey:@"value"]floatValue]/maxValue), 50*i+50);
        [path addLineToPoint:nextPoint];
        [path setLineWidth:30.0];
        
    }
    
    CGContextSetRGBStrokeColor(context,231/255.0,76/255.0,60/255.0,1.0);
    [path stroke];

}


@end
