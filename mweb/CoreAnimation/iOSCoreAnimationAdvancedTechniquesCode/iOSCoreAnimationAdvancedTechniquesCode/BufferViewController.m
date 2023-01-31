//
//  BufferViewController.m
//  iOSCoreAnimationAdvancedTechniquesCode
//
//  Created by chen on 15-1-13.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "BufferViewController.h"

/*
 0.生活和艺术一样，最美的永远是曲线。 -- 爱德华布尔沃 - 利顿
 
 1.动画速度
 那么该如何使用缓冲方程式呢？首先需要设置CAAnimation的timingFunction属性，是CAMediaTimingFunction类的一个对象。如果想改变隐式动画的计时函数，同样也可以使用CATransaction的+setAnimationTimingFunction:方法。
 
 这里有一些方式来创建CAMediaTimingFunction，最简单的方式是调用+timingFunctionWithName:的构造方法。
 
 2.UIView的动画缓冲
 为了改变UIView动画的缓冲选项，给options参数添加如下常量
 
 3.缓冲和关键帧动画
 对CAKeyframeAnimation使用CAMediaTimingFunction
 
 4.自定义缓冲函数
 CAMediaTimingFunction同样有另一个构造函数，一个有四个浮点参数的+functionWithControlPoints::::
 
 5.更加复杂的动画曲线
 
 6.基于关键帧的缓冲
 
 7.流程自动化
 自动把任意属性动画分割成多个关键帧
 用一个数学函数表示弹性动画，使得可以对帧做便宜
 
 (缓冲背后的数学并不很简单，但是幸运的是我们不需要一一实现它。罗伯特·彭纳有一个网页关于缓冲函数（http://www.robertpenner.com/easing），包含了大多数普遍的缓冲函数的多种编程语言的实现的链接，包括C。这里是一个缓冲进入缓冲退出函数的示例（实际上有很多不同的方式去实现它）。)
 
 8.总结
 
 在这一章中，我们了解了有关缓冲和CAMediaTimingFunction类，它可以允许我们创建自定义的缓冲函数来完善我们的动画，同样了解了如何用CAKeyframeAnimation来避开CAMediaTimingFunction的限制，创建完全自定义的缓冲函数。
 
 在下一章中，我们将要研究基于定时器的动画--另一个给我们对动画更多控制的选择，并且实现对动画的实时操纵。
 */

@interface BufferViewController ()

@property (strong, nonatomic) UIView *colorView;
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) CALayer *blueLayer;

@property (nonatomic, strong) UIImageView *ballView;

@end

@implementation BufferViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self drawOne];
    [self draw2];
    [self draw3];
    
    [self.mainScrollV setContentSize:CGSizeMake(0, MAX(self.hSpace, self.view.frame.size.height))];
}

- (void)drawOne
{
    //create a red layer
    self.colorView = [[UIView alloc] init];
    self.colorView.frame = CGRectMake(80, 80, 100, 100);
//    self.colorView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    self.colorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.colorView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //perform the animation
    [UIView animateWithDuration:1.0 delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         //set the position
                         self.colorView.center = [[touches anyObject] locationInView:self.view];
                     }
                     completion:NULL];
    
}

- (void)draw2
{
    //create timing function
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
    //get control points
    CGPoint controlPoint1, controlPoint2;
    [function getControlPointAtIndex:1 values:(float *)&controlPoint1];
    [function getControlPointAtIndex:2 values:(float *)&controlPoint2];
    //create curve
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1)
            controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    //scale the path up to a reasonable size for display
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 4.0f;
    shapeLayer.path = path.CGPath;
    [self.layerView.layer addSublayer:shapeLayer];
    //flip geometry so that 0,0 is in the bottom-left
    self.layerView.layer.geometryFlipped = YES;
}

- (void)draw3
{
    //add ball image view
    UIImage *ballImage = [self createImageWithColor:[UIColor blueColor]];
    self.ballView = [[UIImageView alloc] initWithImage:ballImage];
    self.ballView.frame = CGRectMake(0, 0, 30, 30);
    [self.layerView addSubview:self.ballView];
    //animate
    [self animate];
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)animate
{
    //reset ball to top of screen
    self.ballView.center = CGPointMake(150, 32);
    //create keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(150, 32)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 140)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 220)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 250)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 268)]
                         ];
    
    animation.timingFunctions = @[
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
                                  ];
    
    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    //apply animation
    self.ballView.layer.position = CGPointMake(150, 268);
    [self.ballView.layer addAnimation:animation forKey:nil];
}

@end
