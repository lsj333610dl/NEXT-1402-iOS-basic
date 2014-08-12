//
//  ViewController.h
//  midTerm
//
//  Created by 이상진 on 2014. 8. 12..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "DetailViewController.h"


@interface ViewController : UIViewController<UITableViewDataSource,UITabBarDelegate>{
    Model *model;
    NSMutableArray *dataArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end

