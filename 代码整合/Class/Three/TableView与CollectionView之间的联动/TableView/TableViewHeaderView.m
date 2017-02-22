//
//  TableViewHeaderView.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "TableViewHeaderView.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation TableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = rgba(240, 240, 240, 0.8);
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 20)];
        self.name.font = [UIFont systemFontOfSize:13];
        [self addSubview:self.name];
    }
    return self;
}

@end
