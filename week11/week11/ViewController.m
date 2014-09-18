//
//  ViewController.m
//  week11
//
//  Created by 이상진 on 2014. 9. 18..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    NSMutableArray *resultArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *dbFileName = @"top25";
    NSString *dbExt = @"db";
    
    _dbPath = [mainBundle pathForResource:dbFileName ofType:dbExt];
    resultArray = [[NSMutableArray alloc] init];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:_dbPath] == YES) {
        sqlite3_stmt *statement;
        const char *dbPathInChar = [_dbPath UTF8String];
        if (sqlite3_open(dbPathInChar, &_db) == SQLITE_OK) {
            NSMutableArray *colNames = [[NSMutableArray alloc] init];
            const char *queryInChar = [@"SELECT * FROM tbl_songs" UTF8String];
            const char *queryForColumnNames = [@"PRAGMA TABLE_INFO('tbl_songs')" UTF8String];
            if (sqlite3_prepare_v2(_db, queryForColumnNames, -1, &statement, NULL) == SQLITE_OK) {
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    NSString *colName = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 1)];
                    [colNames addObject:colName];
                }
            }
            
            sqlite3_reset(statement);
            if (sqlite3_prepare_v2(_db, queryInChar, -1, &statement, NULL) == SQLITE_OK) {
                
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
                    for (int i = 0; i < colNames.count; i++) {
                        NSString * dataForCol = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, i)];
                        [data setObject:dataForCol forKey:[colNames objectAtIndex:i]];
                    }
                    [resultArray addObject:data];
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(_db);
        }
        
    }
    
    NSLog(@"%@",resultArray);
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [resultArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"category"];
    
    return cell;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSURL *url = [NSURL URLWithString:[[resultArray objectAtIndex:indexPath.row] objectForKey:@"image"]];
    [[UIApplication sharedApplication]openURL:url];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
