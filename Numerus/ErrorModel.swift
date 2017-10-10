//
//  ErrorModel.swift
//  CodeMoney
//
//  Created by Thuran Eduardo on 3/15/17.
//  Copyright © 2017 Webtouch. All rights reserved.
//

import Foundation
import ObjectMapper

public class ErrorModel:Mappable {
    
    var errors:String = ""
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        errors         <- map["errors"]
    }
}
