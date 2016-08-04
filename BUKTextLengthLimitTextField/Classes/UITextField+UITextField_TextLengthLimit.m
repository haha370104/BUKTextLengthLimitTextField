//
//  UITextField+UITextField_TextLengthLimit.m
//  textFieldLimit
//
//  Created by 罗向宇 on 16/8/3.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "UITextField+UITextField_TextLengthLimit.h"
#import <objc/runtime.h>

static void const* textLengthLimitKey = &textLengthLimitKey;

@implementation UITextField (UITextField_TextLengthLimit)


#pragma mark - getter && setter -

- (NSInteger)textLengthLimit
{
    NSInteger *_textLengthLimit = [(NSNumber *)objc_getAssociatedObject(self, textLengthLimitKey) integerValue];
    if(!_textLengthLimit){
        _textLengthLimit = -1;
    }
    return _textLengthLimit;
}

- (void)setTextLengthLimit:(NSInteger)textLengthLimit
{
    objc_setAssociatedObject(self, textLengthLimitKey, @(textLengthLimit), OBJC_ASSOCIATION_COPY);
    if(textLengthLimit > 0)
    {
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSString *toBeString = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        if (toBeString.length > self.textLengthLimit) {
            textField.text = [toBeString substringToIndex:self.textLengthLimit];
        }
    }
}

@end
