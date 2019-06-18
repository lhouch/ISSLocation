//
//  Astros.swift
//  ISSChalange
//
//  Created by lhouch mohamed on 6/17/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//



struct AstroResponse : Decodable {
    var message : String?
    var number : Int?
    var people : [Astro]?
    
}

struct Astro : Decodable {
    
    var name : String?
    var craft : String?
}
