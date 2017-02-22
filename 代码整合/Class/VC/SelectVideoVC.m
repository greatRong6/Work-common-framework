//
//  SelectVideoVC.m
//  代码整合
//
//  Created by greatRong on 2016/12/27.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import "SelectVideoVC.h"
#import "PhotoAndVideoViewController.h"
#import "PhotoViewController.h"

@interface SelectVideoVC ()

@end

@implementation SelectVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    NSArray *titles = @[@"选择照片 和 选择视频",@"选择照片and视频  和  选择视频"];
    
    for (int i = 0 ; i < titles.count; i++) {
        UIButton *one = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [one setTitle:titles[i] forState:UIControlStateNormal];
        
        [one setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [one addTarget:self action:@selector(goVC:) forControlEvents:UIControlEventTouchUpInside];
        one.tag = i;
        one.frame = CGRectMake(0, 100 + i*100, width, 50);
        [self.view addSubview:one];
    }
    
    // Do any additional setup after loading the view.
}

- (void)goVC:(UIButton *)button
{
    if (button.tag == 0) {
        PhotoViewController *vc = [[PhotoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 1) {
        PhotoAndVideoViewController *vc = [[PhotoAndVideoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
