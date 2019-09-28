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
        
        
//        let attributedString = NSMutableAttributedString(string: "Thank You for using the Where Am I App. This app provides you the current location on map address along with GPS coordinates. You can share your address as needed. It provides best possible address to its capability and can't be held accountable for any incorrect details. Hope this app helps in the little way! Your address is stored ONLY locally on your phone. You can save/pin your current address and use it anytime to navigate to that address just by a tap.")
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 10
//        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
//        infoLabel?.attributedText = attributedString
//        infoLabel?.textAlignment = .center
    

        
        feedbackButton?.layer.cornerRadius = 8.0
        feedbackButton?.layer.borderWidth = 1.0
        feedbackButton?.layer.cornerRadius = 5.0
        feedbackButton?.layer.borderWidth = 1
        feedbackButton?.layer.borderColor = UIColor.black.cgColor
        
        inviteFriendsButton?.layer.cornerRadius = 8.0
        inviteFriendsButton?.layer.borderWidth = 1.0
        inviteFriendsButton?.layer.cornerRadius = 5.0
        inviteFriendsButton?.layer.borderWidth = 1
        inviteFriendsButton?.layer.borderColor = UIColor.black.cgColor

        
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
