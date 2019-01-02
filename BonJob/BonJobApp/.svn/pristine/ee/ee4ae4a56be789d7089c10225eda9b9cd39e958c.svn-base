//
//  PositionDropDown.swift
//  BONJOB
//
//  Created by Infoicon on 08/08/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

import UIKit

class PositionDropDown: NSObject {

    var position_content_id = ""
    var position_id = ""
    var position_name = ""
    var parent_position_id = ""
    var language_id = ""
    var status = ""
    var addedBy = ""
    var updatedOn = ""
    var area_of_activities = [AreaOfActivities]()
    
    
    
    override init() {
        
    }
    init(dict :  NSDictionary) {
        position_content_id = dict["position_content_id"] as! String
        position_id = dict["position_id"] as! String
        position_name = dict["position_name"] as! String
        parent_position_id = dict["parent_position_id"] as! String
        language_id = dict["language_id"] as! String
        status = dict["status"] as! String
        addedBy = dict["addedBy"] as! String
        updatedOn = dict["updatedOn"] as! String
        let area_ofactivities = dict["area_of_activities"] as! [NSDictionary]
        for dicted in area_ofactivities  {
          area_of_activities.append(AreaOfActivities.init(dict: dicted))
        }
        
    }
}
class AreaOfActivities : NSObject
{
    var position_content_id = ""
    var position_id = ""
    var position_name = ""
    var parent_position_id = ""
    var language_id = ""
    var status = ""
    var addedBy = ""
    var updatedOn = ""
    
    override init() {
        
    }
    init(dict :  NSDictionary) {
        position_content_id = dict["position_content_id"] as! String
        position_id = dict["position_id"] as! String
        position_name = dict["position_name"] as! String
        parent_position_id = dict["parent_position_id"] as! String
        language_id = dict["language_id"] as! String
        status = dict["status"] as! String
        addedBy = dict["addedBy"] as! String
        updatedOn = dict["updatedOn"] as! String
        
        
    }
    
}
