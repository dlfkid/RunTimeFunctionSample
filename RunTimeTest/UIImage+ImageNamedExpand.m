//
//  UIImage+ImageNamedExpand.m
//  RunTimeTest
//
//  Created by Ivan_deng on 2017/11/17.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//
#import <objc/message.h>
#import "UIImage+ImageNamedExpand.h"

@implementation UIImage (ImageNamedExpand)

//重写load方法，该方法只会在把类加载进内存的时候调用一次
+ (void)load {
    //获取imageWithName的方法地址
    //getclassmethod获取某各类的方法
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    //获取ln_imageNamed的方法地址
    Method ln_imageNamedMethod = class_getClassMethod(self, @selector(ln_imageNamed:));
    
    //交换两个方法的地址，相当于交换两个方法的实现方式
    method_exchangeImplementations(imageNamedMethod, ln_imageNamedMethod);
}

+ (UIImage *)ln_imageNamed:(NSString *)name {
    UIImage *image = [UIImage ln_imageNamed:name];
    if(image) {
        NSLog(@"图片加载成功");
    }else{
        NSLog(@"图片加载失败");
    }
    return image;
}


@end
