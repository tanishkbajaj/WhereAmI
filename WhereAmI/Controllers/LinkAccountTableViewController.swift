//
//  LinkAccountTableViewController.swift
//  WhereAmI
//
//  Created by IMCS2 on 9/20/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//
import UIKit
var flag: Bool?


class LinkAccountTableViewController: UITableViewController {

    
    var options = ["Remove Ads", "How is works", "About App"]
    var string = "Quick Pin allows you to save the address just by tapping Pin It! Aleternatively, you can give title for the address you save"
    var copyright = "Copyright(c) TCS"
    var switchViewBool = UserDefaults.standard.bool(forKey: "switchState")
    var quickPin = "Quick Pin"
    
    let switchView = UISwitch(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.backgroundColor = hexStringToUIColor(hex: "#DADADA")
      //  switchViewBool = UserDefaults.standard.bool(forKey: "switchState")
        
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
                cell.addSubview(switchView)
                cell.accessoryView = switchView
                switchView.addTarget(self, action: #selector(self.switchValueDidChange), for: .valueChanged)
                switchView.isOn =  UserDefaults.standard.bool(forKey: "switchState")
                cell.textLabel?.text = quickPin
            }else{
                cell.textLabel?.numberOfLines = 3
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.text = string
            }
        }else if indexPath.section == 1{
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = options[indexPath.row]
        }else if indexPath.section == 2{
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .gray
            cell.backgroundColor = .none
            cell.textLabel?.text = copyright
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section ==  0{
            return 10
        }else{
            return 10
        }
        
    }
    @objc func switchValueDidChange(sender:UISwitch!) {
        UserDefaults.standard.set(sender.isOn, forKey: "switchState")
    }
    

    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let removeADsController = storyBoard.instantiateViewController(withIdentifier: "removeADs")
                
                self.navigationController?.pushViewController(removeADsController, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)

                
            }
            
            if indexPath.row == 1 {

                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "onboarding")
                self.present(newViewController, animated: true, completion: nil)
               
            }
            if indexPath.row == 2 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let infoController = storyBoard.instantiateViewController(withIdentifier: "infoController")
                self.show(infoController, sender: self)
            }
        }
    }
    
    
    //Adding the color to the whole view controller
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
    
    
    
    private func setupNavigationItems() {
        let label = UILabel()
        //Diables the auto resize of the image
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        //label.textColor = .white
        label.textAlignment = .left
       // label.font = UIFont.systemFont(ofSize: 20)
      //  label.font = UIFont.boldSystemFont(ofSize: 22.0)
        navigationItem.titleView = label
    }
    
}
