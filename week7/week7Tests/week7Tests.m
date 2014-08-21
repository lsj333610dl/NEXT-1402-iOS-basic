//
//  week7Tests.m
//  week7Tests
//
//  Created by 이상진 on 2014. 8. 21..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface week7Tests : XCTestCase

@end

@implementation week7Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
