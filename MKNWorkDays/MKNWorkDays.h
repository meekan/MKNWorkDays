//
//  MKNWorkDays.h
//  MKNWorkDays
//
//  Created by Eyal Yavor on 21/5/15.
//  Copyright (c) 2015 Meekan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKNWorkDays : NSObject
+(id)workDays;
+(id)workDaysWithLocale:(NSLocale *)locale;
-(instancetype)init;
-(instancetype)initWithLocale:(NSLocale *)locale;
-(NSString *)countryCode;
-(NSNumber *)firstWorkDay;
-(NSNumber *)firstWeekendDay;
-(NSIndexSet *)workDays;
-(NSIndexSet *)weekendDays;
@end
