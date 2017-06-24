//
//  NViewController.m
//  AnimationTest
//
//  Created by 周重阳 on 16/5/28.
//  Copyright © 2016年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import "NViewController.h"

@interface NViewController ()
@property (nonatomic, strong) UIView *lview;
@property (nonatomic, strong) UIView *rview;
@end

@implementation NViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view];
    self.lview = view;
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    self.rview = view2;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 150, 50)];
    v.backgroundColor = [UIColor greenColor];
    [view2 addSubview:v];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [btn setTitle:@"start" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.frame = CGRectMake(150, 150, 75, 40);
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)btnAction:(UIButton *)sender {
    self.lview.frame = CGRectMake(0, 0, 150, 0);
    self.rview.frame = CGRectMake(225, -600, 150, 600);
    [UIView animateWithDuration:2 animations:^{
        self.lview.frame = CGRectMake(0, 0, 150, 600);
        self.rview.frame = CGRectMake(225, 0, 150, 600);
    }];
}

@end
