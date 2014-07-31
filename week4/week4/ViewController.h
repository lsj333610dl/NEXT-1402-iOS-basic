//
//  ViewController.h
//  week4
//
//  Created by 이상진 on 2014. 7. 31..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJModel.h"

@interface ViewController : UIViewController{
    SJModel *model;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgViewRPS;

@end

