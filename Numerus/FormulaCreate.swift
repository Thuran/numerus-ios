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

public class FormulaCreate: Mappable {
    var name:String? = ""
    var authorId: Int = 0
    var rating:String = ""
    var context:String? = ""
    
    required public init(){
        
    }
    
    required public init?(map: Map) {
        
    }
    
    
    public func mapping(map: Map) {
        name        <- map["name"]
        authorId    <- map["authorId"]
        rating      <- map["rating"]
        context     <- map["context"]
        
    }
    
    public static func create(formula: FormulaCreate!,completionHandler:@escaping ((String?)->())) {
        let url = "http://numerus-api.herokuapp.com/formula"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(url, method: .post, parameters: formula.toJSON(), encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse<FormulaRead>) in
            if(response.result.isSuccess) {
                completionHandler(nil)
            } else {
                completionHandler("Erro ao compartilhar fórmula")
            }
        }
    }
    
}

