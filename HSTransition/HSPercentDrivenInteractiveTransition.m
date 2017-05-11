//
//  HSPercentDrivenInteractiveTransition.m
//  HSTransition
//
//  Created by huangshan on 2017/5/10.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "HSPercentDrivenInteractiveTransition.h"

@interface HSPercentDrivenInteractiveTransition ()

@property (nonatomic, strong) UIViewController *gestureVC;

@property (nonatomic, assign) CGFloat percent;

@property (nonatomic, assign) BOOL isInter;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation HSPercentDrivenInteractiveTransition

- (instancetype)initWithViewController:(UIViewController *)vc
{
    self = [super init];
    if (self) {
        
        _gestureVC = vc;
    }
    return self;
}

- (void)setGestureType:(HSGestureType)gestureType {
    
    _gestureType = gestureType;
    
    if (gestureType == HSGestureTypeTapFade){
        
        [self addTapGestureToViewController:_gestureVC];
        
    } else if (gestureType == HSGestureTypePanTop || gestureType == HSGestureTypePanBottom || gestureType == HSGestureTypePanLeft || gestureType == HSGestureTypePanRight){
        
        [self addPanGestureToViewController:_gestureVC];
    }
}


- (void)addTapGestureToViewController:(UIViewController *)vc {
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAction:)];
    
    [vc.view addGestureRecognizer:tapGes];
}

- (void)tapGesAction:(UITapGestureRecognizer *)tapGes{
    
    
}


- (void)addPanGestureToViewController:(UIViewController *)vc {
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesAction:)];
    
    [vc.view addGestureRecognizer:panGes];
}

- (void)panGesAction:(UIPanGestureRecognizer *)panGes{
    
    _percent = 0.0;
    
    CGFloat totalWidth = panGes.view.bounds.size.width;
    CGFloat totalHeight = panGes.view.bounds.size.height;
    
    
    switch (self.gestureType) {
            
        case HSGestureTypePanLeft:{
            CGFloat x = [panGes translationInView:panGes.view].x;
            _percent = -x/totalWidth;
        }
            break;
        case HSGestureTypePanRight:{
            CGFloat x = [panGes translationInView:panGes.view].x;
            _percent = x/totalWidth;
        }
            break;
        case HSGestureTypePanBottom:{
            
            CGFloat y = [panGes translationInView:panGes.view].y;
            _percent = y/totalHeight;
            
        }
            break;
        case HSGestureTypePanTop:{
            CGFloat y = [panGes translationInView:panGes.view].y;
            _percent = -y/totalHeight;
        }
            
        default:
            break;
    }
    
    switch (panGes.state) {
        case UIGestureRecognizerStateBegan:{
            _isInter = YES;
            [self beganGesture];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self updateInteractiveTransition:_percent];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            _isInter = NO;
            [self continueAction];
            
        }
            break;
        default:
            break;
    }
}

-(void)beganGesture{
    
    switch (_transitionType) {
        case HSTransitionTypePresent:{
            _presentBlock? _presentBlock() : nil;
        }
            break;
        case HSTransitionTypeDismiss:{
            _dismissBlock ? _dismissBlock() : [_gestureVC dismissViewControllerAnimated:YES completion:^{
            }];
        }
            break;
        case HSTransitionTypePush: {
            _pushBlock ? _pushBlock() : nil;
        }
            break;
        case HSTransitionTypePop:{
            _popBlock ? _popBlock() : [_gestureVC.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
    
}

- (BOOL)isInteractive {
    
    return _isInter;
}

- (void)continueAction{
    
    if (_displayLink) {
        return;
    }
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(UIChange)];
    
    [_displayLink  addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)UIChange {
    
    CGFloat timeDistance = 2.0/60;
    if (_percent > 0.4) {
        _percent += timeDistance;
    }else {
        _percent -= timeDistance;
    }
    [self updateInteractiveTransition:_percent];
    
    if (_percent >= 1.0) {
        
        _willEndInteractiveBlock ? _willEndInteractiveBlock(YES) : nil;
        [self finishInteractiveTransition];
        [_displayLink invalidate];
        _displayLink = nil;
    }
    
    if (_percent <= 0.0) {
        
        _willEndInteractiveBlock ? _willEndInteractiveBlock(NO) : nil;
        
        [_displayLink invalidate];
        _displayLink = nil;
        [self cancelInteractiveTransition];
    }
}


@end
