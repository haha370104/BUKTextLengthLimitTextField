//
//  BUKViewController.m
//  BUKTextLengthLimitTextField
//
//  Created by haha370104 on 08/04/2016.
//  Copyright (c) 2016 haha370104. All rights reserved.
//

#import "BUKViewController.h"
#import "BUKTextLengthLimitTextField/UITextField+UITextField_TextLengthLimit.h"

@interface BUKViewController ()

@property (nonatomic, strong)UITextField *textField;

@end

@implementation BUKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.textField];
}

- (UITextField *)textField
{
    if(!_textField){
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, self.view.bounds.size.width - 30, 80)];
        _textField.placeholder = @"输入";
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.textLengthLimit = 5;
        [_textField setDidCutOffStringHandler:^(UITextField *textField) {
            NSLog(@"123");
        }];
    }
    return _textField;
}

@end
