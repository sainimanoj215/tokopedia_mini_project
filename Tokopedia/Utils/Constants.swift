//
//  BaseViewController.swift
//  Tokopedia
//
//  Created by Manoj Saini on 15/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//


import Foundation
import UIKit

//MARK: - Singleton objects
let kAppDelgateObject = UIApplication.shared.delegate as! AppDelegate
let systemVersion = (UIDevice.current.systemVersion as NSString).floatValue
let defaults = UserDefaults.standard
let kmainstoryBoard = UIStoryboard(name: "Main", bundle: nil)
let screenSize: CGRect = UIScreen.main.bounds
let windowScreen: UIWindow = UIApplication.shared.keyWindow!

//MARK: -  Devices
let iPhone_X                                        = "iPhoneX"
let iPhone_5                                        = "iPhone_5"
let iPhone_6                                        = "iPhone_6"
let iPhone_6_pluse                                  = "iPhone_6+"
let iPhone_unknown                                  = "unknown"

let Gold_Merchant = "Gold Merchant"
let Official_Store = "Official Store"
let shopTypes = [Gold_Merchant, Official_Store]
