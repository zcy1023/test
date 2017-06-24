//
//  ImageFilterView.m
//  AnimationTest
//
//  Created by 周重阳 on 15/11/12.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import "ImageFilterView.h"
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
#define kTextLabelTop           0
#define kTextLabelHeight        30
#define kCollectionViewTop      (kTextLabelTop + kTextLabelHeight)
#define kCollectionViewHeight   230

#define kSelfHeight             (kCollectionViewTop + kCollectionViewHeight)

@interface ImageTextCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation ImageTextCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_backgroundImageView];
        
        CGFloat space = (frame.size.height - 40)/4.0;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 51)/2.0, space, 51, 20)];
        [self.contentView addSubview:_imageView];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame) + space, frame.size.width, 20)];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = [UIColor colorWithWhite:102/255.0 alpha:1];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    self.backgroundImageView.image = selected ? [UIImage imageNamed:@"Self-Marquee"] : nil;
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

@interface ImageFilterView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *texts;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) NSIndexPath *currentIndex;
@end

@implementation ImageFilterView

static NSString * const identiffer = @"identiffer";

- (instancetype)initWithFrame:(CGRect)frame texts:(NSArray *)texts images:(NSArray *)images {
    return [self initWithFrame:frame texts:texts images:images title:@"车身颜色"];
}

- (instancetype)initWithFrame:(CGRect)frame texts:(NSArray *)texts images:(NSArray *)images title:(NSString *)title {
    self = [super initWithFrame:CGRectMake(0, frame.origin.y, SCREEN_WIDTH, kSelfHeight)];
    if (self) {
        _title = title;
        _texts = texts;
        _images = images;
        [self layoutTextLabel];
        [self layoutCollectionView];
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
    _textLabel.attributedText = [[NSString stringWithFormat:@"%@:不限", _title] left666666RightE83C36Style];
    _textLabel.adjustsFontSizeToFitWidth = YES;
    [view addSubview:_textLabel];
}

- (void)layoutCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    flowLayout.itemSize = CGSizeMake(65, 60);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kCollectionViewTop, SCREEN_WIDTH, kCollectionViewHeight) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[ImageTextCell class] forCellWithReuseIdentifier:identiffer];
    [self addSubview:collectionView];

}

#pragma mark - UIColectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.texts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identiffer forIndexPath:indexPath];
    cell.textLabel.text = self.texts[indexPath.item];
    cell.imageView.image = [UIImage imageNamed:self.images[indexPath.item]];
    cell.selected = _currentIndex != nil && _currentIndex.item == indexPath.item;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.textLabel.attributedText = [[NSString stringWithFormat:@"%@:%@", _title, self.texts[indexPath.item]] left666666RightE83C36Style];
    _currentIndex = indexPath;
    [collectionView reloadData];
}

@end
