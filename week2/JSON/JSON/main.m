//
//  main.m
//  JSON
//
//  Created by 이상진 on 2014. 7. 17..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONserializer.h"

#define TEST1 @"{ \"id\" : 007, \"name\" : \"james\"}"
#define TEST2 @"[{ \"id\" : 001, \"name\" : \"john\"},{ \"id\" : 007, \"name\" : \"james\"}]"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSLog(@"%@",[JSONserializer JSONstringToDict:TEST1]);
        
        NSLog(@"%@",[JSONserializer JSONArraystringToArray:TEST2]);
        
    }
    return 0;
}

