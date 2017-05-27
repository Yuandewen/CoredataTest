//
//  AppDelegate.m
//  CoredataTest
//
//  Created by YPMac on 2017/5/22.
//  Copyright © 2017年 YPMac. All rights reserved.
//

#import "AppDelegate.h"
#import "Person+CoreDataProperties.h"
#import "School+CoreDataProperties.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // [self deleteAllPerson];
    //[self deleteAllSchools];
 /*   NSFetchRequest *request = [Person fetchRequest];
 NSPredicate *predicate = [NSPredicate predicateWithFormat:@"number < 9999 && number > 9997"];
 //   NSPredicate *predicate = [NSPredicate predicateWithFormat:@"school_name BEGINSWITH %@",@"上"];
    [request setPredicate:predicate];
    NSLog(@"s --- %@",[NSDate date]);
  */
   // NSArray *persons = [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
  /*  NSArray *persons = [self searchPersons:@"test"];
    for(Person *p in persons){
        NSLog(@"p.number ----- %@",p.name);
        
    }
    NSLog(@"e --- %@",[NSDate date]);
   */
/*    NSArray *schools = [self getAllSchools];
    for(School *s in schools){
        NSLog(@"s.name - %@   s.address - %@",s.school_name,s.school_address);
    }
 */
 /*  NSArray *persons = [self getAllPersons];
    for(Person *p in persons){
        NSLog(@"name - %@ address - %@ num - %d school - %@",p.name,p.address,p.number,p.relationship.school_name);
    }
 */
  /*  NSLog(@"1---%@",[NSDate date]);
   for(int i=0;i<10000;i++){
       School *school = nil;
         school = [NSEntityDescription insertNewObjectForEntityForName:@"School" inManagedObjectContext:self.persistentContainer.viewContext];
           school.school_name = [NSString stringWithFormat:@"上海%d中",i];
           school.school_address = @"黄浦江边";
       [self insertPerson:[NSString stringWithFormat:@"test%d",i] address:[NSString stringWithFormat:@"上海%d号",i] number:i school:school];
    }
    NSLog(@"2----%@",[NSDate date]);
    NSLog(@"-----%lu",(unsigned long)[self getAllPersons].count);
  
*/
    return YES;
}
- (void)deleteOnePerson:(NSString *)name{
    NSFetchRequest *request = [Person fetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@",name];
    [request setPredicate:predicate];
    NSArray *persons = [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
    if([persons count] > 0){
        for(Person *p in persons){
            [self.persistentContainer.viewContext deleteObject:p];
            NSLog(@"----11");
        }
        if([self.persistentContainer.viewContext hasChanges]){
            [self.persistentContainer.viewContext save:nil];
        }
    }
}
- (void)deleteOneSchool:(NSString *)name{
    NSFetchRequest *request = [School fetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"school_name like %@",name];
    [request setPredicate:predicate];
    NSArray *schools = [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
    if([schools count] > 0){
        for(School *s in schools){
            [self.persistentContainer.viewContext deleteObject:s];
        }
        if([self.persistentContainer.viewContext hasChanges]){
            [self.persistentContainer.viewContext save:nil];
        }
    }
}
// 删除所有数据
- (void)deleteAllPerson{
    NSArray *allPersons = [self getAllPersons];
    for(Person *p in allPersons){
        [self.persistentContainer.viewContext deleteObject:p];
    }
    if([self.persistentContainer.viewContext hasChanges]){
        [self.persistentContainer.viewContext save:nil];
    }
}
- (void)deleteAllSchools{
    NSArray *allSchools = [self getAllSchools];
    for(School *s in allSchools){
        [self.persistentContainer.viewContext deleteObject:s];
    }
    
    if([self.persistentContainer.viewContext hasChanges]){
        [self.persistentContainer.viewContext save:nil];
    }
}
// 根据名字 查询
- (NSArray<Person *>*)searchPersons:(NSString *)name{
    
    NSFetchRequest *request = [Person fetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",name];
    [request setPredicate:predicate];
    
    return [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
}
- (NSArray<School *> *)searchSchools:(NSString *)name{
    NSFetchRequest *request = [School fetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"school_name CONTAINS %@",name];
    [request setPredicate:predicate];
    return [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
}
// 获得所有数据
- (NSArray<Person *> *)getAllPersons{
    NSFetchRequest *request = [Person fetchRequest];
    // 使用xcode的coredata，实体已经连接 可以不写
  //  NSEntityDescription *des = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.persistentContainer.viewContext];
  //  [request setEntity:des];
    
    
    return [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
}
- (NSArray<School *> *)getAllSchools{
    NSFetchRequest *request = [School fetchRequest];
    return [self.persistentContainer.viewContext executeFetchRequest:request error:nil];
}
// 插入一条数据
- (void)insertPerson:(NSString *)name address:(NSString *)address number:(int)number school:(School *)school{
    Person *p = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.persistentContainer.viewContext];
    p.name = name;
    p.address = address;
    p.number = number;
    p.relationship = school;
    NSError *error = nil;

    if([self.persistentContainer.viewContext hasChanges]){
        [self.persistentContainer.viewContext save:&error];
        //NSLog(@"保存成功...");
    }else{
        NSLog(@"error --- %@",error);
        abort();
    }
}
- (void)modifyOnePerson:(NSString *)name newDatas:(NSArray *)newDatas{
    NSFetchRequest *person_request = [Person fetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@",name];
    [person_request setPredicate:predicate];
    NSArray *persons = [self.persistentContainer.viewContext executeFetchRequest:person_request error:nil];
    for(Person *p in persons){
        p.name = newDatas[0];
        p.address = newDatas[1];
        p.number = [newDatas[2] intValue];
        p.relationship.school_name = newDatas[3];
    }
    if([self.persistentContainer.viewContext hasChanges]) [self.persistentContainer.viewContext save:nil];
}
- (void)modifyOneSchool:(NSString *)name newDatas:(NSArray *)newDatas{
    NSFetchRequest *school_request = [School fetchRequest];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"school_name like %@",name];
    [school_request setPredicate:predicate];
    NSArray *schools = [self.persistentContainer.viewContext executeFetchRequest:school_request error:nil];
    for(School *s in schools){
        s.school_name = newDatas[0];
        s.school_address = newDatas[1];
    }
    if([self.persistentContainer.viewContext hasChanges]) [self.persistentContainer.viewContext save:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoredataTest"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
