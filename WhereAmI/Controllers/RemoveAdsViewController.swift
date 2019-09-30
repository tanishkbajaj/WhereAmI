//
//  RemoveAdsViewController.swift
//  WhereAmI
//
//  Created by IMCS2 on 9/26/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit

class RemoveAdsViewController: UIViewController {
    
    @IBOutlet weak var restorePurchases: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restorePurchases?.layer.cornerRadius = 8.0
        restorePurchases?.layer.borderWidth = 1.0
        restorePurchases?.layer.borderColor = UIColor.orange.cgColor
        
   
    }
    

}
