//
//  ZFButton.h
//  ZFIsuueWeiboDemo
//
//  Created by 张锋 on 16/5/24.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFButton.h"

@class ZFWeiboButton;

@protocol ZFWeiboButtonDelegate <NSObject>
- (void)WeiboButtonClick:(ZFWeiboButton *)button;
@end

@interface ZFWeiboButton : UIView
@property (nonatomic, assign) NSInteger btnTag;
@property (nonatomic, weak) id <ZFWeiboButtonDelegate> delegate;
+ (ZFWeiboButton *)buttonWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title;

@end
