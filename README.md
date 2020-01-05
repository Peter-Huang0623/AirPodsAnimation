![airpodsfake](https://github.com/Peter-Huang0623/AirPodsAnimation/blob/master/ScreenFlow.gif)

# 【iOS开发】仿AirPods弹出动画的实现
## 效果图
<p align="center">
	<img src="https://github.com/Peter-Huang0623/AirPodsAnimation/blob/master/ScreenFlow.gif" width="25%" height="25%">
	<p align="center">
		<text>预览图</text>
	</p>
</p>

## 思路
　　在当前ViewController下Present另外一个AnimationViewController，在弹出的AnimationViewController中播放动画，弹出的时候原来的ViewController上有一个全屏覆盖的maskView，在弹出时，有一个渐变动画（页面渐黑），在AnimationViewController声明一个代理，在代理方法中实现收起的动画效果（dissmissController和maskView消失）
　　
## 主要代码
```Objective-C
    HCAirPodsAnimationViewController *vc =  [[HCAirPodsAnimationViewController alloc] init];
    vc.delegate = self;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.maskBgView.alpha = 0.5;
    } completion:nil];
    
    [self presentViewController:vc animated:YES completion:^{
        [vc.animationView play];
    }];
```
　　模态跳转的style有一个枚举值，在iOS13以前`modalPresentationStyle`的默认值为`UIModalPresentationFullScreen`,iOS13以后变成了`UIModalPresentationPageSheet`,在这里我们把style设置为`UIModalPresentationOverCurrentContext`弹出的这个控制器就会覆盖在原来的控制器之上　
```Objective-C
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
```
　　一个覆盖全屏的maskView采用懒加载的方式实现
```Objective-C
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
```
　　动画这里用到的是Lottie这个动画开源库（Airbnb），这个开源库主要的功能是可以将After Effects制作的动画通过插件导出为json格式的文件，然后通过这个开源库解析成动画。
```Objective-C
- (void)onConfirmButtonClick
{
    if ([self.delegate respondsToSelector:@selector(onAirPodsAnimationViewControllerConfirmButtonClick:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate onAirPodsAnimationViewControllerConfirmButtonClick:self];
    }
}
```
　　dissmiss当前的控制器，让viewController来实现这个代理方法，并且在代理方法中隐藏maskView
```Objective-C
- (void)onAirPodsAnimationViewControllerConfirmButtonClick:(HCAirPodsAnimationViewController *)vc
{
    [UIView animateWithDuration:0.2 animations:^{
        self.maskBgView.alpha = 0.0;
    } completion:nil];
}
```

