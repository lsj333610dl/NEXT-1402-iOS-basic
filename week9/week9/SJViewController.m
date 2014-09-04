//
//  SJViewController.m
//  week9
//
//  Created by 이상진 on 2014. 9. 2..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "SJViewController.h"

@interface SJViewController ()

@end

@implementation SJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%zd",[self countOfSubstring:@" " atContents:@"일 이이 삼삼삼 사사사사 오오오오오"]);
}




-(NSUInteger)countOfSubstring:(NSString*)string atContents:(NSString*)contents{
    
    NSRange range;
    NSUInteger count=0;
    NSString *subString;
    
    range.location=0;
    range.length=[string length];
    
    for (int i=0; i<[contents length]; i+=range.length) {
        subString = [contents substringWithRange:range];
        
        if ([subString isEqualToString:string]) {
            count++;
        }
        range.location += range.length;
        
    }
    
    
    return count;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
