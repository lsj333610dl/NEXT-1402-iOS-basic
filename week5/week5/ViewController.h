//
//  ViewController.h
//  week5
//
//  Created by 이상진 on 2014. 8. 7..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>{
    NSMutableArray *imgArray, *imageViewArray, *filenameArray;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

