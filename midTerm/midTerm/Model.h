//
//  Model.h
//  midTerm
//
//  Created by 이상진 on 2014. 8. 12..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (retain) NSArray *dataArray;
@property (retain) NSMutableArray *sortedArray;

-(void)initWithJSON:(NSArray*)JSON;
-(void)sortByDate;

@end
