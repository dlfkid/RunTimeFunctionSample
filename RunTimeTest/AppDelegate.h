//
//  AppDelegate.h
//  RunTimeTest
//
//  Created by Ivan_deng on 2017/11/17.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) UIViewController *currentViewController;

- (void)saveContext;

+ (instancetype)sharedInstance;


@end

