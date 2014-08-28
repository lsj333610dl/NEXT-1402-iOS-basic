//
//  ViewController.h
//  week8
//
//  Created by 이상진 on 2014. 8. 26..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJBarGraphView.h"
#import "SJPieGraphView.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet SJBarGraphView *barView;
@property (strong, nonatomic) IBOutlet SJPieGraphView *pieView;

@end

