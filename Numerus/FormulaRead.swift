//
//  Formula.swift
//  Numerus
//
//  Created by Thuran on 16/05/17.
//  Copyright © 2017 Webtouch. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift

public class FormulaRead: Mappable {
    var name:String? = ""
    var author:UserRead? = UserRead()
    var rating:String = ""
    var context:String? = ""
    
    required public init(){
        
    }
    
    required public init?(map: Map) {
        
    }
    
    
    public func mapping(map: Map) {
        name        <- map["name"]
        author      <- map["author"]
        rating      <- map["rating"]
        context     <- map["context"]
        
    }
    
    
    public static func list(completionHandler:@escaping (([FormulaRead],String?)->())) {
        let URL = "http://numerus-api.herokuapp.com/formula"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type" : "application/json"
        ]
        Alamofire.request(URL, method: .get, encoding: JSONEncoding.default,headers: headers).responseArray { (response: DataResponse<[FormulaRead]>) in
            if(response.result.isSuccess) {
                
                completionHandler(response.result.value!, nil)
            } else {
                completionHandler([FormulaRead](), "Erro")
            }
        }
    }
    
    public static func filter(search: String!,completionHandler:@escaping (([FormulaRead],String?)->())) {
        let url = "http://numerus-api.herokuapp.com/formula"
        let parameters: Parameters = [
            "where": [
                "name" : [
                    "contains" : search
                    ]
                ]
        ]
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters,encoding: JSONEncoding.default,headers: headers).responseArray { (response: DataResponse<[FormulaRead]>) in
            if(response.result.isSuccess) {
                
                completionHandler(response.result.value!, nil)
            } else {
                completionHandler([FormulaRead](), "Erro")
            }
        }
    }
    
}
