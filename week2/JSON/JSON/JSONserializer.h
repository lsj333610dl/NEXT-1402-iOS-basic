//
//  JSONserializer.h
//  JSON
//
//  Created by 이상진 on 2014. 7. 17..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONserializer : NSObject
+ (NSDictionary*)JSONDictStringToDict:(NSString*)string;
+ (NSArray*)JSONArraystringToArray:(NSString*)string;
+ (NSArray*)JSONDictInArrayStringToDict:(NSString*)string;

+ (id)MyJSONSerializationFrom:(NSString*)jsonData;

@end
