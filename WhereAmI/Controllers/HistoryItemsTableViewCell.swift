//
//  HistoryItemsTableViewCell.swift
//  WhereAmI
//
//  Created by IMCS on 9/20/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit

class HistoryItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var LocationNameLabel: UILabel!
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
