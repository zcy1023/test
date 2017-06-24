////
////  FourthViewController.m
////  AnimationTest
////
////  Created by 周重阳 on 15/11/19.
////  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
////
//
//#import "FourthViewController.h"
//#import "BusinessTwoCell.h"
//#import "YYFPSLabel.h"
//#define SCREEN_WIDTH    375
//#define SCREEN_HEIGHT   667
//
//
//@interface FourthViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
//@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic, strong) NSMutableArray *cDataSource;  //正常车源
//@end
//
//@implementation FourthViewController
//
//static NSString * const twoIdentiffer = @"twoIdentiffer";
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    [self layoutCollectionView];
//    [self requestData];
//}
//
//#pragma mark collectionView DataSource
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.cDataSource.count;
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    id model = self.cDataSource[indexPath.item];
//   
//    BusinessTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:twoIdentiffer forIndexPath:indexPath];
//    [cell configCellWithModel:model];
//    return cell;
//    
//}
//#pragma mark collectionView Delegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    id obj = self.cDataSource[indexPath.item];
//    NSLog(@"obj:%@",obj);
//}
//
//- (void)layoutCollectionView {
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.sectionInset = UIEdgeInsetsZero;
//    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/2.0, (SCREEN_WIDTH/2.0-20)/3*2+109);
//    flowLayout.minimumLineSpacing = 0;
//    flowLayout.minimumInteritemSpacing = 0;
//    
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) collectionViewLayout:flowLayout];
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
//    collectionView.backgroundColor = [UIColor whiteColor];
//    collectionView.alwaysBounceVertical = YES;
////    [collectionView registerClass:[BusinessTwoCell class] forCellWithReuseIdentifier:twoIdentiffer];
//    [collectionView registerNib:[UINib nibWithNibName:@"BusinessTwoCell" bundle:nil] forCellWithReuseIdentifier:twoIdentiffer];
//    [self.view addSubview:collectionView];
//    self.collectionView = collectionView;
//    
//    YYFPSLabel *_fpsLabel = [YYFPSLabel new];
//    _fpsLabel.frame = CGRectMake(20, 300, 100, 40);
//    [self.view addSubview:_fpsLabel];
//}
//
//- (void)requestData {
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.100.142:9040/car-seller-client-interfaces/m/business/car/list?currentPage=0&pageSize=100"]];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        if (connectionError==nil) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            self.cDataSource = dic[@"object"];
//            [self.collectionView reloadData];
//        }
//    }];
//}
//@end
