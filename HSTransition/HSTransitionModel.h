//
//  HSTransitionModel.h
//  HSTransition
//
//  Created by huangshan on 2017/5/9.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSTransitionConstant.h"

@interface HSTransitionModel : NSObject<NSCopying>

/** 转场动画时间 */
@property (nonatomic, assign) NSTimeInterval animationTime;

/** 转场动画类型 */
@property (nonatomic, assign) HSTransitionAnimationType animationType;

/** 是否通过手势返回 */
@property (nonatomic, assign) BOOL backGestureEnable;

/** 返回上个界面的手势 默认：右滑 ：HSGestureTypePanRight */
@property (nonatomic,assign) HSGestureType backGestureType;

@end
