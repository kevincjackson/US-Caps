//
//  WorldStateController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class WorldStateController {
    
    private let storageController: StorageController
    private(set) var worldState: WorldState
    
    // MARK: - Save & Init
    init(storageController: StorageController) {
        self.storageController = storageController
        self.worldState = storageController.load() ?? WorldState()
    }
    
    func save() {
        storageController.save(worldState: worldState)
    }
    
    // MARK: Mutators / updators
    func nextDisplayModeForList() -> DisplayMode {
        
        // Change setting.
        let newDisplayMode = worldState.displayMode.next
        worldState.displayMode = newDisplayMode
        
        // Change for the list.
        worldState.states.forEach {
            let updatedState = $0.update(displayMode: newDisplayMode)
            let id = updatedState.id
            worldState.all[id] = updatedState
        }
        
        return newDisplayMode
    }
    
    func nextDisplayModeFor(state: State) {
        let newState = state.update(displayMode: state.displayMode.next)
        worldState.all[newState.id] = newState
    }
        
    func nextDisplayScreen() {
        switch worldState.screen {
        case .item:
            worldState.screen = .list
        case .list:
            worldState.screen = .item
        }
    }
    
    func update(index: Int) {
        worldState.index = index
    }
    
    func update(filter: WorldState.Filter) {
        worldState.filter = filter
        update(index: 0)
    }
    
    func update(toCustomFilterWith states: [State]) {
        worldState.filter = .custom
        worldState.customStates = states
        update(index: 0)
    }
    
    func reversePair() {
        worldState.pairReversed = !worldState.pairReversed
    }
}
