//
//  LotteryRouletteView.h
//  抽奖轮盘
//
//  Created by 莫至钊 on 16/5/19.
//  Copyright © 2016年 莫至钊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Progress)(NSInteger currentProgress, NSInteger totalProgress);
typedef void(^Completion)(NSInteger index);
@interface LotteryRouletteView : UIView

@property (nonatomic, strong) UIColor *prizeBgColor;
@property (nonatomic, strong) UIFont *prizeFont;
@property (nonatomic, strong) UIColor *prizeTextColor;
@property (nonatomic, strong) UIColor *centerBgColor;
@property (nonatomic, strong) UIColor *rollingPrizeBgColor;
@property (nonatomic, strong) UIColor *tipsRollingPrizeBgColor;
@property (nonatomic, strong) UIButton *beginPrizeButton;
@property (nonatomic, assign) float speed; // 数值越大，速度越慢


- (instancetype)initWithFrame:(CGRect)frame prizeArr:(NSArray<NSString *> *)prizeArr progress:(Progress)progress completion:(Completion)completion;
- (void)beginPrize;


@end
