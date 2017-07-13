//
//  OFOMinionsView.m
//  OFOEyes
//
//  Created by 刘小武 on 2017/7/10.
//  Copyright © 2017年 NorthKing. All rights reserved.
//

#import "OFOMinionsHeadView.h"
#import "OFOMinionsEyesView.h"

static const CGFloat eyesWH = 60;
static const CGFloat glassWidth = 10;

@implementation OFOMinionsHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    UIBezierPath *headPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    CGRect leftEyeRect = CGRectMake(self.bounds.size.width*0.5-eyesWH-glassWidth, self.bounds.size.height*0.6-eyesWH-glassWidth, eyesWH, eyesWH);
    UIBezierPath *leftEyePath = [UIBezierPath bezierPathWithOvalInRect:leftEyeRect];
    
    CGRect rightEyeRect = CGRectMake(self.bounds.size.width*0.5+glassWidth, self.bounds.size.height*0.6-eyesWH-glassWidth, eyesWH, eyesWH);
    UIBezierPath *rightEyePath = [UIBezierPath bezierPathWithOvalInRect:rightEyeRect];
    
    [headPath appendPath:leftEyePath];
    [headPath appendPath:rightEyePath];
    [headPath setUsesEvenOddFillRule:YES];

    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = headPath.CGPath;
    pathLayer.fillRule = kCAFillRuleEvenOdd;
    pathLayer.fillColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:pathLayer];
    
    UIBezierPath *leftGlassPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.size.width*0.5-eyesWH-glassWidth*2, self.bounds.size.height*0.6-eyesWH-glassWidth*2, eyesWH+glassWidth*2, eyesWH+glassWidth*2)];
    [leftGlassPath appendPath:leftEyePath];
    [leftGlassPath setUsesEvenOddFillRule:YES];
    CAShapeLayer *leftGlassLayer = [CAShapeLayer layer];
    leftGlassLayer.path = leftGlassPath.CGPath;
    leftGlassLayer.fillRule = kCAFillRuleEvenOdd;
    CGFloat rgb = 115/255.0;
    leftGlassLayer.fillColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0].CGColor;
    [self.layer addSublayer:leftGlassLayer];

    UIBezierPath *rightGlassPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.size.width*0.5, self.bounds.size.height*0.6-eyesWH-glassWidth*2, eyesWH+glassWidth*2, eyesWH+glassWidth*2)];
    [rightGlassPath appendPath:rightEyePath];
    [rightGlassPath setUsesEvenOddFillRule:YES];
    CAShapeLayer *rightGlassLayer = [CAShapeLayer layer];
    rightGlassLayer.path = rightGlassPath.CGPath;
    rightGlassLayer.fillRule = kCAFillRuleEvenOdd;
    rightGlassLayer.fillColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0].CGColor;
    [self.layer addSublayer:rightGlassLayer];
    
    OFOMinionsEyesView * left_eyeView = [[OFOMinionsEyesView alloc] initWithFrame:leftEyeRect];
    [self addSubview:left_eyeView];
    [self bringSubviewToFront:left_eyeView];
    
    OFOMinionsEyesView * right_eyeView = [[OFOMinionsEyesView alloc] initWithFrame:rightEyeRect];
    [self addSubview:right_eyeView];
    [self bringSubviewToFront:right_eyeView];

}

@end
