//
//  InfoViewController.swift
//  WhereAmI
//
//  Created by IMCS on 9/21/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InfoViewController: UIViewController,GADBannerViewDelegate {
    
    @IBOutlet weak var BannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        BannerView.rootViewController = self
        BannerView.load(GADRequest())
        BannerView.delegate = self

        
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
