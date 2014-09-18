//
//  XMLParserViewController.m
//  week11
//
//  Created by 이상진 on 2014. 9. 18..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "XMLParserViewController.h"
#import <sqlite3.h>

@interface XMLParserViewController (){
    NSString *tagName,*tagNameInItem,*dbPath;
    NSMutableArray *itemsArray,*resultArray;
    NSMutableDictionary *itemDict;
    sqlite3 *db;
}

@end

@implementation XMLParserViewController

- (void)viewDidLoad {
    
    resultArray = [NSMutableArray new];
    
    [super viewDidLoad];
    
    [self dbPath];
    
    [self loadFromDB];
    
}

-(NSString *)dbPath
{
    if(!dbPath)
    {
        NSFileManager *fileman = [NSFileManager defaultManager];
        NSURL *documentPathURL = [[fileman URLsForDirectory:NSDocumentDirectory
                                                  inDomains:NSUserDomainMask] lastObject];
        
        NSString *databaseFilename = @"newsfeed.db";
        
        dbPath = [[documentPathURL URLByAppendingPathComponent:databaseFilename] path];
        
        if(![fileman fileExistsAtPath:dbPath])
        {
            NSString *dbSource = [[NSBundle mainBundle] pathForResource:@"newsfeed" ofType:@"db"];
            [fileman copyItemAtPath:dbSource toPath:dbPath error:nil];
            if (!resultArray.count) {
                itemsArray = [NSMutableArray new];
                itemDict = [NSMutableDictionary new];
                
                
                NSURL *url = [NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
                NSXMLParser *myParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
                [myParser setDelegate:self];
                [myParser parse];
            }
        }
    }
    return dbPath;
}

-(NSInteger)loadFromDB{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:dbPath] == YES) {
        sqlite3_stmt *statement;
        const char *dbPathInChar = [dbPath UTF8String];
        if (sqlite3_open(dbPathInChar, &db) == SQLITE_OK) {
            NSMutableArray *colNames = [[NSMutableArray alloc] init];
            const char *queryInChar = [@"SELECT * FROM tbl_newsfeed" UTF8String];
            const char *queryForColumnNames = [@"PRAGMA TABLE_INFO('tbl_newsfeed')" UTF8String];
            if (sqlite3_prepare_v2(db, queryForColumnNames, -1, &statement, NULL) == SQLITE_OK) {
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    NSString *colName = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 1)];
                    [colNames addObject:colName];
                }
            }
            
            sqlite3_reset(statement);
            if (sqlite3_prepare_v2(db, queryInChar, -1, &statement, NULL) == SQLITE_OK) {
                
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
            sqlite3_close(db);
        }
        
    }
    
    [_tableView reloadData];
    NSLog(@"%zd",resultArray.count);
    return resultArray.count;
}



#pragma mark - XMLParserDelegate
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    for (NSDictionary *dict in itemsArray) {
        [self insertNewsFeed:dict];
    }
    
    [self loadFromDB];
    NSLog(@"%zd,%@",resultArray.count,resultArray);
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    

    if ([elementName isEqualToString:@"item"]) {
        tagName = elementName;
    }
    else if ([tagName isEqualToString:@"item"]){
        tagNameInItem = elementName;
    }

}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

    if ([tagName isEqualToString:@"item"]) {
        if (tagNameInItem) {
            
            itemDict[tagNameInItem] = string;
        }
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    
    if ([elementName isEqualToString:@"item"]) {
        tagName = nil;
        [itemsArray addObject:[itemDict mutableCopy]];
    }
    else if ([elementName isEqualToString:tagNameInItem]){
        tagNameInItem = nil;
    }
    
}

- (void)insertNewsFeed:(NSDictionary*)dict {
    
    int dbrc;
    dbrc=sqlite3_open([dbPath UTF8String], &db);
    if (dbrc) {
        NSLog(@"couldn't open db");
        return;
    }
    
    NSString *title = [dict objectForKey:@"title"];
    NSString *link = [dict objectForKey:@"link"];
    NSString *description = [dict objectForKey:@"description"];
    NSString *pubDate = [dict objectForKey:@"pubDate"];
    
    sqlite3_stmt *dbps;
    NSString *insertSQLString= [NSString stringWithFormat:@"INSERT INTO \"tbl_newsfeed\" (title, link, description, pubDate) VALUES (\"%@\",\"%@\", \"%@\", \"%@\");",title,link,description,pubDate];
    
    
    dbrc = sqlite3_prepare_v2(db, [insertSQLString UTF8String], -1, &dbps, NULL);
    dbrc = sqlite3_step(dbps);
    
    sqlite3_finalize(dbps);
    sqlite3_close(db);
    
}

#pragma mark - TableViewDelegate&DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [resultArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"XMLCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[resultArray objectAtIndex:indexPath.row] objectForKey:@"pubDate"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSURL *url = [NSURL URLWithString:[[resultArray objectAtIndex:indexPath.row] objectForKey:@"link"]];
    [[UIApplication sharedApplication]openURL:url];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
