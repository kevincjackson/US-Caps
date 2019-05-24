//
//  State.swift
//  US Caps
//
//  Created by Kevin Jackson on 2/27/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

struct State {
    
    var id = 0
    var name = ""
    var capital = ""
    var region: Region
    var displayMode: DisplayMode.Mode = .show
    
    enum Region: CaseIterable {
        case midwest
        case northeast
        case southwest
        case southeast
        case west
    }
    
    init(id: Int, name: String, capital: String, region: Region) {
        self.id = id
        self.name = name
        self.capital = capital
        self.region = region
    }
    
    init(id: Int, name: String, capital: String, region: Region, displayMode: DisplayMode.Mode) {
        self.id = id
        self.name = name
        self.capital = capital
        self.region = region
        self.displayMode = displayMode
    }
    
    func update(displayMode: DisplayMode.Mode) -> State {
        return State(id: self.id, name: self.name, capital: self.capital, region: self.region, displayMode: displayMode)
    }
}
