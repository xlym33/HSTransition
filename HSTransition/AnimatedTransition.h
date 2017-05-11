//
//  AnimatedTransition.h
//  HSTransition
//
//  Created by huangshan on 2017/5/9.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "HSTransitionConstant.h"

#import "HSTransitionModel.h"

typedef void(^HSTransitionBlock)(HSTransitionModel *);
typedef void(^HSTransitionCompleteBlock)(void);


@interface AnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

/** 转场方式：push,pop,present,dismiss */
@property (nonatomic, assign) HSTransitionType transitionType;

/** 转场动画必要的参数 */
@property (nonatomic, copy) HSTransitionModel *transitionModel;

/** 完成后的block */
@property (nonatomic, copy) void(^completionBlock)();

/** 交互即将完成的block */
@property (nonatomic, copy) void(^willEndInteractiveBlock)(BOOL success);

/** 截图 */
+ (UIImage *)getSnapshotView:(UIView *)view;

@end
