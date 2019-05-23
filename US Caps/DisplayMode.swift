//
//  answerDisplayState.swift
//  US Caps
//
//  Created by Kevin Jackson on 3/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

struct DisplayMode {
    
    enum Mode {
        case hide
        case hint
        case show
    }
    
    // MARK: TODO Refactor to String extension
    static func describe(item: String, mode: DisplayMode.Mode) -> String {
        var description: String
        switch mode {
        case .hide:
            description = ""
        case .hint:
            description = String(item[item.startIndex]) + "..."
        case .show:
            description = item
        }
        
        return description
    }
    
    static func next(state: Mode) -> Mode {
        
        var nextState: Mode
        
        switch state {
        case .hide:
            nextState = .hint
        case .hint:
            nextState = .show
        case .show:
            nextState = .hide
        }
        
        return nextState
    }

    
}

