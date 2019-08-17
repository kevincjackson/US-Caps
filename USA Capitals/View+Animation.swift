//
//  View+Extension.swift
//  US Capitals
//
//  Created by Kevin Jackson on 5/31/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

extension UIView {
    
    func fadeTransition(_ duration:CFTimeInterval) {
        
        // Create transition
        let animation = CATransition()
        
        // Customize properties
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        
        // Add to the layer
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }

    func slideIn(duration: TimeInterval, from location: CATransitionSubtype) {
        
        // Create transition
        let slideInFromLeftTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = location
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add to the layer
        layer.add(slideInFromLeftTransition, forKey: "slideIn")
    }
}
