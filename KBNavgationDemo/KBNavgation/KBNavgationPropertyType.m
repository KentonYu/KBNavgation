//
//  KBNavgationPropertyType.m
//  KBNavgation
//
//  Created by KentonYu on 16/3/5.
//  Copyright © 2016年 KentonYu. All rights reserved.
//

#import "KBNavgationPropertyType.h"

/**
 *  属性类型对应的字符
 */
static NSString *const KBPropertyTypeInt     = @"i";
static NSString *const KBPropertyTypeShort   = @"s";
static NSString *const KBPropertyTypeFloat   = @"f";
static NSString *const KBPropertyTypeDouble  = @"d";
static NSString *const KBPropertyTypeLong    = @"q";
static NSString *const KBPropertyTypeChar    = @"c";
static NSString *const KBPropertyTypeBOOL1   = @"c";
static NSString *const KBPropertyTypeBOOL2   = @"b";
static NSString *const KBPropertyTypePointer = @"*";

static NSString *const KBPropertyTypeIvar    = @"^{objc_ivar=}";
static NSString *const KBPropertyTypeMethod  = @"^{objc_method=}";
static NSString *const KBPropertyTypeBlock   = @"@?";
static NSString *const KBPropertyTypeClass   = @"#";
static NSString *const KBPropertyTypeSEL     = @":";
static NSString *const KBPropertyTypeId      = @"@";

//缓存这个类型
static NSMutableDictionary *cachedTypesDic;

@implementation KBNavgationPropertyType

+ (void)load {
    cachedTypesDic = [NSMutableDictionary dictionary];
}

+ (instancetype)propertyTypeWithAttributeString:(NSString *)string {
    return [[KBNavgationPropertyType alloc] initWithTypeString:string];
}

- (instancetype)initWithTypeString:(NSString *)string {
    NSUInteger loc = 1;
    NSUInteger len = [string rangeOfString:@","].location - loc;
    NSString *typeCode = [string substringWithRange:NSMakeRange(loc, len)];
    
    if (!cachedTypesDic[typeCode]) { //已经存在 则取缓存中的
        self = [super init];
        [self getTypeCode:typeCode];
        cachedTypesDic[typeCode] = self;
    }
    return self;
}

- (void)getTypeCode:(NSString *)code {
    if ([code isEqualToString:KBPropertyTypeId]) {
        _idType = YES;
    } else if (code.length > 3 && [code hasPrefix:@"@\""]) {
        // 去掉@"和"，截取中间的类型名称
        _code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(_code);
        _numberType = (_typeClass == [NSNumber class] || [_typeClass isSubclassOfClass:[NSNumber class]]);
    }
    
    // 是否为数字类型
    NSString *lowerCode = code.lowercaseString;
    NSArray *numberTypes = @[KBPropertyTypeInt, KBPropertyTypeShort, KBPropertyTypeBOOL1, KBPropertyTypeBOOL2, KBPropertyTypeFloat, KBPropertyTypeDouble, KBPropertyTypeLong, KBPropertyTypeChar];
    if ([numberTypes containsObject:lowerCode]) {
        _numberType = YES;
        if ([lowerCode isEqualToString:KBPropertyTypeBOOL1] || [lowerCode isEqualToString:KBPropertyTypeBOOL2]) {
            _boolType = YES;
        }
    }
    
    //是否是Block
    if ([code isEqualToString:KBPropertyTypeBlock]) {
        _blockType = YES;
    }
}
@end
