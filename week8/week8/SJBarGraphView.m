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
    
    [self setClipsToBounds:YES];
    maxValue *= 1.1;
    
//    [self setBackgroundColor:[UIColor whiteColor]];
    
}


- (void)drawRect:(CGRect)rect {
    
    //가이드라인
    for (int i=0; i<maxValue/10+1; i++) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        
        CGPoint startPoint = CGPointMake((60+(float)(rect.size.width-60)*(10.0*i/maxValue)), 0);
        [path moveToPoint:startPoint];
        
        CGPoint nextPoint = CGPointMake((60+(float)(rect.size.width-60)*(10.0*i/maxValue)), rect.size.height-20);
        [path addLineToPoint:nextPoint];
        [path setLineWidth:1.0];
        
        CGContextSetRGBStrokeColor(context,200/255.0,200/255.0,200/255.0,1.0);
        [path stroke];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((30+(float)(rect.size.width-60)*(10.0*i/maxValue)),
                                                                 rect.size.height-20, 60, 20)];
        [label setText:[NSString stringWithFormat:@"%d",10*i]];
        [label setFont:[UIFont systemFontOfSize:10]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
    }
    
    
    //그래프
    for (int i=0 ; i<[datas count] ; i++) {
        
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50*i, 55, 40)];
        [label setFont:[UIFont systemFontOfSize:10]];
        [label setTextAlignment:NSTextAlignmentRight];
        [label setText:[datas[i] objectForKey:@"title"]];
        [self addSubview:label];
        
        CGPoint startPoint = CGPointMake(60, 50*i+20);
        [path moveToPoint:startPoint];
        
        CGPoint nextPoint = CGPointMake(60+(rect.size.width-60)*([[datas[i] objectForKey:@"value"]floatValue]/maxValue), 50*i+20);
        [path addLineToPoint:nextPoint];
        [path setLineWidth:20.0];
        
        CGContextSetRGBStrokeColor(context,231/255.0,76/255.0,60/255.0,1.0);
        CGContextSetShadow(context, CGSizeMake(2, 2), 4.0f);
        [path stroke];
        
    }
    

}


@end
