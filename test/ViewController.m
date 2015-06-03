//
//  ViewController.m
//  test
//
//  Created by LvJianfeng on 15/6/3.
//  Copyright (c) 2015年 famnotes. All rights reserved.
//
//  https://github.com/LvJianfeng
//  http://weibo.com/aaalizzwell
#import "ViewController.h"
#import "OODoubleLevelMenu.h"

@interface ViewController ()
@property (nonatomic, strong) OODoubleLevelMenu *menuView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tap1:(id)sender {
    if (self.menuView) {
        [self.menuView removeFromSuperview];
        self.menuView = nil;
    }
}

- (IBAction)tap2:(id)sender {
    NSArray *arr = [[NSArray alloc] initWithObjects:@"中国",@"美国",@"法国",@"德国",@"英国",@"哈哈", nil];
    if (self.menuView) {
        return;
    }
    self.menuView = [[OODoubleLevelMenu alloc] initWithFrame:CGRectMake(0, 0, 100, 220) WithData:arr withSelectIndex:^(NSInteger left, NSInteger right, id info) {
        NSLog(@"test");
    }];
    self.menuView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.menuView];
}
@end
