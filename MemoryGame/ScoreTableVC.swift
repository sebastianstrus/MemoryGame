//
//  ScoreTableVC.swift
//  MemoryGame
//
//  Created by Sebastian Strus on 2018-02-22.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

import UIKit

class ScoreTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    
    var players: [Player]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        players = CoreData.getUsers()
        
        if let aPlayers = players {
            players = Array(aPlayers).sorted(by: { ($0).score < ($1).score })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (players?.count)!
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = "\(indexPath.row + 1). " + players![indexPath.row].username!
        cell.textLabel?.font = UIFont.init(name: "Helvetica", size: 25)
        
        cell.detailTextLabel?.text = "\(players![indexPath.row].score)"
        cell.detailTextLabel?.font = UIFont.init(name: "Helvetica", size: 25)
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor(hexString: "#ffe700ff")//gold
        } else if (indexPath.row == 1) {
            cell.backgroundColor = UIColor(hexString: "#C0C0C0ff")//silver
        } else if (indexPath.row == 2) {
            cell.backgroundColor = UIColor(hexString: "#965A38ff")//bronze
        } else {
            cell.backgroundColor = UIColor(hexString: "#e6e8e3ff") //default
        }
        

        return cell
    }
    
//    func gradient(frame:CGRect) -> CAGradientLayer {
//        let layer = CAGradientLayer()
//        layer.frame = frame
//        layer.startPoint = CGPoint(x: 0, y: 0.5)
//        layer.endPoint = CGPoint(x: 1, y: 0.5)
//        layer.colors = [
//            UIColor(red: 252.0/255.0, green: 204.0/255.0, blue: 0, alpha: 1.0).cgColor, UIColor(red: 252.0/255.0, green: 184.0/255.0, blue: 0, alpha: 1.0).cgColor]
//        return layer
//    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
