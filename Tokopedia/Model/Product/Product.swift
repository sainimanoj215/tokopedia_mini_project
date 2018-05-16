//
//  Product.swift
//  Tokopedia
//
//  Created by Manoj Saini on 16/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//

import UIKit

class Product: NSObject {
    var id:Int? = 0
    var name:String? = ""
    var uri:String? = ""
    var image_uri:String? = ""
    var image_uri_700:String? = ""
    var price:String? = ""
    var price_range:String? = ""
    var category_breadcrumb:String? = ""
    var shop:Shop? = Shop()
    var condition:Int? = 0
    var preorder:Int? = 0
    var department_id:Int? = 0
    var rating:Int? = 0
    var is_featured:Int? = 0
    var count_review:Int? = 0
    var count_talk:Int? = 0
    var count_sold:Int? = 0
    var badges:[Badges]? = []
    var original_price:String? = ""
    var discount_expired:String? = ""
    var discount_start:String? = ""
    var discount_percentage:Int? = 0
    var stock:Int? = 0
    
    override init() {
        super.init()
    }
    
    func Populate(dictionary:NSDictionary) {
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        uri = dictionary["uri"] as? String
        image_uri = dictionary["image_uri"] as? String
        image_uri_700 = dictionary["image_uri_700"] as? String
        price = dictionary["price"] as? String
        price_range = dictionary["price_range"] as? String
        category_breadcrumb = dictionary["category_breadcrumb"] as? String
        shop = dictionary["shop"] as? Shop
        condition = dictionary["condition"] as? Int
        preorder = dictionary["preorder"] as? Int
        department_id = dictionary["department_id"] as? Int
        rating = dictionary["rating"] as? Int
        is_featured = dictionary["is_featured"] as? Int
        count_review = dictionary["count_review"] as? Int
        count_talk = dictionary["count_talk"] as? Int
        count_sold = dictionary["count_sold"] as? Int
        if ((dictionary["badges"] as? NSArray)?.count)! > 0 {
            badges = Badges.PopulateArray(array: (dictionary["badges"] as? NSArray)!)
        } else {
            badges = []
        }
        original_price = dictionary["original_price"] as? String
        discount_expired = dictionary["discount_expired"] as? String
        discount_start = dictionary["discount_start"] as? String
        discount_percentage = dictionary["discount_percentage"] as? Int
        stock = dictionary["stock"] as? Int
    }
    
    class func Populate(data:Data) -> Product
    {
        return Populate(dictionary: try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary)
    }
    
    class func Populate(dictionary:NSDictionary) -> Product
    {
        let result = Product()
        result.Populate(dictionary: dictionary)
        return result
    }
    
    class func PopulateArray(array:NSArray) -> [Product]
    {
        var result:[Product] = []
        for item in array
        {
            let newItem = Product()
            newItem.Populate(dictionary: item as! NSDictionary)
            result.append(newItem)
        }
        return result
    }
    
}




