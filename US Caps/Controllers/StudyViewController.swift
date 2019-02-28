//
//  StudyViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 2/27/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class StudyViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return States.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = States.all[indexPath.row].name
        cell.detailTextLabel?.text = States.all[indexPath.row].capital
        
        return cell
    }

}
