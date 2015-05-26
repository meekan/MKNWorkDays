//
//  MKNWorkDays.h
//  MKNWorkDays
//
//  Created by Eyal Yavor on 21/5/15.
//  Copyright (c) 2015 Meekan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKNWorkDays : NSObject
+(instancetype)workDays;
+(instancetype)workDaysWithLocale:(NSLocale *)locale;
-(instancetype)init;
-(instancetype)initWithLocale:(NSLocale *)locale NS_DESIGNATED_INITIALIZER;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *countryCode;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *firstWorkDay;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSNumber *firstWeekendDay;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSIndexSet *workDays;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSIndexSet *weekendDays;
@end
