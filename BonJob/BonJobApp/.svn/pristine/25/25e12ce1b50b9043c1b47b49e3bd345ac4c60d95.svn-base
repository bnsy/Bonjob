//
//  MobilityModel.swift
//  BONJOB
//
//  Created by Infoicon on 13/08/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

import UIKit

class MobilityModel: NSObject {

    var mobility_content_id = ""
    var mobility_id = ""
    var mobility_title = ""
    var language_id = ""
    var status = ""
    var addedBy = ""
    var updatedOn = ""
    
    override init() {
        
    }
    
    init(dict : NSDictionary) {
        
        mobility_content_id = dict["mobility_content_id"] as! String
        mobility_id = dict["mobility_id"] as! String
        mobility_title = dict["mobility_title"] as! String
        language_id = dict["language_id"] as! String
        status = dict["status"] as! String
        addedBy = dict["addedBy"] as! String
        updatedOn = dict["updatedOn"] as! String
    }
    
}
