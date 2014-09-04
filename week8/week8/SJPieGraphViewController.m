//
//  SJPieGraphViewController.m
//  week8
//
//  Created by 이상진 on 2014. 8. 28..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "SJPieGraphViewController.h"
@interface SJPieGraphViewController ()

@end

@implementation SJPieGraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //JSON초기화.
    NSString *JSONString = @"[{\"title\":\"April\", \"percentage\":18},{\"title\":\"May\", \"percentage\":12},{\"title\":\"June\", \"percentage\":28},{\"title\":\"July\", \"percentage\":13},{\"title\":\"August\", \"percentage\":18}, {\"title\":\"September\", \"percentage\":19},{\"title\":\"October\", \"percentage\":38}]";
    
    NSData *jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:nil];
    
    
    //barGraph초기화.
    
    [_pieGraphView initWithArray:jsonObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];\
}
\
@end
