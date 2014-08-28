//
//  barGraphViewController.m
//  week8
//
//  Created by 이상진 on 2014. 8. 28..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "SJBarGraphViewController.h"
#import "SJBarGraphView.h"


@interface SJBarGraphViewController ()

@end

@implementation SJBarGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //JSON초기화.
    NSString *JSONString = @"[{\"title\":\"April\", \"value\":5},{\"title\":\"May\", \"value\":12},{\"title\":\"June\", \"value\":18},{\"title\":\"July\", \"value\":11},{\"title\":\"August\", \"value\":15},{\"title\":\"September\", \"value\":9},{\"title\":\"October\", \"value\":17},{\"title\":\"November\", \"value\":25},{\"title\":\"December\", \"value\":31}]";
    
    NSData *jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:nil];
    
    
    //barGraph초기화.
    SJBarGraphView *barGraphView = [SJBarGraphView new];
    [barGraphView initWithArray:jsonObject];
    [barGraphView setBackgroundColor:[UIColor whiteColor]];
    [barGraphView setFrame:CGRectMake(0, 0, 320, 568-50)];
    
    [self.view addSubview:barGraphView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
