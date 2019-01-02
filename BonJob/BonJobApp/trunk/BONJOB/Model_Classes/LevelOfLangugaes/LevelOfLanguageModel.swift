//
//  LevelOfLanguageModel.swift
//  BONJOB
//
//  Created by Infoicon on 09/08/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

import UIKit

class LevelOfLanguageModel: NSObject {
    var job_language_content_id = ""
    var job_language_id = ""
    var job_language_title = ""
    var language_id = ""
    var status = ""
    var addedBy = ""
    var updatedOn = ""
    
    
    
    override init() {
        
    }
    
    init(dict : NSDictionary) {
        
        job_language_content_id = dict["job_language_content_id"] as! String
        job_language_id = dict["job_language_id"] as! String
        job_language_title = dict["job_language_title"] as! String
        language_id = dict["language_id"] as! String
        status = dict["status"] as! String
        addedBy = dict["addedBy"] as! String
        updatedOn = dict["updatedOn"] as! String
    }
}
