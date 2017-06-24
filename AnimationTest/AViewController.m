//
//  AViewController.m
//  AnimationTest
//
//  Created by 周重阳 on 15/11/3.
//  Copyright © 2015年 浙江艾卡资产管理有限公司. All rights reserved.
//

#import "AViewController.h"
#import "SlierView.h"
#import "ImageFilterView.h"


@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    
    SlierView *sliderView = [[SlierView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) thumbCount:2 numbers:@[@0, @3, @5, @10, @15, @20, @30, @50, @100, @"不限"] unitText:@"万元" conditionText:@"价格区间"];
    sliderView.mSuperView = tableView;
    SlierView *sliderView2 = [[SlierView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sliderView.frame), 0, 0) thumbCount:1 numbers:@[@2, @3, @4, @5, @6, @7, @9, @10, @15, @"不限"] unitText:@"万公里" conditionText:@"行驶里程"];
    sliderView2.mSuperView = tableView;
    SlierView *sliderView3 = [[SlierView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sliderView2.frame), 0, 0) thumbCount:2 numbers:@[@0, @1, @2, @3, @4, @5, @6, @7, @"不限"] unitText:@"年" conditionText:@"车龄区间"];
    sliderView3.mSuperView = tableView;
    ImageFilterView *filterView = [[ImageFilterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sliderView3.frame), 0, 0) texts:@[@"黑色", @"白色", @"银灰色", @"深灰色", @"红色", @"蓝色", @"绿色", @"香槟色", @"黄色", @"紫色", @"其他"] images:@[@"Self-Car-1", @"Self-Car-2", @"Self-Car-3", @"Self-Car-4", @"Self-Car-5", @"Self-Car-6", @"Self-Car-7", @"Self-Car-8", @"Self-Car-9", @"Self-Car-10", @"Self-Car-11"]];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(filterView.frame))];
    [footerView addSubview:sliderView];
    [footerView addSubview:sliderView2];
    [footerView addSubview:sliderView3];
    [footerView addSubview:filterView];
    tableView.tableFooterView = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
