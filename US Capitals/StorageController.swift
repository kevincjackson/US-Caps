//
//  StorageController.swift
//  US Capitals
//
//  Created by Kevin Jackson on 7/25/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import Foundation

class StorageController {
    
    private let url = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("worldState.archive")
    
    @discardableResult
    func save(worldState: WorldState) -> Bool {
        do {
            let data = try PropertyListEncoder().encode(worldState)
            try data.write(to: url)
            print("Save successful.")
            return true
        }
        catch {
            print("Save failed.")
            return false
        }
    }
    
    func load() -> WorldState? {
        do {
            let data = try Data(contentsOf: url)
            let worldState = try PropertyListDecoder().decode(WorldState.self, from: data)
            print("Load successful.")
            return worldState
        }
        catch {
            print("Load failed.")
            return nil
        }
    }
}
