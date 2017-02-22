//
//  PortalAnimation.h
//  界面切换
//
//  Created by Seegroup_dev on 16/5/27.
//  Copyright © 2016年 Seegroup_dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PortalAnimation : NSObject<UIViewControllerAnimatedTransitioning>

//开门 YES 或者 关门 NO
@property (nonatomic,assign) BOOL isPortal;


@end
