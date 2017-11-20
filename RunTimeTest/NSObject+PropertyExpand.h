//
//  NSObject+PropertyExpand.h
//  RunTimeTest
//
//  Created by Ivan_deng on 2017/11/17.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PropertyExpand)

//在分类中声明property，并不会增加原来类的成员变量，只会增加对应的getter和setter
@property(nonatomic,strong) NSString * name;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
