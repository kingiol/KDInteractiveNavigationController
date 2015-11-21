//
//  KDInteractiveNavigationController.swift
//  KDInteractiveNavigationController
//
//  Created by Kingiol on 15/11/21.
//  Copyright © 2015年 Kingiol. All rights reserved.
//

import UIKit

@IBDesignable
public class KDInteractiveNavigationController: UINavigationController {
    
    @IBInspectable public var clearBackTitle: Bool = false
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func pushViewController(viewController: UIViewController, animated: Bool) {
        controlClearBackTitle()
        super.pushViewController(viewController, animated: animated)
    }
    
    override public func showViewController(vc: UIViewController, sender: AnyObject?) {
        controlClearBackTitle()
        super.showViewController(vc, sender: sender)
    }
    
}

// MARK: UIGestureRecognizerDelegate

extension KDInteractiveNavigationController: UIGestureRecognizerDelegate {
    
}

// MARK: Private Methods

extension KDInteractiveNavigationController {
    
    func controlClearBackTitle() {
        if clearBackTitle {
            topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        }
    }
    
}