//
//  Station.swift
//  International Space Station
//
//  Created by lhouch mohamed on 6/17/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//

import Foundation

struct IssPositionResponse : Decodable {
    
    var timestamp : Int?
    var message : String?
    var iss_position : Position?
}


struct Position : Decodable {
    var latitude : String?
    var longitude: String?
}

