//
//  FXTagTextField.m
//  TagManager
//
//  Created by johnny on 15/12/3.
//  Copyright © 2015年 ftxbird. All rights reserved.
//

#import "FXTagTextField.h"

@implementation FXTagTextField


- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 9 , 0 );
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 9 , 0 );
}

- (void)deleteBackward {
    
    [super deleteBackward];
    
    if (_keyInputDelegate &&[_keyInputDelegate respondsToSelector:@selector(deleteBackward)]) {
        [_keyInputDelegate deleteBackward];
    }
}

@end
