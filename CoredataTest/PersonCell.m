//
//  PersonCell.m
//  CoredataTest
//
//  Created by YPMac on 2017/5/23.
//  Copyright © 2017年 YPMac. All rights reserved.
//

#import "PersonCell.h"
@interface PersonCell()
@property (weak, nonatomic) IBOutlet UILabel *label_num;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_school;
@property (weak, nonatomic) IBOutlet UILabel *label_address;

@end
@implementation PersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setPerosn:(Person *)perosn{
    _perosn = perosn;
    _label_num.text = [NSString stringWithFormat:@"%d",self.perosn.number];
    _label_name.text = self.perosn.name;
    _label_school.text = self.perosn.relationship.school_name;
    _label_address.text = self.perosn.address;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
