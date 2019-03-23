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
    var region: StateFilter
    var missed = false
    var displayState: DisplayState.Mode = .show
    
    init(name: String, capital: String, region: StateFilter) {
        self.name = name
        self.capital = capital
        self.region = region
    }
    
    
    
}
