//
//  DetailViewController.h
//  midTerm
//
//  Created by 이상진 on 2014. 8. 12..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic) NSUInteger rowIndex;
@property (weak, nonatomic) Model *model;

@end
