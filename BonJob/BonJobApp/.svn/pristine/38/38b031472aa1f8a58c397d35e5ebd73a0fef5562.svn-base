//
//  JobSearchFilter.swift
//  BONJOB
//
//  Created by Infoicon on 08/08/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

import UIKit

class JobSearchFilter: NSObject {
    // Contartct var
    var contract_content_id = ""
    var contract_id = ""
    var contract_title = ""
    var language_id = ""
    var status = ""
    var addedBy = ""
    var updatedOn = ""
    
    // Education Leavels
    
    var education_content_id = ""
    var education_id = ""
    var education_title = ""
    
    // Experieicnes
    
    var experience_content_id = ""
    var experience_id = ""
    var experience_title = ""
   
    // Number of hours
    
    var hours_content_id = ""
    var hours_id = ""
    var hours_title = ""
    
    override init() {
        
    }
    
    init(dictContract : NSDictionary, type : String) {
        if type == "contract" {
            contract_content_id = dictContract["contract_content_id"] as! String
            contract_id = dictContract["contract_id"] as! String
            contract_title = dictContract["contract_title"] as! String
        }
        else if (type == "education")
        {
            education_content_id = dictContract["education_content_id"] as! String
            education_id = dictContract["education_id"] as! String
            education_title = dictContract["education_title"] as! String
        }
        else if (type == "experience")
        {
            experience_content_id = dictContract["experience_content_id"] as! String
            experience_id = dictContract["experience_id"] as! String
            experience_title = dictContract["experience_title"] as! String
        }
        else if (type == "hours")
        {
            hours_content_id = dictContract["hours_content_id"] as! String
            hours_id = dictContract["hours_id"] as! String
            hours_title = dictContract["hours_title"] as! String
        }
       
        language_id = dictContract["language_id"] as! String
        status = dictContract["status"] as! String
        addedBy = dictContract["addedBy"] as! String
        updatedOn = dictContract["updatedOn"] as! String
    }
    
    
}
