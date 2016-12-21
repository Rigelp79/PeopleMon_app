//
//  NetworkModel.swift
//  PeopleMonapp
//
//  Created by Rigel Preston on 12/19/16.
//  Copyright © 2016 Rigel Preston. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

// Describes what you need to make a network request and read it
protocol NetworkModel: JSONDecodable {
    
    //create the object by reading JSON
    init(json: JSON) throws
    //create an empth object
    init()
    
    //what is the HTTP Method (Get Post Put...)
    
    func method() -> Alamofire.HTTPMethod
    //REST URL to the resource i.e. http://server.come/posts/1
    func path() -> String
    //Convert the object to a dictionary for later conversion to JSON
    func toDictionary() -> [String: AnyObject]?
}
