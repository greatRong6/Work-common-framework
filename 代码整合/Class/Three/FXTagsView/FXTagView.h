//
//  FXTagsView.h
//  TagManager
//
//  Created by ftxbird on 15/11/27.
//  Copyright © 2015年 ftxbird. All rights reserved.
//


#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define k1PX (1.0 / [UIScreen mainScreen].scale)

@class FXTagTextField;
@class FXTagView;


@protocol FXTagViewDelegate<NSObject>

@optional
/**
 *  Tags容器 高度改变回调
 *
 *  @param tagView 所在容器
 *  @param height  容器最终高度
 */
-(void)heightDidChangedTagView:(FXTagView*)tagView height:(CGFloat)height;

/**
 *  选择显示模式下,单击点击选择的Tag文本
 *  @param tagView 所在容器
 *  @param text 选择的文本
 */
- (void)tagDidSelectText:(NSString *)text tagView:(FXTagView *)tagView;

/**
 *  选择显示模式下,取消选择的Tag文本
 *  @param tagView 所在容器
 *  @param text 选择的文本
 */
- (void)tagUnSelectText:(NSString *)text tagView:(FXTagView *)tagView;


/**
 *  标签点击删除回调
 *
 *  @param text    删除的文本
 *  @param tagView 所在容器
 */
- (void)tagDeletedText:(NSString *)text tagView:(FXTagView *)tagView;




@end

/**
 *  控件展示类型
 */
typedef NS_ENUM(NSInteger, ShowViewType) {
    /**
     *  纯展示,无交互功能
     */
    ShowViewTypeNormal = 0,
    /**
     *  展示 + 编辑
     */
    ShowViewTypeEdit,
    /**
     *  展示 + 多选择
     */
    ShowViewTypeMultiSelect,
    /**
     *  展示 + 单选
     */
    ShowViewTypeSingeleSelect
};



@interface FXTagView : UIView

/**展示类型*/
@property (nonatomic,assign) ShowViewType showType;

/**标签数组*/
@property (nonatomic,strong) NSMutableArray *tagsArray;

/**文本输入控件*/
@property (nonatomic,strong) FXTagTextField *inputTextField;

/**代理*/
@property (nonatomic, weak)  id<FXTagViewDelegate>tagDelegate;


/**标签背景颜色*/
@property (nonatomic,strong) UIColor *tagBackgroundColor;

/**标签正常颜色*/
@property (nonatomic,strong) UIColor *tagNormalColor;

/**标签选择颜色*/
@property (nonatomic,strong) UIColor *tagSeletedColor;

/**标签字体大小*/
@property (nonatomic,strong) UIFont  *tagFont;

/**限时输入字符类型*/
@property (nonatomic,assign) BOOL limitChar;

/**限制 多少行 超出部分可滚动显示*/
@property (nonatomic,assign) NSInteger limitRowNum;

/**限制 多少列*/
@property (nonatomic,assign) NSInteger limitColumnNum;

@property (nonatomic,strong) UIScrollView *containerScrollerView;

/**
 *  添加一个Tag
 *
 *  @param tagString 待添加Tag文本
 */
- (void)addTag:(NSString *)tagString;

/**
 *  添加一个数组字符串
 *
 *  @param tags 待添加字符串数组
 */
- (void)addTags:(NSArray *)tags;

/**
 *  移除一个Tag
 *
 *  @param tagString 待移除Tag文本
 */
- (void)removeTag:(NSString *)tagString;


/**
 *  改变指定字符串 的控件选择状态
 *
 *  @param tagString 待改变状态控件的文本
 */
- (void)changeTagStateSpecialTag:(NSString *)tagString;


/**
 *  搜索指定文本所在 索引
 *
 *  @param tagString 搜索字符串
 *
 *  @return -1: 未找到 0-N: 寻找到
 */
- (NSInteger)findTagIndexByTagStr:(NSString *)tagString;
@end
