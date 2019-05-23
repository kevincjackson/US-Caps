//
//  MainViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/21/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class CompositeViewController: UIViewController {
    
    @IBOutlet var viewA: UIView!
    @IBOutlet var viewB: UIView!
    
    var worldStateController: WorldStateController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewA.isHidden = false
        viewB.isHidden = true
    }
    
    @IBAction func switchViewButtonPressed(_ sender: UIBarButtonItem) {
        viewA.isHidden = !viewA.isHidden
        viewB.isHidden = !viewB.isHidden
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "listViewSegue":
            let listVC = segue.destination as! ListViewController
            listVC.worldStateController = worldStateController
        case "itemViewSegue":
            let itemVC = segue.destination as! ItemViewController
            itemVC.worldStateController = worldStateController
        default:
            preconditionFailure("Unknown segue identifier.")
        }
    }
    
}
