//
//  SecondViewController.m
//  KBNavgationDemo
//
//  Created by KentonYu on 16/3/6.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "SecondViewController.h"
#import "TestModel.h"

static NSString *const kTableViewIdentity = @"TableViewCellIdentity";

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *dataList;
}

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SecondViewController

- (void)dealloc {
    NSLog(@"%@ dealloc",[self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Second";
    
    [self p_initData];
    
    NSLog(@"arrayA %@",_arrayA);
    NSLog(@"testModel - name:%@ age:%ld", _testModel.name, (long)_testModel.age);
    //    NSLog(@"\n intA=%d, \n integerA=%ld, \n floatA=%f, \n numberA=%@, \n boolA=%d, \n stringA=%@ \n", _intA, (long)_integerA, _floatA, _numberA, _boolA, _stringA);
    if (self.blockA) self.blockA();
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_HEIGHT)];
        tableView.dataSource = self;
        tableView.delegate   = self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView;
    });
    [self.view addSubview:self.tableView];

    self.backButton = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( (SCREEN_WIDTH-100)/2.0f, SCREEN_HEIGHT-50.0f-50.0f, 100.0f, 50.0f)];
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"Back" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.view addSubview:self.backButton];
    
}

- (void)p_initData {
    dataList = @[
                 @{
                     @"title":@"intA",
                     @"value":@(_intA)
                     },
                 @{
                     @"title":@"integerA",
                     @"value":@(_integerA)
                     },
                 @{
                     @"title":@"floatA",
                     @"value":@(_floatA)
                     },
                 @{
                     @"title":@"numberA",
                     @"value":_numberA
                     },
                 @{
                     @"title":@"boolA",
                     @"value":@(_boolA)
                     },
                 @{
                     @"title":@"stringA",
                     @"value":_stringA
                     },
                 ];
}

- (void)back:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark UITabelView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewIdentity];
    if (!cell) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kTableViewIdentity];
    }
    cell.textLabel.text       = [NSString stringWithFormat:@"%@",dataList[indexPath.row][@"title"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",dataList[indexPath.row][@"value"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
