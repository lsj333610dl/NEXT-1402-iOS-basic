//
//  SJPieGraphViewController.m
//  week8
//
//  Created by 이상진 on 2014. 8. 28..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "SJPieGraphViewController.h"
#import "SJPieGraphView.h"

@interface SJPieGraphViewController ()

@end

@implementation SJPieGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //JSON초기화.
    NSString *JSONString = @"[{\"title\":\"April\", \"percentage\":18},{\"title\":\"May\", \"percentage\":12},{\"title\":\"June\", \"percentage\":18},{\"title\":\"July\", \"percentage\":13},{\"title\":\"August\", \"percentage\":18}, {\"title\":\"September\", \"percentage\":9},{\"title\":\"October\", \"percentage\":18}]";
    
    NSData *jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:nil];
    
    
    //barGraph초기화.
    SJPieGraphView *pieGraphView = [SJPieGraphView new];
    [pieGraphView initWithArray:jsonObject];
    [pieGraphView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:pieGraphView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
