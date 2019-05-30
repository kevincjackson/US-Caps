//
//  ItemViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var progressLabel: UILabel!

    var worldStateController: WorldStateController!
    
    private var pageViewController: PageViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "pageViewSegue":
            let pageVC = segue.destination as! PageViewController
            pageVC.worldStateController = worldStateController
            pageViewController = pageVC
        case "unwindToListView":
            break
        default:
            preconditionFailure("Unknown segue identifier.")
        }
    }

    func update() {
//        pageViewController?.update()

        let numerator = worldStateController.worldState.index + 1
        let denominator = worldStateController.worldState.states.count
        let percentage = Float(numerator) / Float(denominator)
        let text = "\(numerator) / \(denominator)"
        
        progressLabel.text = text
        progressView.progress = percentage
    }
}
