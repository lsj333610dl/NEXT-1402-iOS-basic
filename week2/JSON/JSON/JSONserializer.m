//
//  JSONserializer.m
//  JSON
//
//  Created by 이상진 on 2014. 7. 17..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "JSONserializer.h"


@implementation JSONserializer

+ (NSDictionary*)JSONDictStringToDict:(NSString*)string{
    
    NSMutableDictionary *resultDict = [NSMutableDictionary new];
    
    NSString *needle = [self subStringFromString:string prefix:@"{" suffix:@"}"];
    
    NSArray *objects = [needle componentsSeparatedByString:@","];
    
    
    for (NSString *object in objects) {
        NSArray *obj = [object componentsSeparatedByString:@":"];
        [resultDict setValue:obj[1] forKey:obj[0]];
    }
    
    return resultDict;
}


+ (NSArray*)JSONArraystringToArray:(NSString*)string{
    
    NSMutableArray *resultArray = [NSMutableArray new];
    
    NSString *needle = [self subStringFromString:string prefix:@"[{" suffix:@"}]"];
    
    NSArray* split = [needle componentsSeparatedByString:@"},{"];
    
    for (NSString* obj in split) {
        [resultArray addObject:[self JSONDictStringToDict:obj]];
    }
    
    return resultArray;
}


+ (NSDictionary*)JSONDictInArrayStringToDict:(NSString*)string{
    
    NSMutableArray *allObj = [NSMutableArray new];
    
    NSMutableDictionary *resultDict = [NSMutableDictionary new];
    
    NSString *needle = [self subStringFromString:string prefix:@"{" suffix:@"}"];
    
    
    for (NSString* obj in [needle componentsSeparatedByString:@":"]) {
        if ([obj rangeOfString:@"]"].location != NSNotFound) {
            
            NSString *subString = [self subStringFromString:obj prefix:@"[" suffix:@"]"];
            [allObj addObject:[subString componentsSeparatedByString:@","]];
            
        }
        else{
            [allObj addObjectsFromArray:[obj componentsSeparatedByString:@","]];
        }
    }
    for (int i=0; i<allObj.count; i+=2) {
        [resultDict setValue:allObj[i+1] forKey:allObj[i]];
    }
    
    return resultDict;
}



+ (id)MyJSONSerializationFrom:(NSString*)jsonData{
    
    if ([jsonData rangeOfString:@"[{"].location != NSNotFound) {
        return [self JSONArraystringToArray:jsonData];
    }
    else if ([jsonData rangeOfString:@":["].location != NSNotFound){
        return [self JSONDictInArrayStringToDict:jsonData];
    }
    else
        return [self JSONDictStringToDict:jsonData];
    
    return NULL;
}


+ (NSString*) subStringFromString:(NSString*)string prefix:(NSString*)prefix suffix:(NSString*)suffix{
    
    NSRange needleRange = NSMakeRange(prefix.length,
                                      string.length - prefix.length - suffix.length);
    
    NSString *resultString = [string substringWithRange:needleRange];
    
    return resultString;
}

@end
