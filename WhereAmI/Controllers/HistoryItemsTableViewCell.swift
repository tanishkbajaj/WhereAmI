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
    
    @IBOutlet weak var DistanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
