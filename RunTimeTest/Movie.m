//
//  Movie.m
//  RunTimeTest
//
//  Created by Ivan_deng on 2017/11/18.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//
#import <objc/runtime.h>
#import <objc/message.h>
#import "Movie.h"

@implementation Movie

- (void)encodeWithCoder:(NSCoder *)enCoder {
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList([Movie class],&ivarCount);
    for(int i = 0; i < ivarCount; i++) {
        //取出对应i位置的成员变量
        Ivar ivar = ivars[i];
        //查看成员变量
        const char *name = ivar_getName(ivar);
        //归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [enCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)deCoder {
    if(self = [super init]) {
        unsigned int ivarCount = 0;
        Ivar *ivars = class_copyIvarList([Movie class], &ivarCount);
        for(int i = 0; i < ivarCount; i++) {
            //取出对应成员变量
            Ivar ivar = ivars[i];
            //查看成员变量
            const char *name = ivar_getName(ivar);
            //解档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [deCoder decodeObjectForKey:key];
            //设置到成员变量
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

@end
