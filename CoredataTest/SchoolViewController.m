//
//  SchoolViewController.m
//  CoredataTest
//
//  Created by YPMac on 2017/5/23.
//  Copyright © 2017年 YPMac. All rights reserved.
//

#import "SchoolViewController.h"
#import "School+CoreDataProperties.h"
#import "DataBaseHandle.h"
@interface SchoolViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *yp_tableView;
@property (nonatomic, strong) NSMutableArray *datasArray;
@end

@implementation SchoolViewController
- (NSMutableArray *)datasArray{
    if(!_datasArray){
        _datasArray = [NSMutableArray arrayWithArray:[DataBaseHandle getAllSchools]];
    }
    return _datasArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.yp_tableView.delegate = self;
    self.yp_tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell002"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell002"];
    }
    School *s = self.datasArray[indexPath.row];
    cell.textLabel.text = s.school_name;
    cell.detailTextLabel.text = s.school_address;
    return cell;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        School *s = self.datasArray[indexPath.row];
        [self.datasArray removeObject:s];
        [DataBaseHandle deleteOneSchool:s.school_name];
        [self.yp_tableView reloadData];
    }];
    return @[deleteAction];
}
@end
