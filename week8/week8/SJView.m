//
//  SJView.m
//  week8
//
//  Created by 이상진 on 2014. 8. 26..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "SJView.h"

#define RED (id)[UIColor redColor].CGColor
#define ORANGE (id)[UIColor orangeColor].CGColor
#define YELLOW (id)[UIColor yellowColor].CGColor
#define GREEN (id)[UIColor greenColor].CGColor
#define BLUE (id)[UIColor blueColor].CGColor
#define NAVY (id)[UIColor colorWithRed:0x33/255.0 green:0 blue:0x99/255.0 alpha:1.0].CGColor
#define PURPLE (id)[UIColor purpleColor].CGColor

#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)

NSArray *colorArray;

@implementation SJView

- (void)drawRect:(CGRect)rect {
    
    colorArray = [NSArray arrayWithObjects:RED,ORANGE,YELLOW,GREEN,BLUE,NAVY,PURPLE, nil];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient = [self randGradient];
    CGPoint startPoint
    = CGPointMake(CGRectGetMidX(self.bounds), 0.0);
    CGPoint endPoint
    = CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMaxY(self.bounds));
    CGContextDrawLinearGradient(context, gradient,
                                startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    
    
    //////
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int i=0; i<10; i++) {
        startPoint = CGPointMake(arc4random()%320, arc4random()%568);
        [path moveToPoint:startPoint];
        CGPoint nextPoint = CGPointMake(arc4random()%320, arc4random()%568);
        [path addLineToPoint:nextPoint];
        [path setLineWidth:1.0];
        CGContextSetRGBStrokeColor(context,arc4random()%255/255.0,arc4random()%255/255.0,arc4random()%255/255.0,1.0);

        [path stroke];
    }
    
    for (int i=0; i<10; i++) {
        
        CGPoint center;
        center.x = arc4random()%320;
        center.y = arc4random()%568;
        
        CGContextSaveGState(context);
        
        CGContextSetLineWidth(context,1);
        
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1].CGColor);
        
        CGContextAddArc(context, arc4random()%320, arc4random()%568, arc4random()%100, 0.0, M_PI*2, YES);
        CGContextDrawPath(context, kCGPathFill);
        
        
    }
    
}

- (CGGradientRef)gradientFromArray{
    CFArrayRef colors = (CFArrayRef) CFBridgingRetain([NSArray arrayWithObjects:
                                                       colorArray[arc4random()%7],
                                                       colorArray[arc4random()%7],
                                                       colorArray[arc4random()%7],
                                                       nil]);
    
    CGColorSpaceRef colorSpc = CGColorSpaceCreateDeviceRGB();
    
    return CGGradientCreateWithColors(colorSpc, colors, nil);
}


- (CGGradientRef)randGradient{
    CFArrayRef colors = (CFArrayRef) CFBridgingRetain([NSArray arrayWithObjects:
                                                       (id)[UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1].CGColor,
                                                       (id)[UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1].CGColor,
                                                       nil]);
    
    CGColorSpaceRef colorSpc = CGColorSpaceCreateDeviceRGB();
    
    return CGGradientCreateWithColors(colorSpc, colors, nil);
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
}

@end
