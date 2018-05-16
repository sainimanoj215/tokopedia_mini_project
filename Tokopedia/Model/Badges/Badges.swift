//
//  Badges.swift
//  Tokopedia
//
//  Created by Manoj Saini on 16/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//

import UIKit

class Badges: NSObject {
    var title:String? = ""
    var image_url:String? = ""
    
    override init() {
        super.init()
    }
    
    func Populate(dictionary:NSDictionary) {
        
        title = dictionary["title"] as? String
        image_url = dictionary["image_url"] as? String
    }
    
    class func Populate(data:Data) -> Badges
    {
        return Populate(dictionary: try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary)
    }
    
    class func Populate(dictionary:NSDictionary) -> Badges
    {
        let result = Badges()
        result.Populate(dictionary: dictionary)
        return result
    }
    
    class func PopulateArray(array:NSArray) -> [Badges]
    {
        var result:[Badges] = []
        for item in array
        {
            let newItem = Badges()
            newItem.Populate(dictionary: item as! NSDictionary)
            result.append(newItem)
        }
        return result
    }
    
}
