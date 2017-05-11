//
//  AnimatedTransition+CustomAnimated.m
//  HSTransition
//
//  Created by huangshan on 2017/5/9.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "AnimatedTransition+CustomAnimated.h"

@implementation AnimatedTransition (CustomAnimated)


#pragma mark - Cover

- (void)cover_displayAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //得到from视图和to视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //from视图和to视图的截图
    UIView *fromTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:fromVC.view]];
    UIView *toTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:toVC.view]];
    
    //隐藏视图
    fromVC.view.hidden = YES;
    toVC.view.hidden = YES;
    
    //添加截图和视图
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromTempView];
    [containerView addSubview:toTempView];
    
    /** 动画变换 */
    toTempView.layer.transform = CATransform3DMakeScale(4, 4, 1);
    toTempView.alpha = 0.1;
    
    [UIView animateWithDuration:self.transitionModel.animationTime animations:^{
        
        toTempView.layer.transform = CATransform3DIdentity;
        toTempView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {
            
            [transitionContext completeTransition:NO];
            
            fromVC.view.hidden = NO;
            
            [toVC.view removeFromSuperview];
            toVC.view.hidden = NO;
            
        }else{
            
            [transitionContext completeTransition:YES];
            
            fromVC.view.hidden = NO;
            toVC.view.hidden = NO;
            
        }
        
        //隐藏视图
        [fromTempView removeFromSuperview];
        [toTempView removeFromSuperview];
        
    }];
}



- (void)cover_backAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //得到from视图和to视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //from视图和to视图的截图
    UIView *fromTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:fromVC.view]];
    UIView *toTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:toVC.view]];
    
    //隐藏视图
    fromVC.view.hidden = YES;
    toVC.view.hidden = YES;
    
    //添加截图和视图
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromTempView];
    [containerView addSubview:toTempView];
    
    
    /** 动画变换 */
    fromTempView.alpha = 1.0f;
    toTempView.alpha = 0.0f;
    
    [UIView animateWithDuration:self.transitionModel.animationTime animations:^{
        
        toTempView.layer.transform = CATransform3DMakeScale(4, 4, 1);
        fromTempView.alpha = 0.0f;
        toTempView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {
            
            [transitionContext completeTransition:NO];
            
            fromVC.view.hidden = NO;
            
            [toVC.view removeFromSuperview];
            toVC.view.hidden = NO;
            
        }else{
            
            [transitionContext completeTransition:YES];
            
            fromVC.view.hidden = NO;
            toVC.view.hidden = NO;
        }
        
        //移除视图
        [fromTempView removeFromSuperview];
        [toTempView removeFromSuperview];
    }];
    
    self.willEndInteractiveBlock = ^(BOOL success) {
        if (success) {
            toVC.view.hidden = NO;
        }else{
            toVC.view.hidden = YES;
        }
    };
    
}

#pragma mark - Spread

- (void)spread_displayAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //得到from视图和to视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //from视图和to视图的截图
    UIView *fromTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:fromVC.view]];
    UIView *toTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:toVC.view]];
    
    //隐藏视图
    fromVC.view.hidden = YES;
    toVC.view.hidden = YES;
    
    //添加截图和视图
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromTempView];
    [containerView addSubview:toTempView];
    
    /** 动画变换 */
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGRect rect0 ;
    CGRect rect1 = CGRectMake(0, 0, screenWidth, screenHeight);
    
    switch (self.transitionModel.animationType) {
        case HSTransitionAnimationTypeSpreadRight:
            rect0 = CGRectMake(screenWidth, 0, 2, screenHeight);
            break;
        case HSTransitionAnimationTypeSpreadLeft:
            rect0 = CGRectMake(0, 0, 2, screenHeight);
            break;
        case HSTransitionAnimationTypeSpreadTop:
            rect0 = CGRectMake(0, 0, screenWidth, 2);
            break;
        default:
            rect0 = CGRectMake(0, screenHeight , screenWidth, 2);
            break;
    }
    
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRect:rect0];
    UIBezierPath *endPath =[UIBezierPath bezierPathWithRect:rect1];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath; //动画结束后的值
    toTempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = self.transitionModel.animationTime;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"NextPath"];
    
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            
            [transitionContext completeTransition:NO];
            
            fromVC.view.hidden = NO;
            
            [toVC.view removeFromSuperview];
            toVC.view.hidden = NO;
            
        }else{
            
            [transitionContext completeTransition:YES];
            
            fromVC.view.hidden = NO;
            toVC.view.hidden = NO;
            
        }
        
        //隐藏视图
        [fromTempView removeFromSuperview];
        [toTempView removeFromSuperview];
    };
}

