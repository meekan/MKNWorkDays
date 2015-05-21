//
//  MKNWorkDays.h
//  MKNWorkDays
//
//  Created by Eyal Yavor on 21/5/15.
//  Copyright (c) 2015 Meekan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKNWorkDays : NSObject
-(instancetype)init;
-(instancetype)initWithLocale:(NSLocale *)locale;
-(NSUInteger)firstWorkDay;
-(NSUInteger)firstWeekendDay;
-(NSIndexSet *)workDays;
-(NSIndexSet *)weekendDays;
@end
