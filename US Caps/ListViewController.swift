//
//  ListViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var worldStateController: WorldStateController!

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldStateController.worldState.states.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let labelText = worldStateController.worldState.displayReversed ? worldStateController.worldState.states[indexPath.row].capital : worldStateController.worldState.states[indexPath.row].name
        let detailText = worldStateController.worldState.displayReversed ? worldStateController.worldState.states[indexPath.row].name : worldStateController.worldState.states[indexPath.row].capital
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.textLabel?.text = labelText
        cell.detailTextLabel?.text = detailText.display(usingMode: worldStateController.worldState.displayMode)
        
        return cell
    }
    
    // MARK: Implement
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let state = worldStateController.worldState.states[indexPath.row]
        // 1) Change index - itemView needs it
        //       studyCurrentIndex = indexPath.row
        // 2) change display state
        //        item.displayState = DisplayMode.next(state: item.displayState)
       tableView.reloadData()
    }
}


