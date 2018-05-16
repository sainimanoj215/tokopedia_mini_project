//
//  BaseViewController.swift
//  Tokopedia
//
//  Created by Manoj Saini on 15/05/18.
//  Copyright © 2018 MDS. All rights reserved.
//

import UIKit
import Alamofire

class NetworkCommunicationLayer: NSObject {
    
    class func getDataFromAPI(apiName:String ,params:NSMutableDictionary,responseBlock:@escaping (Any,Bool) -> ())
    {
        let finalURL = baseURL + apiName
        var finalDict = [String : Any]()
        for (key, value) in params {
            finalDict[key as! String] = value
        }
        Alamofire.request(finalURL, method: .get, parameters: finalDict, encoding: URLEncoding.default, headers:nil) .responseJSON(completionHandler: { (response) in
            if response.result.isSuccess
            {
                let dict = response.result.value
                responseBlock(dict!,response.result.isSuccess)
            }
            else
            {
                responseBlock(response, false)
            }
        })
    }
    
    class func postDataAPI(apiName:String ,params:NSMutableDictionary,responseBlock:@escaping(Any,Bool) -> ())
    {
        let finalURL = baseURL + apiName
        var finalDict = [String : Any]()
        for (key, value) in params {
            finalDict[key as! String] = value
        }
        
        Alamofire.request(finalURL, method: .post, parameters: finalDict, encoding: URLEncoding.default, headers:nil) .responseJSON(completionHandler: { (response) in
            if response.result.isSuccess {
                let dict = response.result.value
                responseBlock(dict!,response.result.isSuccess)
            }
            else {
                let dict = response.result.error?.localizedDescription
                responseBlock(dict!, false)
            }
        })
    }
    
    class func putDataAPI(apiName:String ,params:NSMutableDictionary,responseBlock:@escaping(Any,Bool) -> ())
    {
        let finalURL = baseURL + apiName
        var finalDict = [String : Any]()
        for (key, value) in params {
            finalDict[key as! String] = value
        }
        
        Alamofire.request(finalURL, method: .put, parameters: finalDict, encoding: JSONEncoding.default, headers:nil) .responseJSON(completionHandler: { (response) in
            if response.result.isSuccess {
                let dict = response.result.value
                responseBlock(dict!,response.result.isSuccess)
            }
            else {
                let dict = response.result.error?.localizedDescription
                
                responseBlock(dict!, false)
            }
        })
    }
    
    class func deleteDataAPI(apiName:String ,params:NSMutableDictionary,responseBlock:@escaping(Any,Bool) -> ())
    {
        let finalURL = baseURL + apiName
        var finalDict = [String : Any]()
        for (key, value) in params {
            finalDict[key as! String] = value
        }
        
        Alamofire.request(finalURL, method: .delete, parameters: finalDict, encoding: URLEncoding.default, headers:nil) .responseJSON(completionHandler: { (response) in
            if response.result.isSuccess {
                let dict = response.result.value
                responseBlock(dict!,response.result.isSuccess)
            }
            else {
                let dict = response.result.error?.localizedDescription
                responseBlock(dict!, false)
            }
        })
    }
    
    class func multipartUpload(apiName:String,params:NSMutableDictionary,multipartData:Data?,fileName:String,mimeType:String,responseBlock:@escaping(Any,Bool) -> ())
    {
        let finalURL = baseURL + apiName
        var URL:URLRequest?
        do
        {
            URL = try URLRequest(url: finalURL, method: .post, headers: nil)
        }
        catch
        {
            print("Error in hedder inclusion")
        }
        
        Alamofire.upload(multipartFormData: { multiFormData in
            multiFormData.append(multipartData!, withName: "file", fileName: fileName, mimeType: mimeType)
//            multiFormData.append(multipartData!, withName: "file", mimeType: mimeType)
            for (key, value) in params {
//                let objectData = try?JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions(rawValue: 0))
//                if ((objectData) != nil){
//                    let objectString = String(data: objectData!, encoding: .utf8)
//                    multiFormData.append((objectString as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
//                }
                multiFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key as! String)
            }
        }, with: URL!, encodingCompletion: {
            encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (Progress) in
                    print(Progress.fractionCompleted)
                })
                upload.responseJSON { response in
                    if response.result.isSuccess
                    {
                        let dict = response.result.value
                        responseBlock(dict!,response.result.isSuccess)
                    }
                    else
                    {
                        responseBlock(response,response.result.isSuccess)
                    }
                }
            case .failure(let encodingError):
                // hide progressbas here
                print("ERROR RESPONSE: \(encodingError)")
                let dict = encodingError.localizedDescription
                responseBlock(dict,false)
            }
        })
    }
}
