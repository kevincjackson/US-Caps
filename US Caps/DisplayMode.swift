//
//  answerDisplayState.swift
//  US Caps
//
//  Created by Kevin Jackson on 3/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

enum DisplayMode: String {
    case hide
    case hint
    case show
    
    var next: DisplayMode {
        switch self {
        case .hide:
            return .hint
        case .hint:
            return .show
        case .show:
            return .hide
        }
    }
}

