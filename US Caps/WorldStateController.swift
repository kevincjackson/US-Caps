//
//  WorldStateController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class WorldStateController {
    
    public private(set) var worldState: WorldState
    
    init() {
        self.worldState = WorldState()
    }
    
    func set(index: Int) {
        worldState.index = index
    }
    
    func reverseDisplay() {
        worldState.displayReversed = !worldState.displayReversed
    }
    
    func nextDisplayMode() {
        let current = worldState.displayMode
        worldState.displayMode = DisplayMode.next(basedOnCurrentStateOf: current)
    }
    
    func nextDisplayScreen() {
        switch worldState.displayScreen {
        case .itemView:
            worldState.displayScreen = .listView
        case .listView:
            worldState.displayScreen = .itemView
        }
    }
    
    func set(filter: WorldState.Filter) {
        worldState.filter = filter
    }
}

