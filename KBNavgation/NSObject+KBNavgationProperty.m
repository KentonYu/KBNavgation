//
//  NSObject+KBNavgationProperty.m
//  KBNavgation
//
//  Created by KentonYu on 16/3/5.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import "NSObject+KBNavgationProperty.h"
#import "KBNavgationProperty.h"
#import "KBNavgationPropertyType.h"
#import <objc/runtime.h>

typedef struct property_t {
    const char *name;
    const char *attributes;
} *propertyStruct;

static NSMutableDictionary *cachedProperties_;

@implementation NSObject (KBNavgationProperty)

+ (NSArray *)properties{

    NSMutableArray *cachedProperties = cachedProperties_[NSStringFromClass(self)];
    
    if (!cachedProperties) {
        cachedProperties = [NSMutableArray array];
        // 1.获得所有的属性
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList(self, &outCount);
        
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            
            KBNavgationProperty *propertyObj = [KBNavgationProperty propertyWithProperty:property];
            
            [cachedProperties addObject:propertyObj];
        }
        free(properties);
        
        cachedProperties_[NSStringFromClass(self)] = cachedProperties;
    }
    
    return cachedProperties;
}

@end
