
//  Created by L2H on 16/7/13.


#import "CollectviewChooseCell.h"
#define SelectNum_ItemHeight 51
#define SelectNum_ItemWidth 77
#define ItemFont1 17
#define ItemFont2 16
//加油包订购——流量包cell展示

@implementation CollectviewChooseCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return  self;
}


-(void)initView{
    
    _SelectIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _SelectIconBtn.userInteractionEnabled = NO;
    [_SelectIconBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_SelectIconBtn setImage:[UIImage imageNamed:@"collectview_Unselect"] forState:UIControlStateNormal];
    [_SelectIconBtn setImage:[UIImage imageNamed:@"collectview_Selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:_SelectIconBtn];
    [_SelectIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    
    _titleLab = [[UILabel alloc]init];
    _titleLab.textColor = [UIColor darkTextColor];
    _titleLab.font = [UIFont systemFontOfSize:16];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

-(void)UpdateCellWithState:(BOOL)select{
    self.SelectIconBtn.selected = select;
    _isSelected = select;
}

//-(void)setData:(CommonItem *)titleItem selected:(BOOL)Selected{
//    NSString * titleStr1 = titleItem.Package_Mb;
//    NSString  * titleStr2 = titleItem.Package_Price;
//    _titleLab.text = [NSString stringWithFormat:@"%@M",titleStr1];
////    titleLab2.text = [NSString stringWithFormat:@"%@元",titleStr2];
//    if (Selected == YES) {
//        _titleLab.textColor = [UIColor blackColor];
////        titleLab2.textColor = [UIColor blackColor];
//        [_SelectIconBtn setSelected:Selected];
//        [_SelectIconBtn setBackgroundImage:[UIImage imageNamed:@"Package_selected"] forState:UIControlStateSelected];
//    }
//    else{
//        _titleLab.textColor = [UIColor lightGrayColor];
////        titleLab2.textColor = [UIColor lightGrayColor];
//        [_SelectIconBtn setSelected:Selected];
//        [_SelectIconBtn setBackgroundImage:[UIImage imageNamed:@"Package_normal"] forState:UIControlStateNormal];
//    }
//    
//}
//
//-(void)setData:(CommonItem *)titleItem index:(NSIndexPath *)indexPath{
//    [self setData:titleItem selected:YES];
//}

@end
