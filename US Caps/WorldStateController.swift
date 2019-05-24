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
    
    func nextDisplayModeForCurrentFilter() {
        let current = worldState.displayMode
        worldState.displayMode = DisplayMode.next(after: current)
    }
    
    func nextDisplayModeFor(state: State) {
        let newState = state.nextDisplayState()
        guard let index = worldState.all.firstIndex(where: { $0.id == state.id }) else {
            preconditionFailure("Index not found.")
        }
        worldState.all[index] = newState
    }
    
    func nextDisplayScreen() {
        switch worldState.displayScreen {
        case .itemView:
            worldState.displayScreen = .listView
        case .listView:
            worldState.displayScreen = .itemView
        }
    }
    
    func set(index: Int) {
        worldState.index = index
    }
    
    func set(filter: WorldState.Filter) {
        worldState.filter = filter
    }
    
    func reverseDisplay() {
        worldState.displayReversed = !worldState.displayReversed
    }
}
