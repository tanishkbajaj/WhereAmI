//
//  WhereAmITableView.swift
//  WhereAmI
//
//  Created by IMCS2 on 9/15/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit

class WhereAmITableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    

   

}
