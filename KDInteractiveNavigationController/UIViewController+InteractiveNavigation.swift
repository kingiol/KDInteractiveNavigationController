//
//  UIViewController+InteractiveNavigation.swift
//  KDInteractiveNavigationController
//
//  Created by Kingiol on 15/11/21.
//  Copyright © 2015年 Kingiol. All rights reserved.
//

import UIKit

private var interactiveNavigationBarHiddenAssociationKey: UInt8 = 0

extension UIApplication {
    override open var next: UIResponder? {
        UIViewController.awake
        return super.next
    }
}

extension UIViewController {
    static let awake : Void  = {
        replaceInteractiveMethods()
        return
    }()
  
    @IBInspectable public var interactiveNavigationBarHidden: Bool {
        get {
            var associateValue = objc_getAssociatedObject(self, &interactiveNavigationBarHiddenAssociationKey)
            if associateValue == nil {
                associateValue = false
            }
            return associateValue as! Bool;
        }
        set {
            objc_setAssociatedObject(self, &interactiveNavigationBarHiddenAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
  
    fileprivate static func replaceInteractiveMethods() {
        method_exchangeImplementations(
            class_getInstanceMethod(self, #selector(UIViewController.viewWillAppear(_:)))!,
            class_getInstanceMethod(self, #selector(UIViewController.KD_interactiveViewWillAppear(_:)))!)
    }
  
    @objc func KD_interactiveViewWillAppear(_ animated: Bool) {
        KD_interactiveViewWillAppear(animated)
        let excludeVCs = [
            "CKSMSComposeRemoteViewController",
            "CKSMSComposeController",
        ]
        let vcName = NSStringFromClass(type(of: self))
        if excludeVCs.contains(vcName) { return }
        navigationController?.setNavigationBarHidden(interactiveNavigationBarHidden, animated: animated)
    }
  
}

