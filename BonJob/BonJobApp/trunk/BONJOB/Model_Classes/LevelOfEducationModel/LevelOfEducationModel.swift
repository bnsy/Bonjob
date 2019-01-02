//
//  LevelOfEducationModel.swift
//  BONJOB
//
//  Created by Infoicon on 09/08/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

import UIKit

class LevelOfEducationModel: NSObject {
    // Contartct var
    var education_content_id = ""
    var education_id = ""
    var education_title = ""
    var language_id = ""
    var status = ""
    var addedBy = ""
    var updatedOn = ""
    
    
    
    override init() {
        
    }
    
    init(dict : NSDictionary) {
      
        education_content_id = dict["education_content_id"] as! String
        education_id = dict["education_id"] as! String
        education_title = dict["education_title"] as! String
        language_id = dict["language_id"] as! String
        status = dict["status"] as! String
        addedBy = dict["addedBy"] as! String
        updatedOn = dict["updatedOn"] as! String
    }
    
    init(candidateSeeksDict : NSDictionary)
    {
        education_content_id = candidateSeeksDict["candidate_seek_content_id"] as! String
        education_id = candidateSeeksDict["candidate_seek_id"] as! String
        education_title = candidateSeeksDict["candidate_seek_title"] as! String
        language_id = candidateSeeksDict["language_id"] as! String
        status = candidateSeeksDict["status"] as! String
        addedBy = candidateSeeksDict["addedBy"] as! String
        updatedOn = candidateSeeksDict["updatedOn"] as! String
    }
    
}
