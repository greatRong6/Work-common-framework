//
//  SingleTableChooseVC.m
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import "TableVC_SingleChoose.h"
#import "SingleChooseTable.h"

@interface TableVC_SingleChoose (){
    SingleChooseTable * MyTable;
    NSMutableArray * dataArr;
}

@end

@implementation TableVC_SingleChoose
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"AddArr" style:UIBarButtonItemStylePlain target:self action:@selector(click)];

    
    
    dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    dataArr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    MyTable = [SingleChooseTable ShareTableWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height)];
    MyTable.dataArr = dataArr;
    [MyTable ReloadData];
    //选中内容
    MyTable.block = ^(NSString *chooseContent,NSIndexPath *indexPath){
        NSLog(@"数据：%@ ；第%ld行",chooseContent,indexPath.row);
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
