//
//  KBNavgationProperty.m
//  KBNavgation
//
//  Created by KentonYu on 16/3/5.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import "KBNavgationProperty.h"
#import "KBNavgationPropertyType.h"
#import <objc/runtime.h>

@implementation KBNavgationProperty

+ (instancetype)propertyWithProperty:(objc_property_t)property {
    return  [[KBNavgationProperty alloc] initWithProperty:property];
}

- (instancetype)initWithProperty:(objc_property_t)property {
    if (self = [super init]) {
        _name = @(property_getName(property));
        _type = [KBNavgationPropertyType propertyTypeWithAttributeString:@(property_getAttributes(property))];;
    }
    return self;
}

@end
