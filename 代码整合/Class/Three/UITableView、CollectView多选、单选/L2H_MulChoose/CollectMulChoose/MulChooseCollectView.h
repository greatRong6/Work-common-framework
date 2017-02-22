//
//  ChooseCollectView.h
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChooseBlock) (NSString *chooseContent,NSMutableArray *chooseArr);
@interface MulChooseCollectView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * MyCollectView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * choosedArr;
@property(nonatomic,copy)ChooseBlock block;
@property (nonatomic,assign)BOOL ifAllSelected;
@property (nonatomic,assign)BOOL ifAllSelecteSwitch;


+(instancetype)ShareCollectviewWithFrame:(CGRect)frame HeaderTitle:(NSString *)title;//有Header
-(void)ReloadData;
@end
