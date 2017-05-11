//
//  AnimatedTransition+SystemAnimated.m
//  HSTransition
//
//  Created by huangshan on 2017/5/9.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "AnimatedTransition+SystemAnimated.h"

@implementation AnimatedTransition (SystemAnimated)

- (void)system_displayAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //得到from视图和to视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //from视图和to视图的截图
    UIView *fromTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:fromVC.view]];
    UIView *toTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:toVC.view]];
    
    UIView *containerView = [transitionContext containerView];
    fromVC.view.hidden = YES;
    toVC.view.hidden = YES;
    
    [containerView addSubview:toVC.view];
    
    [containerView addSubview:fromTempView];
    [containerView addSubview:toTempView];
    
    CATransition *tranAnimation = [self getSystemTransitionWithType:self.transitionModel.animationType];
    [containerView.layer addAnimation:tranAnimation forKey:nil];
    
    
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            
            //过渡取消
            [transitionContext completeTransition:NO];
            
            fromVC.view.hidden = NO;
            [toVC.view removeFromSuperview];
            
        } else{
            
            //过渡完成
            [transitionContext completeTransition:YES];
            
            fromVC.view.hidden = NO;
            toVC.view.hidden = NO;
        }
        
        [fromTempView removeFromSuperview];
        [toTempView removeFromSuperview];
    };
}


- (void)system_backAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //得到from视图和to视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //from视图和to视图的截图
    UIView *fromTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:fromVC.view]];
    UIView *toTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:toVC.view]];
    
    UIView *containerView = [transitionContext containerView];
    
    fromVC.view.hidden = YES;
    toVC.view.hidden = YES;
    [containerView addSubview:toVC.view];
    
    [containerView addSubview:fromTempView];
    [containerView addSubview:toTempView];
    
    CATransition *tranAnimation = [self getSystemTransitionWithType:self.transitionModel.animationType];
    [containerView.layer addAnimation:tranAnimation forKey:nil];
    
    
    //动画完成block
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            
            //过渡取消
            [transitionContext completeTransition:NO];
            
            fromVC.view.hidden = NO;
            
            [toVC.view removeFromSuperview];
            toVC.view.hidden = NO;
            
        } else{
            
            //过渡完成
            [transitionContext completeTransition:YES];
            
            fromVC.view.hidden = NO;
            toVC.view.hidden = NO;
        }
        
        [fromTempView removeFromSuperview];
        [toTempView removeFromSuperview];
    };
    
    
    //动画交互将要完成block
    self.willEndInteractiveBlock = ^(BOOL success) {
        
        if (success) {
            
            toVC.view.hidden = NO;
            
        }else{
            
            toVC.view.hidden = YES;
        }
    };
    
}

- (CATransition *)getSystemTransitionWithType:(HSTransitionAnimationType)type {
    
    CATransition *tranAnimation = [CATransition animation];
    tranAnimation.duration= self.transitionModel.animationTime;
    tranAnimation.delegate = self;
    
    switch (type) {
        case HSTransitionAnimationTypeSystemFadeTop:{
            tranAnimation.type=kCATransitionFade;
            tranAnimation.subtype=kCATransitionFromTop;
        }
            break;
        case HSTransitionAnimationTypeSystemFadeRight:{
            tranAnimation.type = kCATransitionFade;
            tranAnimation.subtype=kCATransitionFromRight;
        }
            break;
        case HSTransitionAnimationTypeSystemFadeLeft:{
            tranAnimation.type = kCATransitionFade;
            tranAnimation.subtype=kCATransitionFromLeft;
        }
            break;
        case HSTransitionAnimationTypeSystemFadeBottom:{
            tranAnimation.type = kCATransitionFade;
            tranAnimation.subtype=kCATransitionFromBottom;
        }
            break;
        default:
            break;
    }
    return tranAnimation;
    
    
}


@end
