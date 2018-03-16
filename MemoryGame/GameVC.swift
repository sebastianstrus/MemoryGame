//
//  GameVC.swift
//  MemoryGame
//
//  Created by Sebastian Strus on 2018-02-24.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    var isGameOver: Bool?
    @IBOutlet weak var flipCountLabel: UILabel!
    //@IBOutlet var cardButtons: [UIButton]!
    @IBOutlet var cardButtons: [UIButton]!
    

    
    lazy var game = Memory(numberOfPairsOfCards: (cardButtons.count) / 2)
    
    var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" } }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        isGameOver = false

        
        print("GameVC ViewDidLoad")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Choosen card was not in cardButtons")
        }
    }
    
    
    func updateViewFromModel() {
        var matchedCards = 0
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.alpha = 1.0
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : #colorLiteral(red: 0, green: 0.5572491288, blue: 1, alpha: 1)
            }
            
            if card.isMatched == true {
                matchedCards += 1
            }
        }
        if matchedCards == 60 {
            createParticles()
            gameOver()
            if (isGameOver == false) {
                scoreAlert()
            }
        }
    }
    
    var emojiChoices = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🦄", "🐌", "🐞", "🕷", "🐋", "🐁", "🐄", "🐖", "🐓", "🐥", "🐟", "🐈", "🐩", "🐇", "🦃"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?" //if is nil returns "?"
    }
    
    
    
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        print("emoji \(emoji)")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0.5572491288, blue: 1, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.alpha = 1.0
        }
    }
    
    
    func scoreAlert() {
        isGameOver = true
        let alert = UIAlertController(title: "Congratulations!", message: "What is your name?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter your name..."
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            if let name = alert.textFields?.first?.text {
                let score: Int32 = Int32(self.flipCount)
                print("Your name: \(name)")
                let saved = CoreData.saveUser(username: name, score: score)
                if saved == true {
                    print("User is saved")
                }
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    public func createParticles() {
        let view = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        view.contentMode = UIViewContentMode.scaleAspectFill
        //view.image = UIImage(named: "landscape")
        self.view.addSubview(view)
        let cloud = CAEmitterLayer()
        cloud.emitterPosition = CGPoint(x: view.center.x, y: -50)
        cloud.emitterShape = kCAEmitterLayerLine
        cloud.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        let flake = makeEmitterCell()
        cloud.emitterCells = [flake]
        view.layer.addSublayer(cloud)
    }
    
    func makeEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contentsScale = 1.5
        cell.birthRate = 4
        cell.lifetime = 50.0
        cell.velocity = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 0.5
        cell.spinRange = 1.2
        cell.scaleRange = -0.05
        cell.contents = UIImage(named: "card")?.cgImage
        return cell
    }
    
    func gameOver() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 460, height: 60))
        label.center = self.view.center
        label.textAlignment = .center
        label.text = "Game over"
        label.textColor = UIColor.red
        label.font = label.font.withSize(40)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 50.0)
        self.view.addSubview(label)
    }
    
//    func scoreAlert() {
//        let alert = UIAlertController(title: "You won!", message: "Please enter your name.", preferredStyle: UIAlertControllerStyle.alert)
//        let action = UIAlertAction(title: "Name Input", style: .default) { (alertAction) in
//            let textField = alert.textFields![0] as UITextField
//        }
//        alert.addTextField { (textField) in
//            textField.placeholder = "Enter your name"
//        }
//        alert.addAction(action)
//        self.present(self, animated:true, completion: nil)
//    }

}
