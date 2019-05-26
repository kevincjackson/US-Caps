//
//  WorldState.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//
//  Use WorldState to represent the current state of the app.
//    Anything that modifies world state should go in the WorldStateController.

import Foundation

struct WorldState {
    
    var index = 0
    var pairReversed = false
    var displayMode: DisplayMode = .show
    var screen: Screen = .list
    var filter: Filter = .all
    var all: [State] = States.all
    
    enum Filter: String, CaseIterable {
        case all
        case midwest
        case northeast
        case southeast
        case southwest
        case west
    }
    
    enum Screen: String, CaseIterable {
        case list
        case item
        
        var next: Screen {
            switch self {
            case .item:
                return .list
            case .list:
                return .item
            }
        }
    }
    
    // MARK: - Computed Properties
    var nextIndex: Int {
        let newIndex = index + 1
        if newIndex < states.count {
            return newIndex
        }
        else {
            return 0
        }
    }
    
    var previousIndex: Int {
        let newIndex = index - 1
        if newIndex < 0 {
            return states.count - 1
        }
        else {
            return newIndex
        }
    }
    
    var states: [State] {
        switch filter {
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
}
