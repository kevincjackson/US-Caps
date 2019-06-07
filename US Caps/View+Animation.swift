//
//  View+Extension.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/31/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

extension UIView {
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
