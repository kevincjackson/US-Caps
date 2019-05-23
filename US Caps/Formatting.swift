//
//  Formatting.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

extension String {
    
    var displayModeHide: String {
        return ""
    }
    
    var displayModeHint: String {
        return String(self[self.startIndex]) + "..."
    }
    
    var displayModeShow: String {
        return self
    }
}
