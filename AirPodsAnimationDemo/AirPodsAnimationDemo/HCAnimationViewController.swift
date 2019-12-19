//
//  HCAnimationViewController.swift
//  AirPodsAnimationDemo
//
//  Created by Peter on 16/12/2019.
//  Copyright © 2019 Peter. All rights reserved.
//

import UIKit
import Lottie
import Masonry
@objc protocol HCAnimationViewControllerDelegate : NSObjectProtocol {
    @objc func didSelect(viewController : HCAnimationViewController)
}


class HCAnimationViewController: UIViewController {

    weak var delegate : HCAnimationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initContentView()
    }
    
    func initContentView() {
        self.view.backgroundColor = UIColor.clear
        
        let lottieAnimationView = LottieView.init()
        lottieAnimationView.backgroundColor = UIColor.white
        lottieAnimationView.layer.cornerRadius = 16
        
        self.view .addSubview(lottieAnimationView)
        
        lottieAnimationView.mas_makeConstraints { (make : MASConstraintMaker!) in
            make.left.equalTo()(self.view)?.offset()(16)
            make.bottom.equalTo()(self.view)?.offset()(-16)
            make.right.equalTo()(self.view)?.offset()(-16)
            make.height.equalTo()(300)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
        if ((self.delegate?.didSelect(viewController: self)) != nil) {
            self.delegate?.didSelect(viewController: self)
        }
    }

}
