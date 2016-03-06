//
//  SecondViewController.h
//  KBNavgationDemo
//
//  Created by KentonYu on 16/3/6.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (nonatomic, assign) int       intA;
@property (nonatomic, assign) NSInteger integerA;
@property (nonatomic, assign) CGFloat   floatA;
@property (nonatomic, strong) NSNumber  *numberA;
@property (nonatomic, assign) BOOL      boolA;
@property (nonatomic, copy  ) NSString  *stringA;
@property (nonatomic, copy  ) void(^blockA)(void);

@end
