//
//  PassTimes.swift
//  ISSChalange
//
//  Created by lhouch mohamed on 6/17/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//

struct PassTimesResponse : Decodable {
    var message : String?
    var response : [Pass]?
    
}

struct Pass : Decodable {
  var  risetime : Double?
    var duration : Int?
}
