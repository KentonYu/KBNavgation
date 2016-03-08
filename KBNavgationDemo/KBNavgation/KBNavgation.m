//
//  KBNavgation.m
//  KBNavgation
//
//  Created by KentonYu on 16/2/29.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import "KBNavgation.h"
#import "NSObject+KBNavgationProperty.h"
#import "NSObject+KBNavgationDicToObject.h"

typedef NS_ENUM(NSUInteger, KBNavgationJumpUrlStrType) {
    KBNavgationJumpUrlStrTypePush    = 1,
    KBNavgationJumpUrlStrTypePresent = 2
};

static NSString *const KBNavgationProtocolInApp = @"app://";
static NSString *const KBNavgationProtocolHTTP  = @"http://";
static NSString *const KBNavgationProtocolHTTPS = @"https://";

static KBNavgation *instance = nil;

@interface KBNavgation ()

@property (nonatomic, strong) Class webVCCla;

@end

@implementation KBNavgation

#pragma mark Base
+ (NSString *)kbNavgationUrlStrWithContent:(NSString *)content protocol:(KBNavgationUrlProtocol)protocol {
    NSString *procolStr;
    switch (protocol) {
        case KBNavgationUrlProtocolInApp:
            procolStr = KBNavgationProtocolInApp;
            break;
        case KBNavgationUrlProtocolHTTP:
            procolStr = KBNavgationProtocolHTTP;
            break;
        case KBNavgationUrlProtocolHTTPS:
            procolStr = KBNavgationProtocolHTTPS;
            break;
    }
    NSMutableString *url = [[NSMutableString alloc] initWithString:procolStr];
    [url appendString:content];
    return [url copy];
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[KBNavgation alloc] init];
        }
    });
    return instance;
}

- (void)setCustomWebVCCla:(Class)webVCCla {
    _webVCCla = webVCCla;
}

#pragma mark Push
- (void)kbNavgationPushToUrlStr:(NSString *)urlStr fromVC:(UIViewController *)fromVC withUserInfo:(NSDictionary *)userInfo {
    [self kbNavgationPushToUrlStr:urlStr fromVC:fromVC withUserInfo:userInfo complete:nil];
}

- (void)kbNavgationPushToUrlStr:(NSString *)urlStr fromVC:(UIViewController *)fromVC withUserInfo:(NSDictionary *)userInfo complete:(KBNavgationCompleteBlock)completeBlock {
    [self p_jumpToUrlStr:urlStr fromVC:fromVC userInfo:userInfo complete:completeBlock jumpType:KBNavgationJumpUrlStrTypePush];
}

#pragma mark Present
- (void)kbNavgationPresentToUrlStr:(NSString *)urlStr fromVC:(UIViewController *)fromVC withUserInfo:(NSDictionary *)userInfo{
    [self kbNavgationPresentToUrlStr:urlStr fromVC:fromVC withUserInfo:userInfo complete:nil];
}

- (void)kbNavgationPresentToUrlStr:(NSString *)urlStr fromVC:(UIViewController *)fromVC withUserInfo:(NSDictionary *)userInfo complete:(KBNavgationCompleteBlock)completeBlock {
    [self p_jumpToUrlStr:urlStr fromVC:fromVC userInfo:userInfo complete:completeBlock jumpType:KBNavgationJumpUrlStrTypePresent];
}

#pragma mark Pravite
- (void)p_jumpToUrlStr:(NSString *)urlStr fromVC:(UIViewController *)fromVC userInfo:(NSDictionary *)userInfo complete:(KBNavgationCompleteBlock)completeBlock jumpType:(KBNavgationJumpUrlStrType)jumpType {
    if (jumpType == KBNavgationJumpUrlStrTypePush) {
        if (!fromVC.navigationController) {
            NSLog(@"%@ 无导航控制器",fromVC);
            return;
        }
    }
    NSRange protocolRange = [urlStr rangeOfString:@"://"];
    if (NSNotFound != protocolRange.location) {
        NSString *protocol                  = [urlStr substringWithRange:NSMakeRange(0, protocolRange.location+protocolRange.length)];
        KBNavgationUrlProtocol protocolEnum = [[KBNavgation shareInstance] p_KBNavgationChangeUrlProtocolStrToEnum:protocol];
        switch (protocolEnum) {
            case KBNavgationUrlProtocolInApp: {
                NSString *routeStr = [urlStr substringWithRange:NSMakeRange(protocol.length, urlStr.length-protocol.length)];
                NSString *claStr = [[routeStr componentsSeparatedByString:@"/"] lastObject];
                Class cla        = NSClassFromString(claStr);
                if (!cla) {
                    NSLog(@"无效路径，找不到控制器%@",claStr);
                    return;
                }
                
                id vcInstance = nil;
                if (userInfo) {   //userInfo 不为空，则将userInfo映射到控制器属性中
                    vcInstance = [cla objectWithDic:userInfo];
                } else {
                    vcInstance = [[cla alloc] init];
                }
                switch (jumpType) {
                    case KBNavgationJumpUrlStrTypePush: {
                        [fromVC.navigationController pushViewController:vcInstance animated:YES];
                        break;
                    }
                    case KBNavgationJumpUrlStrTypePresent: {
                        [fromVC presentViewController:vcInstance animated:YES completion:nil];
                        break;
                    }
                }
                break;
            }
            case KBNavgationUrlProtocolHTTP: {
                [self p_openSafari:urlStr fromVC:fromVC userInfo:userInfo jump:jumpType];
                break;
            }
            case KBNavgationUrlProtocolHTTPS: {
                [self p_openSafari:urlStr fromVC:fromVC userInfo:userInfo jump:jumpType];
                break;
            }
        }
        if (completeBlock) {
            completeBlock();
        }
    } else {
        NSLog(@"无效路径：%@",urlStr);
    }
}

- (KBNavgationUrlProtocol)p_KBNavgationChangeUrlProtocolStrToEnum:(NSString *)protocolStr {
    if ([protocolStr isEqualToString:KBNavgationProtocolInApp]) {
        return KBNavgationUrlProtocolInApp;
    }
    if ([protocolStr isEqualToString:KBNavgationProtocolHTTP]) {
        return KBNavgationUrlProtocolHTTP;
    }
    if ([protocolStr isEqualToString:KBNavgationProtocolHTTPS]) {
        return KBNavgationUrlProtocolHTTPS;
    }
    NSLog(@"无效路径");
    return NSNotFound;
}

- (void)p_openSafari:(NSString *)urlStr fromVC:(UIViewController *)fromVC userInfo:(NSDictionary *)userInfo jump:(KBNavgationJumpUrlStrType)jumpType {
    if (_webVCCla) {
        id webVC = nil;
        if (userInfo) {
           webVC = [_webVCCla objectWithDic:userInfo];
        } else {
           webVC = [[_webVCCla alloc] init];
        }
        switch (jumpType) {
            case KBNavgationJumpUrlStrTypePush: {
                [fromVC.navigationController pushViewController:webVC animated:YES];
                break;
            }
            case KBNavgationJumpUrlStrTypePresent: {
                [fromVC presentViewController:webVC animated:YES completion:nil];
                break;
            }
        }
        
    } else {
      [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlStr]];
    }
}
@end
