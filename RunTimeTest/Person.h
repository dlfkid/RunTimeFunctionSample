//
//  Person.h
//  RunTimeTest
//
//  Created by Ivan_deng on 2017/11/17.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) int age;
@property(nonatomic,assign) int height;
@property(nonatomic,copy) NSString *qoute;

- (void)selfIntroduce;

@end
