//
//  JobTitleModel.swift
//  BONJOB
//
//  Created by Infoicon on 13/08/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

import UIKit

class JobTitleModel: NSObject {
    
    var job_title_content_id = ""
    var job_title_id = ""
    var job_title = ""
    var language_id = ""
    var status = ""
    var addedBy = ""
    var updatedOn = ""
    
    override init() {
        
    }
    
    init(dict : NSDictionary) {
        
        job_title_content_id = dict["job_title_content_id"] as! String
        job_title_id = dict["job_title_id"] as! String
        job_title = dict["job_title"] as! String
        language_id = dict["language_id"] as! String
        status = dict["status"] as! String
        addedBy = dict["addedBy"] as! String
        updatedOn = dict["updatedOn"] as! String
    }
    
}
