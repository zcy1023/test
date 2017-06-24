//
//  SecondViewController.m
//  AnimationTest
//
//  Created by 周重阳 on 15/11/19.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSArray *images;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.images = @[[UIImage imageNamed:@"1.jpg"],
                    [UIImage imageNamed:@"2"],
                    [UIImage imageNamed:@"3"],
                    [UIImage imageNamed:@"4"],
                    [UIImage imageNamed:@"5"]];
}

- (IBAction)switchImage:(id)sender {
    
    NSInteger options[7] = {
        UIViewAnimationOptionTransitionFlipFromLeft,
        UIViewAnimationOptionTransitionFlipFromRight,
        UIViewAnimationOptionTransitionCurlUp,
        UIViewAnimationOptionTransitionCurlDown,
        UIViewAnimationOptionTransitionCrossDissolve,
        UIViewAnimationOptionTransitionFlipFromTop,
        UIViewAnimationOptionTransitionFlipFromBottom};
    UIViewAnimationOptions option = (UIViewAnimationOptions)options[arc4random() % 7];
    
    [UIView transitionWithView:self.imageView duration:1.0
                       options:option
                    animations:^{
                        //cycle to next image
                        UIImage *currentImage = self.imageView.image;
                        NSUInteger index = [self.images indexOfObject:currentImage];
                        index = (index + 1) % [self.images count];
                        self.imageView.image = self.images[index];
                    }
                    completion:NULL];
    
}

- (IBAction)rotation:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.byValue = @(M_PI * 2);
    animation.delegate = self;
    [self.imageView.layer addAnimation:animation forKey:@"rotateAnimation"];
}

- (IBAction)endRotation:(id)sender {
    [self.imageView.layer removeAnimationForKey:@"rotateAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //log that the animation stopped
    NSLog(@"The animation stopped (finished: %@)", flag? @"YES": @"NO");
}

@end
