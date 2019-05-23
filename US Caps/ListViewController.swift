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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = worldStateController.worldState.states[indexPath.row].name
        cell.detailTextLabel?.text = worldStateController.worldState.states[indexPath.row].capital
        
        return cell
    }
}
