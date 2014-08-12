//
//  ViewController.m
//  midTerm
//
//  Created by 이상진 on 2014. 8. 12..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];

    model = [Model new];

    [self initModel];
    
    dataArray = [[NSMutableArray alloc]initWithArray:[model dataArray]];
    
    [_tableView setDelegate:(id)self];
    [_tableView setDataSource:self];
    
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(reloadTableView) name:@"initModel" object:nil];
    [notiCenter addObserver:self selector:@selector(sortData:) name:@"sortByDate" object:nil];
                                    
    
}


- (void)initModel{
    
    char *data = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\
    {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\
        {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\
            {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\
                {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\
                    {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\
                        {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\
                            {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\
                                {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"},\
                                    {\"title\":\"나비\",\"image\":\"10.jpg\",\"date\":\"20140103\"}]";
                                    
                                    NSString *JSONString = [NSString stringWithCString:data encoding:NSUTF8StringEncoding];
                                    
                                    
                                    
                                    NSArray *JSON = [NSJSONSerialization JSONObjectWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
                                    
                                    [model initWithJSON:JSON];
}

- (void)sortData:(NSNotification*)noti{
    dataArray = [model sortedArray];
    [_tableView reloadData];
}

- (void)reloadTableView{
    dataArray = [[NSMutableArray alloc]initWithArray:[model dataArray]];
    [_tableView reloadData];
}

- (IBAction)sort:(id)sender {
    [model sortByDate];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"date"];
    
    return cell;
}
                                
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UIStoryboard *MainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    DetailViewController *detailVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"detailViewController"];

    [detailVC setRowIndex:indexPath.row];
    [detailVC setModel:model];
    
    [[self navigationController] pushViewController:detailVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
                        

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

                                

#pragma mark - shake
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        
        [self initModel];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
