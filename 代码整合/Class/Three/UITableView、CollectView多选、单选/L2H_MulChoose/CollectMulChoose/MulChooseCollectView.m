//
//  ChooseCollectView.m
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import "MulChooseCollectView.h"
#import "CollectviewChooseCell.h"
#import "HeaderView.h"
#define ItemHeight 70
#define HeaderHeight 50
static NSString *CellId = @"CellId";
static NSString *HeaderId = @"HeaderId";


@implementation MulChooseCollectView{
    UICollectionReusableView *reusableview;
}


+(instancetype)ShareCollectviewWithFrame:(CGRect)frame HeaderTitle:(NSString *)title{
    MulChooseCollectView * collect = [[MulChooseCollectView alloc] initWithFrame:frame HaveHeader:YES HeaderTitle:title];
    return  collect;
}

-(instancetype)initWithFrame:(CGRect)frame HaveHeader:(BOOL)ifhHave HeaderTitle:(NSString *)title{
    self = [super init];
    if(self){
        self.frame = frame;
        [self CreateCollectView];
    }
    return self;
}


-(void)CreateCollectView{
    _choosedArr = [[NSMutableArray alloc]initWithCapacity:0];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;//列距
    flowLayout.minimumLineSpacing = 0;
    _MyCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 ,SCREEN_WIDTH, self.frame.size.height) collectionViewLayout:flowLayout];
    _MyCollectView.backgroundColor = ColorRGB(0xf7f7f7);
    [_MyCollectView registerClass:[CollectviewChooseCell class] forCellWithReuseIdentifier:CellId];
    [_MyCollectView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:HeaderId];
    _MyCollectView.showsVerticalScrollIndicator = NO;
    _MyCollectView.scrollEnabled = YES;
    _MyCollectView.delegate = self;
    _MyCollectView.dataSource = self;
    [self addSubview:_MyCollectView];
}


-(void)ChooseAllClick:(UIButton *)button{
    _ifAllSelecteSwitch = YES;
    UIButton * chooseIcon = (UIButton *)[reusableview viewWithTag:10];
    [chooseIcon setSelected:!_ifAllSelected];
    _ifAllSelected = !_ifAllSelected;
    if (_ifAllSelected) {
        [_choosedArr removeAllObjects];
        [_choosedArr addObjectsFromArray:_dataArr];
    }
    else{
        [_choosedArr removeAllObjects];
    }
    [_MyCollectView reloadData];
    _block(@"All",_choosedArr);
    
}

#pragma mark --CollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        if (reusableview==nil) {
            reusableview = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderId forIndexPath:indexPath];
            reusableview.backgroundColor = [UIColor whiteColor];
            UILabel * HeaderTitleLab = [[UILabel alloc]init];
            HeaderTitleLab.text = @"全选";
            [reusableview addSubview:HeaderTitleLab];
            [HeaderTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(reusableview.mas_left).offset(15);
                make.top.equalTo(reusableview.mas_top).offset(0);
                make.height.mas_equalTo(reusableview.mas_height);
            }];
            UIButton *chooseIcon = [UIButton buttonWithType:UIButtonTypeCustom];
            chooseIcon.tag = 10;
            [chooseIcon setImage:[UIImage imageNamed:@"table_UnSelect"] forState:UIControlStateNormal];
            [chooseIcon setImage:[UIImage imageNamed:@"table_Selected"] forState:UIControlStateSelected];
            chooseIcon.userInteractionEnabled = NO;
            [reusableview addSubview:chooseIcon];
            [chooseIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(HeaderTitleLab.mas_right).offset(10);
                make.right.equalTo(reusableview.mas_right).offset(-15);
                make.top.equalTo(reusableview.mas_top);
                make.height.mas_equalTo(reusableview.mas_height);
                make.width.mas_equalTo(50);
            }];
            
            UIButton * chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            chooseBtn.frame = CGRectMake(0, 0, reusableview.frame.size.width, reusableview.frame.size.height);
            [chooseBtn addTarget:self action:@selector(ChooseAllClick:) forControlEvents:UIControlEventTouchUpInside];
            [reusableview addSubview:chooseBtn];

        }
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, HeaderHeight);
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
    if (_ifAllSelecteSwitch) {
        [cell UpdateCellWithState:_ifAllSelected];
        if (indexPath.row == _dataArr.count-1) {
            _ifAllSelecteSwitch  = NO;
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectviewChooseCell * cell = (CollectviewChooseCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell UpdateCellWithState:!cell.isSelected];
    if (cell.isSelected) {
        [_choosedArr addObject:cell.titleLab.text];
    }
    else{
        [_choosedArr removeObject:cell.titleLab.text];
    }
    
    if (_choosedArr.count<_dataArr.count) {
        _ifAllSelected = NO;
        UIButton * chooseIcon = (UIButton *)[reusableview viewWithTag:10];
        chooseIcon.selected = _ifAllSelected;
    }
    _block(cell.titleLab.text,_choosedArr);
}

-(void)ReloadData{
    [self.MyCollectView reloadData];
}



@end
