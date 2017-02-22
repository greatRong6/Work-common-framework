//
//  LuckyVC.m
//  代码整合
//
//  Created by greatRong on 2016/12/26.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import "LuckyVC.h"
#import "LotteryRouletteView.h"

@interface LuckyVC ()

@property (nonatomic,strong)LotteryRouletteView * lotteryRouletteView;;

@end

@implementation LuckyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf = self;
//    self.progess.progress = 0;
    __block NSArray *prizeArr = @[@"i6", @"大冰箱", @"屎一督", @"美女一个", @"不中奖", @"imac", @"macPro"];
    self.lotteryRouletteView = [[LotteryRouletteView alloc] initWithFrame:CGRectMake(100, 100, 300, 300) prizeArr:prizeArr progress:^(NSInteger currentProgress, NSInteger totalProgress) {
//        weakSelf.progess.progress = currentProgress / (float)totalProgress;
    } completion:^(NSInteger index) {
//        weakSelf.label.text = [NSString stringWithFormat:@"奖品：%@", prizeArr[index]];
    }];
    self.lotteryRouletteView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.f, 200);
    self.lotteryRouletteView.prizeBgColor = [UIColor colorWithRed:141 / 255.f green:190 / 255.f blue:246 / 255.f alpha:1];
    [self.view addSubview:self.lotteryRouletteView];

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
