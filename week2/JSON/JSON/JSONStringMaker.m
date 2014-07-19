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
    
    NSMutableString *resultJSON = [NSMutableString new];
    
    NSArray *allkeys = [sourceDict allKeys];
    
    [resultJSON setString:@"{"];
    
    for (NSString* key in allkeys) {
        [resultJSON appendString:[NSString stringWithFormat:@"%@:%@,",key,[sourceDict valueForKey:key]]];
    }
    [resultJSON deleteCharactersInRange:NSMakeRange([resultJSON length]-1, 1)];
    [resultJSON appendString:@"}"];
    
    return resultJSON;
}

+ (NSString*)JSONMakerWithArray:(NSArray*)array{
    
    return @"";
}

@end
