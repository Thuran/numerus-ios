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

public class User: Mappable {
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
        email      <- map["email"]
        birthDate <- map["birthDate"]
        photo      <- map["photo"]
        password     <- map["password"]
        id     <- map["id"]
        
    }
    
    

    
}

