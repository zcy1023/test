//
//  JViewController.m
//  AnimationTest
//
//  Created by 周重阳 on 15/11/3.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import "JViewController.h"
#define kScreenWidth     [UIScreen mainScreen].bounds.size.width

@interface TestView : UIView

@end

@implementation TestView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:95 startAngle:-M_PI_2+M_PI_4 endAngle:-M_PI_2-M_PI_4 clockwise:YES];
    path.lineWidth = 5;
    path.lineJoinStyle = kCGLineJoinRound;
    [[UIColor redColor] setStroke];
    [path stroke];
}

@end

@interface JViewController ()
@property (nonatomic, strong) UIView *aView;
@property (nonatomic, strong) UIView *containerView;
@end

@implementation JViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    
    [self animationCircul];
    [self CAAnimationGroup];

}

- (void)CAAnimationGroup {
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 300)/2.0, 300, 300, 300)];
    _containerView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_containerView];
    
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 75)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, -100) controlPoint2:CGPointMake(225, 300)];
    
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    //add a colored layer
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.containerView.layer addSublayer:colorLayer];
    //create the position animation
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = bezierPath.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    //create the color animation
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    //create group animation
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 4.0;
    groupAnimation.repeatCount = 1000;
    groupAnimation.autoreverses = YES;
    //add the animation to the color layer
    [colorLayer addAnimation:groupAnimation forKey:nil];
}

- (void)animationCircul {
    CATransform3D transorm = CATransform3DIdentity;
    transorm.m34 = -1.0/500;
    self.view.layer.sublayerTransform = transorm;
    
    TestView *view3 = [[TestView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    CATransform3D transform3 = CATransform3DMakeRotation(M_PI_4, 1, 0, 0);
    view3.layer.transform = transform3;
    view3.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view3];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    v.layer.cornerRadius = 5;
    v.backgroundColor = [UIColor blueColor];
    [view3 addSubview:v];
    
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(view3.bounds.size.width/2, view3.bounds.size.height/2) radius:view3.bounds.size.width / 2 startAngle:0 endAngle:-M_PI_2-M_PI_4 clockwise:YES];
    keyframeAnimation.path = bezierPath.CGPath;
    keyframeAnimation.duration = 1;
    keyframeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    keyframeAnimation.repeatCount = 1000;
    keyframeAnimation.autoreverses = YES;
    [v.layer addAnimation:keyframeAnimation forKey:@"keyFrame"];
}
@end
