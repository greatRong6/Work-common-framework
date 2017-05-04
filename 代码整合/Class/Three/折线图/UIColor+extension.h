//
//  UIColor+extension.h
//  IOS框架
//
//  Created by wangyu on 16/1/14.
//  Copyright © 2016年 wangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (extension)
+ (UIColor *)colorWithHexString:(NSString *)color;
//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (NSString *) hexFromUIColor: (UIColor*) color;

@end
