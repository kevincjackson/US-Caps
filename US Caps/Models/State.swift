//
//  State.swift
//  US Caps
//
//  Created by Kevin Jackson on 2/27/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class State {
    
    var name = ""
    var capital = ""
    var region: Filter
    var missed = false
    var displayState: DisplayState.Mode = .show
    
    enum Filter: CaseIterable {
        case all
        case midwest
        case northeast
        case southwest
        case southeast
        case west
    }
    
    init(name: String, capital: String, region: Filter) {
        self.name = name
        self.capital = capital
        self.region = region
    }
    
}
