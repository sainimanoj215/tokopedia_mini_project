//
//  BaseViewController.swift
//  Tokopedia
//
//  Created by Manoj Saini on 15/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//

import UIKit

class CommonClass: NSObject {

    //MARK: - Current Device
    class func getCurrentDeviceType() -> String {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
//                print("iPhone 5 or 5S or 5C")
                return iPhone_5
            case 1334:
//                print("iPhone 6/6S/7/8")
                return iPhone_6
            case 2208:
//                print("iPhone 6+/6S+/7+/8+")
                return iPhone_6_pluse
            case 2436:
//                print("iPhone X")
                return iPhone_X
            default:
//                print("unknown")
                return iPhone_unknown
            }
        }
        return iPhone_unknown
    }
    
    //MARK: - Validation
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        if let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx) as NSPredicate? {
            return emailTest.evaluate(with: testStr)
        }
        return false
    }
    
    class func isValidPassword(testStr:String) -> Bool {
        return testStr.count >= 3
    }
    
    class func isValidMobile(testStr:String) -> Bool {
        let phoneRegEx = "^(04[0-9]{8})"
        
        if let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx) as NSPredicate? {
            return phoneTest.evaluate(with: testStr)
        }
        return false
    }
    
    //MARK: - String
    class func heightOfString(withConstrainedWidth width: CGFloat, font: UIFont, text: String) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    class func widthOfString(withConstrainedHeight height: CGFloat, font: UIFont, text: String) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    class func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_")
        return String(text.filter {okayChars.contains($0) })
    }
    
    class func getYearsMontsFromTotalMonth(totalExperience: Int) -> String {
        let yr = totalExperience/12
        let months = totalExperience%12
        var exp = ""
        if yr > 1 {
            exp = "\(yr) Years"
        }
        else if yr == 1 {
            exp = "\(yr) Year"
        }
        if months > 1 {
            exp = exp + "\(months) Months"
        }
        else if months == 1 {
            exp = exp + "\(months) Month"
        }
        if exp == "" {
//            exp = "No Experience"
        }
        else {
//            exp = exp + " of Experience"
        }
        return exp
    }
    
    class func getStrigFromDate(date: String) -> String {
        let str = date.split(separator: "T")[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let d = dateFormatter.date(from: String(str))
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy"
        let dateStr = df.string(from: d!)
        return dateStr
    }
    
    class func getDateTimeStrigFromDate(date: String) -> String {
        let str = date.split(separator: ".")[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let d = dateFormatter.date(from: String(str))
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy hh:mm a"
        let dateStr = df.string(from: d!)
        return dateStr
    }

    class func getStartJobStrigFromDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let d = dateFormatter.date(from: date)
        let df = DateFormatter()
        df.dateFormat = "MMM yyyy"
        let dateStr = df.string(from: d!)
        return dateStr
    }
    
    class func getMyAvailabilityDateStrigFromDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let d = dateFormatter.date(from: date)
        let df = DateFormatter()
        df.dateFormat = "dd MMM (EEE)"
        let dateStr = df.string(from: d!)
        return dateStr
    }
    
    class func getBoldAttributedStringFor(attrStr:String, fullString:String, fontSize:CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: fullString, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: fontSize)])
        let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: fontSize), NSAttributedStringKey.foregroundColor: UIColor.black]
        attributedString.addAttributes(boldFontAttribute, range: (fullString as NSString).range(of: attrStr))
        return attributedString
    }
    
    class func getMyAvailabilityDateAttributedStringFor(attrStr:String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: attrStr)
        let attribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        attributedString.addAttributes(attribute, range: NSRange.init(location: attrStr.count - 5, length: 5))
        return attributedString
    }
}
