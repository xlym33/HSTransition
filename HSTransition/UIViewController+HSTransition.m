//
//  UIViewController+HSTransition.m
//  HSTransition
//
//  Created by huangshan on 2017/5/10.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "UIViewController+HSTransition.h"
#import <objc/runtime.h>
#import "HSPercentDrivenInteractiveTransition.h"
#import "HSTransitionModel.h"

UINavigationControllerOperation _operation;
AnimatedTransition *_transition;
HSPercentDrivenInteractiveTransition *_interactiveTransition;

@implementation UIViewController (HSTransition)

- (void)hs_presentViewController:(UIViewController *)presentViewController makeTransition:(HSTransitionBlock)transitionBlock completion:(HSTransitionCompleteBlock)completionBlock {
    
    presentViewController.transitioningDelegate = presentViewController;
    presentViewController.transitionBlock = transitionBlock ? transitionBlock : nil;
    
    [self presentViewController:presentViewController animated:YES completion:completionBlock];
}



#pragma mark - UIViewControllerTransitioningDelegate

/** 页面即将消失 */
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    if (!_transition){
        _transition = [[AnimatedTransition alloc] init];
    }
    
    HSTransitionModel *model = [[HSTransitionModel alloc] init];
    
    if (self.transitionBlock) {
        self.transitionBlock(model);
    }
    
    _transition.transitionModel = model;
    _transition.transitionType = HSTransitionTypeDismiss;
    return _transition;
    
}

/** 页面要显示 */
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    if (!_transition){
        _transition = [[AnimatedTransition alloc] init];
    }
    
    HSTransitionModel *model = [[HSTransitionModel alloc] init];
    
    if (self.transitionBlock) {
        self.transitionBlock(model);
    }
    
    _transition.transitionModel = model;
    _transition.transitionType = HSTransitionTypePresent;
    
    
    //添加手势
    if (_transition.transitionModel.backGestureEnable) {
        
        _interactiveTransition = [[HSPercentDrivenInteractiveTransition alloc] initWithViewController:self];
        _interactiveTransition.transitionType = HSTransitionTypeDismiss;
        _interactiveTransition.gestureType = _transition.transitionModel.backGestureType;
        _interactiveTransition.willEndInteractiveBlock = ^(BOOL suceess) {
            _transition.willEndInteractiveBlock ? _transition.willEndInteractiveBlock(suceess) : nil;
        };
    }
    
    return _transition;
    
}

/** 展现页面交互 */
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    return nil;
}

/** 消失页面交互 */
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    return _interactiveTransition.isInteractive ? _interactiveTransition : nil ;
}

#pragma mark - UINavigationControllerDelegate

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (!_transition){
        _transition = [[AnimatedTransition alloc] init];
    }
    
    HSTransitionModel *model = [[HSTransitionModel alloc] init];
    
    if (self.transitionBlock) {
        self.transitionBlock(model);
    }
    
    _transition.transitionModel = model;
    
    _operation = operation;
    
    if (operation == UINavigationControllerOperationPush) {
        
        _transition.transitionType = HSTransitionTypePush;
        
    } else {
        
        _transition.transitionType = HSTransitionTypePop;
    }
    
    if (operation == UINavigationControllerOperationPush && _transition.transitionModel.backGestureEnable) {
        
        //添加手势
        _interactiveTransition = [[HSPercentDrivenInteractiveTransition alloc] initWithViewController:self];
        _interactiveTransition.transitionType = HSTransitionTypePop;
        _interactiveTransition.gestureType = _transition.transitionModel.backGestureType;
        _interactiveTransition.willEndInteractiveBlock = ^(BOOL suceess) {
            _transition.willEndInteractiveBlock ? _transition.willEndInteractiveBlock(suceess) : nil;
        };
    }
    
    return _transition;
    
}
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    if (_operation == UINavigationControllerOperationPush) {
        
        return nil;
        
    } else {
        
        return _interactiveTransition.isInteractive ? _interactiveTransition : nil ;
    }
    
    return nil;
    
}



@end


@implementation UIViewController (HSTransitionModel)


- (void)setTransitionBlock:(HSTransitionBlock)transitionBlock {
    
    objc_setAssociatedObject(self, @selector(transitionBlock), transitionBlock, OBJC_ASSOCIATION_COPY);
}

- (HSTransitionBlock)transitionBlock {
    
    return objc_getAssociatedObject(self, _cmd);
}

@end



