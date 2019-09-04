//
//  NSObject+Runtime.h
//  RunTimeTest
//
//  Created by Ivan_deng on 2019/8/31.
//  Copyright © 2019 Ivan_deng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Runtime)

/**
 判断当前类有没有包含某方法

 @param selector 方法索引编号
 @return 是否含有方法
 */
+ (BOOL)isContainSEL:(SEL)selector;

/**
 交换类中的某两个实例方法

 @param selector1 方法1
 @param selector2 方法2
 */
- (void)exchangeInstanceMethodWithSelector:(SEL)selector1 AndSelector:(SEL)selector2;

/**
 交换类中的某两个实例方法
 
 @param selector1 方法1
 @param selector2 方法2
 */
+ (void)exchangeInstanceMethodWithSelector:(SEL)selector1 AndSelector:(SEL)selector2;

/**
 交换类中的某两个类方法

 @param selector1 方法1
 @param selector2 方法2
 */
+ (void)exchangeClassMethodWithSelector:(SEL)selector1 AndSelector:(SEL)selector2;

/**
 添加实例方法到类
 
 @param selector 方法SEL指针
 @return 成功与否
 */
+ (BOOL)addInstanceMethod:(SEL)selector;

/**
 添加类方法到类
 
 @param selector 方法SEL指针
 @return 成功与否
 */
+ (BOOL)addClassMethod:(SEL)selector;

/**
 获得当前类的所有方法名

 @return 方法名数组
 */
+ (NSArray <NSString *> *)methodNames;

@end

NS_ASSUME_NONNULL_END
