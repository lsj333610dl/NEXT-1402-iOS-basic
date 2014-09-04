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
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"bookfile" ofType:@"txt"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    
    NSLog(@"%zd",[self countOfSubstring:@"자본주의" atContents:fileContents]);
}




-(NSUInteger)countOfSubstring:(NSString*)string atContents:(NSString*)contents{
    
    NSRange range;
    
    NSUInteger count=0;
    
    NSString *subString = nil;
    
    range.location=0;
    range.length=[string length];
    
    for (int i=0; i<contents.length; i++) {
        
        if (contents.length<(range.location+range.length)) {
            NSLog(@"%zd,%zd",contents.length,range.location+range.length);
            continue;
        }
        
        subString = [contents substringWithRange:range];
        
//        NSLog(@"%@",subString);
        
        if ([subString isEqualToString:string]) {
            count++;
        }
        
        range.location += 1;
    }
    
    
    return count;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
