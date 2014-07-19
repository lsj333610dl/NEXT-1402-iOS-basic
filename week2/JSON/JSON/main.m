//
//  main.m
//  JSON
//
//  Created by 이상진 on 2014. 7. 17..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONserializer.h"
#import "JSONStringMaker.h"

#define TEST1 @"{\"id\":007,\"name\":\"james\"}"
#define TEST2 @"[{ \"id\":001,\"name\":\"john\" },{ \"id\":007,\"name\":\"james\" }]"
#define TEST3 @"{\"id\":007,\"name\":\"james\",\"weapons\":[gun,pen]}"



NSString* subStringFromString(NSString* string, NSString* prefix, NSString* suffix){
    
    NSRange needleRange = NSMakeRange(prefix.length,
                                      string.length - prefix.length - suffix.length);
    
    NSString *resultString = [string substringWithRange:needleRange];
    
    return resultString;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSLog(@"1. 간단 Dict : %@",[JSONserializer MyJSONSerializationFrom:TEST1]);
        NSLog(@"2. Array : %@",[JSONserializer MyJSONSerializationFrom:TEST2]);
        NSLog(@"3. Dict in Array : %@",[JSONserializer MyJSONSerializationFrom:TEST3]);
        
        
        
        NSDictionary *sourceDict = [JSONserializer MyJSONSerializationFrom:TEST1];
        NSLog(@"%@",[JSONStringMaker JSONMakerWithDict:sourceDict]);
        
        NSArray *sourceArray = [JSONserializer MyJSONSerializationFrom:TEST2];
        NSLog(@"%@",[JSONStringMaker JSONMakerWithArray:sourceArray]);
        
        
        
    }
    
    return 0;
}




