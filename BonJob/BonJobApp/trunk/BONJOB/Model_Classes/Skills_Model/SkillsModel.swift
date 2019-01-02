//
//  SkillsModel.swift
//  BONJOB
//
//  Created by Infoicon on 13/08/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

import UIKit

class SkillsModel: NSObject {
    
    var skill_content_id = ""
    var skill_id = ""
    var skill_title = ""
    var language_id = ""
    var status = ""
    var addedBy = ""
    var updatedOn = ""
    
    override init() {
        
    }
    
    init(dict : NSDictionary) {
        
        skill_content_id = dict["skill_content_id"] as! String
        skill_id = dict["skill_id"] as! String
        skill_title = dict["skill_title"] as! String
        language_id = dict["language_id"] as! String
        status = dict["status"] as! String
        addedBy = dict["addedBy"] as! String
        updatedOn = dict["updatedOn"] as! String
    }
    
}
