//
//  KBNavgationProperty.h
//  KBNavgation
//
//  Created by KentonYu on 16/3/5.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@class KBNavgationPropertyType;

@interface KBNavgationProperty : NSObject

/** 成员属性的名字 */
@property (nonatomic, readonly) NSString *name;
/** 成员属性的类型 */
@property (nonatomic, readonly) KBNavgationPropertyType *type;

+ (instancetype)propertyWithProperty:(objc_property_t)property;

@end
