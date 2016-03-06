//
//  NSObject+KBNavgationDicToObject.m
//  KBNavgation
//
//  Created by KentonYu on 16/3/5.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import "NSObject+KBNavgationProperty.h"
#import "NSObject+KBNavgationDicToObject.h"
#import "KBNavgationProperty.h"
#import "KBNavgationPropertyType.h"

@implementation NSObject (KBNavgationDicToObject)
+ (instancetype)objectWithDic:(id)dic {
    if (!dic) return nil;
    return [[[self alloc] init] setDic:dic];
}

- (instancetype)setDic:(id)dic {
    NSArray *propertiesArray = [self.class properties];
    for (KBNavgationProperty *property in propertiesArray) {
        //获取对应字典的值
        id value = [dic valueForKey:property.name];
        if (!value) continue;
        
        //获取对应属性的类型信息
        KBNavgationPropertyType *type = property.type;
        Class typeClass = type.typeClass;

        if (type.isNumberType) {
            // 字符串->数字
            if ([value isKindOfClass:[NSString class]]){
                value = [[[NSNumberFormatter alloc] init] numberFromString:value];
                NSString *oldValue = value;
                //如果是BOOL值的，则将dic中的yes no true false 1 2 转成 NSNumber
                if (type.isBoolType) {
                    NSString *lower = [oldValue lowercaseString];
                    if ([lower isEqualToString:@"yes"] || [lower isEqualToString:@"true"] || [lower isEqual:@1]) {
                        value = @YES;
                    } else if ([lower isEqualToString:@"no"] || [lower isEqualToString:@"false"] || [lower isEqual:@0]) {
                        value = @NO;
                    } else {
                        value = @NO;
                    }
                }
            }
        } else {
            //属性是NSString  值是NSNumber或NSUrl 则进行转化
            if (typeClass == [NSString class]) {
                if ([value isKindOfClass:[NSNumber class]]) {
                    if (type.isNumberType)
                        // NSNumber -> NSString
                        value = [value description];
                }else if ([value isKindOfClass:[NSURL class]]){
                    // NSURL -> NSString
                    value = [value absoluteString];
                }
            }
        }
        [self setValue:value forKey:property.name];
    }
    
    return self;
}
@end
