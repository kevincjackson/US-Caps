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
    var displayState: DisplayMode.Mode = .show
    
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
    
}
