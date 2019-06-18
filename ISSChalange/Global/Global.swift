//
//  Global.swift
//  ISSChalange
//
//  Created by lhouch mohamed on 6/17/19.
//  Copyright © 2019 lhouch mohamed. All rights reserved.
//

import UIKit

/*****************API Key***********************/
let BASE_URL = "http://api.open-notify.org/"
let  ISS_NOW_URL = BASE_URL + "iss-now.json"
let PASS_URL = BASE_URL + "iss-pass.json"
let ASTROS_URL = BASE_URL + "astros.json"

/*****************Object Key***********************/
var ActivityIndicatorViewInSuperviewAssociatedObjectKey = "_UIViewActivityIndicatorViewInSuperviewAssociatedObjectKey";

/*****************User Defaults Key***********************/
enum UserDefaultsKeys : String {
    case ISSLatitude
    case ISSLongitude
}
