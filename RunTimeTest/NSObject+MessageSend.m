//
//  NSObject+MessageSend.m
//  RunTimeTest
//
//  Created by Ivan_deng on 2019/8/31.
//  Copyright © 2019 Ivan_deng. All rights reserved.
//
#import <objc/message.h>
#import "NSObject+MessageSend.h"

@implementation NSObject (MessageSend)

+ (void)load {
    Method originalMethod = class_getInstanceMethod(NSObject.class, @selector(doesNotRecognizeSelector:));
    Method newMethod = class_getInstanceMethod(NSObject.class, @selector(runtime_doesNotRecognizeSelector:));
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)runtime_doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"消息无法处理");
}

@end
