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
    
    public func addNumberAdjustButtons() {
        let keypadToolbar: UIToolbar = UIToolbar()
        
        keypadToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: NSLocalizedString("-10", comment: ""), style: .Plain, target: self, action: #selector(subtractCurrentNumberWith10)),
            
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: NSLocalizedString("-1", comment: ""), style: .Plain, target: self, action: #selector(subtractCurrentNumberWith1)),
            
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: NSLocalizedString("+1", comment: ""), style: .Plain, target: self, action: #selector(addCurrentNumberWith1)),
            
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: NSLocalizedString("+10", comment: ""), style: .Plain, target: self, action: #selector(addCurrentNumberWith10)),
            
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(UITextField.resignFirstResponder))
        ]
        keypadToolbar.sizeToFit()
        // add a toolbar with a done button above the number pad
        inputAccessoryView = keypadToolbar
    }
    
    func subtractCurrentNumberWith10() {
        adjustCurrentNumberWith(-10)
    }
    
    func subtractCurrentNumberWith1() {
        adjustCurrentNumberWith(-1)
    }
    
    func addCurrentNumberWith1() {
        adjustCurrentNumberWith(1)
    }
    
    func addCurrentNumberWith10() {
        adjustCurrentNumberWith(10)
    }
    
    func adjustCurrentNumberWith(value: Int) {
        let newNumber = ((text ?? "").toInt() ?? 0) + value
        self.text = (newNumber > 0 ? newNumber : 0).toString
    }
}
