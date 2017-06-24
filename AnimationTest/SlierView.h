//
//  SlierView.h
//  AnimationTest
//
//  Created by 周重阳 on 15/11/2.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlierView : UIView
- (instancetype)initWithFrame:(CGRect)frame thumbCount:(NSInteger)thumbCount numbers:(NSArray *)numbers unitText:(NSString *)unitText conditionText:(NSString *)conditionText;
@property (nonatomic, strong) NSNumber *minNumber;
@property (nonatomic, strong) NSNumber *maxNumber;
@property (nonatomic, strong) UIScrollView *mSuperView;
@end
