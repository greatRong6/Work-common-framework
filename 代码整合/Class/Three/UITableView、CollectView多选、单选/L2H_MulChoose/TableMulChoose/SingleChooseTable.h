//
//  SingleChooseTableView.h
//  MulChooseDemo
//
//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChooseBlock) (NSString *chooseContent,NSIndexPath *indexPath);

@interface SingleChooseTable : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * MyTable;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSIndexPath * currentSelectIndex;
@property(nonatomic,copy)ChooseBlock block;
+(SingleChooseTable *)ShareTableWithFrame:(CGRect)frame;
-(void)ReloadData;
@end
