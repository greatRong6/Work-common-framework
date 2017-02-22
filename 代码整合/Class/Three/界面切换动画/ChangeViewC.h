//
//  ChangeViewC.h
//  代码整合
//
//  Created by greatRong on 2016/12/28.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainViewControllerDelegate <NSObject>

-(void)dismiss;

@end

@interface ChangeViewC : UIViewController

@property (nonatomic,weak) id<MainViewControllerDelegate>delegate;

@end
