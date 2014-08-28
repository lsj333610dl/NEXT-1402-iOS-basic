//
//  SJPieGraphView.h
//  week8
//
//  Created by 이상진 on 2014. 8. 28..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJPieGraphView : UIView{
    
    NSArray *datas;
    NSMutableArray *degrees;
    double total;
}

- (void)initWithArray:(NSArray*)array;

@end
