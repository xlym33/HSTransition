//
//  UINavigationController+HSTransition.h
//  HSTransition
//
//  Created by huangshan on 2017/5/10.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimatedTransition.h"

@interface UINavigationController (HSTransition)

- (void)hs_pushViewController:(UIViewController *)presentViewController makeTransition:(HSTransitionBlock)transitionBlock completion:(HSTransitionCompleteBlock)completionBlock;

@end
