//
//  BusinessOneCell.h
//  AKCar
//
//  Created by 周重阳 on 16/4/29.
//  Copyright © 2016年 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessTwoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *featureImView;
@property (weak, nonatomic) IBOutlet UIImageView *carImView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *midLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLabelHeight;
- (void)configCellWithModel:(id)model;
@end
