//
//  NSObject+KBNavgationDicToObject.m
//  KBNavgation
//
//  Created by KentonYu on 16/3/5.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+KBNavgationProperty.h"
#import "NSObject+KBNavgationDicToObject.h"
#import "KBNavgationProperty.h"
#import "KBNavgationPropertyType.h"

@implementation NSObject (KBNavgationDicToObject)
+ (instancetype)objectWithDic:(id)dic{
    if (!dic) return nil;
    return [[[self alloc] init] setDic:dic];
}

- (instancetype)setDic:(id)dic{
    NSArray *propertiesArray = [self.class properties];
    for (KBNavgationProperty *property in propertiesArray) {
        KBNavgationPropertyType *type = property.type;
        Class typeClass = type.typeClass;
        
        id value = [dic valueForKey:property.name];
        if (!value) continue;
        
        if (type.isNumberType){
            NSString *oldValue = value;
            // 字符串->数字
            if ([value isKindOfClass:[NSString class]]){
                value = [[[NSNumberFormatter alloc] init] numberFromString:value];
                if (type.isBoolType) {
                    NSString *lower = [oldValue lowercaseString];
                    if ([lower isEqualToString:@"yes"] || [lower isEqualToString:@"true"] ) {
                        value = @YES;
                    } else if ([lower isEqualToString:@"no"] || [lower isEqualToString:@"false"]) {
                        value = @NO;
                    }
                }
            }
        }
        else{
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
