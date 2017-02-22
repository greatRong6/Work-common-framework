//
//  STListController.m
//  SwipeTableView
//
//  Created by Roy lee on 16/4/2.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

#import "STListController.h"
#import "STViewController.h"

@interface STListController ()

@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation STListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[@{
                            @"title":@"SingleOneKindView",
                            @"type":@(STControllerTypeNormal),
                            },
                        @{
                            @"title":@"HybridItemViews",
                            @"type":@(STControllerTypeHybrid),
                            },
                        @{
                            @"title":@"DisabledBarScroll",
                            @"type":@(STControllerTypeDisableBarScroll),
                            },
                        @{
                            @"title":@"HiddenNavigationBar",
                            @"type":@(STControllerTypeHiddenNavBar),
                            }];
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _dataSource[indexPath.row][@"title"];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    STViewController *demoVC = [[STViewController alloc] init];
    demoVC.type             = (STControllerType)[_dataSource[indexPath.row][@"type"] integerValue];
    demoVC.title            = _dataSource[indexPath.row][@"title"];
    [self.navigationController pushViewController:demoVC animated:YES];
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
// 在storyboard-based应用程序中,您通常会希望导航之前做一些准备
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller  将选择的对象传递给新视图控制器 .
    
//    STViewController * demoVC = [segue destinationViewController];
//    UITableViewCell * cell  = sender;
//    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
//    demoVC.type             = (STControllerType)[_dataSource[indexPath.row][@"type"] integerValue];
//    demoVC.title            = _dataSource[indexPath.row][@"title"];
//    [super prepareForSegue:segue sender:sender];
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
