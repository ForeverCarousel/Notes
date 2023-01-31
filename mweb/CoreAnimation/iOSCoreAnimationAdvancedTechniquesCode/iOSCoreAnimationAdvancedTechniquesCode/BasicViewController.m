//
//  BasicViewController.m
//  iOSCoreAnimationAdvancedTechniquesCode
//
//  Created by chen on 15-1-6.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainScrollV = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.mainScrollV.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.mainScrollV];
    
//    [self.mainScrollV setContentSize:CGSizeMake(0, self.mainScrollV.frame.size.height)];
}

@end
