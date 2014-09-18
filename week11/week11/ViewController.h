//
//  ViewController.h
//  week11
//
//  Created by 이상진 on 2014. 9. 18..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property NSString *dbPath;
@property sqlite3 *db;

@end

