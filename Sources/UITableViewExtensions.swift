//
//  UITableViewExtensions.swift
//  Daily Review
//
//  Created by kevin.zhu on 16/9/4.
//  Copyright © 2016年 Easy Life. All rights reserved.
//

import UIKit

#if os(iOS)
    
    extension UITableView {
        public func updates(action: (() -> Void)?) {
            beginUpdates()
            if let action = action {
                action()
            }
            endUpdates()
        }
    }
    
#endif