//
//  ButtonCell.m
//  代码整合
//
//  Created by greatRong on 2017/1/2.
//  Copyright © 2017年 greatRong. All rights reserved.
//

#import "ButtonCell.h"
#import "QQButton.h"

@implementation ButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        QQButton *btn = [QQButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 10, 30, 30);
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
    }
    
    return self;
}

-(void)btnClick{




}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
