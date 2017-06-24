//
//  ImageFilterView.h
//  AnimationTest
//
//  Created by 周重阳 on 15/11/12.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageFilterView : UIView
- (instancetype)initWithFrame:(CGRect)frame texts:(NSArray *)texts images:(NSArray *)images;
- (instancetype)initWithFrame:(CGRect)frame texts:(NSArray *)texts images:(NSArray *)images title:(NSString *)title;
@property (nonatomic, strong) NSString *text;
@end
