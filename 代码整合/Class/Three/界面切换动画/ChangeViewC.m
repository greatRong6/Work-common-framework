//
//  ChangeViewC.m
//  代码整合
//
//  Created by greatRong on 2016/12/28.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import "ChangeViewC.h"

@interface ChangeViewC ()

@end

@implementation ChangeViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.center = self.view.center;
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
    // Do any additional setup after loading the view.
}

-(void)buttonClick{
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_delegate && [_delegate respondsToSelector:@selector(dismiss)]) {
        [_delegate dismiss];
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
