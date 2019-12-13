//
//  HCAirPodsAnimationViewController.m
//  AirPodsAnimation
//
//  Created by Peter on 13/12/2019.
//  Copyright © 2019 Peter. All rights reserved.
//

#import "HCAirPodsAnimationViewController.h"
#import <Lottie/Lottie.h>
#define     SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define     SCREEN_HEIGHT        [UIScreen mainScreen].bounds.size.height

@interface HCAirPodsAnimationViewController ()

@end

@implementation HCAirPodsAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
}

- (void)initContentView
{
    CGFloat containerW = SCREEN_WIDTH - 20;
    CGFloat containerH = containerW * 0.9;
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - containerH - 10, containerW, containerH)];
    containerView.layer.cornerRadius = 20;
    containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containerView];
    
    self.animationView = [[LOTAnimationView alloc] initWithFrame:CGRectMake(70, 70, containerW - 140, containerH - 140)];
    [containerView addSubview:self.animationView];
    self.animationView.animation = @"gift_animation";
    
    self.animationView.loopAnimation = YES;
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 34)];
    confirmButton.center = CGPointMake(self.animationView.center.x, containerH - 44);
    
    [confirmButton setTitle:@"Close" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [confirmButton setBackgroundColor:[UIColor blueColor]];
    confirmButton.layer.cornerRadius = 10;
    
    [confirmButton addTarget:self action:@selector(onConfirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:confirmButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self onConfirmButtonClick];
}

- (void)onConfirmButtonClick
{
    if ([self.delegate respondsToSelector:@selector(onAirPodsAnimationViewControllerConfirmButtonClick:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate onAirPodsAnimationViewControllerConfirmButtonClick:self];
    }
}
@end
