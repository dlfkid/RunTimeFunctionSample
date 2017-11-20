//
//  Person.m
//  RunTimeTest
//
//  Created by Ivan_deng on 2017/11/17.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//
#import <objc/message.h>
#import "Person.h"

@implementation Person

- (void)selfIntroduce {
    NSLog(@"My name is %@ and I am %d years old, %d height, I always tell somebody %@",self.name,self.age,self.height,self.qoute);
}

void aaa(id self,SEL _cmd, NSNumber *meter) {
    NSLog(@"跑了%@米",meter);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if(sel == NSSelectorFromString(@"run:")) {
        // 动态添加run方法
        // class: 给哪个类添加方法
        // SEL: 添加哪个方法，即添加方法的方法编号
        // IMP: 方法实现 => 函数 => 函数入口 => 函数名（添加方法的函数实现（函数地址））
        // type: 方法类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, sel, (IMP)aaa, "v@:@");
        return true;
    }
    return [super resolveInstanceMethod:sel];
}


@end
