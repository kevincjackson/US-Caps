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
    private var numerator = 0
    private var denominator = 50

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "pageViewSegue":
            let pageVC = segue.destination as! PageViewController
            pageVC.worldStateController = worldStateController
            pageViewController = pageVC
        default:
            preconditionFailure("Unkown segue identifier.")
        }
    }

    func update() {
        pageViewController?.update()
        numerator = worldStateController.worldState.index + 1
        denominator = worldStateController.worldState.states.count
        updateProgressView()
        updateProgressLabel()
    }
    
    private func updateProgressView() {
        let percentage = Float(numerator) / Float(denominator)
        progressView.progress = percentage
    }
    
    private func updateProgressLabel() {
        let text = "\(numerator) / \(denominator)"
        progressLabel.text = text
    }
}
