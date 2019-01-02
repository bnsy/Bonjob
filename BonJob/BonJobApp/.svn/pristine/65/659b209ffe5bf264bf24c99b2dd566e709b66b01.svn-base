//
//  ExperienceModel.swift
//  BONJOB
//
//  Created by Infoicon on 13/08/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

import UIKit

class ExperienceModel: NSObject {

    var experience_content_id = ""
    var experience_id = ""
    var experience_title = ""
    var language_id = ""
    var status = ""
    var addedBy = ""
    var updatedOn = ""
    
    override init() {
        
    }
    
    init(dict : NSDictionary) {
        
        experience_content_id = dict["experience_content_id"] as! String
        experience_id = dict["experience_id"] as! String
        experience_title = dict["experience_title"] as! String
        language_id = dict["language_id"] as! String
        status = dict["status"] as! String
        addedBy = dict["addedBy"] as! String
        updatedOn = dict["updatedOn"] as! String
    }
    
}
