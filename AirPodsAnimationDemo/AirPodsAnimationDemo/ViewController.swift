//
//  ViewController.swift
//  AirPodsAnimationDemo
//
//  Created by Peter on 16/12/2019.
//  Copyright © 2019 Peter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HCAnimationViewControllerDelegate {

    lazy var maskView : UIView = {
        var view = UIView.init(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black
        view.alpha = 0.0
        self.view.addSubview(view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initContentView()
    }
    func initContentView() {
        self.view.backgroundColor = UIColor.white
        let button : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 40))
        button.center = CGPoint.init(x: self.view.bounds.size.width / 2, y: self.view.bounds.size.height / 2)
        button.setTitle("Touch Me", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action:#selector(onButtonClick), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func onButtonClick() {
        let vc = HCAnimationViewController.init()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        UIView.animate(withDuration: 0.3, animations: {
            self.maskView.alpha = 0.3
        }, completion: nil)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func didSelect(viewController: HCAnimationViewController) {
        UIView.animate(withDuration: 0.3, animations: {
            self.maskView.alpha = 0.0
        }, completion: nil)
    }
}

