//
//  DataBaseHandle.m
//  CoredataTest
//
//  Created by YPMac on 2017/5/23.
//  Copyright © 2017年 YPMac. All rights reserved.
//

#import "DataBaseHandle.h"

@implementation DataBaseHandle
+ (AppDelegate *)delegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
+ (void)addPerson:(NSString *)name address:(NSString *)address number:(int)number school:(School *)school{
    [[DataBaseHandle delegate] insertPerson:name address:address number:number school:school];
}
+ (void)modifyPerson:(NSString *)name newDatas:(NSArray *)newDatas{
    [[self delegate] modifyOnePerson:name newDatas:newDatas];
}
+ (void)modifySchool:(NSString *)name newDatas:(NSArray *)newDatas{
    [[self delegate] modifyOneSchool:name newDatas:newDatas];
}
+ (NSArray *)getAllSchools{
   return [[DataBaseHandle delegate] getAllSchools];
}
+ (NSArray *)getAllPersons{
    return [[DataBaseHandle delegate] getAllPersons];
}
+ (void)deleteOnePerson:(NSString *)name{
    [[DataBaseHandle delegate] deleteOnePerson:name];
}
+ (void)deleteOneSchool:(NSString *)name{
    [[DataBaseHandle delegate] deleteOneSchool:name];
}
@end
