//
//  HCAirPodsAnimationViewController.h
//  AirPodsAnimation
//
//  Created by Peter on 13/12/2019.
//  Copyright © 2019 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Lottie/Lottie.h>

NS_ASSUME_NONNULL_BEGIN

@class HCAirPodsAnimationViewController;
@protocol HCAirPodsAnimationViewControllerDelegate <NSObject>

- (void)onAirPodsAnimationViewControllerConfirmButtonClick:(HCAirPodsAnimationViewController *)vc;

@end

@interface HCAirPodsAnimationViewController : UIViewController

@property (nonatomic, strong) LOTAnimationView *animationView;

@property (nonatomic, weak) id <HCAirPodsAnimationViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
