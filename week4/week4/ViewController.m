//
//  ViewController.m
//  week4
//
//  Created by 이상진 on 2014. 7. 31..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "ViewController.h"
#import "SJModel.h"

@interface ViewController ()
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(printRPS:) name:@"randRps" object:nil];
    
    [SJModel randomize];
    
}

- (void)printRPS:(NSNotification*)noti{
    NSDictionary *notiDic = [noti userInfo];
    NSString *rps = [notiDic objectForKey:@"randRps"];
    
    NSString *imgName = [NSString stringWithFormat:@"game_big_%@.png",rps];
    [_imgViewRPS setImage:[UIImage imageNamed:imgName]];
    
}

- (IBAction)getRPS:(id)sender {

    [SJModel randomize];
    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        
        [SJModel randomize];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
