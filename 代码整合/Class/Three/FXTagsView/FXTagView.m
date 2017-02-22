//
//  FXTagsView.m
//  TagManager
//
//  Created by ftxbird on 15/11/27.
//  Copyright © 2015年 ftxbird. All rights reserved.
//

#import "FXTagView.h"
#import "FXTagTextField.h"

/**根据项目需要,此处做调整*/
CGFloat     const columnSpace       = 8;   //列间距
CGFloat     const rowSpace          = 8;   //行间距
CGFloat     const rowHeight         = 30;  //行高
CGFloat     const inputViewWidth    = 100; //输入框宽度
CGFloat     const tagMinWidth       = 60;  //标签最小宽度
NSInteger   const limitTagCount     = 20;  //标签数量限制
NSInteger   const limitTagWordCount = 50;  //单标签文本字数限制
NSUInteger  const FXInitialTag      = 1000;// Tag起始值

@interface FXTagView ()<UITextFieldDelegate, keyInputTextFieldDelegate>

/**缓存TagsButton*/
@property(nonatomic, strong) NSArray *tagButtonPool;

/**单击删除按钮*/
@property(nonatomic, strong) UIButton *tagDeleteButton;

/**用户回退删除是否打开*/
@property(nonatomic, strong) UIButton *backDeleteButton;

@property(nonatomic, strong) UIButton *lastSingleSelectButton;
@end

@implementation FXTagView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIMenuControllerWillShowMenuNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIMenuControllerDidHideMenuNotification
     object:nil];
}

- (void)commonInit {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(WillShowMenu:)
     name:UIMenuControllerWillShowMenuNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(HideMenu:)
     name:UIMenuControllerDidHideMenuNotification
     object:nil];
    
    _tagFont = [UIFont systemFontOfSize:14.0f];
    
    _tagNormalColor = UIColorFromRGB(0x3F3F3F);
    _tagSeletedColor = UIColorFromRGB(0x0FA2F9);
    _limitRowNum = 4;
    _tagBackgroundColor = [UIColor whiteColor];
    _tagsArray = [NSMutableArray array];
    
    self.layer.borderColor = UIColorFromRGB(0xdcdcdc).CGColor;
    self.layer.borderWidth = k1PX;
    
    self.backgroundColor = _tagBackgroundColor;
}

- (void)setShowType:(ShowViewType)showType {
    _showType = showType;
    
    if (showType == ShowViewTypeEdit) {
        //初始化缓存池
        [self initReusableButtonPool];
    }
}

/**
 *  初始化缓存池
 */
- (void)initReusableButtonPool {
    if (self.tagButtonPool.count) {
        return;
    }
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < limitTagCount; i++) {
        UIButton *tagBtn = [self creatButtonTitle:nil type:ShowViewTypeEdit];
        [tempArray addObject:tagBtn];
    }
    self.tagButtonPool = [tempArray copy];
}

- (UIButton *)creatButtonTitle:(NSString *)title type:(ShowViewType)type {
    UIButton *tagBtn = [UIButton new];
    [tagBtn.titleLabel setFont:_tagFont];
    tagBtn.layer.cornerRadius = ceil(rowHeight / 2);
    [self configColorTag:tagBtn ShowType:type];
    tagBtn.layer.masksToBounds = YES;
    tagBtn.layer.borderWidth = k1PX;
    return tagBtn;
}

/**
 *  获取缓存中的TagButton
 *
 *  @return Button
 */
- (UIButton *)dequeueReusableTagButton:(NSInteger)tag {
    if (self.tagButtonPool.count <= 0) return nil;
    UIButton *button = [self.tagButtonPool objectAtIndex:tag];
    return button;
}

