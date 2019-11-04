//
//  NSObject+Runtime.m
//  RunTimeTest
//
//  Created by Ivan_deng on 2019/8/31.
//  Copyright © 2019 Ivan_deng. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/message.h>

@implementation NSObject (Runtime)

- (DeallocHandlerBlock)deallocHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDeallocHandler:(DeallocHandlerBlock)deallocHandler {
    objc_setAssociatedObject(self, _cmd, deallocHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)dealloc {
    !self.deallocHandler ?: self.deallocHandler(self);
}
#pragma clang dianostic pop

+ (BOOL)isContainSEL:(SEL)selector {
    unsigned int count;
    Method *methodList = class_copyMethodList(self,&count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *tempMethodString = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        if ([tempMethodString isEqualToString:NSStringFromSelector(selector)]) {
            return YES;
        }
    }
    return NO;
}

- (void)swizzleInstanceMethodWithSelector:(SEL)selector1 AndSelector:(SEL)selector2 {
    Method originMethod = class_getInstanceMethod(self.class, selector1);
    Method newMethod = class_getInstanceMethod(self.class, selector2);
    method_exchangeImplementations(originMethod, newMethod);
}

+ (void)swizzleInstanceMethodWithSelector:(SEL)selector1 AndSelector:(SEL)selector2 {
    Method originMethod = class_getInstanceMethod(self, selector1);
    Method newMethod = class_getInstanceMethod(self, selector2);
    method_exchangeImplementations(originMethod, newMethod);
}

+ (void)swizzleClassMethodWithSelector:(SEL)selector1 AndSelector:(SEL)selector2 {
    Method originMethod = class_getClassMethod(self, selector1);
    Method newMethod = class_getClassMethod(self, selector2);
    method_exchangeImplementations(originMethod, newMethod);
}

+ (NSArray <NSString *> *)methodNames {
    unsigned int count;
    Method *methodList = class_copyMethodList(self, &count);
    NSMutableArray *methodNames = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
//        NSLog(@"%s%s",__func__,sel_getName(method_getName(method)));
        NSString *methodName = [NSString stringWithFormat:@"%s%s", __func__, sel_getName(method_getName(method))];
        [methodNames addObject:methodName];
    }
    return methodNames;
}

+ (void)logPropertys {
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList(self, &count);
    for (int i = 0; i < count; i++) {
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        NSLog(@"%@",name);
    }
}

+ (void)logIvars {
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        // objc_property_t 属性类型
        Ivar ivar = ivars[i];
        // 获取属性的名称 C语言字符串
        const char *cName = ivar_getName(ivar);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        NSLog(@"%@",name);
    }
}

@end
