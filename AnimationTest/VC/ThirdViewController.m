//
//  ThirdViewController.m
//  AnimationTest
//
//  Created by 周重阳 on 15/11/19.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor greenColor];
}


- (IBAction)jietu:(id)sender {
    //preserve the current view snapshot
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    //insert snapshot view in front of this one
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    //update the view (we'll simply randomize the layer background color)
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //perform animation (anything you like)
    [UIView animateWithDuration:1.0 animations:^{
        //scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
    } completion:^(BOOL finished) {
        //remove the cover view now we're finished with it
        [coverView removeFromSuperview];
    }];
}

- (IBAction)H:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"HViewController") alloc] init] animated:YES];
}

- (IBAction)I:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"IViewController") alloc] init] animated:YES];
}

- (IBAction)K:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"KViewController") alloc] init] animated:YES];
}

- (IBAction)L:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"LViewController") alloc] init] animated:YES];
}

- (IBAction)M:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"MViewController") alloc] init] animated:YES];
}

- (IBAction)N:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"NViewController") alloc] init] animated:YES];
}

- (IBAction)O:(id)sender {
    [self.navigationController pushViewController:[[NSClassFromString(@"OViewController") alloc] init] animated:YES];
}


@end
