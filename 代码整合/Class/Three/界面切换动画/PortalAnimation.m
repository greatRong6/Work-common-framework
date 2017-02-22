//
//  PortalAnimation.m
//  界面切换
//
//  Created by Seegroup_dev on 16/5/27.
//  Copyright © 2016年 Seegroup_dev. All rights reserved.
//

#import "PortalAnimation.h"

@implementation PortalAnimation

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //切出的ViewController
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //切入的ViewController
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    
    if (_isPortal) {
        [self executeForwardsAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }else{
        [self executeReverseAnimation:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }
}

#pragma mark - 动画时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 1;
    
}

//控制视图是否缩小
#define ZOOM_SCALE 0.8
- (void)executeForwardsAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    //VC切换所发生的view容器，开发者应该将切出的view移除，将切入的view加入到该view容器中。
    UIView *containerView = [transitionContext containerView];
    
    //截屏
    UIView *toViewSnapshot = [toView resizableSnapshotViewFromRect:toView.frame afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    //把切入的VC缩小到 0.8
    CATransform3D scale = CATransform3DIdentity;
    toViewSnapshot.layer.transform = CATransform3DScale(scale, ZOOM_SCALE, ZOOM_SCALE, 1);
    [containerView addSubview:toViewSnapshot];
    //把切入的VC放到 containerView 后面
    [containerView sendSubviewToBack:toViewSnapshot];
    
    //把切出的VC分成两部分
    //左边
    CGRect leftSnapshotRegion = CGRectMake(0, 0, fromView.frame.size.width / 2, fromView.frame.size.height);
    //截取屏幕的左边的一半
    UIView *leftHandView = [fromView resizableSnapshotViewFromRect:leftSnapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    leftHandView.frame = leftSnapshotRegion;
    [containerView addSubview:leftHandView];
    
    //右边
    CGRect rightSnapshotRegion = CGRectMake(fromView.frame.size.width / 2, 0, fromView.frame.size.width / 2, fromView.frame.size.height);
    //截取屏幕右边的一半
    UIView *rightHandView = [fromView resizableSnapshotViewFromRect:rightSnapshotRegion afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    rightHandView.frame = rightSnapshotRegion;
    [containerView addSubview:rightHandView];
    
    //删除截屏的试图(切出的VC)
    [fromView removeFromSuperview];

    //动画
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //开门动画
        leftHandView.frame = CGRectOffset(leftHandView.frame, -leftHandView.frame.size.width, 0);
        rightHandView.frame = CGRectOffset(rightHandView.frame, rightHandView.frame.size.width, 0);
        
//        toViewSnapshot.center = toView.center;
        toViewSnapshot.frame = toView.frame;
        
    } completion:^(BOOL finished) {
        
        //删除所有的临时视图
        if ([transitionContext transitionWasCancelled]) {
            [containerView addSubview:fromView];
            [self removeOtherViews:fromView];
        }else{
            [containerView addSubview:toView];
            [self removeOtherViews:toView];
//            toView.frame = containerView.bounds;
        }
        
        //通知上下文完成
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)executeReverseAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    UIView *continerView = [transitionContext containerView];
    
    toView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0);
    
    CGRect leftSnapshotRegion = CGRectMake(0, 0, toView.frame.size.width / 2, toView.frame.size.height);
    UIView *leftHandView = [toView resizableSnapshotViewFromRect:leftSnapshotRegion  afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    leftHandView.frame = leftSnapshotRegion;
    leftHandView.frame = CGRectOffset(leftHandView.frame, - leftHandView.frame.size.width, 0);
    [continerView addSubview:leftHandView];
    
    CGRect rightSnapshotRegion = CGRectMake(toView.frame.size.width / 2, 0, toView.frame.size.width / 2, toView.frame.size.height);
    UIView *rightHandView = [toView resizableSnapshotViewFromRect:rightSnapshotRegion  afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    rightHandView.frame = rightSnapshotRegion;
    rightHandView.frame = CGRectOffset(rightHandView.frame, rightHandView.frame.size.width, 0);
    [continerView addSubview:rightHandView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         leftHandView.frame = CGRectOffset(leftHandView.frame, leftHandView.frame.size.width, 0);
                         rightHandView.frame = CGRectOffset(rightHandView.frame, - rightHandView.frame.size.width, 0);
                         
                         CATransform3D scale = CATransform3DIdentity;
                         fromView.layer.transform = CATransform3DScale(scale, ZOOM_SCALE, ZOOM_SCALE, 1);
                         
                         
                     } completion:^(BOOL finished) {
                         
                         if ([transitionContext transitionWasCancelled]) {
                             
                             [continerView addSubview:fromView];
                             [self removeOtherViews:fromView];
                             
                         } else {
                             
                             [continerView addSubview:toView];
                             [self removeOtherViews:toView];
                             toView.frame = continerView.bounds;
                         }
          
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}



// 删除其他的所有试图
- (void)removeOtherViews:(UIView*)viewToKeep {
    UIView *containerView = viewToKeep.superview;
    for (UIView *view in containerView.subviews) {
        if (view != viewToKeep) {
            [view removeFromSuperview];
        }
    }
}


@end
