//
//  ViewController.m
//  YRJKit
//
//  Created by YURENJIE on 2018/3/7.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

#import "ViewController.h"

#import "YRJKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor yrj_gradientFromColor:RandomColor toColor:RandomColor withHeight:SCREEN_HEIGHT];
    
//    [YRJTools delay:1 task:^{
//
//        UIViewController * rootVC = [UIViewController new];
//        rootVC.view.backgroundColor = [UIColor redColor];
//
//        [YRJTools setRootControllerWithController:rootVC options:UIViewAnimationOptionTransitionCrossDissolve];
//
//    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
