//
//  Formatting.swift
//  US Capitals
//
//  Created by Kevin Jackson on 5/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

extension String {
    
    func display(usingMode mode: DisplayMode) -> String {
        switch mode {
        case .show:
            return self
        case .hint:
            return String(self[self.startIndex]) + "..."
        case .hide:
            return ""
        }
    }
}
