//
//  DetailViewController.h
//  week7
//
//  Created by 이상진 on 2014. 8. 21..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<NSStreamDelegate>{
    long length;
    NSMutableData *_data;
    NSInteger len;
}

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

