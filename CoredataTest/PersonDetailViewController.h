//
//  PersonDetailViewController.h
//  CoredataTest
//
//  Created by YPMac on 2017/5/24.
//  Copyright © 2017年 YPMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person+CoreDataProperties.h"
#import "School+CoreDataProperties.h"



@interface PersonDetailViewController : UIViewController
@property (nonatomic, strong) Person *person;
@end
