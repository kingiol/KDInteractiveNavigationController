//
//  KDInteractiveNavigationController.swift
//  KDInteractiveNavigationController
//
//  Created by Kingiol on 15/11/21.
//  Copyright © 2015年 Kingiol. All rights reserved.
//

import UIKit

@IBDesignable
open class KDInteractiveNavigationController: UINavigationController {
    
    @IBInspectable open var clearBackTitle: Bool = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        controlClearBackTitle()
        super.pushViewController(viewController, animated: animated)
    }
    
    override open func show(_ vc: UIViewController, sender: Any?) {
        controlClearBackTitle()
        super.show(vc, sender: sender)
    }
    
}

// MARK: UIGestureRecognizerDelegate

extension KDInteractiveNavigationController: UIGestureRecognizerDelegate {
    
}

// MARK: Private Methods

extension KDInteractiveNavigationController {
    
    func controlClearBackTitle() {
        if clearBackTitle {
            topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
}
