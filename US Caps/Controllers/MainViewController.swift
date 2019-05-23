//
//  MainViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/21/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var viewA: UIView!
    @IBOutlet var viewB: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewA.isHidden = false
        viewB.isHidden = true
    }
    
    @IBAction func switchViewButtonPressed(_ sender: UIBarButtonItem) {
        viewA.isHidden = !viewA.isHidden
        viewB.isHidden = !viewB.isHidden
    }
    
}
