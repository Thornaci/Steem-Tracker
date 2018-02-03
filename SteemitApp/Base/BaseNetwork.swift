//
//  BaseNetwork.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import Alamofire

final class BaseNetwork {
    
    static let sharedInstance: BaseNetwork = BaseNetwork()
    
    func getRequest(path: String,
                    success: @escaping (_ result: Any) -> Void,
                    failure: @escaping (_ error: String) -> Void) {
        
        let headers: HTTPHeaders = [ "Content-Type": "application/json",
                                     "Accept": "application/json" ]

        let pathUrl = URL.init(string: path)!
        Alamofire.request(pathUrl,
                          method: .get,
                          headers: headers).responseJSON { (response: DataResponse<Any>) in
                            
            switch response.result {
                
            case .success(_):
                if let data = response.result.value {
                    success(data)
                } else {
                    success("Nothing else matter")
                }
                break
            case .failure(_):
                failure("An error appeared!")
                break
            }
        }
    }
    
    func postRequest(path: String,
                     params: Dictionary<String, Any>!,
                     success: @escaping (_ result: Any) -> Void,
                     failure: @escaping (_ error: String) -> Void) {
        
        let headers: HTTPHeaders = [ "Content-Type": "application/json",
                                     "Accept": "application/json"]
        
        Alamofire.request(path,
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding(options: .prettyPrinted), headers: headers).responseJSON { (response: DataResponse<Any>) in
            
            switch response.result {
                
            case .success(_):
                if let data = response.result.value {
                    success(data)
                } else {
                    success("Nothing else matter")
                }
                break
            case .failure(_):
                failure("An error appeared!")
                break
            }
        }
    }
    
    func cancelAllSessions() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
}