- (void)configColorTag:(UIButton *)tag ShowType:(ShowViewType)type {
    if (type == ShowViewTypeNormal) {
        tag.backgroundColor = _tagBackgroundColor;
        tag.layer.borderColor = _tagNormalColor.CGColor;
        [tag setTitleColor:_tagNormalColor forState:UIControlStateNormal];
        
    } else if (type == ShowViewTypeEdit) {
        if (tag.selected) {
            [tag setBackgroundColor:_tagSeletedColor];
            [tag setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tag.layer.borderColor = [UIColor whiteColor].CGColor;
            
        } else {
            [tag setBackgroundColor:_tagBackgroundColor];
            [tag setTitleColor:_tagSeletedColor forState:UIControlStateNormal];
            tag.layer.borderColor = _tagSeletedColor.CGColor;
        }
    } else if (type == ShowViewTypeMultiSelect ||
               type == ShowViewTypeSingeleSelect) {
        tag.selected = !tag.selected;
        if (tag.selected) {
            tag.layer.borderColor = _tagSeletedColor.CGColor;
            [tag setTitleColor:_tagSeletedColor forState:UIControlStateNormal];
            tag.backgroundColor = _tagBackgroundColor;
            
            if ([self.tagDelegate
                 respondsToSelector:@selector(tagDidSelectText:tagView:)]) {
                [self.tagDelegate tagDidSelectText:tag.currentTitle tagView:self];
            }
        } else {
            tag.backgroundColor = self.backgroundColor;
            tag.layer.borderColor = _tagNormalColor.CGColor;
            [tag setTitleColor:_tagNormalColor forState:UIControlStateNormal];
            if ([self.tagDelegate
                 respondsToSelector:@selector(tagUnSelectText:tagView:)]) {
                [self.tagDelegate tagUnSelectText:tag.currentTitle tagView:self];
            }
        }
    }
}

/**
 *  点击标签,弹出删除菜单
 *
 *  @param sender 所点击的标签
 */
- (void)tagButtonSelected:(UIButton *)sender {
    if (self.showType == ShowViewTypeNormal) return;
    
    if (self.showType == ShowViewTypeEdit) {
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        if (sender.selected) {
            [self configColorTag:sender ShowType:ShowViewTypeEdit];
            sender.selected = NO;
            [menu setMenuVisible:NO animated:YES];
        } else {
            [menu setMenuVisible:NO];
            [self configColorTag:_tagDeleteButton ShowType:ShowViewTypeEdit];
            _tagDeleteButton.selected = NO;
            _tagDeleteButton = sender;
            [menu setTargetRect:sender.frame inView:_containerScrollerView];
            [menu setMenuVisible:YES animated:YES];
        }
    } else if (self.showType == ShowViewTypeMultiSelect) {
        [self configColorTag:sender ShowType:ShowViewTypeMultiSelect];
        
    } else if (self.showType == ShowViewTypeSingeleSelect) {
        [self configColorTag:_lastSingleSelectButton
                    ShowType:ShowViewTypeSingeleSelect];
        
        [self configColorTag:sender ShowType:ShowViewTypeSingeleSelect];
        
        self.lastSingleSelectButton = sender;
    }
}

/**
 *  添加一个Tag   ***此处可优化为不用整个遍历创建
 *
 *  @param tagString 待添加Tag文本
 */
- (void)addTag:(NSString *)tagString {
    tagString = [tagString
                 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (tagString.length == 0) {
        NSLog(@"不能输入空白标签!");
        return;
    }
    
    if (tagString.length > limitTagWordCount) {
        NSLog(@"最多10个字!");
        return;
    }
    
    for (NSString *title in self.tagsArray) {
        if ([tagString isEqualToString:title]) {
            NSLog(@"已存在相同标签!");
            return;
        }
    }
    
    if (self.tagsArray.count == limitTagCount) {
        NSLog(@"超过标签数量限制,当前限制15个");
        return;
    }
    
    [self.tagsArray addObject:tagString];
    
    [self layoutTagViews];
    
    if ([self.tagDelegate
         respondsToSelector:@selector(heightDidChangedTagView:height:)]) {
        [self.tagDelegate heightDidChangedTagView:self
                                           height:self.frame.size.height];
    }
}

/**
 *  添加一个数组字符串
 *
 *  @param tags 待添加字符串数组
 */
- (void)addTags:(NSArray *)tags {
    if (!tags || !tags.count) return;
    
    for (NSString *tag in tags) {
        NSArray *result =
        [_tagsArray filteredArrayUsingPredicate:
         [NSPredicate predicateWithFormat:@"SELF == %@", tag]];
        if (result.count == 0) {
            [_tagsArray addObject:tag];
        }
    }
    
    [self layoutTagViews];
    
    if ([self.tagDelegate
         respondsToSelector:@selector(heightDidChangedTagView:height:)]) {
        [self.tagDelegate heightDidChangedTagView:self
                                           height:self.frame.size.height];
    }
}

/**
 *  改变指定字符串 的控件选择状态
 *
 *  @param tagString 待改变状态控件的文本
 */
- (void)changeTagStateSpecialTag:(NSString *)tagString {
    NSInteger foundedIndex = [self findTagIndexByTagStr:tagString];
    
    if (foundedIndex == -1) return;
    
    UIButton *sender =
    [self.containerScrollerView viewWithTag:foundedIndex + FXInitialTag];
    
    if (self.showType == ShowViewTypeSingeleSelect) {
        [self configColorTag:_lastSingleSelectButton
                    ShowType:ShowViewTypeSingeleSelect];
        [self configColorTag:sender ShowType:ShowViewTypeSingeleSelect];
        self.lastSingleSelectButton = sender;
    } else {
        [self configColorTag:sender ShowType:ShowViewTypeSingeleSelect];
    }
}

/**
 *  搜索指定文本所在 索引
 *
 *  @param tagString 搜索字符串
 *
 *  @return -1: 未找到 0-N: 寻找到
 */
- (NSInteger)findTagIndexByTagStr:(NSString *)tagString {
    NSInteger foundedIndex = -1;
    for (NSString *tempTagString in self.tagsArray) {
        if ([tagString isEqualToString:tempTagString]) {
            foundedIndex = (NSInteger)[self.tagsArray indexOfObject:tempTagString];
            break;
        }
    }
    return foundedIndex;
}

/**
 *  移除一个Tag
 *
 *  @param tagString 待移除Tag文本
 */
- (void)removeTag:(NSString *)tagString {
    NSInteger foundIndex = [self findTagIndexByTagStr:tagString];
    
    if ([self findTagIndexByTagStr:tagString] == -1) {
        return;
    }
    [self.tagsArray removeObjectAtIndex:foundIndex];
    
    [self layoutTagViews];
    
    if ([self.tagDelegate
         respondsToSelector:@selector(heightDidChangedTagView:height:)]) {
        [self.tagDelegate heightDidChangedTagView:self
                                           height:self.frame.size.height];
    }
}

/**
 *  判断是否需要换行
 *
 *  @param currentX 当前移动X点
 *  @param btnWidth 当前要添加的宽度
 *
 *  @return Bool 是否需要换行
 */
- (BOOL)ifNeedAddRowCurrentX:(CGFloat)currentX width:(CGFloat)btnWidth {
    //当前剩余宽度
    CGFloat restSpace = self.frame.size.width - currentX - columnSpace;
    
    //判断待加入按钮是否大于剩余宽度
    return (btnWidth > restSpace);
}

- (void)layoutTagViews {
    //子控件从视图移除
    for (UIView *view in self.containerScrollerView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    //设置tagsArray,创建添加tag控件,并设置Frame
    //设置起点XY
    CGFloat moveX = columnSpace;
    CGFloat moveY = rowSpace;
    
    for (NSInteger i = 0; i < self.tagsArray.count; i++) {
        NSString *tagText = (NSString *)[self.tagsArray objectAtIndex:i];
        UIButton *tagBtn = [self tagButtonWithTag:tagText index:i];
        CGFloat btnWidth =
        [tagBtn.titleLabel.text
         sizeWithAttributes:@{NSFontAttributeName : _tagFont}]
        .width +
        20.0f;
        if (btnWidth < tagMinWidth) {
            btnWidth = tagMinWidth;
        }
        //特殊需求,强制开启 列等分
        if (_limitColumnNum) {
            btnWidth = (self.frame.size.width - (_limitColumnNum+1) * columnSpace) / _limitColumnNum;
        }
        
        if ([self ifNeedAddRowCurrentX:moveX width:btnWidth]) {
            moveX = columnSpace;
            moveY += (rowHeight + rowSpace);
        }
        tagBtn.frame = CGRectMake(moveX, moveY, btnWidth, rowHeight);
        moveX += btnWidth + columnSpace;
        [self.containerScrollerView addSubview:tagBtn];
    }
    
    //更新 输入框 Frame
    if (self.showType == ShowViewTypeEdit) {
        BOOL addRowForTextField =
        [self ifNeedAddRowCurrentX:moveX
                             width:20.0f];
        if (addRowForTextField) {
            moveX = columnSpace;
            moveY += (rowHeight + rowSpace);
        }
        self.inputTextField.frame =
        CGRectMake(moveX, moveY, inputViewWidth, rowHeight);
    }
    
    [self updateContainerStartAtX:moveX Y:moveY];
    
}


- (void)updateContainerStartAtX:(CGFloat)moveX  Y:(CGFloat)moveY {

    CGRect tempFrame = self.frame;
    //更新主Frame 和滚动视图
    if (moveY <= (_limitRowNum *(rowHeight +rowSpace))) {
        if (self.containerScrollerView.contentSize.height > moveY) {
            CGSize tempSize = self.containerScrollerView.contentSize;
            tempSize.height = moveY;
            self.containerScrollerView.contentSize = tempSize;
        }
        tempFrame.size.height = moveY + rowHeight + columnSpace;
        self.frame = tempFrame;
        self.containerScrollerView.frame = self.bounds;
    } else {
        tempFrame.size.height = _limitRowNum * rowHeight + (_limitRowNum+1) * rowSpace;
        self.frame = tempFrame;
        self.containerScrollerView.frame = self.bounds;
        self.containerScrollerView.contentSize =
        CGSizeMake(tempFrame.size.width, moveY + rowHeight + 2 * columnSpace);
        
        [self.containerScrollerView
         setContentOffset:CGPointMake(
                                      0, _containerScrollerView.contentSize.height -
                                      _containerScrollerView.frame.size.height -
                                      rowSpace)
         animated:YES];
    }
}


- (void)layoutSubviews {
    //初始化滚动容器
    if (_containerScrollerView == nil) {
        [self containerScrollerView];
    }
    
    if (_showType == ShowViewTypeEdit && !_inputTextField) {
        [self inputTextField];
    }
    [super layoutSubviews];
}

- (UIButton *)tagButtonWithTag:(NSString *)tagTitle index:(NSInteger)index {
    UIButton *tagBtn;
    if (self.showType == ShowViewTypeEdit) {
        tagBtn = [self dequeueReusableTagButton:index];
    } else {
        tagBtn = [self creatButtonTitle:tagTitle type:ShowViewTypeNormal];
        tagBtn.tag = index + FXInitialTag;
    }
    [tagBtn setTitle:tagTitle forState:UIControlStateNormal];
    //选择模式添加 点击事件
    if (self.showType != ShowViewTypeNormal) {
        [tagBtn addTarget:self
                   action:@selector(tagButtonSelected:)
         forControlEvents:UIControlEventTouchUpInside];
    }
    return tagBtn;
}

- (UIScrollView *)containerScrollerView {
    if (_containerScrollerView == nil) {
        UIScrollView *container = [[UIScrollView alloc] initWithFrame:self.bounds];
        container.contentSize = CGSizeMake(self.frame.size.width, rowHeight);
        container.autoresizingMask =
        UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        container.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        container.showsVerticalScrollIndicator = YES;
        container.showsHorizontalScrollIndicator = NO;
        [self addSubview:container];
        
        if (self.showType == ShowViewTypeEdit) {
            UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector
                                                            (handlerTapGesture:)];
            tapGestureRecognizer.numberOfTapsRequired=1;
            [self addGestureRecognizer:tapGestureRecognizer];
        }
        
        _containerScrollerView = container;
    }
    return _containerScrollerView;
}


- (void)handlerTapGesture:(UIPanGestureRecognizer *)recognizer {
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    if (_showType == ShowViewTypeEdit) {
        
        [self.inputTextField becomeFirstResponder];
        
    }
}

- (FXTagTextField *)inputTextField {
    if (_inputTextField == nil) {
        FXTagTextField *inputField = [[FXTagTextField alloc]
                                      initWithFrame:CGRectMake(columnSpace, rowSpace, inputViewWidth,
                                                               rowHeight)];
        inputField.backgroundColor = [UIColor whiteColor];
        inputField.font = _tagFont;
        inputField.textColor = _tagNormalColor;
        inputField.autocorrectionType = UITextAutocorrectionTypeNo;
        [inputField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
        inputField.delegate = self;
        inputField.keyInputDelegate = self;
        inputField.placeholder = @"输入标签";
        inputField.returnKeyType = UIReturnKeyDone;
        _inputTextField = inputField;
        [self.containerScrollerView addSubview:_inputTextField];
    }
    return _inputTextField;
}

#pragma dataCheck

#pragma textField delegate

- (void)deleteBackward {
    if (self.inputTextField.text.length > 0) return;
    if (self.tagsArray.count <= 0) return;
    
    UIButton *lastButton =
    [self.tagButtonPool objectAtIndex:(self.tagsArray.count - 1)];
    if (lastButton.selected) {
        lastButton.selected = NO;
        [self configColorTag:lastButton ShowType:ShowViewTypeEdit];
        [self removeTag:lastButton.currentTitle];
        self.backDeleteButton = nil;
        
        if ([self.tagDelegate
             respondsToSelector:@selector(tagDeletedText:tagView:)]) {
            if (self.showType == ShowViewTypeEdit) {
                [self.tagDelegate tagDeletedText:lastButton.currentTitle tagView:self];
            }
        }
    } else {
        lastButton.selected = YES;
        [self configColorTag:lastButton ShowType:ShowViewTypeEdit];
        
        self.backDeleteButton = lastButton;
    }
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
    
    
  
    
    
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.limitChar) {
        NSString *regex = @"^[\u4E00-\u9FA5A-Za-z0-9_]+$";
        NSPredicate *pred =
        [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:textField.text];
        if (!isMatch) {
            return NO;
        }
    }
    
    [self addTag:textField.text];
    _inputTextField.text = nil;
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing");
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textFieldDidEndEditing");
}

- (void)textFieldDidChange:(FXTagTextField *)textField {
    NSLog(@"textFieldDidChange");
    if (self.backDeleteButton &&self.tagsArray.count){
        self.backDeleteButton.selected = NO;
        [self configColorTag:self.backDeleteButton ShowType:ShowViewTypeEdit];
        self.backDeleteButton = nil;
    }
    
    //新输入框 宽度 (最小值)
    CGFloat newWidth =  MAX( 70, [textField.text sizeWithAttributes:@{NSFontAttributeName:_tagFont}].width + 30.0f);
    
    CGRect inputRect = _inputTextField.frame;
    
    BOOL addRowForTextField = (inputRect.origin.x +newWidth) >= self.frame.size.width;

    if (addRowForTextField) {
        self.inputTextField.frame =
        CGRectMake(columnSpace, (inputRect.origin.y +rowHeight + rowSpace ), newWidth, rowHeight);
        
        [self updateContainerStartAtX:columnSpace Y:(inputRect.origin.y +2*rowHeight + rowSpace )];
        
        if ([self.tagDelegate
             respondsToSelector:@selector(heightDidChangedTagView:height:)]) {
            [self.tagDelegate heightDidChangedTagView:self
                                               height:self.frame.size.height];
        }
    }else {
       self.inputTextField.frame = CGRectMake(inputRect.origin.x,inputRect.origin.y , newWidth, rowHeight);
    }
    
    
   
    
}

#pragma mark - Custom Menu

- (void)HideMenu:(NSNotification *)notification {
    _tagDeleteButton.selected = NO;
    [self configColorTag:_tagDeleteButton ShowType:ShowViewTypeEdit];
    _tagDeleteButton = nil;
}
- (void)WillShowMenu:(NSNotification *)notification {
    _tagDeleteButton.selected = YES;
    [self configColorTag:_tagDeleteButton ShowType:ShowViewTypeEdit];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (_tagDeleteButton) {
        return action == @selector(delete:);
    }
    return NO;
}

- (void) delete:(id)sender {
    NSString *tempStr = _tagDeleteButton.currentTitle;
    
    [self removeTag:tempStr];
    
    if ([self.tagDelegate
         respondsToSelector:@selector(tagDeletedText:tagView:)]) {
        [self.tagDelegate tagDeletedText:tempStr tagView:self];
    }
}

@end
