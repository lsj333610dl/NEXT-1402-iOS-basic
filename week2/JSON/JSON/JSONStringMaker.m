//
//  JSONStringMaker.m
//  JSON
//
//  Created by 이상진 on 2014. 7. 17..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "JSONStringMaker.h"

@implementation JSONStringMaker

+ (NSString*)JSONMakerWithDict:(NSDictionary*)sourceDict{
    
    NSMutableString *resultJSONString = [NSMutableString new];
    
    NSArray *allkeys = [sourceDict allKeys];
    
    [resultJSONString setString:@"{"];
    
    for (NSString* key in allkeys) {
        [resultJSONString appendString:[NSString stringWithFormat:@"%@:%@,",key,[sourceDict valueForKey:key]]];
    }
    [resultJSONString deleteCharactersInRange:NSMakeRange([resultJSONString length]-1, 1)];
    [resultJSONString appendString:@"}"];
    
    return resultJSONString;
}

+ (NSString*)JSONMakerWithArray:(NSArray*)sourceArray{
    
    NSMutableString *resultJSONString = [NSMutableString new];
    
    [resultJSONString setString:@"["];
    
    for (NSDictionary *dict in sourceArray) {
        [resultJSONString appendString:[self JSONMakerWithDict:dict]];
        [resultJSONString appendString:@","];
    }
    
    [resultJSONString deleteCharactersInRange:NSMakeRange([resultJSONString length]-1, 1)];
    [resultJSONString appendString:@"]"];
    
    return resultJSONString;
}

@end
