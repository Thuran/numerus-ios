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

public class RegisterModel: Mappable {
    var name:String? = ""
    var email:String? = ""
    var birthDate: String? = ""
    var password:String? = ""
    var photo: String? = ""
    
    
    required public init(){
        
    }
    
    required public init?(map: Map) {
        
    }
    
    
    public func mapping(map: Map) {
        name          <- map["name"]
        email         <- map["email"]
        birthDate      <- map["birthDate"]
        password      <- map["password"]
        photo         <- map["photo"]
    }
    
    
    public static func create(register: RegisterModel,completionHandler:@escaping ((UserRead?, String?)->())) {
        let URL = "http://numerus-api.herokuapp.com/user"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type" : "application/json"
        ]
        
        
        Alamofire.request(URL, method: .post, parameters: register.toJSON(), encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse<UserRead>) in
            if(response.result.isSuccess) {
                completionHandler(response.result.value, nil)
            } else {
                completionHandler(nil, response.result.error?.localizedDescription)
            }
        }
    }
    
  
    
}
