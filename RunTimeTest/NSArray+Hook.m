//
//  NSArray+Hook.m
//  RunTimeTest
//
//  Created by LeonDeng on 2019/10/16.
//  Copyright © 2019 Ivan_deng. All rights reserved.
//

#import "NSArray+Hook.h"
#import "NSObject+Runtime.h"


@implementation NSArray (Hook)

+ (void)load {
    [NSClassFromString(@"__NSArrayI") swizzleInstanceMethodWithSelector:@selector(objectAtIndex:) AndSelector:@selector(custom_objectAtIndex:)];
    [NSClassFromString(@"__NSArrayI") swizzleInstanceMethodWithSelector:@selector(objectAtIndexedSubscript:) AndSelector:@selector(custom_objectAtIndexedSubscript:)];
}

- (id)custom_objectAtIndex:(NSUInteger)index {
    if (self.count > index) {
        return [self custom_objectAtIndex:index];
    } else {
        return @"你丫越界啦！🐂🍺";
    }
}

- (id)custom_objectAtIndexedSubscript:(NSUInteger)idx API_AVAILABLE(macos(10.8), ios(6.0), watchos(2.0), tvos(9.0)) {
    if (self.count > idx) {
        return [self custom_objectAtIndexedSubscript:idx];
    } else {
        return @"你丫越界啦！🐂🍺";
    }
}


@end
