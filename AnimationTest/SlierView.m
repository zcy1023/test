//
//  SlierView.m
//  AnimationTest
//
//  Created by 周重阳 on 15/11/2.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import "SlierView.h"
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define kTextLabelTop       0
#define kTextLabelHeight    30
#define kNumberLabelTop     (kTextLabelTop + kTextLabelHeight + 15)
#define kNumberLabelHeight  20
#define kLineViewTop        (kNumberLabelTop + kNumberLabelHeight + 5)
#define kLineViewHeight     5
#define kSliderViewTop      (kLineViewTop + kLineViewHeight)
#define kSliderViewHeight   5
#define kThumbViewTop       (kSliderViewTop + kSliderViewHeight)
#define kThumbViewHeight    30
#define kThumbViewWidth     30
#define kThumbTextTop       (kLineViewTop - kThumbTextHeight)
#define kThumbTextHeight    35
#define kThumbTextWidth     30

#define kSelfHeight         (kThumbViewTop + kThumbViewHeight + 15)

#pragma interface:TextImageView
@interface TextImageView : UIImageView
@property (nonatomic, strong) UILabel *label;
@end

@implementation TextImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(3, 10, CGRectGetWidth(frame) - 6, 20)];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:label];
        self.label = label;
    }
    return self;
}
@end



#pragma mark - NSString+Custom
@interface NSString (Custom)
- (NSMutableAttributedString *)left666666RightE83C36Style;
@end

@implementation NSString (Custom)
- (NSMutableAttributedString *)left666666RightE83C36Style {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]} range:NSMakeRange(0, self.length)];
    
    NSRange range = [self rangeOfString:@":"];
    if (range.length != 0) {
        [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRed:232/255.0 green:60/255.0 blue:54/255.0 alpha:1]} range:NSMakeRange(range.location + 1, self.length - range.location - 1)];
    }
    return attrStr;
}
@end


@interface SlierView ()
{
    BOOL _touchBeginInMainThumb;
    BOOL _touchBeginInLeftThumb;
    BOOL _touchBeginInRightThumb;
    NSInteger _mainThumbIndex;
    NSInteger _leftThumbIndex;
    NSInteger _rightThumbIndex;
}
@property (nonatomic, strong) NSArray *numbers;
@property (nonatomic, copy) NSString *unitText;
@property (nonatomic, copy) NSString *conditionText;
@property (nonatomic, assign) NSInteger thumbCount;

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *slider;
@property (nonatomic, strong) UIImageView *mainThumb;
@property (nonatomic, strong) UIImageView *leftThumb;
@property (nonatomic, strong) UIImageView *rightThumb;
@property (nonatomic, strong) TextImageView *mainThumbText;
@property (nonatomic, strong) TextImageView *leftThumbText;
@property (nonatomic, strong) TextImageView *rightThumbText;
@end

@implementation SlierView

- (instancetype)initWithFrame:(CGRect)frame thumbCount:(NSInteger)thumbCount numbers:(NSArray *)numbers unitText:(NSString *)unitText conditionText:(NSString *)conditionText {
    self = [super initWithFrame:CGRectMake(0, frame.origin.y, SCREEN_WIDTH, kSelfHeight)];
    NSLog(@"%d", kSelfHeight);
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _thumbCount = thumbCount;
        _numbers = numbers;
        _unitText = unitText;
        _conditionText = conditionText;
        [self layoutTextLabel];
        [self layoutNumbers];
        [self layoutSlider];
        [self layoutThumb];
    }
    return self;
}

- (void)layoutTextLabel {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kTextLabelTop, SCREEN_WIDTH, kTextLabelHeight)];
    view.backgroundColor = [UIColor colorWithWhite:244/255.0 alpha:1];
    [self addSubview:view];
    UIView *topline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    topline.backgroundColor = [UIColor colorWithWhite:224/255.0 alpha:1];
    [view addSubview:topline];
    UIView *downline = [[UIView alloc] initWithFrame:CGRectMake(0, kTextLabelHeight - 0.5, SCREEN_WIDTH, 0.5)];
    downline.backgroundColor = [UIColor colorWithWhite:224/255.0 alpha:1];
    [view addSubview:downline];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, kTextLabelHeight)];
    _textLabel.attributedText = [[NSString stringWithFormat:@"%@:不限", _conditionText] left666666RightE83C36Style];
    _textLabel.font = [UIFont systemFontOfSize:16];
    _textLabel.adjustsFontSizeToFitWidth = YES;
    [view addSubview:_textLabel];
}

- (void)layoutNumbers {
    CGFloat width = (SCREEN_WIDTH - 30) / _numbers.count;
    for (int i = 0; i < _numbers.count; i++) {
        CGFloat x = 15 + i * width;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, kNumberLabelTop, width, kNumberLabelHeight)];
        titleLabel.text = [NSString stringWithFormat:@"%@", _numbers[i]];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.center.x - 0.25, kLineViewTop, 0.5, kLineViewHeight)];
        line.backgroundColor = [UIColor colorWithWhite:224/255.0 alpha:1];
        [self addSubview:line];

    }
}

