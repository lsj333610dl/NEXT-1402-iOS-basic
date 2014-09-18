//
//  XMLParserViewController.m
//  week11
//
//  Created by 이상진 on 2014. 9. 18..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "XMLParserViewController.h"

@interface XMLParserViewController (){
    NSString *tagName,*tagNameInItem;
    NSMutableArray *itemsArray;
    NSMutableDictionary *itemDict;
}

@end

@implementation XMLParserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    itemsArray = [NSMutableArray new];
    itemDict = [NSMutableDictionary new];
    
    NSURL *url = [NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    NSXMLParser *myParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [myParser setDelegate:self];
    [myParser parse];
}





#pragma mark - XMLParserDelegate
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"%zd",itemsArray.count);
    [_tableView reloadData];
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


#pragma mark - TableViewDelegate&DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [itemsArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"XMLCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [[itemsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[itemsArray objectAtIndex:indexPath.row] objectForKey:@"pubDate"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSURL *url = [NSURL URLWithString:[[itemsArray objectAtIndex:indexPath.row] objectForKey:@"link"]];
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