- (void)spread_backAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //得到from视图和to视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //from视图和to视图的截图
    UIView *fromTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:fromVC.view]];
    UIView *toTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:toVC.view]];
    
    //隐藏视图
    fromVC.view.hidden = YES;
    toVC.view.hidden = YES;
    
    //添加截图和视图
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromTempView];
    [containerView addSubview:toTempView];
    
    
    /** 动画变换 */
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGRect rect0 ;
    CGRect rect1 = CGRectMake(0, 0, screenWidth, screenHeight);
    
    
    switch (self.transitionModel.animationType) {
        case HSTransitionAnimationTypeSpreadRight:
            rect0 = CGRectMake(0, 0, 0, screenHeight);
            break;
        case HSTransitionAnimationTypeSpreadLeft:
            rect0 = CGRectMake(screenWidth, 0, 0, screenHeight);
            break;
        case HSTransitionAnimationTypeSpreadTop:
            rect0 = CGRectMake(0, screenHeight - 2 , screenWidth, 2);
            break;
            
        default:
            rect0 = CGRectMake(0, 0, screenWidth, 2);
            break;
    }
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithRect:rect0];
    UIBezierPath *endPath =[UIBezierPath bezierPathWithRect:rect1];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    toTempView.layer.mask = maskLayer;
    maskLayer.path = endPath.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = self.transitionModel.animationTime;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"BackPath"];
    
    self.willEndInteractiveBlock = ^(BOOL success) {
        
        if (success) {
            maskLayer.path = endPath.CGPath;
            
        }else{
            maskLayer.path = startPath.CGPath;
        }
        
    };
    
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            
            [transitionContext completeTransition:NO];
            
            fromVC.view.hidden = NO;
            
            [toVC.view removeFromSuperview];
            toVC.view.hidden = NO;
            
        }else{
            
            [transitionContext completeTransition:YES];
            
            fromVC.view.hidden = NO;
            toVC.view.hidden = NO;
            
        }
        
        //移除视图
        [fromTempView removeFromSuperview];
        [toTempView removeFromSuperview];
    };
    
    
}

#pragma mark - PointSpread

- (void)pointSpread_displayAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //得到from视图和to视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //from视图和to视图的截图
    UIView *fromTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:fromVC.view]];
    UIView *toTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:toVC.view]];
    
    //隐藏视图
    fromVC.view.hidden = YES;
    toVC.view.hidden = YES;
    
    //添加截图和视图
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromTempView];
    [containerView addSubview:toTempView];
    
    /** 动画变换 */
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGRect rect0 = CGRectMake(containerView.center.x - 1, containerView.center.y - 1, 2, 2);
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:rect0];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)  startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath; //动画结束后的值
    toTempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = self.transitionModel.animationTime;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"NextPath"];
    
    self.completionBlock = ^(){
        
        if ([transitionContext transitionWasCancelled]) {
            
            [transitionContext completeTransition:NO];
            
            fromVC.view.hidden = NO;
            
            [toVC.view removeFromSuperview];
            toVC.view.hidden = NO;
            
        }else{
            
            [transitionContext completeTransition:YES];
            
            fromVC.view.hidden = NO;
            toVC.view.hidden = NO;
            
        }
        
        //隐藏视图
        [fromTempView removeFromSuperview];
        [toTempView removeFromSuperview];
    };
}

- (void)pointSpread_backAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //得到from视图和to视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //from视图和to视图的截图
    UIView *fromTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:fromVC.view]];
    UIView *toTempView = [[UIImageView alloc] initWithImage:[AnimatedTransition getSnapshotView:toVC.view]];
    
    //隐藏视图
    fromVC.view.hidden = YES;
    toVC.view.hidden = YES;
    
    //添加截图和视图
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView addSubview:toTempView];
    [containerView addSubview:fromTempView];
    
    
    /** 动画变换 */
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGRect rect0 = CGRectMake(containerView.center.x - 1, containerView.center.y - 1, 2, 2);
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)  startAngle:0 endAngle:M_PI*2 clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:rect0];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    fromTempView.layer.mask = maskLayer;
    maskLayer.path = endPath.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = self.transitionModel.animationTime;
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"BackPath"];
    
    self.willEndInteractiveBlock = ^(BOOL success) {
        
        if (success) {
            maskLayer.path = endPath.CGPath;
            
        }else{
            maskLayer.path = startPath.CGPath;
        }
        
    };
    
    self.completionBlock = ^(){
        
        
        if ([transitionContext transitionWasCancelled]) {
            
            [transitionContext completeTransition:NO];
            
            fromVC.view.hidden = NO;
            
            [toVC.view removeFromSuperview];
            toVC.view.hidden = NO;
            
        }else{
            
            [transitionContext completeTransition:YES];
            
            fromVC.view.hidden = NO;
            toVC.view.hidden = NO;
        }
        
        //移除视图
        [fromTempView removeFromSuperview];
        [toTempView removeFromSuperview];
    };
    
    
}


@end
