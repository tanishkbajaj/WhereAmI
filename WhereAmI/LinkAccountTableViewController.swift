//
//  LinkAccountTableViewController.swift
//  WhereAmI
//
//  Created by IMCS2 on 9/20/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit

class LinkAccountTableViewController: UITableViewController {
    var options = ["Remove Ads", "How is works", "About App"]
    var string = "Quick Pin allows you to save the address just by tapping Pin It! Aleternatively, you can give title for the address you save"
    var copyright = "Copyright(c) 123 Apps Studio LLC"
    

    var quickPin = "Quick Pin"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.backgroundColor = hexStringToUIColor(hex: "#DADADA")
   
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section ==  2 {
            return " "
        }else{
            return " "
        }
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 2
        }else if section == 1{
            return 3
        }else{
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.section ==  0{
            if indexPath.row == 0 {
            let switchView = UISwitch(frame: CGRect.zero)
            cell.addSubview(switchView)
            cell.accessoryView = switchView
            cell.textLabel?.text = quickPin
            }else{
                cell.textLabel?.numberOfLines = 3
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.text = string
            }
        }else if indexPath.section == 1{
            cell.textLabel?.text = options[indexPath.row]
        }else if indexPath.section == 2{
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .gray
            cell.backgroundColor = .none
            cell.textLabel?.text = copyright
        
        }

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        if section == 0{
//
//            return "Quick Pin allows you to save the address just by tapping Pin It! Aleternatively, you can give title for the address you save"
//        }else{
//            return ""
//        }
    

    

    
    
    
    
//
//
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section ==  0{
            return 10
        }else{
            return 10
        }

    }

    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
    cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
    return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
    red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
    blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
    alpha: CGFloat(1.0)
    )
    }

}
