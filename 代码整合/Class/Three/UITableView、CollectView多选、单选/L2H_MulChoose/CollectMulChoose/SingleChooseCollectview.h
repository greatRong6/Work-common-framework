//
//  SingleChooseCollectview.h
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChooseBlock) (NSString *chooseContent,NSIndexPath *indexPath);
@interface SingleChooseCollectview : UIView
<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * MyCollectView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * chooseedArr;
@property(nonatomic,strong)NSIndexPath * currentSelectIndex;
@property(nonatomic,copy)ChooseBlock block;

+(instancetype)ShareCollectviewWithFrame:(CGRect)frame;
-(void)ReloadData;

@end
