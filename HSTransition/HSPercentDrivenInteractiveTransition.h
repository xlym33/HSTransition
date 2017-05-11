//
//  HSPercentDrivenInteractiveTransition.h
//  HSTransition
//
//  Created by huangshan on 2017/5/10.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSTransitionConstant.h"

typedef void(^GestureActionBlock)(void);

@interface HSPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

/** 手势的方式 */
@property (nonatomic, assign) HSGestureType gestureType;

/** 是否正在交互 */
@property (readonly, assign, nonatomic) BOOL isInteractive;

/** 屏幕过渡的方式 */
@property (nonatomic, assign) HSTransitionType transitionType;

@property (nonatomic, copy) GestureActionBlock presentBlock;
@property (nonatomic, copy) GestureActionBlock pushBlock;
@property (nonatomic, copy) GestureActionBlock dismissBlock;
@property (nonatomic, copy) GestureActionBlock popBlock;

/** 页面即将交互完成 */
@property (nonatomic, copy) void(^willEndInteractiveBlock)(BOOL success);

/** 初始化 */
- (instancetype)initWithViewController:(UIViewController *)vc;

@end
