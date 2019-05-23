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
    var displayReversed = false
    var displayMode: DisplayMode.Mode = .show
    var displayScreen: Screen = .listView
    var filter: Filter = .all
    var states: [State] {
        let filt: Filter = filter
        switch filt {
        case .all:
            return all
        case .midwest:
            return all.filter { $0.region == .midwest }
        case .northeast:
            return all.filter { $0.region == .northeast }
        case .southeast:
            return all.filter { $0.region == .southeast }
        case .southwest:
            return all.filter { $0.region == .southwest }
        case .west:
            return all.filter { $0.region == .west}
        }
    }
    private var all = States.all
    
    enum Filter {
        case all
        case midwest
        case northeast
        case southeast
        case southwest
        case west
    }
    
    enum Screen {
        case listView
        case itemView
    }
}
