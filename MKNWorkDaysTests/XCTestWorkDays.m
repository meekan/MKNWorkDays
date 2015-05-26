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

NSUInteger SUNDAY = 1;
NSUInteger MONDAY = 2;
NSUInteger TUESDAY = 3;
NSUInteger WEDNESDAY = 4;
NSUInteger THURSDAY = 5;
NSUInteger FRIDAY = 6;
NSUInteger SATURDAY = 7;

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

- (void)testCanInitializeWithLocale {
    NSString *testCountryCode = @"he_IL";
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:testCountryCode];
    MKNWorkDays *workdays = [[MKNWorkDays alloc]initWithLocale:locale];
    XCTAssertEqualObjects([workdays countryCode], @"IL");
}

- (void)testIsraeliWorkweekShouldStartOnSunday {
    NSString *testCountryCode = @"he_IL";
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:testCountryCode];
    MKNWorkDays *workdays = [[MKNWorkDays alloc]initWithLocale:locale];
    NSNumber *firstWorkDay = [workdays firstWorkDay];
    XCTAssertEqual([firstWorkDay unsignedIntegerValue], SUNDAY);
}

- (void)testAmericanWorkweekShouldStartOnSunday {
    NSString *testCountryCode = @"en_US";
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:testCountryCode];
    MKNWorkDays *workdays = [[MKNWorkDays alloc]initWithLocale:locale];
    NSNumber *firstWorkDay = [workdays firstWorkDay];
    XCTAssertEqual([firstWorkDay unsignedIntegerValue], MONDAY);
}

- (void)testIsraeliWorkweekShouldBeSundayToThursday {
    NSString *testCountryCode = @"he_IL";
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:testCountryCode];
    MKNWorkDays *israel = [[MKNWorkDays alloc]initWithLocale:locale];
    NSIndexSet *workdays = [israel workDays];
    XCTAssertEqualObjects(workdays, [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(SUNDAY, 5)]);
}

- (void)testAmericanWorkweekShouldBeMondayToFriday {
    NSString *testCountryCode = @"en_US";
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:testCountryCode];
    MKNWorkDays *us = [[MKNWorkDays alloc]initWithLocale:locale];
    NSIndexSet *workdays = [us workDays];
    XCTAssertEqualObjects(workdays, [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(MONDAY, 5)]);
}

- (void)testIsraeliWeekendShouldStartOnFriday {
    NSString *testCountryCode = @"he_IL";
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:testCountryCode];
    MKNWorkDays *israel = [[MKNWorkDays alloc]initWithLocale:locale];

    XCTAssertEqual([[israel firstWeekendDay] unsignedIntegerValue], FRIDAY);
}

- (void)testAmericanWeekendShouldBeStartOnSaturday {
    NSString *testCountryCode = @"en_US";
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:testCountryCode];
    MKNWorkDays *us = [[MKNWorkDays alloc]initWithLocale:locale];
    XCTAssertEqual([[us firstWeekendDay] unsignedIntegerValue], SATURDAY);
}


- (void)testIsraeliWeekendShouldBeFridaySaturday {
    NSString *testCountryCode = @"he_IL";
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:testCountryCode];
    MKNWorkDays *israel = [[MKNWorkDays alloc]initWithLocale:locale];
    NSIndexSet *weekend = [israel weekendDays];
    NSMutableIndexSet *expectedWeekend = [NSMutableIndexSet indexSetWithIndex:FRIDAY];
    [expectedWeekend addIndex:SATURDAY];
    XCTAssertEqualObjects(weekend, expectedWeekend);
}

- (void)testAmericanWeekendShouldBeSaturdaySunday {
    NSString *testCountryCode = @"en_US";
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:testCountryCode];
    MKNWorkDays *us = [[MKNWorkDays alloc]initWithLocale:locale];
    NSIndexSet *weekend = [us weekendDays];
    NSMutableIndexSet *expectedWeekend = [NSMutableIndexSet indexSetWithIndex:SATURDAY];
    [expectedWeekend addIndex:SUNDAY];
    XCTAssertEqualObjects(weekend, expectedWeekend);
}


- (void)testUnknownLocaleShouldBeBasedOnCalendarFirstDayOfWeek {
    NSString *testCountryCode = @"en_ZZ";
    NSCalendar *current = [NSCalendar currentCalendar];
    NSLocale *unknownLocale = [NSLocale localeWithLocaleIdentifier:testCountryCode];
    current.locale = unknownLocale;
    NSUInteger firstDayOfWeekInCalendar = current.firstWeekday;
    MKNWorkDays *unknown = [[MKNWorkDays alloc]initWithLocale:unknownLocale];
    NSIndexSet *workdays = [unknown workDays];
    NSIndexSet *weekend = [unknown weekendDays];
    NSIndexSet *expecteWorkdays = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(firstDayOfWeekInCalendar, 5)];
    NSIndexSet *expectedWeekend = [[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1,7)] indexesPassingTest:^BOOL(NSUInteger idx, BOOL *stop) {
        return ![expecteWorkdays containsIndex:idx];
    }];
    XCTAssertEqual([[unknown firstWorkDay] unsignedIntegerValue], firstDayOfWeekInCalendar);
    XCTAssertEqualObjects(workdays, expecteWorkdays);
    XCTAssertEqualObjects(weekend, expectedWeekend);
}


@end
