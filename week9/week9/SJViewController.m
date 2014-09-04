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
    
   
}

- (IBAction)start:(id)sender {
    NSLog(@"시작");
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"bookfile" ofType:@"txt"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    //
    //    NSLog(@"%zd",[self countOfSubstring:@"자본주의" atContents:fileContents]);
    
    
    NSURL *url = [NSURL URLWithString:@"http://125.209.194.123/wordlist.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
//        dispatch_async(globalQueue, ^{
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableDictionary *resultDict = [NSMutableDictionary new];
            
            for (NSString *string in array) {
                [resultDict setObject:@([self countOfSubstring:string atContents:fileContents]) forKey:string];
            }
            
            NSArray *orderedKeys = [resultDict keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2){
                return [obj1 compare:obj2];
            }];
            
            NSString *title = [NSString stringWithFormat:@"가장 많은거 : %@\n 가장 적은거 : %@",orderedKeys[orderedKeys.count-1],orderedKeys[0] ];
            
            NSString *message = [NSString stringWithFormat:@"전체 단어수 : "];
            
            
            dispatch_async(mainQueue, ^{
                NSLog(@"%@",message);
                UIAlertView *alertView =  [[UIAlertView alloc]initWithTitle:title
                                                                    message:message
                                                                   delegate:nil
                                                          cancelButtonTitle:@"확인"
                                                          otherButtonTitles:nil];
                [alertView show];
            });
//        });
    }];
}



-(NSUInteger)countOfSubstring:(NSString*)string atContents:(NSString*)contents{
    
    NSRange range;
    
    NSUInteger count=0;
    
    NSString *subString = nil;
    
    range.location=0;
    range.length=[string length];
    
    for (int i=0; i<contents.length; i++) {
        
        if (contents.length<(range.location+range.length)) {
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
