//
//  answerDisplayState.swift
//  US Capitals
//
//  Created by Kevin Jackson on 3/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

enum DisplayMode: Int, Codable, CustomStringConvertible {
    
    case hide
    case hint
    case show
    
    var description: String {
        switch self {
        case .hide:
            return "hide"
        case .hint:
            return "hint"
        case .show:
            return "show"
        }
    }
    
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
