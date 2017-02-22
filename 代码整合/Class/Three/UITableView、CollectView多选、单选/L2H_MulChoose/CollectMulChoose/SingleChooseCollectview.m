//
//  SingleChooseCollectview.m
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import "SingleChooseCollectview.h"
#import "CollectviewChooseCell.h"
#define ItemHeight 70
#define HeaderHeight 50
static NSString *CellId = @"CellId";
static NSString *HeaderId = @"HeaderId";
@implementation SingleChooseCollectview


+(instancetype)ShareCollectviewWithFrame:(CGRect)frame{
    SingleChooseCollectview * collect = [[SingleChooseCollectview alloc] initWithCollectFrame:frame];
    return  collect;
}

-(instancetype)initWithCollectFrame:(CGRect)frame{
    self = [super init];
    if(self){
        self.frame = frame;
        [self CreateCollectView];
    }
    return self;
}


-(void)CreateCollectView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;//列距
    flowLayout.minimumLineSpacing = 10;
    _MyCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 ,SCREEN_WIDTH, self.frame.size.height) collectionViewLayout:flowLayout];
    _MyCollectView.backgroundColor = ColorRGB(0xf7f7f7);
    [_MyCollectView registerClass:[CollectviewChooseCell class] forCellWithReuseIdentifier:CellId];
    _MyCollectView.showsVerticalScrollIndicator = NO;
    _MyCollectView.scrollEnabled = YES;
    _MyCollectView.delegate = self;
    _MyCollectView.dataSource = self;
    [self addSubview:_MyCollectView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/3,ItemHeight);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdetify = CellId;
    CollectviewChooseCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdetify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLab.text = [_dataArr objectAtIndex:indexPath.row];
//    if (_ifAllSelecteSwitch) {
//        [cell UpdateCellWithState:_ifAllSelected];
//        if (indexPath.row == _dataArr.count-1) {
//            _ifAllSelecteSwitch  = NO;
//        }
//    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentSelectIndex!=nil&&_currentSelectIndex != indexPath) {
        CollectviewChooseCell * cell = (CollectviewChooseCell *)[collectionView cellForItemAtIndexPath:_currentSelectIndex];
        [cell UpdateCellWithState:NO];
    }
    CollectviewChooseCell * cell = (CollectviewChooseCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell UpdateCellWithState:!cell.isSelected];
    _currentSelectIndex = indexPath;

    _block(cell.titleLab.text,indexPath);
}

-(void)ReloadData{
    [self.MyCollectView reloadData];
}

@end
