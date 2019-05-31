//
//  ItemViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/22/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet var filterButton: UIBarButtonItem!
    @IBOutlet var listDisplayModeButton: UIBarButtonItem!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var progressLabel: UILabel!

    var worldStateController: WorldStateController!
    
    private var pageViewController: PageViewController?

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        update()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "pageViewSegue":
            let pageVC = segue.destination as! PageViewController
            pageVC.worldStateController = worldStateController
            pageVC.pageViewControllerDelegate = self
            pageViewController = pageVC
        case "unwindToListView":
            break
        default:
            preconditionFailure("Unknown segue identifier.")
        }
    }
    
    // MARK: - Target-Actions
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        showFilterOptions(sender)
    }
    
    @IBAction func reverseButtonPressed(_ sender: UIBarButtonItem) {
        worldStateController.reversePair()
        pageViewController?.updatePair()
    }
    
    @IBAction func listDisplayModeButtonPressed(_ sender: UIBarButtonItem) {
        let newMode = worldStateController.nextDisplayModeForList()
        listDisplayModeButton.title = newMode.next.rawValue.capitalized
        pageViewController?.updatePair()
    }
    
    // MARK: - Helpers
    private func showFilterOptions(_ sender: UIBarButtonItem) {
        // Create alert
        let actionSheet = UIAlertController(title: "Study By Region", message: nil, preferredStyle: .actionSheet)
        
        // Add handler for each filter.
        WorldState.Filter.allCases.forEach { stateFilter in
            actionSheet.addAction(UIAlertAction(
                title: "\(stateFilter)".capitalized,
                style: .default,
                handler: { [weak self] _ in
                    self?.worldStateController.update(filter: stateFilter)
                    self?.update()
            }))}
        
        // Add Cancel
        actionSheet.addAction(UIAlertAction(title: "Cancel", style:.cancel))
        
        // Handle popovers
        actionSheet.popoverPresentationController?.barButtonItem = sender
        
        // Show it
        self.present(actionSheet, animated: true)
    }

    func update() {
        updateToolBar()
        pageViewController?.update()
        updateProgress()
    }
    
    func updateToolBar() {
        filterButton.title = worldStateController.worldState.filter.rawValue.capitalized
        listDisplayModeButton.title = worldStateController.worldState.displayMode.next.rawValue.capitalized
    }
    
    func updateProgress() {
        let numerator = worldStateController.worldState.index + 1
        let denominator = worldStateController.worldState.states.count
        let percentage = Float(numerator) / Float(denominator)
        let text = "\(numerator) / \(denominator)"
        
        progressLabel.text = text
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.progressView.setProgress(percentage, animated: true)
        }
    }
}

extension ItemViewController: PageViewControllerDelegate {
    func indexDidUpdate() {
        updateProgress()
    }
}
