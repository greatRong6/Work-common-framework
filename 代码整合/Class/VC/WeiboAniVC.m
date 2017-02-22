//
//  WeiboAniVC.m
//  代码整合
//
//  Created by greatRong on 2016/12/26.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import "WeiboAniVC.h"
#import "ZFWeiboButton.h"
#import "ZFIssueWeiboView.h"

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface WeiboAniVC ()<ZFIssueWeiboViewDelegate>


@end

@implementation WeiboAniVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(20, SCREENHEIGHT/2, SCREENWIDTH/2-40, 50);
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clicj) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    // Do any additional setup after loading the view.
}

-(void)clicj{

    ZFIssueWeiboView *view = [ZFIssueWeiboView initIssueWeiboView];
    view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    view.delegate = self;
    [self.view addSubview:view];


}

- (void)animationHasFinishedWithButton:(ZFWeiboButton *)button
{
    NSLog(@"%zd", button.tag);
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
