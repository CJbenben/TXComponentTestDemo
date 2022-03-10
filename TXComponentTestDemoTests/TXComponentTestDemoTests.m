//
//  TXComponentTestDemoTests.m
//  DemoTests
//
//  Created by ChenJie on 2017/11/2.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TXImageUtils.h"

@interface TXComponentTestDemoTests : XCTestCase

@end

@implementation TXComponentTestDemoTests

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
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"123456" ofType:@"pdf"];
    [[TXImageUtils alloc] getAndSaveUIImageFromPdfFilePath:path completion:^(BOOL isSuccess) {
            
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
