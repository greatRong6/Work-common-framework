//
//  LotteryRouletteView.m
//  抽奖轮盘
//
//  Created by 莫至钊 on 16/5/19.
//  Copyright © 2016年 莫至钊. All rights reserved.
//

#import "LotteryRouletteView.h"

#define kDegreesToRadians(degrees)  ((M_PI * degrees)/ 180)
#define AKAngle(radian) (radian / M_PI * 180.f)
#define AKCos(a) cos(a / 180.f * M_PI)
#define AKSin(a) sin(a / 180.f * M_PI)

@interface RollingPrizeView : UIView

@property (nonatomic, assign) float derees;
@property (nonatomic, strong) UIColor *rollingPrizeBgColor;
@property (nonatomic, strong) UIColor *tipsRollingPrizeBgColor;

@end

@implementation RollingPrizeView

- (instancetype)initWithFrame:(CGRect)frame degrees:(float)degrees
{
    self = [super initWithFrame:frame];
    if (self) {
        self.derees = degrees;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float width = rect.size.width;
    float height = rect.size.height;
    float moveAngle =  self.derees  + 270 > 360 ? self.derees  - 90 : self.derees  + 270 ;
    CGContextRef cont = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cont, self.rollingPrizeBgColor.CGColor);
    CGContextSetLineWidth(cont, width / 3.f);
    CGContextAddArc(cont, width / 2.f, height / 2.f, width / 3.f, kDegreesToRadians(270), kDegreesToRadians(moveAngle), 0);
    CGContextDrawPath(cont, kCGPathStroke);
    
    CGContextRef cont1 = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cont1, self.tipsRollingPrizeBgColor.CGColor);
    CGContextSetLineWidth(cont1, width / 20.f);
    CGContextAddArc(cont1, width / 2.f, height / 2.f, 11 * width / 40.f, kDegreesToRadians(270), kDegreesToRadians(moveAngle), 0);
    CGContextDrawPath(cont, kCGPathStroke);
}

@end


@interface LotteryRouletteView ()

@property (nonatomic, strong) NSArray *prizeArr;
@property (nonatomic, strong) RollingPrizeView *rollingPrizeView;
@property (nonatomic, assign) NSInteger prizeIndex;
@property (nonatomic, assign) NSInteger rotatCount;
@property (nonatomic, assign) NSInteger progressCount;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) Progress progress;
@property (nonatomic, copy) Completion competion;
@property (nonatomic, assign) BOOL canBegin;

@end

@implementation LotteryRouletteView

- (instancetype)initWithFrame:(CGRect)frame prizeArr:(NSArray *)prizeArr progress:(Progress)progress completion:(Completion)completion
{
    self = [super initWithFrame:frame];
    if (self) {
        self.prizeArr = prizeArr;
        self.progress = progress;
        self.competion = completion;
        self.speed = 2;
        self.progressCount = 0;
        self.canBegin = YES;
        self.prizeBgColor = [UIColor colorWithRed:141 / 255.f green:190 / 255.f blue:246 / 255.f alpha:1];
        self.prizeFont = [UIFont systemFontOfSize:13];
        self.prizeTextColor = [UIColor blackColor];
        self.rollingPrizeBgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
        self.centerBgColor = [UIColor colorWithRed:14 / 255.f green:29 / 255.f blue:73 / 255.f alpha:1];
        self.prizeIndex = 0;
        self.tipsRollingPrizeBgColor = [UIColor redColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float width = rect.size.width;
    float height = rect.size.height;
    float degrees = (1 / (float)self.prizeArr.count) * 360.f;
    float statAngle = kDegreesToRadians(270.f);
    self.rollingPrizeView = [[RollingPrizeView alloc] initWithFrame:rect degrees:degrees];
    self.rollingPrizeView.rollingPrizeBgColor = self.rollingPrizeBgColor;
    self.rollingPrizeView.tipsRollingPrizeBgColor = self.tipsRollingPrizeBgColor;
    [self addSubview:self.rollingPrizeView];
    float radius = 2 * width / 5.f + width / 10.f;
    float radius1 = width / 5.f;
    for (int i = 0; i < self.prizeArr.count; i++) {
        float moveAngle =  degrees * (i + 1) + 270 > 360 ? degrees * (i + 1) - 90 : degrees * (i + 1) + 270 ;
        CGContextRef cont = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(cont, self.prizeBgColor.CGColor);
        CGContextSetLineWidth(cont, width / 5.f);
        CGContextAddArc(cont, width / 2.f, height / 2.f, 2 * width / 5.f, statAngle, kDegreesToRadians(moveAngle), 0);
        CGContextDrawPath(cont, kCGPathStroke);
        statAngle = kDegreesToRadians(moveAngle);
        
        CGContextRef cont1 = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(cont1, radius + AKSin(i * degrees) * radius, radius - AKCos(i * degrees) * radius);
        CGContextAddLineToPoint(cont1, (radius + AKSin(i * degrees) * radius) - AKSin(i * degrees) * radius1, (radius - AKCos(i * degrees) * radius) + AKCos(i * degrees) * radius1);
        CGContextSetStrokeColorWithColor(cont1, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(cont1, 1);
        CGContextDrawPath(cont1, kCGPathStroke);
        
        UILabel *label = [[UILabel alloc] init];
        label.text = self.prizeArr[i];
        label.font = self.prizeFont;
        label.textColor = self.prizeTextColor;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize size = [label sizeThatFits:CGSizeMake(100, 99999)];
        label.frame = CGRectMake(0, 0, size.width, size.height);
        float labelDegees = i * degrees + degrees / 2.f;
        float centerX = AKSin(labelDegees) * 2 * width / 5.f + radius;
        float centerY = radius - AKCos(labelDegees) * 2 * width / 5.f;
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(centerX, centerY);
        [self addSubview:label];
        label.transform = CGAffineTransformRotate(label.transform, kDegreesToRadians(labelDegees));
    }
    CGContextRef cont2 = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(cont2, self.centerBgColor.CGColor);
    CGContextAddArc(cont2, width / 2.f, height / 2.f, 3 * width / 10.f, 0, 2 * M_PI, 0);
    CGContextDrawPath(cont2, kCGPathFill);
    if (self.beginPrizeButton) {
        [self addSubview:self.beginPrizeButton];
    }
    else{
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 3 * width / 10.f, 3 * width / 10.f);
        button.center = CGPointMake(width / 2.f, height / 2.f);
        [self addSubview:button];
        [button setTitle:@"启动" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(beginPrize) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)beginPrize
{
    if (self.canBegin) {
        self.rotatCount = arc4random() % 164 + 64;
        [self rollingPrize];
    }
}

- (void)rollingPrize
{
    self.canBegin = NO;
    self.rollingPrizeView.transform = CGAffineTransformRotate(self.rollingPrizeView.transform, kDegreesToRadians(self.rollingPrizeView.derees));
    self.prizeIndex++;
    self.prizeIndex = self.prizeIndex % self.prizeArr.count;
    self.progressCount++;
    self.progress(self.progressCount, self.rotatCount);
    NSInteger fenzi = self.progressCount > self.rotatCount / 2 ? self.progressCount - self.rotatCount / 2 : self.rotatCount / 2 - self.progressCount;
    float time = fenzi / ((float)self.rotatCount * self.speed);
    if (self.progressCount == self.rotatCount) {
        self.progressCount = 0;
        [self.timer invalidate];
        self.timer = nil;
        self.competion(self.prizeIndex);
        self.canBegin = YES;
    }
    else{
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(rollingPrize) userInfo:nil repeats:NO];
    }
}


@end
