//
//  ViewController.m
//  TYMagnificationTransition
//
//  Created by thomasTY on 16/11/12.
//  Copyright © 2016年 thomasTY. All rights reserved.
//

#import "ViewController.h"
#import "MagnificationAnimator.h"

@interface ViewController ()

@end

@implementation ViewController
{
    MagnificationAnimator * _magniAnima;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

//自定义转场样式
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        self.modalPresentationStyle = UIModalPresentationCustom;
        //配置参数
        _magniAnima= [MagnificationAnimator
                      magnificationAnimatorWithShapeType:ShapeTypeTriangle diameter:20 topMargin:100 rightMargin:100 duration:3];
        //强引用
        self.transitioningDelegate = _magniAnima;
    }
    return self;
}

@end
