//
//  ZFButton.m
//  ZFIsuueWeiboDemo
//
//  Created by 张锋 on 16/5/24.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import "ZFWeiboButton.h"
#import "UIView+ZF.h"

#define titleH 20

@interface ZFWeiboButton ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;


@property (nonatomic, strong) ZFButton *button;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ZFWeiboButton

+ (ZFWeiboButton *)buttonWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title
{
    return [[ZFWeiboButton alloc] initWithFrame:frame image:image title:title];
}

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = image;
        _title = title;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews
{
    [self addSubview:self.button];
    [self addSubview:self.titleLabel];
}

- (void)setBtnTag:(NSInteger)btnTag
{
    self.tag = btnTag;
    self.button.tag = btnTag;
}

- (UIButton *)button
{
    if (!_button) {
        CGFloat imgViewWH = self.h - titleH - 10;
        CGFloat imgViewX  = (self.w-imgViewWH) / 2;
        _button = [ZFButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(imgViewX,
                                   0,
                                   imgViewWH,
                                   imgViewWH);
        [_button setImage:[UIImage imageNamed:_image]
                 forState:UIControlStateNormal];
        [_button addTarget:self
                    action:@selector(buttonClicked)
          forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                self.h - titleH,
                                                                self.w,
                                                                titleH)];
        _titleLabel.text = _title;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - 图片点击事件
- (void)buttonClicked
{
    // NSLog(@"%zd", self.tag);
    if (self.delegate && [self.delegate respondsToSelector:@selector(WeiboButtonClick:)]) {
        [self.delegate WeiboButtonClick:self];
    }
}

@end
