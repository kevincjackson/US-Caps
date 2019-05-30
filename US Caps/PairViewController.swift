//
//  PairViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/25/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

protocol PairViewControllerDelegate: AnyObject {
    func stateDisplayModeDidUpdate(for state: State)
}

class PairViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    var worldStateController: WorldStateController!
    var index: Int!
    weak var pairViewControllerDelegate: PairViewControllerDelegate?
    
    private var state: State!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        state = worldStateController.worldState.states[index]
        let questionText = worldStateController.worldState.pairReversed ?
            state.capital : state.name
        let answerText = worldStateController.worldState.pairReversed ?
            state.name : state.capital
        let answerTextFormatted = answerText.display(usingMode: state.displayMode)

        questionLabel.text = questionText
        answerLabel.text = answerTextFormatted
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        worldStateController.nextDisplayModeFor(state: state)
        pairViewControllerDelegate?.stateDisplayModeDidUpdate(for: state)
    }
}

// MARK: -
extension PairViewController {
    
    // Convenience function for creating a Pair View
    static func instantiateFromStoryBoard(worldStateController: WorldStateController,
                                          index: Int) -> PairViewController {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pairViewController") as! PairViewController
        
        vc.worldStateController = worldStateController
        vc.index = index
        
        return vc
    }
}
