//
//  answerDisplayState.swift
//  US Caps
//
//  Created by Kevin Jackson on 3/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

struct DisplayState {
    
    enum Mode {
        case hide
        case hint
        case show
    }
    
    static func describe(answer: String, mode: DisplayState.Mode) -> String {
        var description: String
        switch mode {
        case .hide:
            description = ""
        case .hint:
            description = String(answer[answer.startIndex]) + "..."
        case .show:
            description = answer
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

