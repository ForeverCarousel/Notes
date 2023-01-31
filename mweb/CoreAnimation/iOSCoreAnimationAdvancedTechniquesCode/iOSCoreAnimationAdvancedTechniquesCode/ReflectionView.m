//
//  ReflectionView.m
//  iOSCoreAnimationAdvancedTechniquesCode
//
//  Created by chen on 15-1-8.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "ReflectionView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ReflectionView

+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}

- (void)setUp
{
    //configure replicator
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
    layer.instanceCount = 10;
    
//    //move reflection instance below original and flip vertically
//    CATransform3D transform = CATransform3DIdentity;
//    CGFloat verticalOffset = self.bounds.size.height + 2;
//    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
//    transform = CATransform3DScale(transform, 1, -1, 0);
//    
//    layer.instanceTransform = transform;
//    
//    //reduce alpha of reflection layer
//    layer.instanceAlphaOffset = -0.6;
    
    //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    layer.instanceTransform = transform;
    
    //apply a color shift for each instance
    layer.instanceBlueOffset = -0.1;
    layer.instanceGreenOffset = -0.1;
}

- (id)initWithFrame:(CGRect)frame
{
    //this is called when view is created in code
    if ((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = [UIColor blackColor];
        UIImage *image = [UIImage imageNamed:@"mao.png"];
        self.layer.contents = (__bridge id)image.CGImage;
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    //this is called when view is created from a nib
    [self setUp];
}

@end
