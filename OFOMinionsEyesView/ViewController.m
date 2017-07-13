//
//  ViewController.m
//  OFOMinionsEyesView
//
//  Created by 刘小武 on 2017/7/13.
//  Copyright © 2017年 NorthKing. All rights reserved.
//

#import "ViewController.h"
#import "OFOMinionsHeadView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    OFOMinionsHeadView * headView = [[OFOMinionsHeadView alloc] initWithFrame:CGRectMake(60, 300, 200, 200)];
    [self.view addSubview:headView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
