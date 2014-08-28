//
//  ViewController.m
//  week8
//
//  Created by 이상진 on 2014. 8. 26..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView setContentSize:CGSizeMake(_pieView.frame.size.width+_barView.frame.size.width, _pieView.frame.size.height)];
    
    
    //JSON초기화.
    NSString *barJSONString = @"[{\"title\":\"April\", \"value\":5},{\"title\":\"May\", \"value\":12},{\"title\":\"June\", \"value\":18},{\"title\":\"July\", \"value\":11},{\"title\":\"August\", \"value\":15},{\"title\":\"September\", \"value\":9},{\"title\":\"October\", \"value\":17},{\"title\":\"November\", \"value\":25},{\"title\":\"December\", \"value\":31}]";
    
    NSData *barJsonData = [barJSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    id barJsonObject = [NSJSONSerialization JSONObjectWithData:barJsonData options: NSJSONReadingMutableContainers error:nil];
    
    
    //barGraph초기화.
    [_barView initWithArray:barJsonObject];
    
    
    
    
    //JSON초기화.
    NSString *piJSONString = @"[{\"title\":\"April\", \"percentage\":18},{\"title\":\"May\", \"percentage\":12},{\"title\":\"June\", \"percentage\":18},{\"title\":\"July\", \"percentage\":13},{\"title\":\"August\", \"percentage\":18}, {\"title\":\"September\", \"percentage\":9},{\"title\":\"October\", \"percentage\":18}]";

    NSData *piJsonData = [piJSONString dataUsingEncoding:NSUTF8StringEncoding];

    id pieJsonObject = [NSJSONSerialization JSONObjectWithData:piJsonData options: NSJSONReadingMutableContainers error:nil];

    [_pieView initWithArray:pieJsonObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
