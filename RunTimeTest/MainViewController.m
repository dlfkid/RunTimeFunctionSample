//
//  MainViewController.m
//  RunTimeTest
//
//  Created by Ivan_deng on 2017/11/17.
//  Copyright © 2017年 Ivan_deng. All rights reserved.
//

#import "MainViewController.h"
#import "UIImage+ImageNamedExpand.h"
#import "NSObject+PropertyExpand.h"
#import "Person.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 600)];
    imageView.image = [UIImage imageNamed:@"IMG_8350"];
    [self.view addSubview:imageView];
    NSObject *newObject = [[NSObject alloc]init];
    [newObject setName:@"Johnny"];
    NSLog(@"my name is %@",newObject.name);
    NSDictionary *personDict = @{@"name":@"Peter",@"age":@"10",@"qoute":@"Yes we can",@"height":@"180"};
    Person *markOne = [Person modelWithDict:personDict];
    [markOne performSelector:@selector(run:) withObject:@10];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"RunTime Test";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
