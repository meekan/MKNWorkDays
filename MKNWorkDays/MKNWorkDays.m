//
//  MKNWorkDays.m
//  MKNWorkDays
//
//  Created by Eyal Yavor on 21/5/15.
//  Copyright (c) 2015 Meekan. All rights reserved.
//

#import "MKNWorkDays.h"

static NSMutableDictionary* _codeToWorkdays = nil;
static NSIndexSet *_allDays = nil;

@interface MKNWorkDays ()
@property (nonatomic, strong) NSLocale *locale;
@end

@implementation MKNWorkDays

+ (void)initialize {
    if (self == [MKNWorkDays class]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _allDays = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 7)];
            _codeToWorkdays = [@{
              @"BD":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"BE":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"BG":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"BN":@{@"work": @[@2,@3,@4,@5,@7], @"weekend": @[@6,@1]},
              @"JP":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"BI":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"BJ":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"JO":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"BR":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"RU":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"RW":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"RO":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"GQ":@{@"work": @[@2,@3,@4,@5,@6,@7], @"weekend": @[@1]},
              @"BH":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"GB":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"GA":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"GM":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"GH":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"OM":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"HR":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"HU":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"HK":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"PS":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"PT":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"LV":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"PK":@{@"work": @[@2,@3,@4,@5,@6,@7], @"weekend": @[@1]},
              @"PH":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"PL":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"ZM":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"EE":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"EG":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"ZA":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"ET":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"ES":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"MG":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"MA":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"ML":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"MN":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"US":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"MT":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"MW":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"MV":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"MR":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"UG":@{@"work": @[@2,@3,@4,@5,@6,@7], @"weekend": @[@1]},
              @"MY":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"MX":@{@"work": @[@2,@3,@4,@5,@6,@7], @"weekend": @[@1]},
              @"IL":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"FR":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"FI":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"NL":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"NG":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"NZ":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"NP":@{@"work": @[@1,@2,@3,@4,@5,@6], @"weekend": @[@7]},
              @"CI":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"CO":@{@"work": @[@2,@3,@4,@5,@6,@7], @"weekend": @[@1]},
              @"CN":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"CM":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"CL":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"CA":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"CG":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"CD":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"CZ":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"SY":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"KE":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"SK":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"KR":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"KP":@{@"work": @[@2,@3,@4,@5,@6,@7], @"weekend": @[@1]},
              @"KW":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"SN":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"SC":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"KZ":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"SA":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"SG":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"SE":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"SD":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"DJ":@{@"work": @[@7,@1,@2,@3,@4,@5], @"weekend": @[@6]},
              @"DK":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"DE":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"YE":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"DZ":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"LB":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"LA":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"TW":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"TR":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"TN":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"TH":@{@"work": @[@2,@3,@4,@5,@6,@7], @"weekend": @[@1]},
              @"TG":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"LY":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"AE":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"AF":@{@"work": @[@7,@1,@2,@3,@4], @"weekend": @[@5,@6]},
              @"IQ":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"IR":@{@"work": @[@7,@1,@2,@3,@4,@5], @"weekend": @[@6]},
              @"AM":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"IT":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"AO":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"AR":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"AU":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"AT":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"IN":@{@"work": @[@2,@3,@4,@5,@6,@7], @"weekend": @[@1]},
              @"TZ":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"IE":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"ID":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              @"QA":@{@"work": @[@1,@2,@3,@4,@5], @"weekend": @[@6,@7]},
              @"MZ":@{@"work": @[@2,@3,@4,@5,@6], @"weekend": @[@7,@1]},
              } mutableCopy];
        });
    }
}

+(id)workDays {
    return [[MKNWorkDays alloc] init];
}

+(id)workDaysWithLocale:(NSLocale *)locale {
    return [[MKNWorkDays alloc] initWithLocale:locale];
}

-(instancetype)init {
    return [self initWithLocale:[NSLocale autoupdatingCurrentLocale]];
}

-(instancetype)initWithLocale:(NSLocale *)locale {
    if (self = [super init]) {
        self.locale = locale;
    }
    return self;
}

-(NSString *)countryCode {
    return [self.locale objectForKey:NSLocaleCountryCode];
}

-(NSNumber *)firstWorkDay {
    NSNumber *dayNumber = [[self storedOrDefaultWorkDaysDictionary][@"work"] firstObject];
    return dayNumber;}

/*
 The first weekend day is the first day that doesn't appear in the workdays, but is after a work day.
 (So in the US, Sunday is not the first day of weekend)
 If working days are 2-6, than 7,1 are weekend.
 When working days are
 */
-(NSNumber *)firstWeekendDay {
    NSNumber *dayNumber = [[self storedOrDefaultWorkDaysDictionary][@"weekend"] firstObject];
    return dayNumber;
}

-(NSIndexSet *)workDays {
    NSArray *workDays = [self storedOrDefaultWorkDaysDictionary][@"work"];
    return [_allDays indexesPassingTest:^BOOL(NSUInteger idx, BOOL *stop) {
        return [workDays containsObject:@(idx)];
    }];
}

-(NSIndexSet *)weekendDays {
    NSArray *weekend = [self storedOrDefaultWorkDaysDictionary][@"weekend"];
    return [_allDays indexesPassingTest:^BOOL(NSUInteger idx, BOOL *stop) {
        return [weekend containsObject:@(idx)];
    }];
}

- (NSDictionary *)storedOrDefaultWorkDaysDictionary {
    if (![_codeToWorkdays objectForKey:self.countryCode]) {
        NSCalendar *cal = [NSCalendar autoupdatingCurrentCalendar];
        cal.locale = self.locale;
        // Best we can do
        NSUInteger firstWeekday = cal.firstWeekday - 1; // Offset to zero
        NSMutableArray *workdays = [NSMutableArray array];
        NSMutableArray *weekends = [NSMutableArray array];
        [workdays addObject:@(((firstWeekday + 0) % 7)+1)];
        [workdays addObject:@(((firstWeekday + 1) % 7)+1)];
        [workdays addObject:@(((firstWeekday + 2) % 7)+1)];
        [workdays addObject:@(((firstWeekday + 3) % 7)+1)];
        [workdays addObject:@(((firstWeekday + 4) % 7)+1)];
        [weekends addObject:@(((firstWeekday + 5) % 7)+1)];
        [weekends addObject:@(((firstWeekday + 6) % 7)+1)];
        _codeToWorkdays[self.countryCode] = @{@"work":workdays,@"weekend":weekends };
    }
    return [_codeToWorkdays objectForKey:self.countryCode];
}

@end
