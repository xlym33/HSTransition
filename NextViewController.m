//
//  NextViewController.m
//  HSTransition
//
//  Created by huangshan on 2017/5/9.
//  Copyright © 2017年 huangshan. All rights reserved.
//

#import "NextViewController.h"

#import "AnimatedTransition.h"

#import "HSPercentDrivenInteractiveTransition.h"

@interface NextViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) HSPercentDrivenInteractiveTransition *interactive;

@property (nonatomic, strong) AnimatedTransition *transition;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 40, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)click {
    
    if (self.navigationController.viewControllers.count > 1){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
