//
//  ViewController.m
//  maskLayer
//
//  Created by trung bao on 29/11/2015.
//  Copyright © 2015 baotrung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIImageView *images;
    CAShapeLayer *maskLayer, *rugbyLayer;
    UIPanGestureRecognizer *pan;
    UIPinchGestureRecognizer *pinch;
    CGFloat circleRadius;
    CGPoint circleCenter;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    images = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
    images.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:images];
    maskLayer = [CAShapeLayer layer];
    self.view.layer.mask = maskLayer;
    rugbyLayer = [CAShapeLayer layer];
    rugbyLayer.lineWidth = 1.0;
    rugbyLayer.fillColor = [[UIColor clearColor] CGColor];
    rugbyLayer.strokeColor = [[UIColor blackColor] CGColor];
    [self.view.layer addSublayer:rugbyLayer];
    //[self.view.layer addSublayer:maskLayer];
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handPan:)];
    [self.view addGestureRecognizer:pan];
    pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handPinch:)];
    [self.view addGestureRecognizer:pinch];
    self.view.multipleTouchEnabled = true;
    self.view.userInteractionEnabled = true;
    [self updateCirclePathAtLocation:CGPointMake(self.view.bounds.size.width *0.5, self.view.bounds.size.height *0.5)
                              radius:self.view.bounds.size.width *0.2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)handPan:(UIPanGestureRecognizer *)gesture
{
    static CGPoint oldCenter;
    CGPoint tranlation = [gesture translationInView:gesture.view];
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        oldCenter = circleCenter;
    }
    
    CGPoint newCenter = CGPointMake(oldCenter.x + tranlation.x, oldCenter.y + tranlation.y);
    
    [self updateCirclePathAtLocation:newCenter radius:circleRadius];
}

- (void)handPinch:(UIPinchGestureRecognizer *)gesture
{
    static CGFloat oldRadius;
    CGFloat scale = [gesture scale];
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        oldRadius = circleRadius;
    }
    
    CGFloat newRadius = oldRadius * scale;
    
    [self updateCirclePathAtLocation:circleCenter radius:newRadius];
}
- (void)updateCirclePathAtLocation:(CGPoint)location radius:(CGFloat)radius
{
    circleCenter = location;
    circleRadius = radius;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:circleCenter
                    radius:circleRadius
                startAngle:0.0
                  endAngle:M_PI*2
                 clockwise:true];
    maskLayer.path = [path CGPath];
    rugbyLayer.path = [path CGPath];
}
@end
