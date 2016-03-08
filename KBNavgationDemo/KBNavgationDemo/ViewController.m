//
//  ViewController.m
//  KBNavgationDemo
//
//  Created by KentonYu on 16/3/6.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"First";
    
    UIButton *pushButton = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 100, 50)];
        [button setTitle:@"Push" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor orangeColor];
        [button addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:pushButton];
    
    UIButton *presentButton = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 114, 100, 50)];
        [button setTitle:@"Present" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor greenColor];
        [button addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:presentButton];
    
    UIButton *httpButton = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 164, 100, 50)];
        [button setTitle:@"HTTP" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor blueColor];
        [button addTarget:self action:@selector(http:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:httpButton];
}

- (void)push:(id)sender {
    void(^block)(void) = ^{
        NSLog(@"demoBlock");
    };
    TestModel *model = [[TestModel alloc] init];
    model.name = @"testModelName";
    model.age  = 22;
    
    NSDictionary *userInfo = @{
                               @"intA" : @1,
                               @"integerA" : @2,
                               @"floatA"   : @3.12,
                               @"numberA"  : @4,
                               @"boolA"    : @(YES),
                               @"stringA"  : @(2222),
                               @"blockA"   : block,
                               @"arrayA"   : @[@1,@2,@3],
                               @"testModel": model
                               };
    KBNavgationCompleteBlock completeBlock = ^{
        NSLog(@"completeBlock");
    };
    
    [[KBNavgation shareInstance] kbNavgationPushToUrlStr:[KBNavgation kbNavgationUrlStrWithContent:@"SecondViewController" protocol:KBNavgationUrlProtocolInApp] fromVC:self withUserInfo:userInfo complete:completeBlock];
}

- (void)present:(id)sender {
    void(^block)(void) = ^{
        NSLog(@"demoBlock");
    };
    TestModel *model = [[TestModel alloc] init];
    model.name = @"testModelName";
    model.age  = 22;
    
    NSDictionary *userInfo = @{
                               @"intA" : @1,
                               @"integerA" : @2,
                               @"floatA"   : @3.12,
                               @"numberA"  : @4,
                               @"boolA"    : @(YES),
                               @"stringA"  : @(2222),
                               @"blockA"   : block,
                               @"arrayA"   : @[@1,@2,@3],
                               @"testModel": model
                               };
    KBNavgationCompleteBlock completeBlock = ^{
        NSLog(@"completeBlock");
    };
    
    [[KBNavgation shareInstance] kbNavgationPresentToUrlStr:[KBNavgation kbNavgationUrlStrWithContent:@"SecondViewController" protocol:KBNavgationUrlProtocolInApp] fromVC:self withUserInfo:userInfo complete:completeBlock];
}

- (void)http:(id)sender {
     [[KBNavgation shareInstance] kbNavgationPushToUrlStr:[KBNavgation kbNavgationUrlStrWithContent:@"baidu.com" protocol:KBNavgationUrlProtocolHTTP] fromVC:self withUserInfo:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
