//
//  InfoViewController.swift
//  WhereAmI
//
//  Created by IMCS on 9/21/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit
import MessageUI
import GoogleMobileAds

class InfoViewController: UIViewController,GADBannerViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var BannerView: GADBannerView!
    @IBOutlet weak var infoLabel: UILabel?
    @IBOutlet weak var feedbackButton: UIButton?
    @IBOutlet weak var inviteFriendsButton: UIButton?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        BannerView.rootViewController = self
        BannerView.load(GADRequest())
        BannerView.delegate = self
        
        feedbackButton?.layer.cornerRadius = 8.0
        feedbackButton?.layer.borderWidth = 1.0
        feedbackButton?.layer.cornerRadius = 25.0
        feedbackButton?.layer.borderWidth = 1.5
        feedbackButton?.layer.borderColor = UIColor.green.cgColor
        
        inviteFriendsButton?.layer.cornerRadius = 8.0
        inviteFriendsButton?.layer.borderWidth = 1.0
        inviteFriendsButton?.layer.cornerRadius = 25.0
        inviteFriendsButton?.layer.borderWidth = 1.5
        inviteFriendsButton?.layer.borderColor = UIColor.green.cgColor
    }
    
    
    @IBAction func feedbackButton(_ sender: Any) {
        if MFMailComposeViewController.canSendMail(){
            let mail =  MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mail.setToRecipients(["channappakg@gmail.com"])
            mail.setMessageBody("Feedback for 'Where Am I'", isHTML: true)
            present(mail, animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: "Sending Mail failed", preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .default
                , handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?){
        controller.dismiss(animated: true)
    }
    
    @IBAction func inviteFriendsButton(_ sender: Any) {
        let activity = UIActivityViewController(
            activityItems: ["Download Where Am I app from App store. This is the amazing app!!!"],
            applicationActivities: nil
        )
        present(activity, animated: true, completion: nil)
    }

}
