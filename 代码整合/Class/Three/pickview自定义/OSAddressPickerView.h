//
//  OSAddressPickerView.h
//  AddressPicker
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 筒子家族. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^AdressBlock)(NSString *province, NSString *city, NSString *district);

@interface OSAddressPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic,copy) AdressBlock block;

+ (id)shareInstance;
- (void)showBottomView;

@end
