//
//  TableViewChoose.m
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import "TableVC_MulChoose.h"
#import "MulChooseTable.h"
@interface TableVC_MulChoose (){
    MulChooseTable * MyTable;
    NSMutableArray * dataArr;
}

@end

@implementation TableVC_MulChoose
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //增加数据
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 0, 100, 50)];
//    [btn setTitle:@"AddArr" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar addSubview:btn];
//    UINavigationItem * right = [[UINavigationItem alloc]initWithTitle:@"AddArr"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"AddArr" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    
    
    dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    MyTable = [MulChooseTable ShareTableWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) HeaderTitle:@"全选"];
    MyTable.dataArr = dataArr;
    //选中内容
    MyTable.block = ^(NSString *chooseContent,NSMutableArray *chooseArr){
        NSLog(@"数据：%@ ; %@",chooseContent,chooseArr);
    };
    [self.view addSubview:MyTable];
}

-(void)click{
    NSUInteger CurrentCount = dataArr.count;
    for (int i=1; i<=10; i++) {
        [dataArr addObject:[NSString stringWithFormat:@"%lu",CurrentCount+i]];
    }
    MyTable.dataArr = dataArr;
    [MyTable ReloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
