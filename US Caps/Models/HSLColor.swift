//
//  HSLColor.swift
//  US Caps
//
//  Created by Kevin Jackson on 3/27/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

// Hue, Saturation, Lightness Color Model
// Note Swift provides a similar, but different color model (HSB)
struct HSLColor {
    
    var h: Double
    var s: Double
    var l: Double

    init?(h: Double, s: Double, l: Double) {
        
        guard h >= 0 && h <= 360 else {
            print("HSLColor: h out of bounds error. Must be between 0 and 360.")
            return nil
        }
        
        guard s >= 0 && s <= 1 else {
            print("HSLColor: s out of bounds error. Must be between 0 and 1.")
            return nil
        }
        
        guard l >= 0 && l <= 1 else {
            print("HSLColor: l out of bounds error. Must be between 0 and 1.")
            return nil
        }
        
        self.h = h
        self.s = s
        self.l = l
    }
    
    func to_UIColor() -> UIColor {
        
        let hsb_h = self.h / Double(360)
        let hsb_b = ((2 * self.l) + (self.s * (1 - abs(2 * self.l - 1)))) / 2
        let hsb_s = 2 * (hsb_b - self.l) / hsb_b

        return UIColor(hue: CGFloat(hsb_h), saturation: CGFloat(hsb_s), brightness: CGFloat(hsb_b), alpha: 1)
    }
    
    // MARK: - TODO: Extract to Extension
    // Gets a gradient color based on start on end colors
    func getGradientColor(index: Int, max: Int, start: HSLColor = Constants.LightBackground, end: HSLColor = Constants.DarkBackground)  -> UIColor {
        
        let h_step = (end.h - start.h) / Double(max)
        let s_step = (end.s - start.s) / Double(max)
        let l_step = (end.l - start.l) / Double(max)
        
        let h = start.h + (h_step * Double(index))
        let s = start.s + (s_step * Double(index))
        let l = start.l + (l_step * Double(index))
        
        return HSLColor(h: h, s: s, l: l)!.to_UIColor()
    }
    
    // MARK: - TODO: Extract to Extension
    func getContrastColor(_ color: UIColor) -> UIColor {
        
        let col = CIColor(color: color)
        let value = (col.red + col.green + col.blue) / 3
        
        return value < 0.61 ? Constants.LightBackground.to_UIColor() : Constants.DarkText.to_UIColor()
    }
    
}

