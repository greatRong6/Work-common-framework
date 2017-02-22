//
//  ZFButton.m
//  ZFImagePicker
//
//  Created by 张锋 on 16/5/13.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import "ZFButton.h"

@implementation ZFButton

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self resetButtonState];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGFloat boundsExtension = 0.0f;
    CGRect outerBounds = CGRectInset(self.bounds, -1 * boundsExtension, -1 * boundsExtension);
    
    BOOL touchOutside = !CGRectContainsPoint(outerBounds, [touch locationInView:self]);
    if(touchOutside) {
        BOOL previousTouchInside = CGRectContainsPoint(outerBounds, [touch previousLocationInView:self]);
        if(!previousTouchInside) {
            [self resetButtonState];
            [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
        }
    }
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:NO];
}

- (void)resetButtonState
{
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

@end
