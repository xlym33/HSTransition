//
//  UIViewController+HSTransition.h
//  HSTransition
//
//  Created by huangshan on 2017/5/10.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSTransitionModel.h"
#import "AnimatedTransition.h"



@interface UIViewController (HSTransition)<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

- (void)hs_presentViewController:(UIViewController *)presentViewController makeTransition:(HSTransitionBlock)transitionBlock completion:(HSTransitionCompleteBlock)completionBlock;

@end


@interface UIViewController (HSTransitionModel)

@property (nonatomic, copy) HSTransitionBlock transitionBlock;

@end
