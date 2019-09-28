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
        
        
   // self.navigationController?.navigationBar.backItem?.title = "Cancel"
 
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
