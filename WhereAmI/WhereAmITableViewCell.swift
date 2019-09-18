//
//  WhereAmITableViewCell.swift
//  WhereAmI
//
//  Created by IMCS2 on 9/16/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit



class LabelCell: UITableViewCell {
    
  
    @IBOutlet weak var AddressLabel: UILabel!
    
    
}

class ButtonCell: UITableViewCell {
    
   
    @IBOutlet weak var shareButtonOutlet: UIButton!
    
    @IBAction func shareButtonAction(_ sender: Any) {
    }
    
    
    @IBOutlet weak var pinButtonOutlet: UIButton!
    
    @IBAction func pinButtonAction(_ sender: Any) {
    }
    
    
    @IBOutlet weak var historyButtonOutlet: UIButton!
    
    @IBAction func historyButtonAction(_ sender: Any) {
    }
    
}

