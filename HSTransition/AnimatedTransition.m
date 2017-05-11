//
//  AnimatedTransition.m
//  HSTransition
//
//  Created by huangshan on 2017/5/9.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "AnimatedTransition.h"

@implementation AnimatedTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return _transitionModel.animationTime;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (_transitionType) {
        case HSTransitionTypePush:
        case HSTransitionTypePresent:
            [self transitionDisplayAnimation:transitionContext animationType:_transitionModel.animationType];
            break;
        case HSTransitionTypePop:
        case HSTransitionTypeDismiss:
            [self transitionBackAnimation:transitionContext animationType:_transitionModel.animationType];
            break;
        default:
            break;
    }
}

-(void)transitionDisplayAnimation:(id<UIViewControllerContextTransitioning>)transitionContext animationType:(HSTransitionAnimationType)animationType {
    
    NSString *prefix = changeMethodName(animationType);
    
    NSString *methodName = [NSString stringWithFormat:@"%@_displayAnimateTransition:", prefix];
    
    SEL selector = NSSelectorFromString(methodName);
    
    if ([self respondsToSelector:selector]){
        
        [self performSelector:selector withObject:transitionContext];
    }
    
}

-(void)transitionBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext animationType:(HSTransitionAnimationType )animationType{
    
    NSString *prefix = changeMethodName(animationType);
    
    NSString *methodName = [NSString stringWithFormat:@"%@_backAnimateTransition:", prefix];
    
    SEL selector = NSSelectorFromString(methodName);
    
    if ([self respondsToSelector:selector]){
        
        [self performSelector:selector withObject:transitionContext];
    }
}


NSString * changeMethodName(HSTransitionAnimationType type) {
    
    switch (type) {
            
        case HSTransitionAnimationTypeSystemFadeLeft...HSTransitionAnimationTypeDefault:
        {
            
            return @"system";
        }
            break;
            
        case HSTransitionAnimationTypeCover:
        {
            
            return @"cover";
        }
            break;
            
        case HSTransitionAnimationTypeSpreadLeft...HSTransitionAnimationTypeSpreadBottom:
        {
            
            return @"spread";
        }
            break;
            
        case HSTransitionAnimationTypePointSpread:
        {
            
            return @"pointSpread";
        }
            break;
            
        default:{
            
            return nil;
        }
            break;
    }
}


- (void)animationDidStart:(CAAnimation *)anim {
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {
        _completionBlock ? _completionBlock() : nil;
        _completionBlock = nil;
    }
    
}

#pragma mark - 截图

+ (UIImage *)getSnapshotView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage*targetImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return targetImage;
    
}

@end
