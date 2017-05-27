//
//  DataBaseHandle.h
//  CoredataTest
//
//  Created by YPMac on 2017/5/23.
//  Copyright © 2017年 YPMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DataBaseHandle : NSObject

+ (NSArray *)getAllPersons;
+ (NSArray *)getAllSchools;
+ (void)deleteOnePerson:(NSString *)name;
+ (void)deleteOneSchool:(NSString *)name;

+ (void)addPerson:(NSString *)name address:(NSString *)address number:(int)number school:(School *)school;
+ (void)modifyPerson:(NSString *)name newDatas:(NSArray *)newDatas;
+ (void)modifySchool:(NSString *)name newDatas:(NSArray *)newDatas;
@end
