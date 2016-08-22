//
//  UITextFieldExtensions.swift
//  Daily Review
//
//  Created by kevin.zhu on 16/8/22.
//  Copyright © 2016年 Easy Life. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    public func addDoneButtonOnNumpad() {
        let keypadToolbar: UIToolbar = UIToolbar()
        
        // add a done button to the numberpad
        keypadToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: #selector(UITextField.resignFirstResponder))
        ]
        keypadToolbar.sizeToFit()
        // add a toolbar with a done button above the number pad
        inputAccessoryView = keypadToolbar
    }
}