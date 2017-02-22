//
//  ProgressVC.m
//  代码整合
//
//  Created by greatRong on 2016/12/26.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import "ProgressVC.h"

#import "ZZCircleProgress.h"

#define ZZRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface ProgressVC (){
    ZZCircleProgress *circle1;
    ZZCircleProgress *circle2;
    ZZCircleProgress *circle3;
    ZZCircleProgress *circle4;
}

@end

@implementation ProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"圆形进度条";
    
    [self initCircles];
    
    // Do any additional setup after loading the view.
}

//初始化
- (void)initCircles {
    
    CGFloat xCrack = ([UIScreen mainScreen].bounds.size.width-150*2)/3.0;
    CGFloat yCrack = ([UIScreen mainScreen].bounds.size.height-150*2)/3.0;
    CGFloat itemWidth = 150;
    
    //默认状态
    circle1 = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(xCrack, yCrack, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:0 strokeWidth:10];
    circle1.progress = 0.6;
    [self.view addSubview:circle1];
    
    //无小圆点、同动画时间
    circle2 = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(xCrack*2+itemWidth, yCrack, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:0 strokeWidth:10];
    circle2.progress = 0.6;
    circle2.showPoint = NO;
    circle2.animationModel = CircleIncreaseSameTime;
    [self.view addSubview:circle2];
    
    //自定义起始角度
    circle3 = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(xCrack, yCrack*2+itemWidth, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:-255 strokeWidth:10];
    circle3.progress = 0.6;
    circle3.reduceValue = 30;
    [self.view addSubview:circle3];
    
    //同动画时间、隐藏文字
    circle4 = [[ZZCircleProgress alloc] initWithFrame:CGRectMake(xCrack*2+itemWidth, yCrack*2+itemWidth, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:0 strokeWidth:10];
    circle4.progress = 0.3;
    circle4.animationModel = CircleIncreaseSameTime;
    circle4.showProgressText = NO;
    [self.view addSubview:circle4];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    circle1.progress = 0.6;
    circle2.progress = 0.6;
    circle3.progress = 0.6;
    circle4.progress = 0.3;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
