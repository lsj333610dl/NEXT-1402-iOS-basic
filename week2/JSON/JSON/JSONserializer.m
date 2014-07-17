//
//  JSONserializer.m
//  JSON
//
//  Created by 이상진 on 2014. 7. 17..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "JSONserializer.h"


@implementation JSONserializer

+ (NSDictionary*)JSONstringToDict:(NSString*)string{
    NSMutableDictionary *resultDict = [NSMutableDictionary new];
    
    NSString *prefix = @"{"; // string prefix, not needle prefix!
    NSString *suffix = @"}"; // string suffix, not needle suffix!
    
    
    NSRange needleRange = NSMakeRange(prefix.length,
                                      string.length - prefix.length - suffix.length);
    NSString *needle = [string substringWithRange:needleRange];
    
    NSArray *objects = [needle componentsSeparatedByString:@","];
    
    
    for (NSString *object in objects) {
        NSArray *obj = [object componentsSeparatedByString:@" : "];
        [resultDict setValue:obj[1] forKey:obj[0]];
    }
    
    return resultDict;
}


+ (NSArray*)JSONArraystringToArray:(NSString*)string{
    
    NSMutableArray *resultArray = [NSMutableArray new];
    
    NSString *prefix = @"[{"; // string prefix, not needle prefix!
    NSString *suffix = @"}]"; // string suffix, not needle suffix!
    
    
    NSRange needleRange = NSMakeRange(prefix.length,
                                      string.length - prefix.length - suffix.length);
    NSString *needle = [string substringWithRange:needleRange];
    
    NSArray* split = [needle componentsSeparatedByString:@"},{"];
    
    for (NSString* obj in split) {
        [resultArray addObject:[self JSONstringToDict:obj]];
    }
    
    return resultArray;
}

@end
