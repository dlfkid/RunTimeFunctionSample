//
//  UIViewController+Extension.m
//  RunTimeTest
//
//  Created by Ivan_deng on 2019/9/1.
//  Copyright © 2019 Ivan_deng. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "NSObject+Runtime.h"
#import "AppDelegate.h"

@implementation UIViewController (Extension)

+ (void)load {
    [self exchangeMethodWithSelector:@selector(extension_viewDidAppear:) AndSelector:@selector(viewDidAppear:)];
}

- (void)extension_viewDidAppear:(BOOL)animated {
    NSLog(@"Current view controller: %@", NSStringFromClass(self.class));
    AppDelegate *delegate = [AppDelegate sharedInstance];
    delegate.currentViewController = self;
    [self extension_viewDidAppear:animated];
}



@end
