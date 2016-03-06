//
//  KBNavgation.h
//  KBNavgation
//
//  Created by KentonYu on 16/2/29.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KBNavgationUrlProtocol) {
    KBNavgationUrlProtocolInApp = 0,
    KBNavgationUrlProtocolHTTP  = 1,
    KBNavgationUrlProtocolHTTPS = 2
};

@interface KBNavgation : NSObject

/**
 *  生成对应协议的路径
 *
 *  @param content  路径内容 //example Home/HomeViewController
 *  @param protocol 路径协议
 *
 *  @return 返回生成的路径    //example app://Home/HomeViewController
 */
+ (NSString *)kbNavgationUrlStrWithContent:(NSString *)content protocol:(KBNavgationUrlProtocol)protocol;

/**
 *  单例
 *
 *  @return 实例对象
 */
+ (instancetype)shareInstance;

/**
 *  设置自定义web控制器，显示Web页面，默认是跳转Safari
 *  全局设置
 *  @param webVC web控制器
 */
- (void)setCustomWebVCCla:(Class)webVCCla;

/**
 *  跳转相应UrlStr
 *
 *  @param urlStr   路径
 *  @param fromVC   跳转所在的控制器
 *  @param userInfo 传递的信息
 */
- (void)kbNavgationJumpToUrlStr:(NSString *)urlStr fromVC:(UIViewController *)fromVC withUserInfo:(NSDictionary *)userInfo;

@end
