//
//  SalariesModel.swift
//  BONJOB
//
//  Created by VISHAL SETH on 23/08/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

import UIKit

class SalariesModel: NSObject {
    var salary_content_id = ""
    var salary_id = ""
    var salary_title = ""
    var language_id = ""
    var status = ""
    var addedBy = ""
    var updatedOn = ""
    
    override init() {
        
    }
    
    init(dict : NSDictionary) {
        
        salary_content_id = dict["salary_content_id"] as! String
        salary_id = dict["salary_id"] as! String
        salary_title = dict["salary_title"] as! String
        language_id = dict["language_id"] as! String
        status = dict["status"] as! String
        addedBy = dict["addedBy"] as! String
        updatedOn = dict["updatedOn"] as! String
    }
}
