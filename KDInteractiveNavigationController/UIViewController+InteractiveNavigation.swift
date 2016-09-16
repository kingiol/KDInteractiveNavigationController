//
//  UIViewController+InteractiveNavigation.swift
//  KDInteractiveNavigationController
//
//  Created by Kingiol on 15/11/21.
//  Copyright © 2015年 Kingiol. All rights reserved.
//

import UIKit

private var didKDVCInitialized = false

private var interactiveNavigationBarHiddenAssociationKey: UInt8 = 0

@IBDesignable
extension UIViewController {
    
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
    
    override open static func initialize() {
        if !didKDVCInitialized {
            replaceInteractiveMethods()
            didKDVCInitialized = true
        }
    }
    
    fileprivate static func replaceInteractiveMethods() {
        method_exchangeImplementations(
            class_getInstanceMethod(self, #selector(UIViewController.viewWillAppear(_:))),
            class_getInstanceMethod(self, #selector(UIViewController.KD_interactiveViewWillAppear(_:))))
    }
    
    func KD_interactiveViewWillAppear(_ animated: Bool) {
        KD_interactiveViewWillAppear(animated)
        navigationController?.setNavigationBarHidden(interactiveNavigationBarHidden, animated: animated)
    }
    
}
