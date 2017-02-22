#import <UIKit/UIKit.h>

@interface SYChineseToPinyin : NSObject

+ (NSString *)pinyinFromChiniseString:(NSString *)string;
+ (char)sortSectionTitle:(NSString *)string;

/**
 获取汉字首字母

 @param hanzi 汉字
 @return 汉字首字母(小写)
 */
char pinyinFirstLetter(unsigned short hanzi);

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

// ShenYang 整理修改版本

@interface SYPinyinSort : NSObject

@property (nonatomic, copy) NSArray *chineses;
@property (nonatomic, copy, readonly) NSArray *originalChineses;
@property (nonatomic, copy, readonly) NSArray *formatChineses;
@property (nonatomic, copy, readonly) NSArray *indexArray;
@property (nonatomic, copy, readonly) NSDictionary *cityDicts;


+ (instancetype)defaultPinyinSort;

+ (NSArray *)sortWithChineses:(NSArray *)chineses;
+ (NSDictionary *)dictWithChineses:(NSArray *)chineses;

@end
