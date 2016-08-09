//
//  UITextField+UITextField_TextLengthLimit.m
//  textFieldLimit
//
//  Created by 罗向宇 on 16/8/3.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "UITextField+TextLengthLimit.h"
#import <objc/runtime.h>

static void const* bx_textLengthLimitKey = &bx_textLengthLimitKey;
static void const* bx_handleDidCutOffStringKey = &bx_handleDidCutOffStringKey;

@implementation UITextField (UITextField_TextLengthLimit)

#pragma mark - Actions

- (void)bx_textFieldDidChange:(UITextField *)textField
{
    NSString *toBeString = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position= [textField positionFromPosition:selectedRange.start offset:0];
    if(position){
        return;
    }
    if (toBeString.length > self.bx_textLengthLimit) {
        NSInteger lastCharacterLength = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.bx_textLengthLimit].length;
        NSRange subStringRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.bx_textLengthLimit)];
        if(subStringRange.length > self.bx_textLengthLimit){
            subStringRange.length -= lastCharacterLength;
        }
        textField.text = [toBeString substringWithRange:subStringRange];
        if(self.bx_didCutOffStringHandler){
            self.bx_didCutOffStringHandler(self);
        }
    }
}

#pragma mark - getter && setter

- (NSInteger)bx_textLengthLimit
{
    NSNumber *textLengthLimitNumber = (NSNumber *)objc_getAssociatedObject(self, bx_textLengthLimitKey);
    return textLengthLimitNumber ? [textLengthLimitNumber integerValue] : NSNotFound;
}

- (void (^)(UITextField *))bx_didCutOffStringHandler
{
    return objc_getAssociatedObject(self, bx_handleDidCutOffStringKey);
}

- (void)setBx_textLengthLimit:(NSInteger)bx_textLengthLimit
{
    if (bx_textLengthLimit <= 0){
        [self removeTarget:self action:@selector(bx_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        return;
    }
    objc_setAssociatedObject(self, bx_textLengthLimitKey, @(bx_textLengthLimit), OBJC_ASSOCIATION_COPY);
    if (bx_textLengthLimit > 0) {
        [self addTarget:self action:@selector(bx_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)setBx_didCutOffStringHandler:(void (^)(UITextField *))bx_didCutOffStringHandler
{
    objc_setAssociatedObject(self, bx_handleDidCutOffStringKey, bx_didCutOffStringHandler, OBJC_ASSOCIATION_COPY);
}

@end
