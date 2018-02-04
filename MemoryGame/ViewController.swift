//
//  ViewController.swift
//  MemoryGame
//
//  Created by Sebastian Strus on 2018-02-03.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var p1score: UILabel!
    @IBOutlet weak var p2score: UILabel!
    
    var p1points = 0 {
        didSet {
            p1score.text = "\(p1points)"
        }
    }
    var p2points = 0 {
        didSet {
            p2score.text = "\(p2points)"
        }
    }
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiChoices = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🦄", "🐌", "🐞", "🕷", "🐋", "🐁", "🐄", "🐖", "🐓", "🐥", "🐟", "🐈", "🐩", "🐇", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🦄", "🐌", "🐞", "🕷", "🐋", "🐁", "🐄", "🐖", "🐓", "🐥", "🐟", "🐈", "🐩", "🐇"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in cardButtons {
            button.layer.cornerRadius = 3
            button.clipsToBounds = true
            button.backgroundColor = UIColor.orange
            button.layer.borderWidth = 0.3
            button.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("Choosen card was not in cardButtons")
        }
        
        
    }

    
    
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        print("emoji \(emoji)")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = UIColor.orange
            button.alpha = 0.7
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.alpha = 1.0
        }
    }

    @IBAction func restartPressed(_ sender: UIButton) {
        emojiChoices.shuffle()
        p1points = 0
        p2points = 0
        flipCount = 0
        for button in cardButtons {
            button.backgroundColor = UIColor.orange
            button.setTitle("", for: UIControlState.normal)
            button.alpha = 1.0
        }
    }
    
    @IBAction func p1minus(_ sender: Any) {
        p1points -= 1
    }
    @IBAction func p1plus(_ sender: Any) {
        p1points += 1
    }
    @IBAction func p2minus(_ sender: Any) {
        p2points -= 1
    }
    @IBAction func p2plus(_ sender: Any) {
        p2points += 1
    }
    

    
}

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

