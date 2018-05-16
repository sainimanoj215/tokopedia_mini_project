//
//  Category.swift
//  Tokopedia
//
//  Created by Manoj Saini on 16/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//

import UIKit

class Category: NSObject {
    var id:Int? = 0
    var name:String? = ""
    var total_data:String? = ""
    var parent_id:Int? = 0
    var child_ids:[Int]? = []
    var level:Int? = 0
    
    override init() {
        super.init()
    }
    
    func Populate(dictionary:NSDictionary) {        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        total_data = dictionary["total_data"] as? String
        parent_id = dictionary["parent_id"] as? Int
        child_ids = dictionary["child_id"] as? [Int]
        level = dictionary["level"] as? Int
    }
    
    class func Populate(data:Data) -> Category
    {
        return Populate(dictionary: try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary)
    }
    
    class func Populate(dictionary:NSDictionary) -> Category
    {
        let result = Category()
        result.Populate(dictionary: dictionary)
        return result
    }
    
    class func PopulateArray(array:NSArray) -> [Category]
    {
        var result:[Category] = []
        for item in array
        {
            let newItem = Category()
            newItem.Populate(dictionary: item as! NSDictionary)
            result.append(newItem)
        }
        return result
    }
}

