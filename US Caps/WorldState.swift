//
//  WorldState.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

struct WorldState {
    
    var index = 0
    var filter: Filter = .all
    var displayReversed = false
    var displayMode: DisplayMode.Mode = .show
    var displayScreen: Screen = .listView
    var states = States.all
    
    enum Filter {
        case all
        case northeast
        case northwest
        case southeast
        case southwest
        case west
    }
    
    enum Mode {
        case show
        case hide
        case hint
    }
    
    enum Screen {
        case listView
        case itemView
    }
}

