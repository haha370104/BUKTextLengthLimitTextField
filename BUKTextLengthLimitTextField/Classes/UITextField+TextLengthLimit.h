//
//  UITextField+UITextField_TextLengthLimit.h
//  textFieldLimit
//
//  Created by 罗向宇 on 16/8/3.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

@import UIKit;

@interface UITextField (TextLengthLimit)

@property (nonatomic, assign) NSInteger bx_textLengthLimit;
@property (nonatomic, copy) void (^bx_didCutOffStringHandler)(UITextField *);

@end
