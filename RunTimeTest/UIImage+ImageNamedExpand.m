//
//  UIImage+ImageNamedExpand.m
//  RunTimeTest
//
//  Created by Ivan_deng on 2017/11/17.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "UIImage+ImageNamedExpand.h"
#import "NSObject+Runtime.h"

@implementation UIImage (ImageNamedExpand)

//重写load方法，该方法只会在把类加载进内存的时候调用一次
+ (void)load {
    [self swizzleClassMethodWithSelector:@selector(imageNamed:) AndSelector:@selector(ln_imageNamed:)];
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
