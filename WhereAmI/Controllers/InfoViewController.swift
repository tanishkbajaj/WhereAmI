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

class InfoViewController: UIViewController, GADBannerViewDelegate {
    @IBOutlet weak var infoLabel: UILabel?
    
    @IBOutlet weak var feedbackButton: UIButton?
    
    @IBOutlet weak var inviteFriendsButton: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        BannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        BannerView.rootViewController = self
        BannerView.load(GADRequest())
        BannerView.delegate = self

        let attributedString = NSMutableAttributedString(string: "Thank for using the Where Am I App. This app provides you the current location on map address along with GPS coordinates. You can share your address as needed. It provides best possible address to its capability and can't be held accountable for any incorrect details. Hope this app helps in the little way! Your address is stored ONLY locally on your phone. You can save/pin your current address and use it anytime to navigate to that address just by a tap.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 15
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        infoLabel?.attributedText = attributedString
        
        feedbackButton?.layer.cornerRadius = 8.0
        feedbackButton?.layer.borderWidth = 1.0
        feedbackButton?.layer.borderColor = UIColor.orange.cgColor
        
        inviteFriendsButton?.layer.cornerRadius = 8.0
        inviteFriendsButton?.layer.borderWidth = 1.0
        inviteFriendsButton?.layer.borderColor = UIColor.orange.cgColor

        
    }
    
    @IBAction func feedbackButton(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let emailTitle = "Feedback"
            let messageBody = "Feature request or bug report?"
            let toRecipents = ["friend@stackoverflow.com"]
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mc.setSubject(emailTitle)
            mc.setMessageBody(messageBody, isHTML: false)
            mc.setToRecipients(toRecipents)
            
            self.present(mc, animated: true, completion: nil)
        } else {
            // show failure alert
        }
    }
    
    
    @IBAction func inviteFriendButton(_ sender: Any) {
        let activity = UIActivityViewController(
            activityItems: ["Share the info about the app"],
            applicationActivities: nil
        )
        present(activity, animated: true, completion: nil)
        
    }

func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError) {
    switch result {
    case .cancelled:
        print("Mail cancelled")
    case .saved:
        print("Mail saved")
    case .sent:
        print("Mail sent")
    case .failed:
        print("Mail sent failure: \(error.localizedDescription)")
    default:
        break
    }
    self.dismiss(animated: true, completion: nil)
}
}
