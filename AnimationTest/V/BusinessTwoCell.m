//
//  BusinessOneCell.m
//  AKCar
//
//  Created by 周重阳 on 16/4/29.
//  Copyright © 2016年 AK. All rights reserved.
//

#import "BusinessTwoCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
@implementation BusinessTwoCell

- (void)awakeFromNib {
    // Initialization code
    _carImView.contentMode = UIViewContentModeScaleAspectFill;
    _carImView.layer.masksToBounds = YES;
    _topLabel.font = [UIFont systemFontOfSize:15];
    _topLabel.textColor = [UIColor blackColor];
    _topLabel.numberOfLines = 2;
    _midLabel.font = [UIFont systemFontOfSize:12];
    _midLabel.textColor = [UIColor lightGrayColor];
    _bottomLabel.font = [UIFont systemFontOfSize:18];
    _bottomLabel.textColor = [UIColor lightGrayColor];
    
    UIView *underLine = [[UIView alloc] initWithFrame:CGRectMake(0, 222, 375/2.0, 0.5)];
    underLine.backgroundColor = [UIColor colorWithWhite:243/255.0 alpha:1];
    [self addSubview:underLine];
    [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.and.right.and.bottom.equalTo(@0);
    }];
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(375/2.0-0.5, 0, 0.5, self.frame.size.height)];
    rightLine.backgroundColor = [UIColor colorWithWhite:243/255.0 alpha:1];
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@0.5);
        make.right.and.top.and.bottom.equalTo(@0);
    }];
}

- (void)configCellWithModel:(id)model {
    [self.carImView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.100.24%@",model[@"photo"]]] placeholderImage:nil completed:nil];
    self.topLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model[@"brandName"],model[@"modelName"],model[@"styleName"]];
    self.midLabel.text = [NSString stringWithFormat:@"%@/%.2f万公里",model[@"firstRegDate"],[model[@"kmNum"] doubleValue]/10000];
    self.bottomLabel.text = [NSString stringWithFormat:@"¥ %.2f万元",[model[@"price"] doubleValue]/10000];
}
@end
