//
//  ViewController.m
//  HSTransition
//
//  Created by huangshan on 2017/5/9.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "ViewController.h"

#import "NextViewController.h"

#import "AnimatedTransition.h"

#import <objc/runtime.h>

#import "UIViewController+HSTransition.h"

#import "UINavigationController+HSTransition.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1"]];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, 40, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)click {
    
    NextViewController *nextVC = [[NextViewController alloc] init];
    
    //UINavigation
    [self.navigationController hs_pushViewController:nextVC makeTransition:^(HSTransitionModel *model) {
        
        model.animationTime = 1.0f;
        
        model.animationType = HSTransitionAnimationTypeCover;
        
        model.backGestureEnable = YES;
        
        model.backGestureType = HSGestureTypePanLeft;
        
    } completion:^{
        
    }];
    
    
    //present
    //    [self hs_presentViewController:nextVC makeTransition:^(HSTransitionModel *model) {
    //
    //        model.animationTime = 2.0f;
    //
    //        model.animationType = HSTransitionAnimationTypeSpreadLeft;
    //
    //        model.backGestureEnable = YES;
    //
    //        model.backGestureType = HSGestureTypePanLeft;
    //
    //    } completion:^{
    //
    //    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
