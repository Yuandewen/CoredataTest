//
//  PersonDetailViewController.m
//  CoredataTest
//
//  Created by YPMac on 2017/5/24.
//  Copyright © 2017年 YPMac. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "DataBaseHandle.h"

@interface PersonDetailViewController ()<UITextFieldDelegate>
{
    NSString *name;
    NSString *address;
    NSString *number;
    NSString *school;
}
@property (weak, nonatomic) IBOutlet UITextField *text_name;
@property (weak, nonatomic) IBOutlet UITextField *text_address;
@property (weak, nonatomic) IBOutlet UITextField *text_number;
@property (weak, nonatomic) IBOutlet UITextField *text_school;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation PersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _text_school.delegate = self;
    _text_number.delegate = self;
    _text_address.delegate = self;
    _text_name.delegate = self;
    
    _text_name.text = self.person.name;
    _text_address.text = self.person.address;
    _text_number.text = [NSString stringWithFormat:@"%d",self.person.number];
    _text_school.text = self.person.relationship.school_name;
}

- (IBAction)btnClick:(id)sender {
    if(name.length == 0 || address.length == 0 || number.length == 0 || school.length == 0){
        return;
    }
    NSArray *datas = @[name,address,number,school];
    [DataBaseHandle modifyPerson:self.person.name newDatas:datas];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PersonRefresh" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField == _text_name){
        name = textField.text;
    }else if (textField == _text_address){
        address = textField.text;
    }else if(textField == _text_number){
        number = textField.text;
    }else if(textField == _text_school){
        school = textField.text;
    }
    [textField resignFirstResponder];
    return YES;
}

@end
