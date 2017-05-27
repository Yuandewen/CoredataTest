//
//  AppDelegate.h
//  CoredataTest
//
//  Created by YPMac on 2017/5/22.
//  Copyright © 2017年 YPMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Person+CoreDataProperties.h"
#import "School+CoreDataProperties.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
////////////数据库操作//////////////////
- (void)insertPerson:(NSString *)name address:(NSString *)address number:(int)number school:(School *)school;
- (NSArray<School *> *)getAllSchools;
- (NSArray<Person *> *)getAllPersons;
- (void)deleteOnePerson:(NSString *)name;
- (void)deleteOneSchool:(NSString *)name;
- (void)modifyOnePerson:(NSString *)name newDatas:(NSArray *)newDatas;
- (void)modifyOneSchool:(NSString *)name newDatas:(NSArray *)newDatas;
@end

