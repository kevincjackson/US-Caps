//
//  PairViewController.swift
//  US Caps
//
//  Created by Kevin Jackson on 5/25/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

class PairViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    var worldStateController: WorldStateController!
    var pageViewDirection: PageViewController.direction?
    var index: Int!
    private var question: String!
    private var answer: String!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        question = worldStateController.worldState.states[index].name
        answer = worldStateController.worldState.states[index].capital
        
        questionLabel.text = worldStateController.worldState.pairReversed ? answer : question
        answerLabel.text = worldStateController.worldState.pairReversed ? question : answer
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
