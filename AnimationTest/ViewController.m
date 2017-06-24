//
//  ViewController.m
//  AnimationTest
//
//  Created by 周重阳 on 15/10/30.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "LayerLabel.h"

#import "AViewController.h"
#import "BViewController.h"
#import "CViewController.h"
#import "DViewController.h"
#import "EViewController.h"
#import "FViewController.h"
#import "JViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.imageView.layer.borderWidth = 1;
    self.imageVIew2.layer.borderWidth = 1;
    
    CATransform3D transorm = CATransform3DIdentity;
    transorm.m34 = -1.0/500;
    self.view.layer.sublayerTransform = transorm;
    
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.imageView.layer.transform = transform1;
    
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.imageVIew2.layer.transform = transform2;
    
    [self CAShapeLayer];
    
    [self CATextLayer];
    [self CATextLayerAttribute];
    
    [self layerLabel];
    
}

- (void)layerLabel {
    LayerLabel *label = [[LayerLabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.imageVIew2.frame) + 10, [UIScreen mainScreen].bounds.size.width - 40, 30)];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor blueColor];
    label.text = @"阿拉蕾阿里郎阿拉蕾~~";
    [self.view addSubview:label];
}

- (void)CATextLayerAttribute {
    //create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectInset(self.view.bounds, 20, 100) ;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.view.layer addSublayer:textLayer];
    
    //set text attributes
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //choose some text
    NSString *text = @"阿斯达克是打开四大四大四大,啊实打实的,请问请问请问.请问请问请问;请问请问请问,驱蚊器驱蚊请问企鹅全文.";
    
    //create attributed string
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];
    
    //convert UIFont to a CTFont
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    //set text attributes
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                              };
    
    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleThick),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(10, 5)];
    
    //release the CTFont we created earlier
    CFRelease(fontRef);
    
    //set layer text
    textLayer.string = string;
}
//2.
- (void)CATextLayer {
    //create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectInset(self.imageVIew2.bounds, 20, 20) ;
    [self.imageVIew2.layer addSublayer:textLayer];
    
    //set text attributes
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.truncationMode = kCATruncationMiddle;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    //choose some text
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing";
    
    //set layer text
    textLayer.string = text;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
}

//1.
- (void)CAShapeLayer {
    CGFloat x = 100;
    CGFloat y = 60;
    CGFloat r = 25;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(x, y)];
    [path addArcWithCenter:CGPointMake(x-r, y) radius:r startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(x-r, y+r)];
    [path addLineToPoint:CGPointMake(x-r, y+3*r)];
    [path addLineToPoint:CGPointMake(x-2*r, y+5*r)];
    [path moveToPoint:CGPointMake(x-r, y+3*r)];
    [path addLineToPoint:CGPointMake(x, y+5*r)];
    [path moveToPoint:CGPointMake(x-3*r, y+2*r)];
    [path addLineToPoint:CGPointMake(x+r, y+2*r)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //add it to our view
    [self.imageView.layer addSublayer:shapeLayer];
    
    CGRect rect = CGRectInset(self.imageVIew2.bounds, 20, 20);
    CGSize radii = CGSizeMake(30, 30);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor redColor].CGColor;
    shapeLayer2.lineWidth = 2;
    shapeLayer2.lineJoin = kCALineJoinRound;
    shapeLayer2.lineCap = kCALineCapRound;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.path = path2.CGPath;
    [self.imageVIew2.layer addSublayer:shapeLayer2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushA:(id)sender {
    AViewController *vc = [[AViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pushB:(id)sender {
    BViewController *vc = [[BViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pushC:(id)sender {
    CViewController *vc = [[CViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pushD:(id)sender {
    DViewController *vc = [[DViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pushE:(id)sender {
    EViewController *vc = [[EViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pushF:(id)sender {
    FViewController *vc = [[FViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pushJ:(id)sender {
    JViewController *vc = [[JViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
