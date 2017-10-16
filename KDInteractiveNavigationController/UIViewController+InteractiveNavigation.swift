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

protocol SelfAware: class {
    static func awake()
}

class NothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount { (types[index] as? SelfAware.Type)?.awake() }
        types.deallocate(capacity: typeCount)
    }
}
extension UIApplication {
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
}
@IBDesignable
extension UIViewController: SelfAware {
    static func awake() {
        if !didKDVCInitialized {
            replaceInteractiveMethods()
            didKDVCInitialized = true
        }
    }
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
