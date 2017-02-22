//
//  ZFIssueWeiboView.h
//  ZFIsuueWeiboDemo
//
//  Created by 张锋 on 16/5/24.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZFWeiboButton;
@protocol ZFIssueWeiboViewDelegate <NSObject>

- (void)animationHasFinishedWithButton:(ZFWeiboButton *)button;

@end

@interface ZFIssueWeiboView : UIView
/**
 *  按钮标题数组，数组个数应<=6
 */
@property (nonatomic, strong) NSArray *titles;
/**
 *  按钮图片数组，数组个数应<=6
 */
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, weak) id<ZFIssueWeiboViewDelegate> delegate;
+ (instancetype)initIssueWeiboView;
@end
