//
//  MagnificationAnimator.h
//  TYMagnificationTransition
//
//  Created by thomasTY on 16/11/12.
//  Copyright © 2016年 thomasTY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger
{
    ShapeTypeOval,//圆形
    ShapeTypeRect,//矩形
    ShapeTypeTriangle//三角形
}ShapeType;

@interface MagnificationAnimator : NSObject <UIViewControllerTransitioningDelegate>

/**
 初始化方法

 @param shapeType 放大图形
 @param diameter  直径
 @param topMargin 顶部间距
 @param rightMargin 右侧间距
 @param duration  动画时间

 @return 放大动画转场动画器对象实例
 */
- (instancetype)initWithShapeType:(ShapeType)shapeType diameter:(CGFloat)diameter topMargin:(CGFloat)topMargin rightMargin:(CGFloat)rightMargin duration:(NSTimeInterval)duration;

/**
 快速创建对象方法

 @param shapeType 放大图形
 @param diameter  直径
 @param topMargin 顶部间距
 @param rightMargin 右侧间距
 @param duration  动画时间
 
 @return 放大动画转场动画器对象实例
 */
+ (instancetype)magnificationAnimatorWithShapeType:(ShapeType)shapeType diameter:(CGFloat)diameter topMargin:(CGFloat)topMargin rightMargin:(CGFloat)rightMargin duration:(NSTimeInterval)duration;


@end
