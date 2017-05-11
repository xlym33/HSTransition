//
//  HSTransitionModel.m
//  HSTransition
//
//  Created by huangshan on 2017/5/9.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "HSTransitionModel.h"

@implementation HSTransitionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _animationTime = 0.5f;
        
        _animationType = HSTransitionAnimationTypeDefault;
        
        _backGestureEnable = NO;
        
        _backGestureType = HSGestureTypePanRight;
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {

    HSTransitionModel *model = [[[self class] allocWithZone:zone] init];
    
    model.animationTime = _animationTime;
    
    model.animationType = _animationType;
    
    model.backGestureEnable = _backGestureEnable;
    
    model.backGestureType = _backGestureType;

    
    return model;
}


@end
