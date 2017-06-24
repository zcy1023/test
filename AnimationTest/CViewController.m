//
//  CViewController.m
//  AnimationTest
//
//  Created by 周重阳 on 15/11/3.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import "CViewController.h"

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    
    
    [self twoColors];
    [self manyColors];
}

- (void)twoColors {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(60, 80, 200, 200);
    [self.view.layer addSublayer:gradientLayer];
    
    //set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];

    //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = CGRectMake(300, 80, 5, 200);
    [self.view.layer addSublayer:gradientLayer2];
    
    //set gradient colors
    gradientLayer2.colors = @[(__bridge id)[UIColor colorWithWhite:0 alpha:0].CGColor, (__bridge id)[UIColor colorWithWhite:0 alpha:0.08].CGColor];
    
    //set gradient start and end points
    gradientLayer2.startPoint = CGPointMake(0, 0.5);
    gradientLayer2.endPoint = CGPointMake(1, 0.5);
}

- (void)manyColors {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 350, [UIScreen mainScreen].bounds.size.width, 200);
    [self.view.layer addSublayer:gradientLayer];
    
    //set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor orangeColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor,
                             (__bridge id)[UIColor cyanColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor,
                             (__bridge id)[UIColor purpleColor].CGColor];
    
    //set locations
//    gradientLayer.locations = @[@0.0, @0.15, @0.2, @0.3, @0.4, @0.5, @0.9];
    gradientLayer.locations = @[@(0/7.0), @(1/7.0), @(2/7.0), @(3/7.0), @(4/7.0), @(5/7.0), @(6/7.0)];
    //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
}

@end
