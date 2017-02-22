//
//  PickViewVC.m
//  代码整合
//
//  Created by greatRong on 2016/12/26.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import "PickViewVC.h"
#import "OSAddressPickerView.h"

@interface PickViewVC (){
    UIButton *_btn;
    OSAddressPickerView *_pickerview;
}


@end

@implementation PickViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"省市区地址选择器";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.backgroundColor = [UIColor blueColor];
    _btn.frame = CGRectMake(20, 100, self.view.frame.size.width - 40, 40);
    if ([defaults objectForKey:@"address"]) {
        [_btn setTitle:[defaults objectForKey:@"address"] forState:UIControlStateNormal];
    } else {
        [_btn setTitle:@"请选择地址" forState:UIControlStateNormal];
    }
    [_btn addTarget:self action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];

    
    // Do any additional setup after loading the view.
}

- (void)btnEvent
{
    _pickerview = [OSAddressPickerView shareInstance];
    [_pickerview showBottomView];
    [self.view addSubview:_pickerview];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    __weak UIButton *temp = _btn;
    _pickerview.block = ^(NSString *province,NSString *city,NSString *district)
    {
        [temp setTitle:[NSString stringWithFormat:@"%@ %@ %@",province,city,district] forState:UIControlStateNormal];
        [defaults setObject:[NSString stringWithFormat:@"%@ %@ %@",province,city,district] forKey:@"address"];
    };
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
