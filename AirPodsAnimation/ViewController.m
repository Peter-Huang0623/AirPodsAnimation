//
//  ViewController.m
//  AirPodsAnimation
//
//  Created by Peter on 13/12/2019.
//  Copyright © 2019 Peter. All rights reserved.
//

#import "ViewController.h"
#import "HCAirPodsAnimationViewController.h"

@interface ViewController ()<HCAirPodsAnimationViewControllerDelegate>

@property (nonatomic, strong) UIView *maskBgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    button.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    [self.view addSubview:button];
    
    [button setTitle:@"Click To Pop Up" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(onPopUpBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onPopUpBtnClick
{
    HCAirPodsAnimationViewController *vc = [[HCAirPodsAnimationViewController alloc] init];
    vc.delegate = self;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.maskBgView.alpha = 0.5;
    } completion:nil];
    
    [self presentViewController:vc animated:YES completion:^{
        [vc.animationView play];
    }];
}

- (UIView *)maskBgView
{
    if (!_maskBgView) {
        _maskBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _maskBgView.backgroundColor = [UIColor blackColor];
        _maskBgView.alpha = 0;
        [self.view addSubview:_maskBgView];
    }
    return _maskBgView;
}


- (void)onAirPodsAnimationViewControllerConfirmButtonClick:(HCAirPodsAnimationViewController *)vc
{
    [UIView animateWithDuration:0.2 animations:^{
        self.maskBgView.alpha = 0.0;
    } completion:nil];
}


@end
