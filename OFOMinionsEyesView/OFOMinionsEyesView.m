
//
//  OFOEyesView.m
//  OFOEyes
//
//  Created by 刘小武 on 2017/7/10.
//  Copyright © 2017年 NorthKing. All rights reserved.
//

#import "OFOMinionsEyesView.h"
#import <CoreMotion/CoreMotion.h>

@interface OFOMinionsEyesView ()

@property (nonatomic, strong) UIDynamicAnimator * animator;
@property (nonatomic, strong) UIGravityBehavior * gravity;
@property (nonatomic, strong) UIImageView * eyesImageView;

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation OFOMinionsEyesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.eyesImageView];
        [self createDynamic];
        [self getMotionData];
    }
    return self;
}

- (void)createDynamic {

    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    gravity.gravityDirection = CGVectorMake(1, 1);
    [gravity addItem:self.eyesImageView];
    _gravity = gravity;
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.eyesImageView];
    
    UIDynamicItemBehavior * itemBehavior = [[UIDynamicItemBehavior alloc] init];
    itemBehavior.elasticity = 0.5;
    itemBehavior.allowsRotation = YES;
    [itemBehavior addItem:self.eyesImageView];
    
    UIBezierPath *boundaryPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    [collision addBoundaryWithIdentifier:@"Boundary" forPath:boundaryPath];
    
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
    [self.animator addBehavior:itemBehavior];
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    }
    return _animator;
}

- (UIImageView*)eyesImageView {
    if (!_eyesImageView) {
        _eyesImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"minions_eyes"]];
        _eyesImageView.frame = CGRectMake(self.bounds.size.width*0.5-12, self.bounds.size.height-24, 24, 24);
    }
    return _eyesImageView;
}

- (void)getMotionData {
    
    CMMotionManager * motionManager = [[CMMotionManager alloc] init];
    _motionManager = motionManager;
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    _queue = queue;
    
    if (self.motionManager.deviceMotionAvailable) {
        
        self.motionManager.deviceMotionUpdateInterval = 0.1;
        
        [self.motionManager startDeviceMotionUpdatesToQueue:self.queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _gravity.gravityDirection = CGVectorMake(motion.gravity.x, -motion.gravity.y);
                [self.animator addBehavior:_gravity];

            });
        }];
    }else{
        NSLog(@"您的设备暂不支持此功能!");
    }
}

@end
