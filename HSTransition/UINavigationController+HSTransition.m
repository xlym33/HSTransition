//
//  UINavigationController+HSTransition.m
//  HSTransition
//
//  Created by huangshan on 2017/5/10.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "UINavigationController+HSTransition.h"
#import "UIViewController+HSTransition.h"

@implementation UINavigationController (HSTransition)

- (void)hs_pushViewController:(UIViewController *)presentViewController makeTransition:(HSTransitionBlock)transitionBlock completion:(HSTransitionCompleteBlock)completionBlock {
    
    self.delegate = presentViewController;
    presentViewController.transitionBlock = transitionBlock ? transitionBlock : nil;
    [self pushViewController:presentViewController animated:YES];
}

@end
