//
//  LViewController.m
//  AnimationTest
//
//  Created by 周重阳 on 15/11/20.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import "LViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LViewController ()

@end

@implementation LViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    [self getControlPoint];
    [self customMediaTimingFunction];
}

- (void)customMediaTimingFunction {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [btn setTitle:@"xxx" forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(100, 300, 200, 50);
    [btn addTarget:self action:@selector(angle) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}
- (void)angle {
    static CGFloat angle = 0;
    angle+=M_PI_2;
    [self setAngle:angle forHand:self.view animated:YES];
}

- (void)getControlPoint {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 70, 200, 200)];
    view.backgroundColor = [UIColor colorWithWhite:224/255.0 alpha:1];
    [self.view addSubview:view];
    
    //CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
    
    //get control points
    float point0[2] = {};
    float point1[2] = {};
    float point2[2] = {};
    float point3[2] = {};
    [function getControlPointAtIndex:0 values:point0];
    [function getControlPointAtIndex:1 values:point1];
    [function getControlPointAtIndex:2 values:point2];
    [function getControlPointAtIndex:3 values:point3];
    NSLog(@"p0:{%.2f,%.2f} p1:{%.2f,%.2f} p2:{%.2f,%.2f} p3:{%.2f,%.2f}", point0[0], point0[1], point1[0], point1[1], point2[0], point2[1], point3[0], point3[1]);
    //create curve
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1)
            controlPoint1:CGPointMake(point1[0], point1[1]) controlPoint2:CGPointMake(point2[0], point2[1])];
    
    //scale the path up to a reasonable size for display
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 4.0f;
    shapeLayer.path = path.CGPath;
    [view.layer addSublayer:shapeLayer];
    //flip geometry so that 0,0 is in the bottom-left
    view.layer.geometryFlipped = YES; //翻转坐标系
}

- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated
{
    //generate transform
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        //create transform animation
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"transform";
        animation.fromValue = [handView.layer.presentationLayer valueForKey:@"transform"];
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
        //apply animation
        handView.layer.transform = transform;
        [handView.layer addAnimation:animation forKey:nil];
    } else {
        //set transform directly
        handView.layer.transform = transform;
    }
}
@end
