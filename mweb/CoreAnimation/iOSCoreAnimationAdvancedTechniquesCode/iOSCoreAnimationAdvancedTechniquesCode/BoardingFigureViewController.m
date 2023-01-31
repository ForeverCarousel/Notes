//
//  BoardingFigureViewController.m
//  iOSCoreAnimationAdvancedTechniquesCode
//
//  Created by chen on 15-1-6.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "BoardingFigureViewController.h"

/*
 0.图片胜过千言万语，界面抵得上千图片 ——Ben Shneiderman
 
 1.contents属性
 
 2.contentGravity
 在使用UIImageView的时候遇到过同样的问题，解决方法就是把contentMode属性设置成更合适的值
 
 3.contentsScale
 contentsScale属性定义了寄宿图的像素尺寸和视图大小的比例，默认情况下它是一个值为1.0的浮点数。
 
 4.maskToBounds
 UIView有一个叫做clipsToBounds的属性可以用来决定是否显示超出边界的内容，CALayer对应的属性叫做masksToBounds，把它设置为YES
 
 5.contentsRect
 
 6.contentsCenter
 他工作起来的效果和UIImage里的-resizableImageWithCapInsets: 方法效果非常类似，只是它可以运用到任何寄宿图，甚至包括在Core Graphics运行时绘制的图形
 
 7.Custome Drawing
 
 8.总结
 
 本章介绍了寄宿图和一些相关的属性。你学到了如何显示和放置图片， 使用拼合技术来显示， 以及用CALayerDelegate和Core Graphics来绘制图层内容。
 
 在第三章，"图层几何学"中，我们将会探讨一下图层的几何，观察他们是如何放置和改变相互的尺寸的。
 
 */

@interface BoardingFigureViewController ()

@property (weak, nonatomic) IBOutlet UIView *coneView;
@property (weak, nonatomic) IBOutlet UIView *shipView;
@property (weak, nonatomic) IBOutlet UIView *iglooView;
@property (weak, nonatomic) IBOutlet UIView *anchorView;

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) CALayer *blueLayer;

@end

@implementation BoardingFigureViewController

- (void)dealloc
{
    self.blueLayer.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //load sprite sheet
    UIImage *image = [UIImage imageNamed:@"Sprites.png"];
    //set igloo sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.iglooView.layer];
    //set cone sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.coneView.layer];
    //set anchor sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.anchorView.layer];
    //set spaceship sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.shipView.layer];
    
    //create sublayer
    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //set controller as layer delegate
    self.blueLayer.delegate = self;
    
    //ensure that layer backing image uses correct scale
    self.blueLayer.contentsScale = [UIScreen mainScreen].scale; //add layer to our view
    [self.layerView.layer addSublayer:self.blueLayer];
    
    //force layer to redraw
    [self.blueLayer display];
}

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer //set image
{
    layer.contents = (__bridge id)image.CGImage;
    
    //scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    
    //set contentsRect
    layer.contentsRect = rect;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

@end
