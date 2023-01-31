//
//  LayerTreeViewController.m
//  iOSCoreAnimationAdvancedTechniquesCode
//
//  Created by chen on 15-1-6.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "LayerTreeViewController.h"

/*
 0.巨妖有图层，洋葱也有图层，你有吗？我们都有图层 -- 史莱克
 
 1.layer跟UIView类似，最大不同在于layer缺少与用户交互，如触摸事件等
 
 2.每个UIView都要一个layer属性，也就是所谓的backing layer
 
 3.这里有一些UIView没有暴露出来的CALayer的功能：
 
 阴影，圆角，带颜色的边框
 3D变换
 非矩形范围
 透明遮罩
 多级非线性动画
 
 4.总结
 
 这一章阐述了图层的树状结构，说明了如何在iOS中由UIView的层级关系形成的一种平行的CALayer层级关系，在后面的实验中，我们创建了自己的CALayer，并把它添加到图层树中。
 
 在第二章，“图层关联的图片”，我们将要研究一下CALayer关联的图片，以及Core Animation提供的操作显示的一些特性。
 */

@interface LayerTreeViewController ()

@end

@implementation LayerTreeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake((self.layerView.frame.size.width - 100)/2, (self.layerView.frame.size.height - 100)/2, 100.f, 100.f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.layerView.layer addSublayer:blueLayer];
}

@end
