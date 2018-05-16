//
//  Shop.swift
//  Tokopedia
//
//  Created by Manoj Saini on 16/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//

import UIKit

class Shop: NSObject {
    var id:Int? = 0
    var name:String? = ""
    var uri:String? = ""
    var is_gold:Int? = 0
    var rating:Int? = 0
    var location:String? = ""
    var reputation_image_uri:String? = ""
    var shop_lucky:String? = ""
    var city:String? = ""
    
    override init() {
        super.init()
    }
    
    func Populate(dictionary:NSDictionary) {
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        uri = dictionary["uri"] as? String
        is_gold = dictionary["is_gold"] as? Int
        rating = dictionary["rating"] as? Int
        location = dictionary["location"] as? String
        reputation_image_uri = dictionary["reputation_image_uri"] as? String
        shop_lucky = dictionary["shop_lucky"] as? String
        city = dictionary["city"] as? String
    }
    
    class func Populate(data:Data) -> Shop
    {
        return Populate(dictionary: try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary)
    }
    
    class func Populate(dictionary:NSDictionary) -> Shop
    {
        let result = Shop()
        result.Populate(dictionary: dictionary)
        return result
    }
    
    class func PopulateArray(array:NSArray) -> [Shop]
    {
        var result:[Shop] = []
        for item in array
        {
            let newItem = Shop()
            newItem.Populate(dictionary: item as! NSDictionary)
            result.append(newItem)
        }
        return result
    }
    
}


