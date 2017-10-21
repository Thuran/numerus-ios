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

public class CalculateExpression: Mappable {
    var expr: [String] = [String]()
    var precision: Int? = 0
    
    
    required public init(){
        
    }
    
    required public init?(map: Map) {
        
    }
    
    
    public func mapping(map: Map) {
        expr          <- map["expr"]
        precision     <- map["precision"]
        
    }
    
    
    public static func calculate(expr: CalculateExpression,completionHandler:@escaping ((MathResponse?, String?)->())) {
        let URL = "http://api.mathjs.org/v1/"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type" : "application/json"
        ]
        
        
        Alamofire.request(URL, method: .post, parameters: expr.toJSON(), encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse<MathResponse>) in
            if(response.result.isSuccess) {
                completionHandler(response.result.value, nil)
            } else {
                completionHandler(nil, response.result.error?.localizedDescription)
            }
        }
    }
    
    public class MathResponse: Mappable {
        var result: [String] = [String]()
        var error: String? = ""
        
        
        required public init(){
            
        }
        
        required public init?(map: Map) {
            
        }
        
        
        public func mapping(map: Map) {
            result    <- map["result"]
            error     <- map["error"]
            
        }
        
    }
    
    
    
}

