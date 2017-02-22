//
//  FXTagTextField.h
//  TagManager
//
//  Created by johnny on 15/12/3.
//  Copyright © 2015年 ftxbird. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol keyInputTextFieldDelegate <NSObject>

@optional
/**
 *  键盘删除键 回调
 */
- (void)deleteBackward;

@end

@interface  FXTagTextField : UITextField

@property (nonatomic,assign) id<keyInputTextFieldDelegate> keyInputDelegate;

@end
