//
//  StatusModel.swift
//  BONJOB
//
//  Created by Infoicon on 13/08/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

import UIKit

class StatusModel: NSObject {
    var seeker_current_status_content_id = ""
    var seeker_current_status_id = ""
    var seeker_current_status_title = ""
    var language_id = ""
    var status = ""
    var addedBy = ""
    var updatedOn = ""

    override init() {
        
    }
    
    init(dict : NSDictionary) {
        
        seeker_current_status_content_id = dict["seeker_current_status_content_id"] as! String
        seeker_current_status_id = dict["seeker_current_status_id"] as! String
        seeker_current_status_title = dict["seeker_current_status_title"] as! String
        language_id = dict["language_id"] as! String
        status = dict["status"] as! String
        addedBy = dict["addedBy"] as! String
        updatedOn = dict["updatedOn"] as! String
    }
    
}
