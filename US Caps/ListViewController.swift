//
//  MainViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/21/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet private var filterButton: UIBarButtonItem!
    @IBOutlet private var listDisplayModeButton: UIBarButtonItem!
    @IBOutlet private var tableView: UITableView!
    
    var worldStateController: WorldStateController!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        update(animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "itemViewSegue":
            let navVC = segue.destination as! UINavigationController
            let itemVC = navVC.topViewController as! ItemViewController
            itemVC.worldStateController = worldStateController
        default:
            preconditionFailure("Unknown segue identifier")
        }
    }
    
    // MARK: - Target-Actions
    @IBAction private func filterButtonPressed(_ sender: UIBarButtonItem) {
        showFilterOptions(sender)
    }
    
    @IBAction private func reverseButtonPressed(_ sender: UIBarButtonItem) {
        worldStateController.reversePair()
        reloadRows(withAnimation: .automatic, usingInterval: 0.05)
    }
    
    @IBAction private func displayModeButtonPressed(_ sender: UIBarButtonItem) {
        let newMode = worldStateController.nextDisplayModeForList()
        listDisplayModeButton.title = newMode.next.rawValue.capitalized
        update(animated: true)
    }
    
    @IBAction func unwindToListView(_ unwindSegue: UIStoryboardSegue) {}

    // MARK: - Helpers
    private func showFilterOptions(_ sender: UIBarButtonItem) {
        // Create alert
        let actionSheet = UIAlertController(title: "Study By Region", message: nil, preferredStyle: .actionSheet)

        // Add handler for each filter.
        actionSheet.addAction(UIAlertAction(title: "All", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .all)
        })
        
        actionSheet.addAction(UIAlertAction(title: "Midwest", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .midwest)
        })
        
        actionSheet.addAction(UIAlertAction(title: "Northeast", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .northeast)
        })
        
        actionSheet.addAction(UIAlertAction(title: "Southeast", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .southeast)
        })
        
        actionSheet.addAction(UIAlertAction(title: "Southwest", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .southwest)
        })
        
        actionSheet.addAction(UIAlertAction(title: "West", style: .default) { [unowned self] _ in
            self.updateFilter(from: self.worldStateController.worldState.filter,
                              to: .west)
        })
        
        // Add Cancel
        actionSheet.addAction(UIAlertAction(title: "Cancel", style:.cancel))
        
        // Handle popovers
        actionSheet.popoverPresentationController?.barButtonItem = sender

        // Show it
        self.present(actionSheet, animated: true)
    }
    
    private func updateFilter(from: WorldState.Filter, to: WorldState.Filter) {
        
        var currentStates = worldStateController.worldState.states(by: from)
        let targetStates = worldStateController.worldState.states(by: to)
        
        for state in worldStateController.worldState.all {
            
            // Add missing state
            if !currentStates.contains(state) && targetStates.contains(state) {
                
                currentStates.append(state)
                worldStateController.update(toCustomFilterWith: currentStates)
                tableView.insertRows(at: [IndexPath(row: currentStates.count - 1, section: 0)], with: .automatic)
            }
            
            // Delete extra state
            else if currentStates.contains(state) && !targetStates.contains(state) {
                let index = currentStates.firstIndex { $0.id == state.id }!
                currentStates.remove(at: index)
                worldStateController.update(toCustomFilterWith: currentStates)
                tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
            
//            // How do i insert at the right spot?
//            else {
//                tableView.reloadRows(at: <#T##[IndexPath]#>, with: .automatic)
//            }
        }
        
        tableView.setContentOffset(CGPoint.zero, animated: true)
        worldStateController.update(filter: to)
        filterButton.title = worldStateController.worldState.filter.toString()
        
        print(currentStates.count)
        print(targetStates.count)
        print(worldStateController.worldState.states.count)
    }
    
    func update(animated: Bool) {
        
        if animated {
            reloadRows(withAnimation: .automatic, usingInterval: 0.05)
        }
        else {
            update()
        }
    }
    
    private func update() {
        tableView.reloadData()
        filterButton.title = worldStateController.worldState.filter.toString()
        listDisplayModeButton.title = worldStateController.worldState.displayMode.next.rawValue.capitalized
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldStateController.worldState.states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let state = worldStateController.worldState.states[indexPath.row]
        let labelText = worldStateController.worldState.pairReversed ?
            state.capital : state.name
        let detailText = worldStateController.worldState.pairReversed ?
            state.name : state.capital
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        cell.textLabel?.text = labelText
        cell.detailTextLabel?.text = detailText.display(usingMode: state.displayMode)
        
        return cell
    }
    
    // MARK: Implement
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let state = worldStateController.worldState.states[index]
        
        // Update current index
        worldStateController.update(index: index)
        
        // Change display mode
        worldStateController.nextDisplayModeFor(state: state)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func reloadRows(withAnimation rowAnimation: UITableView.RowAnimation, usingInterval timeInterval: TimeInterval) {
        
        worldStateController.worldState.states.enumerated().forEach { (arg) in
            
            let (index, _) = arg
            Timer.scheduledTimer(withTimeInterval: Double(index) * timeInterval, repeats: false) {_ in
                
                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: rowAnimation)
            }
        }
    }
}


