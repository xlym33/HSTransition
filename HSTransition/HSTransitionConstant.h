//
//  HSTransitionConstant.h
//  HSTransition
//
//  Created by huangshan on 2017/5/9.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#ifndef HSTransitionConstant_h
#define HSTransitionConstant_h

typedef NS_ENUM(NSInteger,HSTransitionAnimationType){
    
    //=====================System=====================
    
    
    /** Fade */
    HSTransitionAnimationTypeSystemFadeLeft,
    HSTransitionAnimationTypeSystemFadeRight,
    HSTransitionAnimationTypeSystemFadeTop,
    HSTransitionAnimationTypeSystemFadeBottom,
    
    
    /** Push */
    HSTransitionAnimationTypeSystemPushLeft,
    HSTransitionAnimationTypeSystemPushRight,
    HSTransitionAnimationTypeSystemPushTop,
    HSTransitionAnimationTypeSystemPushBottom,
    
    
    /** Reveal */
    HSTransitionAnimationTypeSystemRevealLeft,
    HSTransitionAnimationTypeSystemRevealRight,
    HSTransitionAnimationTypeSystemRevealTop,
    HSTransitionAnimationTypeSystemRevealBottom,
    
    
    /** Reveal */
    HSTransitionAnimationTypeSystemMoveInLeft,
    HSTransitionAnimationTypeSystemMoveInRight,
    HSTransitionAnimationTypeSystemMoveInTop,
    HSTransitionAnimationTypeSystemMoveInBottom,
    
    
    //=====================Custom=====================

    
    /** Default */
    HSTransitionAnimationTypeDefault,
    
    
    /** Cover */
    HSTransitionAnimationTypeCover,
    
    
    /** Spread */
    HSTransitionAnimationTypeSpreadLeft,
    HSTransitionAnimationTypeSpreadRight,
    HSTransitionAnimationTypeSpreadTop,
    HSTransitionAnimationTypeSpreadBottom,
    
    
    /** PointSpread */
    HSTransitionAnimationTypePointSpread
};


typedef NS_ENUM(NSInteger,HSTransitionType){
    
    HSTransitionTypePop,
    HSTransitionTypePush,
    HSTransitionTypePresent,
    HSTransitionTypeDismiss,
};

typedef NS_ENUM(NSInteger,HSGestureType){
    
    HSGestureTypeNone,
    HSGestureTypePanLeft,
    HSGestureTypePanRight,
    HSGestureTypePanTop,
    HSGestureTypePanBottom,
    HSGestureTypeTapFade
};


#endif /* HSTransitionConstant_h */
