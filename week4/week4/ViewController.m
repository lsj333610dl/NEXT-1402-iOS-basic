//
//  ViewController.m
//  week4
//
//  Created by 이상진 on 2014. 7. 31..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(printRPS:) name:@"randRps" object:nil];
    
    
    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    model = delegate.model;
    
    [model addObserver:self forKeyPath:@"rps" options:(NSKeyValueObservingOptionNew |
                                                       NSKeyValueObservingOptionOld) context:nil];
    
    
//    [model randomize];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"rps"]) {
        NSLog(@"%@", [change objectForKey:NSKeyValueChangeNewKey] );
        
        NSString *imgName = [NSString stringWithFormat:@"game_big_%@.png",[change objectForKey:NSKeyValueChangeNewKey]];
        [_imgViewRPS setImage:[UIImage imageNamed:imgName]];
        
    }
    
}

- (void)printRPS:(NSNotification*)noti{
    NSDictionary *notiDic = [noti userInfo];
    NSString *rps = [notiDic objectForKey:@"randRps"];
    
    NSString *imgName = [NSString stringWithFormat:@"game_big_%@.png",rps];
    [_imgViewRPS setImage:[UIImage imageNamed:imgName]];
}

- (IBAction)getRPS:(id)sender {

//    [SJModel randomize];
    [model randomize];
    
    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        
//        [SJModel randomize];
        [model randomize];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
