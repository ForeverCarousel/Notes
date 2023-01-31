//
//  LayerTimeViewController.m
//  iOSCoreAnimationAdvancedTechniquesCode
//
//  Created by chen on 15-1-12.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "LayerTimeViewController.h"

/*
 0.时间和空间最大的区别在于，时间不能被复用 -- 弗斯特梅里克
 
 1.CAMediaTiming协议
 1.1.duration是一个CFTimeInterval的类型（类似于NSTimeInterval的一种双精度浮点类型），对将要进行的动画的一次迭代指定了时间
 1.2.repeatCount，代表动画重复的迭代次数。如果duration是2，repeatCount设为3.5（三个半迭代），那么完整的动画时长将是7秒。
 1.3.autoreverses的属性（BOOL类型）在每次间隔交替循环过程中自动回放
 1.4.beginTime指定了动画开始之前的的延迟时间。
 1.5.speed是一个时间的倍数，默认1.0，减少它会减慢图层/动画的时间，增加它会加快速度。
 1.6.timeOffset和beginTime类似，但是和增加beginTime导致的延迟动画不同，增加timeOffset只是让动画快进到某一点
 
 2.fillMode
 默认是kCAFillModeRemoved，当动画不再播放的时候就显示图层模型指定的值剩下的三种类型向前，向后或者即向前又向后去填充动画状态，使得动画在开始前或者结束后仍然保持开始和结束那一刻的值。
 
 3.层级关系时间
 3.1.全局时间和本地时间
 CFTimeInterval time = CACurrentMediaTime();
 每个CALayer和CAAnimation实例都有自己本地时间的概念，是根据父图层/动画层级关系中的beginTime，timeOffset和speed属性计算。就和转换不同图层之间坐标关系一样，CALayer同样也提供了方法来转换不同图层之间的本地时间。
 3.2.暂停，倒回和快进
 一个简单的方法是可以利用CAMediaTiming来暂停图层本身。如果把图层的speed设置成0，它会暂停任何添加到图层上的动画。类似的，设置speed大于1.0将会快进，设置成一个负值将会倒回动画。
 
 4.手动动画
 timeOffset一个很有用的功能在于你可以它可以让你手动控制动画进程，通过设置speed为0，可以禁用动画的自动播放，然后来使用timeOffset来来回显示动画序列。
 
 5.总结
 
 在这一章，我们了解了CAMediaTiming协议，以及Core Animation用来操作时间控制动画的机制。在下一章，我们将要接触缓冲，另一个用来使动画更加真实的操作时间的技术。
 */

@interface LayerTimeViewController ()

@property (nonatomic, strong) CALayer *doorLayer;

@end

@implementation LayerTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self drawDoor];
    [self drawDoor2];
    
//    [self.mainScrollV setContentSize:CGSizeMake(0, self.hSpace)];
}

- (void)drawDoor
{
    self.hSpace = 20;
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, self.hSpace, 60, 100)];
    l.text = @"我是门";
    l.backgroundColor = [UIColor whiteColor];
    l.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollV addSubview:l];
    
    //add the door
    CALayer *doorLayer = [CALayer layer];
    doorLayer.frame = CGRectMake(0, 0, 128, 150);
    doorLayer.position = CGPointMake(150 - 64, 80);
    doorLayer.anchorPoint = CGPointMake(0, 0.5);
//    doorLayer.contents = (__bridge id)[UIImage imageNamed: @"Door.png"].CGImage;
    doorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [l.layer addSublayer:doorLayer];
    //apply perspective transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    l.layer.sublayerTransform = perspective;
    //apply swinging animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 2.0;
    animation.repeatDuration = INFINITY;
    animation.autoreverses = YES;
    [doorLayer addAnimation:animation forKey:nil];
    
    self.hSpace += l.frame.size.height + 20;
}

- (void)drawDoor2
{
    //add the door
    self.doorLayer = [CALayer layer];
    self.doorLayer.frame = CGRectMake(0, 0, 128, 256);
    self.doorLayer.position = CGPointMake(150 - 64, 340);
    self.doorLayer.anchorPoint = CGPointMake(0, 0.5);
//    self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"Door.png"].CGImage;
    self.doorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.mainScrollV.layer addSublayer:self.doorLayer];
    //apply perspective transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.mainScrollV.layer.sublayerTransform = perspective;
    //add pan gesture recognizer to handle swipes
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.mainScrollV addGestureRecognizer:pan];
    //pause all layer animations
    self.doorLayer.speed = 0.0;
    //apply swinging animation (which won't play because layer is paused)
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0;
    [self.doorLayer addAnimation:animation forKey:nil];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    //get horizontal component of pan gesture
    CGFloat x = [pan translationInView:self.view].x;
    //convert from points to animation duration //using a reasonable scale factor
    x /= 200.0f;
    //update timeOffset and clamp result
    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    self.doorLayer.timeOffset = timeOffset;
    //reset pan gesture
    [pan setTranslation:CGPointZero inView:self.view];
}

@end
