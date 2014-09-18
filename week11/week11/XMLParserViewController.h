//
//  XMLParserViewController.h
//  week11
//
//  Created by 이상진 on 2014. 9. 18..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMLParserViewController : UIViewController<NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
