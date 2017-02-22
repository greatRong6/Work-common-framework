//
//  TheTopVC.m
//  代码整合
//
//  Created by greatRong on 2017/1/2.
//  Copyright © 2017年 greatRong. All rights reserved.
//

#import "TheTopVC.h"

@interface TheTopVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dateSource;


@end

@implementation TheTopVC

-(NSMutableArray *)dateSource{
    if (!_dateSource) {
        _dateSource = [[NSMutableArray alloc] init];
    }
    return _dateSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"123";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self.view addSubview:topView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height - 100, 50, 50);
    [btn setTitle:@"置顶" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height - 130, 50, 50);
    [btn1 setTitle:@"置底" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(buttonClick1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    for (int i = 0; i < 100; i++) {
        NSString *str =  [NSString stringWithFormat:@"RowAtIndexPath %.d",i];
        [self.dateSource addObject:str];
    }

    
    // Do any additional setup after loading the view.
}

-(void)buttonClick{
    
    NSLog(@"滚到顶部");
    NSIndexPath *topRow = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tableView scrollToRowAtIndexPath:topRow atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

-(void)buttonClick1{
    
    NSLog(@"滚到底部");
    NSIndexPath *buttomRow = [NSIndexPath indexPathForRow:self.dateSource.count - 1 inSection:0];
    [_tableView scrollToRowAtIndexPath:buttomRow atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dateSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = self.dateSource[indexPath.row];
    cell.textLabel.backgroundColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//设置滑动时显示多个按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //添加一个删除按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除");
        //1.更新数据
        [self.dateSource removeObjectAtIndex:indexPath.row];
        //2.更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        
    }];
    //删除按钮颜色
    deleteAction.backgroundColor = [UIColor redColor];
    
    
    //添加一个置顶按钮
    UITableViewRowAction *topRowAction =[UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了置顶");
        //1.更新数据
        [self.dateSource exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        //2.更新UI
        NSIndexPath *firstIndexPath =[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
        
    }];
    //置顶按钮颜色
    topRowAction.backgroundColor = [UIColor magentaColor];
    
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"更多" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        //        DetailViewController *detailVC = [[DetailViewController alloc]init];
        //        [self.navigationController pushViewController:detailVC animated:YES];
        
    }];
    //背景特效
    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
    
    //----------收藏
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏" handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"收藏" message:@"收藏成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertView show];
    }];
    //收藏按钮颜色
    collectRowAction.backgroundColor = [UIColor greenColor];
    
    //将设置好的按钮方到数组中返回
    return @[deleteAction,topRowAction,moreRowAction,collectRowAction];
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
