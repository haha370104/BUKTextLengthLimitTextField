//
//  UITextField+UITextField_TextLengthLimit.h
//  textFieldLimit
//
//  Created by 罗向宇 on 16/8/3.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (UITextField_TextLengthLimit)

@property (nonatomic, assign) NSInteger textLengthLimit;
@property (nonatomic, copy) void (^didCutOffStringHandler)(UITextField *);

@end
