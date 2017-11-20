//
//  NSObject+PropertyExpand.m
//  RunTimeTest
//
//  Created by Ivan_deng on 2017/11/17.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//
#import <objc/message.h>
#import "NSObject+PropertyExpand.h"

@implementation NSObject (PropertyExpand)

- (void)setName:(NSString *)name {
    // objc_setAssociatedObject（将某个值跟某个对象关联起来，将某个值存储到某个对象中）
    // object:给哪个对象添加属性
    // key:属性名称
    // value:属性值
    // policy:保存策略
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, @"name");
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    //创建对应的对象
    id objc = [[self alloc] init];
    //利用runtime给对象中的属性赋值
    /**
     class_copyIvarList: 获取类中的所有成员变量
     Ivar：成员变量
     第一个参数：表示获取哪个类中的成员变量
     第二个参数：表示这个类有多少成员变量，传入一个Int变量地址，会自动给这个变量赋值
     返回值Ivar *：指的是一个ivar数组，会把所有成员属性放在一个数组中，通过返回的数组就能全部获取到。
     count: 成员变量个数
     */
    unsigned int count = 0;
    //获取类中的所有带下划线的成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    //如果要获取类中包括不带下划线的属性
    //Ivar *propertyList = class_copyPropertyList(self, count);
    
    
    //变量所有成员变量
    for(int i = 0; i < count; i++) {
        //根据角标取出每一个成员变量
        Ivar ivar = ivarList[i];
        
        //获取成员变量的名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //获取成员变量的类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        // 替换: @\"User\" -> User
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        //处理成员变量名使之对应字典中的key值,去掉开头的"_"
        NSString *key = [ivarName substringFromIndex:1];
        //根据成员属性名去查找字典中对应的值
        id value = dict[key];
        
//---------------------分割线-----------------------
        //二级转换:如果字典中还有字典，也要把对应的字典转成模型
        //判断下value是否为字典，并且是自定义模型才实施转换
        if([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            // 字典转换成模型 userDict => User模型, 转换成哪个模型
            // 根据字符串类名生成类对象
            Class modelClass = NSClassFromString(ivarType);
            //如果对应模型存在,进行递归把键值也转换成对应的模型
            if(modelClass) {
                value = [modelClass modelWithDict:value];
            }
//--------------------分割线--------------------------
        //三级转换：如果字典中有数组，数组中还有字典的情况
        //判断下value是否为数组
        }else if ([value isKindOfClass:[NSArray class]]) {
            NSArray *valueArray = value;
            int arrayCount = (int)valueArray.count;
            for(int i = 0; i < arrayCount; i++) {
                id object = valueArray[i];
                if([object isKindOfClass:[NSDictionary class]]) {
                    Class modelClass = NSClassFromString(ivarType);
                    object = [modelClass modelWithDict:object];
                }
            }
            // 判断对应类有没有实现字典数组转模型数组的协议
            // arrayContainModelClass 提供一个协议，只要遵守这个协议的类，都能把数组中的字典转模型
        }
        //如果模型的属性数量大于字典的key数量，属性会被赋值为nil，导致崩溃，要避免这情况：
        if(value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}

@end
