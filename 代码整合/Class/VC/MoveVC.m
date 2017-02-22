//
//  MoveVC.m
//  代码整合
//
//  Created by greatRong on 2017/1/2.
//  Copyright © 2017年 greatRong. All rights reserved.
//

#import "MoveVC.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

@interface MoveVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *datas;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MoveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];

    
    self.datas = @[@"UITableView",@"UICollectionView"];
    
    [self.tableView reloadData];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        TableViewController *table = [[TableViewController alloc] init];
        table.title = self.datas[indexPath.row];
        [self.navigationController pushViewController:table animated:YES];
    }
    else
    {
        CollectionViewController *collection = [[CollectionViewController alloc] init];
        collection.title = self.datas[indexPath.row];
        [self.navigationController pushViewController:collection animated:YES];
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
