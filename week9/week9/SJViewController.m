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

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bookfile" ofType:@"txt"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    //
    //    NSLog(@"%zd",[self countOfSubstring:@"자본주의" atContents:fileContents]);


    NSURL *url = [NSURL URLWithString:@"http://125.209.194.123/wordlist.php"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{

        [self counting:array fileContents:fileContents];
    });

//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];


//    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();


//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
//        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
//        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_async(globalQueue, ^{
//
//            [self counting:array fileContents:fileContents];
//        });
//
//    }];
}

- (void)counting:(NSArray *)array fileContents:(NSString *)fileContents{

    NSMutableDictionary *resultDict = [NSMutableDictionary new];




    for (NSString *string in array) {
        resultDict[string] = @([self countOfSubstring:string atContents:fileContents]);
    }

    NSArray *orderedKeys = [resultDict keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2];
    }];

    NSString *title = [NSString stringWithFormat:@"가장 많은거 : %@\n 가장 적은거 : %@",orderedKeys[orderedKeys.count-1],orderedKeys[0] ];

    NSString *message = [NSString stringWithFormat:@"전체 단어수 : %zd",[[fileContents componentsSeparatedByString:@" "] count]];


    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSLog(@"%@",message);
        UIAlertView *alertView =  [[UIAlertView alloc]initWithTitle:title
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil];
        [alertView show];
    });
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

        if ([subString isEqualToString:string]) {
            range.location += range.length;
            count++;
        }
        else
            range.location += 1;
    }


    return count;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
