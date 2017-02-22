//
//  ChangeVC.m
//  代码整合
//
//  Created by greatRong on 2016/12/28.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import "ChangeVC.h"
#import "PortalAnimation.h"
#import "ChangeViewC.h"

@interface ChangeVC ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate,MainViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    PortalAnimation *portalAnimation;
    
}


@end

@implementation ChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    portalAnimation = [PortalAnimation new];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"indexPath %ld",indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    portalAnimation.isPortal = YES;
    
    ChangeViewC *vc = [[ChangeViewC alloc] init];
    vc.transitioningDelegate = self;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    portalAnimation.isPortal = YES;
//
//    MainViewController *vc = [[MainViewController alloc] init];
//    vc.transitioningDelegate = self;
//    vc.delegate = self;
//    [self presentViewController:vc animated:YES completion:nil];
//}


-(void)dismiss{
    
    portalAnimation.isPortal = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return portalAnimation;
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return portalAnimation;
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