- (void)layoutSlider {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, kSliderViewTop, SCREEN_WIDTH - 30, kSliderViewHeight)];
    view.layer.cornerRadius = 2.5;
    view.backgroundColor = [UIColor colorWithWhite:224/255.0 alpha:1];
    [self addSubview:view];
    
    self.slider = [[UIView alloc] initWithFrame:view.bounds];
    _slider.layer.cornerRadius = 5;
    _slider.backgroundColor = [UIColor colorWithRed:232/255.0 green:60/255.0 blue:54/255.0 alpha:1];
    [view addSubview:_slider];
    
}

- (void)layoutThumb {
    if (_thumbCount == 1) {
        self.mainThumb = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, kThumbViewTop, 30, kThumbViewHeight)];
        _mainThumb.image = [UIImage imageNamed:@"Self-Pulley-2"];
        [self addSubview:_mainThumb];
        
        self.mainThumbText = [[TextImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, kThumbTextTop, 30, kThumbTextHeight)];
        _mainThumbText.image = [UIImage imageNamed:@"Self-Pulley-1"];
        _mainThumbText.label.text = [NSString stringWithFormat:@"%@", _numbers.lastObject];
        [self addSubview:_mainThumbText];
        
    } else if (_thumbCount == 2) {
        self.leftThumb = [[UIImageView alloc] initWithFrame:CGRectMake(0, kThumbViewTop, 30, kThumbViewHeight)];
        _leftThumb.image = [UIImage imageNamed:@"Self-Pulley-2"];
        [self addSubview:_leftThumb];
        
        self.leftThumbText = [[TextImageView alloc] initWithFrame:CGRectMake(0, kThumbTextTop, 30, kThumbTextHeight)];
        _leftThumbText.image = [UIImage imageNamed:@"Self-Pulley-1"];
        _leftThumbText.label.text = [NSString stringWithFormat:@"%@", _numbers.firstObject];
        [self addSubview:_leftThumbText];
        
        self.rightThumb = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, kThumbViewTop, 30, kThumbViewHeight)];
        _rightThumb.image = [UIImage imageNamed:@"Self-Pulley-2"];
        [self addSubview:_rightThumb];
        _rightThumbIndex = _numbers.count - 1;
        
        self.rightThumbText = [[TextImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, kThumbTextTop, 30, kThumbTextHeight)];
        _rightThumbText.image = [UIImage imageNamed:@"Self-Pulley-1"];
        _rightThumbText.label.text = [NSString stringWithFormat:@"%@", _numbers.lastObject];
        [self addSubview:_rightThumbText];
    }
}

- (CAShapeLayer *)maskLayer {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 15)];
    [path addLineToPoint:CGPointMake(15, 0)];
    [path addLineToPoint:CGPointMake(30, 15)];
    [path addLineToPoint:CGPointMake(30, 30)];
    [path addLineToPoint:CGPointMake(0, 30)];
    [path closePath];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [path CGPath];
    return maskLayer;
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    _touchBeginInMainThumb = CGRectContainsPoint(CGRectInset(self.mainThumb.frame, -10, -10), currentPoint);
    _touchBeginInLeftThumb = CGRectContainsPoint(CGRectInset(self.leftThumb.frame, -10, -10), currentPoint);
    _touchBeginInRightThumb = CGRectContainsPoint(CGRectInset(self.rightThumb.frame, -10, -10), currentPoint);
    _mainThumbText.hidden = _touchBeginInMainThumb;
    _leftThumbText.hidden = _touchBeginInLeftThumb;
    _rightThumbText.hidden = _touchBeginInRightThumb;
    if ([self.mSuperView isKindOfClass:[UIScrollView class]]) self.mSuperView.scrollEnabled = NO;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    CGFloat dx = currentPoint.x - previousPoint.x;
    
    if (_touchBeginInMainThumb && _thumbCount == 1) {
        CGFloat minX = MIN(self.mainThumb.center.x + dx, SCREEN_WIDTH - 15);
        CGFloat maxX = MAX(minX, 15);
        self.mainThumb.center = CGPointMake(maxX, self.mainThumb.center.y);
        [self adjustMainThumb];
        
    } else if (_touchBeginInLeftThumb && _thumbCount == 2) {
        CGFloat minX = MIN(self.leftThumb.center.x + dx, self.rightThumb.center.x - 15);
        CGFloat maxX = MAX(minX, 15);
        self.leftThumb.center = CGPointMake(maxX, self.leftThumb.center.y);
        [self adjustLeftThumb];
        
    } else if (_touchBeginInRightThumb && _thumbCount == 2) {
        CGFloat minX = MIN(self.rightThumb.center.x + dx, SCREEN_WIDTH - 15);
        CGFloat maxX = MAX(minX, self.leftThumb.center.x + 15);
        self.rightThumb.center = CGPointMake(maxX, self.rightThumb.center.y);
        [self adjustRightThumb];
        
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat width = (SCREEN_WIDTH - 30) / _numbers.count;
    if (_touchBeginInMainThumb && _thumbCount == 1) {
        _mainThumbIndex = MIN(self.mainThumb.frame.origin.x / width, _numbers.count - 1);
        CGRect frame = self.mainThumb.frame;
        frame.origin.x = (_mainThumbIndex + 0.5) * width;
        self.mainThumb.frame = frame;
        [self adjustMainThumb];
        [self setLabelText];
        
    } else if (_touchBeginInLeftThumb && _thumbCount == 2) {
        _leftThumbIndex = MIN(self.leftThumb.frame.origin.x / width, _numbers.count - 2);
        _leftThumbIndex = MIN(_leftThumbIndex, _rightThumbIndex - 1);
        CGRect frame = self.leftThumb.frame;
        frame.origin.x = (_leftThumbIndex + 0.5) * width;
        self.leftThumb.frame = frame;
        [self adjustLeftThumb];
        [self setLabelText];

    } else if (_touchBeginInRightThumb && _thumbCount == 2) {
        _rightThumbIndex = MIN(self.rightThumb.frame.origin.x / width, _numbers.count - 1);
        _rightThumbIndex = MAX(_rightThumbIndex, _leftThumbIndex+1);
        CGRect frame = self.rightThumb.frame;
        frame.origin.x = (_rightThumbIndex + 0.5) * width;
        self.rightThumb.frame = frame;
        [self adjustRightThumb];
        [self setLabelText];
    }
    _touchBeginInMainThumb = NO;
    _touchBeginInLeftThumb = NO;
    _touchBeginInRightThumb = NO;
    _rightThumbText.hidden = NO;
    _leftThumbText.hidden = NO;
    _mainThumbText.hidden = NO;
    if ([self.mSuperView isKindOfClass:[UIScrollView class]]) self.mSuperView.scrollEnabled = YES;
}


