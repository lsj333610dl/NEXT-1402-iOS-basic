//
//  barGraphViewController.h
//  week8
//
//  Created by 이상진 on 2014. 8. 28..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJBarGraphView.h"

@interface SJBarGraphViewController : UIViewController

@property (strong, nonatomic) IBOutlet SJBarGraphView *barGraphView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
