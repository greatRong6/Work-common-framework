//
//  TagVC.m
//  代码整合
//
//  Created by greatRong on 2016/12/23.
//  Copyright © 2016年 greatRong. All rights reserved.
/* 
   不错的标签选择
 */

#import "TagVC.h"
#import "FXTagView.h"

@interface TagVC ()<FXTagViewDelegate>

@property(nonatomic,strong)FXTagView *editTagView;

@end

@implementation TagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.editTagView = [[FXTagView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height-64)];
    self.editTagView.limitChar = YES;
    self.editTagView.tagDelegate =self;
    self.editTagView.tagNormalColor = [UIColor blackColor];
    self.editTagView.tagSeletedColor = [UIColor whiteColor];
    self.editTagView.tagBackgroundColor = [UIColor redColor];
    self.editTagView.showType = ShowViewTypeSingeleSelect;
    self.editTagView.tagNormalColor = [UIColor whiteColor];
    self.editTagView.tagSeletedColor = [UIColor blueColor];
    [self.view addSubview:self.editTagView];

    [self.editTagView addTags:@[@"你好",@"好好学习",@"天天向上",@"大宝天天见",@"好",@"中国",@"你好"]];

    // Do any additional setup after loading the view.
}

- (void)tagDidSelectText:(NSString *)selectText tagView:(FXTagView *)tagView{
    NSLog(@"%@",selectText);
    
    [self.editTagView addTag:selectText];
}


- (void)tagUnSelectText:(NSString *)unSelectText tagView:(FXTagView *)tagView{
    
    NSLog(@"%@",unSelectText);
//    [self.editTagView removeTag:unSelectText];
}

- (void)heightDidChangedTagView:(FXTagView *)tagView height:(CGFloat)height {
    
    if (self.editTagView == tagView) {
        
        self.editTagView.frame.size.height == height;
        [self.view layoutIfNeeded];
        
    }
}


- (void)tagDeletedText:(NSString *)text tagView:(FXTagView *)tagView {
    
//    [self.editTagView changeTagStateSpecialTag:text];
    NSLog(@"删除文本%@",text);
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
