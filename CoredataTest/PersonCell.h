//
//  PersonCell.h
//  CoredataTest
//
//  Created by YPMac on 2017/5/23.
//  Copyright © 2017年 YPMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person+CoreDataProperties.h"
#import "School+CoreDataProperties.h"

@interface PersonCell : UITableViewCell
@property (nonatomic, strong) Person *perosn;
@end