- (void)setLabelText {
    //1个滑块
    _mainThumbText.label.text = [NSString stringWithFormat:@"%@", _numbers[_mainThumbIndex]];
    if (_thumbCount == 1) {
        if (_mainThumbIndex < (_numbers.count - 1)) {
            id number = _numbers[_mainThumbIndex];
            self.textLabel.attributedText = [[NSString stringWithFormat:@"%@:%@%@以内", _conditionText, number, _unitText] left666666RightE83C36Style];
            self.maxNumber = number;
        } else if (_mainThumbIndex == (_numbers.count - 1)) {
            self.textLabel.attributedText = [[NSString stringWithFormat:@"%@:不限", _conditionText] left666666RightE83C36Style];
            self.maxNumber = nil;
        }
        return;
    }
    //2个滑块
    _leftThumbText.label.text = [NSString stringWithFormat:@"%@", _numbers[_leftThumbIndex]];
    _rightThumbText.label.text = [NSString stringWithFormat:@"%@", _numbers[_rightThumbIndex]];
    
    if (_leftThumbIndex == 0) {
        self.minNumber = nil;
        if (_rightThumbIndex == (_numbers.count - 1)) {
            self.textLabel.attributedText = [[NSString stringWithFormat:@"%@:不限", _conditionText] left666666RightE83C36Style];
            self.maxNumber = nil;
        } else {
            id number = _numbers[_rightThumbIndex];
            self.textLabel.attributedText = [[NSString stringWithFormat:@"%@:%@%@以下", _conditionText, number, _unitText] left666666RightE83C36Style];
            self.maxNumber = number;
        }
        
    } else {
        if (_rightThumbIndex == (_numbers.count - 1)) {
            id number = _numbers[_leftThumbIndex];
            self.textLabel.attributedText = [[NSString stringWithFormat:@"%@:%@%@以上", _conditionText, number, _unitText] left666666RightE83C36Style];
            self.minNumber = number;
            self.maxNumber = nil;
        } else {
            id leftNumber = _numbers[_leftThumbIndex];
            id rightNumber = _numbers[_rightThumbIndex];
            self.textLabel.attributedText = [[NSString stringWithFormat:@"%@:%@~%@%@", _conditionText, leftNumber, rightNumber, _unitText] left666666RightE83C36Style];
            self.minNumber = leftNumber;
            self.maxNumber = rightNumber;
        }
    }
    
}

- (void)adjustMainThumb {
    CGPoint center = _mainThumbText.center;
    center.x = _mainThumb.center.x;
    _mainThumbText.center = center;

    CGRect frame = self.slider.frame;
    frame.size.width = self.mainThumb.center.x - 15;
    self.slider.frame = frame;
}

- (void)adjustLeftThumb {
    CGPoint center = _leftThumbText.center;
    center.x = _leftThumb.center.x;
    _leftThumbText.center = center;

    CGRect frame = self.slider.frame;
    frame.origin.x = self.leftThumb.center.x - 15;
    frame.size.width = self.rightThumb.center.x - frame.origin.x - 15;
    self.slider.frame = frame;
}

- (void)adjustRightThumb {
    CGPoint center = _rightThumbText.center;
    center.x = _rightThumb.center.x;
    _rightThumbText.center = center;
    
    CGRect frame = self.slider.frame;
    frame.size.width = self.rightThumb.center.x - frame.origin.x - 15;
    self.slider.frame = frame;
    
}


@end



