//
//  KViewController.m
//  AnimationTest
//
//  Created by 周重阳 on 15/11/20.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import "KViewController.h"

@interface KViewController ()
@property (nonatomic, strong) CALayer *colorLayer;
@end

@implementation KViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 100, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.view.layer addSublayer:self.colorLayer];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [btn setTitle:@"changeColorFrame" forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(100, 300, 200, 50);
    [btn addTarget:self action:@selector(changeColorAndFrame) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

- (void)changeColorAndFrame
{
    //create a keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 3.0;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    //add timing function
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    animation.timingFunctions = @[fn, fn, fn];
    //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    //create a keyframe animation
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animation];
    animation2.keyPath = @"position";
    animation2.duration = 3.0;
    animation2.values = @[[NSValue valueWithCGPoint:CGPointMake(50, 150)],
                         [NSValue valueWithCGPoint:CGPointMake(screenWidth/2, 400)],
                         [NSValue valueWithCGPoint:CGPointMake(screenWidth - 50, 150)],
                         [NSValue valueWithCGPoint:CGPointMake(50, 150)]];
    //add timing function
    CAMediaTimingFunction *fn2 = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    animation2.timingFunctions = @[fn2, fn2, fn2];
    //apply animation to layer
    [self.colorLayer addAnimation:animation2 forKey:nil];
}

@end
