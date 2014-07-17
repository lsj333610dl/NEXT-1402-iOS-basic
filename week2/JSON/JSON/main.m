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


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        
        
        NSLog(@"%@",[JSONserializer JSONstringToDict:TEST1]);
        
    }
    return 0;
}

