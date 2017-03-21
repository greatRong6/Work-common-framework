//
//  ViewController.m
//  代码整合
//
//  Created by greatRong on 2016/12/23.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import "ViewController.h"
#import "TagVC.h"
#import "HomeViewController.h"
#import "LuckyVC.h"
#import "TelephoneVC.h"
#import "EncryptVC.h"
#import "ProgressVC.h"
#import "SelectCityVC.h"
#import "PickViewVC.h"
#import "KarVC.h"
#import "MainViewController.h"
#import "STListController.h"
#import "WeiboAniVC.h"
#import "ApplePayVC.h"
#import "PYSearchExampleController.h"
#import "SelectPicVC.h"
#import "SelectVideoVC.h"
#import "ChangeViewC.h"
#import "QQButtonVC.h"
#import "ShowViewController.h"
#import "EditVC.h"
#import "TheTopVC.h"
#import "MoveVC.h"
#import "PicSelectVC.h"
#import "FigureVC.h"
#import "DemoViewController.h"
#import "WebViewVC.h"
#import "PredicateVC.h"
#import "ImageCopVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ViewController

-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self loadData];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)loadData{

//    相机滤镜效果
    [self.dataSource addObjectsFromArray:@[@"不错的标签选择",@"不错的通讯录",@"抽奖轮盘",@"各种跑马灯",@"加密",@"圆形进度条",@"省市区地址选择器",@"搜索筛选城市",@"秒拍卡牌模式",@"tableView加载viewcontroller左右滑动",@"collection加载viewcontroller左右滑动",@"微博动画",@"苹果内部购买",@"搜索控制器",@"选择照片,拍照,视频",@"选择照片和选择视频",@"界面切换动画",@"QQButton滑动消失",@"UIAlertView/UIAlertController便捷调用工具",@"模仿今日头条, 网易频道编辑",@"UITableView、CollectView多选、单选",@"UITableView置顶",@"TableView与CollectionView之间的联动",@"表情图片选择",@"折线图",@"利用余弦函数实现的图片浏览工具",@"webView的优化缓存",@"查询，原理和用法都类似于SQL中的where",@"图片裁剪"]];
    [self.tableView reloadData];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld text:%@",indexPath.row,self.dataSource[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        TagVC *tag = [[TagVC alloc] init];
        tag.title = @"不错的标签选择";
        [self.navigationController pushViewController:tag animated:YES];
        
    }else if (indexPath.row == 1){
    
        TelephoneVC *tel = [[TelephoneVC alloc] init];
        tel.title = @"不错的通讯录";
        [self.navigationController pushViewController:tel animated:YES];
        
    }else if (indexPath.row == 3){
        
        HomeViewController *home =[[HomeViewController alloc] init];
        [self.navigationController pushViewController:home animated:YES];
        
    }else if (indexPath.row == 2){
    
        LuckyVC *luck = [[LuckyVC alloc] init];
        luck.title = @"抽奖轮盘";
        [self.navigationController pushViewController:luck animated:YES];

    }else if (indexPath.row == 4){
        
        EncryptVC *encrypt =[[EncryptVC alloc] init];
        [self.navigationController pushViewController:encrypt animated:YES];
        
    }else if (indexPath.row == 5){
        
        ProgressVC *progress =[[ProgressVC alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
    }else if (indexPath.row == 6){
        
        PickViewVC *progress =[[PickViewVC alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 7){
        
        SelectCityVC *progress =[[SelectCityVC alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 8){
        
        KarVC *progress =[[KarVC alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 9){
        
        MainViewController *progress =[[MainViewController alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 10){
        
        STListController *progress =[[STListController alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 11){
        
        WeiboAniVC *progress =[[WeiboAniVC alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 12){
        
        ApplePayVC *progress =[[ApplePayVC alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 13){
        
        PYSearchExampleController *progress =[[PYSearchExampleController alloc] init];
        [self.navigationController pushViewController:progress animated:YES];

    }else if (indexPath.row == 14){
        
        SelectPicVC *progress = [[SelectPicVC alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 15){
        
        SelectVideoVC *progress = [[SelectVideoVC alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 16){
        
        ChangeViewC *progress = [[ChangeViewC alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 17){
        
        QQButtonVC *progress = [[QQButtonVC alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 18){
        
        ShowViewController *progress = [[ShowViewController alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 19){
        
        ShowViewController *progress = [[ShowViewController alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 20){
        
        EditVC *progress = [[EditVC alloc] init];
        progress.title = @"UITableView、CollectView多选、单选";
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 21){
        
        TheTopVC *progress = [[TheTopVC alloc] init];
        progress.title = @"UITableView置顶 置地";
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 22){
        
        MoveVC *progress = [[MoveVC alloc] init];
        progress.title = @"TableView与CollectionView之间的联动";
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 23){
        
        PicSelectVC *progress = [[PicSelectVC alloc] init];
        progress.title = @"表情图片选择";
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 24){
        
        FigureVC *progress = [[FigureVC alloc] init];
        progress.title = @"折线图";
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 25){
        
        DemoViewController *progress = [[DemoViewController alloc] init];
        progress.title = @"利用余弦函数实现的图片浏览工具";
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 26){
        
        WebViewVC *progress = [[WebViewVC alloc] init];
        progress.title = @"webView的优化缓存";
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 27){
        
        PredicateVC *progress = [[PredicateVC alloc] init];
        progress.title = @"查询，原理和用法都类似于SQL中的where";
        [self.navigationController pushViewController:progress animated:YES];
        
    }else if (indexPath.row == 28){
        
        ImageCopVC *progress = [[ImageCopVC alloc] init];
        progress.title = @"图片裁剪";
        [self.navigationController pushViewController:progress animated:YES];
        
    }
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
