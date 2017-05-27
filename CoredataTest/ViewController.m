//
//  ViewController.m
//  CoredataTest
//
//  Created by YPMac on 2017/5/22.
//  Copyright © 2017年 YPMac. All rights reserved.
//

#import "ViewController.h"
#import "DataBaseHandle.h"
#import "PersonCell.h"
#import "PersonDetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *yp_tableView;
@property (nonatomic, strong) NSMutableArray *datasArray;

@end

@implementation ViewController
- (NSMutableArray *)datasArray{
    if(!_datasArray){
        _datasArray = [NSMutableArray arrayWithArray:[DataBaseHandle getAllPersons]];
    }
    return _datasArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.yp_tableView.delegate = self;
    self.yp_tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 通知刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"PersonRefresh" object:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count ----- %lu",(unsigned long)self.datasArray.count);
    return self.datasArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell001";
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonCell" owner:nil options:nil] firstObject];
    }
    Person *p = self.datasArray[indexPath.row];
    cell.perosn = p;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Person *p = self.datasArray[indexPath.row];
    
    PersonDetailViewController *controller = [[PersonDetailViewController alloc] init];
    controller.title = @"详情";
    controller.person = p;
    [self.navigationController pushViewController:controller animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        Person *p = self.datasArray[indexPath.row];
        [self.datasArray removeObject:p];
        [DataBaseHandle deleteOnePerson:p.name];
        [_yp_tableView reloadData];
    }];
    
    return @[deleteAction];
}
- (void)refresh{
    [_yp_tableView reloadData];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
