//
//  BeginViewController.m
//  TYMagnificationTransition
//
//  Created by thomasTY on 16/11/12.
//  Copyright © 2016年 thomasTY. All rights reserved.
//

#import "BeginViewController.h"


@interface BeginViewController ()

@end

@implementation BeginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buttonClick:(UIButton *)sender
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * vc = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self presentViewController:vc animated:YES completion:nil];
}


@end
