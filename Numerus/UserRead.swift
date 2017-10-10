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

public class UserRead: Mappable {
    var name:String? = ""
    var email:String? = ""
    var birthDate: String? = ""
    var photo:String = ""
    var password:String? = ""
    var id:Int? = 0
    
    required public init(){
        
    }
    
    required public init?(map: Map) {
        
    }
    
    
    public func mapping(map: Map) {
        name        <- map["name"]
        email       <- map["email"]
        birthDate   <- map["birthDate"]
        photo       <- map["photo"]
        password    <- map["password"]
        id          <- map["id"]
        
    }
    
    public static func login(email: String!, password: String!,completionHandler:@escaping ((Bool?)->())) {
        let URL = "http://numerus-api.herokuapp.com/user?email=" + email
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type" : "application/json"
        ]
        Alamofire.request(URL, method: .get, headers: headers).responseArray { (response: DataResponse<[UserRead]>) in
            if(response.result.isSuccess) {
                let user: UserRead = response.result.value![0]
                if(user.password == password){
                    userGlobal = user
                    completionHandler(true)
                }else{
                    completionHandler(false)
                }
            } else {
                completionHandler(false)
            }
        }
    }
    
    

    
}

