//  Created by L2H on 16/7/13.
//  Copyright © 2016年 ailk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectviewChooseCell : UICollectionViewCell
@property(nonatomic,retain)UILabel * titleLab;
@property(nonatomic,retain)UIButton * SelectIconBtn;
@property (nonatomic,assign)BOOL isSelected;
-(void)UpdateCellWithState:(BOOL)select;
@end
