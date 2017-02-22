//
//  PicSelectVC.m
//  代码整合
//
//  Created by greatRong on 2017/1/8.
//  Copyright © 2017年 greatRong. All rights reserved.
//

#define MTScreenW [UIScreen mainScreen].bounds.size.width

#define MTScreenH [UIScreen mainScreen].bounds.size.height

#import "PicSelectVC.h"

//#import "MTInputToolbar.h"

@interface PicSelectVC ()
//<MTInputToolbarDelegate>

@end

@implementation PicSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MTInputToolbar *inputToolbar = [[MTInputToolbar alloc] initWithFrame:CGRectMake(0,MTScreenH - 50 , MTScreenW, 50)];
//    inputToolbar.delegate = self;
//    
//    NSMutableArray *arr = [[NSMutableArray alloc] init];
//    for (int i = 0; i<12; i ++ ) {
//        NSDictionary *dict = @{@"image":@"img_defaulthead_nor",
//                               @"label":[NSString stringWithFormat:@"%d",i],
//                               };
//        [arr addObject:dict];
//    }
//    inputToolbar.typeDatas = [arr copy];
//    
//    //文本输入框最大行数
//    inputToolbar.textViewMaxLine = 4;
//    [self.view addSubview:inputToolbar];

    
    // Do any additional setup after loading the view.
}

#pragma MTInputToolbarDelegate

//- (void)inputToolbar:(MTInputToolbar *)inputToolbar sendContent:(NSAttributedString *)sendContent
//{
//    NSLog(@"sendContent  %@",sendContent);
//}
//
//- (void)inputToolbar:(MTInputToolbar *)inputToolbar sendRecordData:(NSData *)Data
//{
//    NSLog(@"sendRecordData %@",Data);
//}
//
//- (void)inputToolbar:(MTInputToolbar *)inputToolbar indexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"inputToolbar indexPath %@",indexPath);
//}


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
