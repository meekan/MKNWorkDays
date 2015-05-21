//
//  XCTestWorkDays.m
//  MKNWorkDays
//
//  Created by Eyal Yavor on 21/5/15.
//  Copyright (c) 2015 Meekan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MKNWorkDays.h"

@interface XCTestWorkDays : XCTestCase

@end

@implementation XCTestWorkDays

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCanInitialize {
    MKNWorkDays *workdays = [[MKNWorkDays alloc]init];
    XCTAssertNotNil(workdays);
}

@end
