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
static void const* handleDidCutOffStringKey = &handleDidCutOffStringKey;

@implementation UITextField (UITextField_TextLengthLimit)

#pragma mark - event -

- (void)textFieldDidChange:(UITextField *)textField
{
    NSString *toBeString = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        if (toBeString.length > self.textLengthLimit) {
            NSInteger lastCharacterLength = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.textLengthLimit].length;
            NSRange subStringRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.textLengthLimit)];
            if(subStringRange.length > self.textLengthLimit){
                subStringRange.length -= lastCharacterLength;
            }
            textField.text = [toBeString substringWithRange:subStringRange];
            if(self.didCutOffStringHandler){
                self.didCutOffStringHandler(self);
            }
        }
    }
}

#pragma mark - getter && setter -

#pragma mark - getter -

- (NSInteger)textLengthLimit
{
    NSNumber *textLengthLimitNumber = (NSNumber *)objc_getAssociatedObject(self, textLengthLimitKey);
    NSInteger _textLengthLimit = -1;
    if(textLengthLimitNumber){
        _textLengthLimit = [textLengthLimitNumber integerValue];
    }
    return _textLengthLimit;
}

- (void (^)(UITextField *))didCutOffStringHandler
{
    return objc_getAssociatedObject(self, handleDidCutOffStringKey);
}

#pragma mark - setter -

- (void)setTextLengthLimit:(NSInteger)textLengthLimit
{
    if(textLengthLimit > 0)
    {
        objc_setAssociatedObject(self, textLengthLimitKey, @(textLengthLimit), OBJC_ASSOCIATION_COPY);
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)setDidCutOffStringHandler:(void (^)(UITextField *))handleDidCutOffString
{
    objc_setAssociatedObject(self, handleDidCutOffStringKey, handleDidCutOffString, OBJC_ASSOCIATION_COPY);
}

@end
