//
//  MagnificationAnimator.m
//  TYMagnificationTransition
//
//  Created by thomasTY on 16/11/12.
//  Copyright © 2016年 thomasTY. All rights reserved.
//

#import "MagnificationAnimator.h"

@interface MagnificationAnimator() <UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@end

ShapeType _shapeType = ShapeTypeOval;
CGFloat _diameter = 0.0;
CGFloat _topMargin = 0.0;
CGFloat _rightMargin = 0.0;
NSTimeInterval _duration = 0.0;

@implementation MagnificationAnimator
{
    //展示标记
    BOOL _isPresented;

    UIBezierPath * _beginPath;
    UIBezierPath * _endPath;

    
    id <UIViewControllerContextTransitioning> _transitionContext;
}

- (instancetype)initWithShapeType:(ShapeType)shapeType diameter:(CGFloat)diameter topMargin:(CGFloat)topMargin rightMargin:(CGFloat)rightMargin duration:(NSTimeInterval)duration
{
    _shapeType = shapeType;
    _diameter = diameter;
    _topMargin = topMargin;
    _rightMargin = rightMargin;
    _duration = duration;

    return [[MagnificationAnimator alloc] init];
}

+ (instancetype)magnificationAnimatorWithShapeType:(ShapeType)shapeType diameter:(CGFloat)diameter topMargin:(CGFloat)topMargin rightMargin:(CGFloat)rightMargin duration:(NSTimeInterval)duration
{
    return [[self alloc] initWithShapeType:shapeType diameter:diameter topMargin:topMargin rightMargin:rightMargin duration:duration];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _isPresented = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _isPresented = NO;
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return _duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView * containerView = [transitionContext containerView];
    UIView * formView = [transitionContext viewForKey: UITransitionContextFromViewKey];
    UIView * toView = [transitionContext viewForKey: UITransitionContextToViewKey];
    UIView * view = _isPresented ? toView : formView;
    //展示
    if (_isPresented)
    {
        [containerView addSubview:view];
    }
    
    [self magnificationAnimationWith:view];
    
    _transitionContext = transitionContext;
    
}
#pragma mark - 放大动画
- (void)magnificationAnimationWith:(UIView *)view
{
    

    
    CGFloat viewWidth = view.bounds.size.width;
    CGFloat viewHeight = view.bounds.size.height;
    CGFloat maxRadius = sqrt(viewWidth * viewWidth + viewHeight * viewHeight);
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    CGRect beginRect = CGRectMake(viewWidth - _diameter - _rightMargin, _topMargin , _diameter, _diameter);
    
    switch (_shapeType)
    {
        case ShapeTypeOval:
        {
            _beginPath = [UIBezierPath bezierPathWithOvalInRect:beginRect];

            break;
        }
        case ShapeTypeRect:
        {
            _beginPath = [UIBezierPath bezierPathWithRect:beginRect];
            break;
        }
        case ShapeTypeTriangle:
        {
            _beginPath = [UIBezierPath bezierPath];
            [_beginPath moveToPoint:CGPointMake(viewWidth - _rightMargin - _diameter, _topMargin)];
            [_beginPath addLineToPoint:CGPointMake(viewWidth - _rightMargin, _topMargin)];
            [_beginPath addLineToPoint:CGPointMake(viewWidth - _rightMargin, _diameter + _topMargin)];
            [_beginPath addLineToPoint:CGPointMake(viewWidth - _rightMargin - _diameter, _topMargin)];

            break;
        }
    }
    shapeLayer.path = _beginPath.CGPath;
    view.layer.mask = shapeLayer;
    
    CGRect endRect = CGRectInset(beginRect, -maxRadius, -maxRadius);
    switch (_shapeType)
    {
        case ShapeTypeOval:
        {
            _endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
            break;
        }
        case ShapeTypeRect:
        {
            _endPath = [UIBezierPath bezierPathWithRect:endRect];
            break;
        }
        case ShapeTypeTriangle:
        {
            _endPath = [UIBezierPath bezierPath];
            [_endPath moveToPoint:CGPointMake(-viewWidth, 0)];
            [_endPath addLineToPoint:CGPointMake(viewWidth, 0)];
            [_endPath addLineToPoint:CGPointMake(viewWidth, viewHeight * 2)];
            [_endPath addLineToPoint:CGPointMake(-viewWidth, 0)];
            break;
        }

    }
    
    CABasicAnimation * anima = [CABasicAnimation animationWithKeyPath:@"path"];
    anima.duration = [self transitionDuration:_transitionContext];
    if (_isPresented)
    {
        anima.fromValue = (__bridge id _Nullable)(_beginPath.CGPath);
        anima.toValue = (__bridge id _Nullable)(_endPath.CGPath);
    }else
    {
        anima.fromValue = (__bridge id _Nullable)(_endPath.CGPath);
        anima.toValue = (__bridge id _Nullable)(_beginPath.CGPath);
    }

    anima.fillMode = kCAFillModeForwards;
    anima.removedOnCompletion = NO;
    anima.delegate = self;
    [shapeLayer addAnimation:anima forKey:nil];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [_transitionContext completeTransition:YES];
}

@end
