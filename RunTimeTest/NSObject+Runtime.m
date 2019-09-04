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

- (void)exchangeInstanceMethodWithSelector:(SEL)selector1 AndSelector:(SEL)selector2 {
    Method originMethod = class_getInstanceMethod(self.class, selector1);
    Method newMethod = class_getInstanceMethod(self.class, selector2);
    method_exchangeImplementations(originMethod, newMethod);
}

+ (void)exchangeInstanceMethodWithSelector:(SEL)selector1 AndSelector:(SEL)selector2 {
    Method originMethod = class_getInstanceMethod(self, selector1);
    Method newMethod = class_getInstanceMethod(self, selector2);
    method_exchangeImplementations(originMethod, newMethod);
}

+ (void)exchangeClassMethodWithSelector:(SEL)selector1 AndSelector:(SEL)selector2 {
    Method originMethod = class_getClassMethod(self, selector1);
    Method newMethod = class_getClassMethod(self, selector2);
    method_exchangeImplementations(originMethod, newMethod);
}

+ (BOOL)addInstanceMethod:(SEL)selector {
    Method method = class_getInstanceMethod(self, selector);
    IMP implementation = class_getMethodImplementation(self, selector);
    return class_addMethod(self, selector, implementation, method_getTypeEncoding(method));
}

+ (BOOL)addClassMethod:(SEL)selector {
    Method method = class_getClassMethod(self, selector);
    IMP implementation = class_getMethodImplementation(self, selector);
    return class_addMethod(self, selector, implementation, method_getTypeEncoding(method));
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

@end
