//
//  OneViewTableTableViewController.m
//  HeaderViewAndPageView
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "OneViewTableTableViewController.h"

@interface OneViewTableTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic ,strong)UITableView * myTableView;
@end

@implementation OneViewTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 44)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_myTableView];
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"homePageCellIdentifier%@",indexPath ];
    UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"onetableForIndex.row =%ld",indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%@",[NSString stringWithFormat:@"onetableForIndex.row =%ld",indexPath.row]);

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

@end
